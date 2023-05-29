{ config, pkgs, ... }:
{
  imports = [ ];

  config = {
    home.packages = with pkgs; [
      rclone
    ];

    # Note that you'll need to configure the remote credentials manually
    # for zettel with `rclone config`
    systemd.user.services.zettelb2 = {
      Unit.Description = "Zettel Rclone Mount";
      Install.WantedBy = ["default.target"];
      Service = {
        Type = "simple";
        ExecStart = "/bin/bash -c 'mkdir -p $HOME/zt && exec ${pkgs.rclone}/bin/rclone mount zettel:/ $HOME/zt'";
        ExecStop = "/usr/bin/fusermount -u $HOME/zt";
      };
    };

  };
}
