# Vagrant sync

Vagrant command to copy files in your box using rsync.

You don't need to add anything to your ssh-config to use this command.

## Usage

```
$ vagrant sync [vm_name] --from /bar/foo --to /foo/bar
```

## Options

* --from:    source file or directory, if this options is not provided the current directory is copied.
* --to:      destination directory, mandatory.
* --verbose  very verbose.

## Copyright

Copyright (c) 2012 David Calavera. See LICENSE for details.
