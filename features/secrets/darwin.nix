{ config, lib, pkgs, ... }:
let
  user = config.system.primaryUser;
  home = "/Users/${user}";

  mkSecret = sopsFile: path: {
    inherit path sopsFile;
    format = "binary";
    owner = user;
    mode = "0600";
  };
in {
  environment.systemPackages = with pkgs; [
    age
    sops
    ssh-to-age
  ];

  sops.age.keyFile = "${home}/.config/nix/.sops/age/keys.txt";

  system.activationScripts.preActivation.text = lib.mkBefore ''
    install -d -o ${user} -g staff -m 0700 "${home}/.ssh"
    install -d -o ${user} -g staff -m 0700 "${home}/.aws"
    install -d -o ${user} -g staff -m 0700 "${home}/.config/gh"
    install -d -o ${user} -g staff -m 0700 "${home}/.config/gcloud"
    install -d -o ${user} -g staff -m 0700 "${home}/.config/gcloud/legacy_credentials/huogyxd@gmail.com"
    install -d -o ${user} -g staff -m 0700 "${home}/.codex"
    install -d -o ${user} -g staff -m 0700 "${home}/.config/opencode"
    install -d -o ${user} -g staff -m 0700 "${home}/.config/github-copilot"
  '';

  system.activationScripts.postActivation.text = lib.mkAfter ''
    for key in id_ed25519 id_rsa; do
      private_key="${home}/.ssh/$key"
      public_key="$private_key.pub"

      if [ -f "$private_key" ] && [ ! -f "$public_key" ]; then
        /usr/bin/ssh-keygen -y -f "$private_key" > "$public_key"
        chown ${user}:staff "$public_key"
        chmod 0644 "$public_key"
      fi
    done
  '';

  sops.secrets = {
    "ssh/id_ed25519" = mkSecret ../../secrets/ssh/id_ed25519 "${home}/.ssh/id_ed25519";
    "ssh/id_rsa" = mkSecret ../../secrets/ssh/id_rsa "${home}/.ssh/id_rsa";
    "aws/credentials" = mkSecret ../../secrets/aws/credentials "${home}/.aws/credentials";
    "npm/npmrc" = mkSecret ../../secrets/npm/npmrc "${home}/.npmrc";
    "gh/hosts.yml" = mkSecret ../../secrets/gh/hosts.yml "${home}/.config/gh/hosts.yml";
    "gcloud/application_default_credentials.json" = mkSecret ../../secrets/gcloud/application_default_credentials.json "${home}/.config/gcloud/application_default_credentials.json";
    "gcloud/legacy_credentials/huogyxd_gmail_com/adc.json" = mkSecret ../../secrets/gcloud/legacy_credentials/huogyxd_gmail_com/adc.json "${home}/.config/gcloud/legacy_credentials/huogyxd@gmail.com/adc.json";
    "gcloud/legacy_credentials/huogyxd_gmail_com/boto" = mkSecret ../../secrets/gcloud/legacy_credentials/huogyxd_gmail_com/boto "${home}/.config/gcloud/legacy_credentials/huogyxd@gmail.com/.boto";
    "codex/auth.json" = mkSecret ../../secrets/codex/auth.json "${home}/.codex/auth.json";
    "opencode/antigravity-accounts.json" = mkSecret ../../secrets/opencode/antigravity-accounts.json "${home}/.config/opencode/antigravity-accounts.json";
    "github-copilot/apps.json" = mkSecret ../../secrets/github-copilot/apps.json "${home}/.config/github-copilot/apps.json";
  };
}
