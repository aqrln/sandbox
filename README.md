# sandbox

Simple sandbox using podman and krun, with a nushell wrapper script.

The home directory of the user within the container/VM is in `home`, everything is `.gitignore`d by default and persistent configs are un-ignored.

The container image is configured by editing `Containerfile`.

```text
$ ./run.nu --help
Usage:
  > run.nu {flags}

Flags:
  -h, --help: Display the help message for this command
  -c, --no-krun: Disable virtualization via krun and run the container on the host kernel
  -n, --host-net: Share the network with the host (implies --no-krun)
```
