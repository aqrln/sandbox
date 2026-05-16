#!/usr/bin/env nu

let user = "user"
let shell = "fish"
let sandbox_home = $"($env.FILE_PWD)/home"

def main [
    --no-krun (-c)  # Disable virtualization via krun and run the container on the host kernel
    --host-net (-n) # Share the network with the host (implies `--no-krun`)
] {
    build-container
    run-container $no_krun $host_net
}

def build-container [] {
    (podman build -t sandbox
        --build-arg $"user=($user)"
        --build-arg $"uid=(id -u)"
        --build-arg $"gid=(id -g)"
        .)
}

def run-container [$no_krun: bool, $host_net: bool] {
    let use_krun = not $no_krun and not $host_net

    let runtime_args = if $use_krun {
        ["--runtime", "krun"]
    } else {
        []
    }

    let net_args = if $host_net {
        ["--network", "host"]
    } else {
        []
    }

    let command = if $use_krun {
        ["runuser", "-u", $user, "--", $shell]
    } else {
        [$shell]
    } 

    (podman run -it --rm
        -v $"($sandbox_home):/home/($user):rw,Z"
        --userns keep-id
        ...$runtime_args
        ...$net_args
        localhost/sandbox
        ...$command)
}
