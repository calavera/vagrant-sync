class Sync < Vagrant::Command::Base
  def execute
    options = {}

    opts = OptionParser.new do |opts|
      opts.banner = "Usage: vagrant rsync [vm-name] [-f from] [-t to]"

      opts.separator ""

      opts.on("-f", "--from SOURCE", "Source directory or file, current directory by default") do |from|
        options[:from] = from
      end

      opts.on('-t', '--to DESTINATION', 'Destination directory or file') do |to|
        options[:to] = to
      end

      opts.on('--verbose') do |v|
        options[:verbose] = true
      end
    end

    argv = parse_options(opts)
    return unless argv

    raise ArgumentError, "destination path not found, use -t flag" unless options[:to]
    options[:from] ||= Dir.pwd

    with_target_vms(argv[0], :single_target => true) do |vm|
      raise Vagrant::Errors::VMNotCreatedError if !vm.created?
      raise Vagrant::Errors::VMInaccessible if !vm.state == :inaccessible

      with_target_vms(argv[0], :single_target => true) do |vm|
        ssh_info  = vm.ssh.info

        ssh_options = "-p#{ssh_info[:port]} -oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no -oPasswordAuthentication=no -oIdentitiesOnly=yes -i#{ssh_info[:private_key_path]}"
        ssh_host    = "#{ssh_info[:username]}@#{ssh_info[:host]}:#{options[:to]}"

        rsync_options = '-az'
        rsync_options << 'vvv' if options[:verbose]

        command = 'rsync %s --delete %s -e "ssh %s" %s' % [rsync_options, options[:from], ssh_options, ssh_host]
        puts command if options[:verbose]
        system(command)
      end
    end
  end
end

Vagrant.commands.register(:sync) { Sync }
