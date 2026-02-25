{ config, ... }: {
  home.packages = [
    config.services.paneru.package
  ];

  services.paneru = {
    enable = true;

    settings = {
      options = {
        preset_column_widths = [
          0.30
          0.40
          0.50
          0.60
          0.70
        ];
        swipe_gesture_fingers = 3;
        animation_speed = 25;
      };

      bindings = {
        quit = "ctrl + alt + shift + cmd - f20";
      };

      windows = {
        all = {
          title = ".*";
          horizontal_padding = 5;
          vertical_padding = 5;
        };
      };
    };
  };
}
