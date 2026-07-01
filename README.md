# Fresh Mac install:

```sh
/bin/bash -c "$(curl --proto '=https' --tlsv1.2 -fsSL https://raw.githubusercontent.com/balazshevesi/nix/main/bootstrap.sh)"
```

## Other 
Install nix `curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install`
Build config on my mac: `sudo nix run nix-darwin -- switch --flake .#macbook-air-m2`


# to do
