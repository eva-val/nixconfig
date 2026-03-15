{ ... }:

let
  themePath = "cosmic/com.system76.CosmicTheme.Dark/v1";
  builderPath = "cosmic/com.system76.CosmicTheme.Dark.Builder/v1";
in
{
  xdg.configFile = {
    # ── Expanded theme (applied immediately) ──────────────────────────

    "${themePath}/palette".text = builtins.readFile ../themes/witch-hazel-hypercolor-palette.ron;

    "${themePath}/accent".text = ''
      (
          base: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          hover: (
              red: 0.624871,
              green: 0.47579053,
              blue: 0.9095444,
              alpha: 1.0,
          ),
          pressed: (
              red: 0.3895318,
              green: 0.27483982,
              blue: 0.60409975,
              alpha: 1.0,
          ),
          selected: (
              red: 0.624871,
              green: 0.47579053,
              blue: 0.9095444,
              alpha: 1.0,
          ),
          selected_text: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          focus: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          divider: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 1.0,
          ),
          on: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 1.0,
          ),
          disabled: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          on_disabled: (
              red: 0.34117648,
              green: 0.25294116,
              blue: 0.5,
              alpha: 1.0,
          ),
          border: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          disabled_border: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 0.5,
          ),
      )
    '';

    "${themePath}/accent_button".text = ''
      (
          base: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          hover: (
              red: 0.624871,
              green: 0.47579053,
              blue: 0.9095444,
              alpha: 1.0,
          ),
          pressed: (
              red: 0.3895318,
              green: 0.27483982,
              blue: 0.60409975,
              alpha: 1.0,
          ),
          selected: (
              red: 0.624871,
              green: 0.47579053,
              blue: 0.9095444,
              alpha: 1.0,
          ),
          selected_text: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          focus: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          divider: (
              red: 0.017995808,
              green: 0.000000003008172,
              blue: 0.07722523,
              alpha: 1.0,
          ),
          on: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 1.0,
          ),
          disabled: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          on_disabled: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 0.5,
          ),
          border: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          disabled_border: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 0.5,
          ),
      )
    '';

    "${themePath}/background".text = ''
      (
          base: (
              red: 0.15686275,
              green: 0.14901961,
              blue: 0.20392157,
              alpha: 1.0,
          ),
          component: (
              base: (
                  red: 0.24256516,
                  green: 0.23473287,
                  blue: 0.29353854,
                  alpha: 1.0,
              ),
              hover: (
                  red: 0.31830862,
                  green: 0.31125444,
                  blue: 0.36418468,
                  alpha: 1.0,
              ),
              pressed: (
                  red: 0.39405215,
                  green: 0.38777608,
                  blue: 0.43483084,
                  alpha: 1.0,
              ),
              selected: (
                  red: 0.31830862,
                  green: 0.31125444,
                  blue: 0.36418468,
                  alpha: 1.0,
              ),
              selected_text: (
                  red: 0.68235296,
                  green: 0.5058823,
                  blue: 1.0,
                  alpha: 1.0,
              ),
              focus: (
                  red: 0.68235296,
                  green: 0.5058823,
                  blue: 1.0,
                  alpha: 1.0,
              ),
              divider: (
                  red: 0.8318802,
                  green: 0.8318715,
                  blue: 0.8090188,
                  alpha: 0.2,
              ),
              on: (
                  red: 0.8318802,
                  green: 0.8318715,
                  blue: 0.8090188,
                  alpha: 1.0,
              ),
              disabled: (
                  red: 0.24256516,
                  green: 0.23473287,
                  blue: 0.29353854,
                  alpha: 0.5,
              ),
              on_disabled: (
                  red: 0.8318802,
                  green: 0.8318715,
                  blue: 0.8090188,
                  alpha: 0.65,
              ),
              border: (
                  red: 0.7484719,
                  green: 0.70970017,
                  blue: 0.92521137,
                  alpha: 1.0,
              ),
              disabled_border: (
                  red: 0.7484719,
                  green: 0.70970017,
                  blue: 0.92521137,
                  alpha: 0.5,
              ),
          ),
          divider: (
              red: 0.32326424,
              green: 0.31698993,
              blue: 0.35619086,
              alpha: 1.0,
          ),
          on: (
              red: 0.9888701,
              green: 0.98887116,
              blue: 0.9652681,
              alpha: 1.0,
          ),
          small_widget: (
              red: 0.20948622,
              green: 0.20224732,
              blue: 0.22404286,
              alpha: 0.25,
          ),
      )
    '';

    "${themePath}/button".text = ''
      (
          base: (
              red: 0.62602556,
              green: 0.587263,
              blue: 0.7957552,
              alpha: 0.25,
          ),
          hover: (
              red: 0.3920014,
              green: 0.36471617,
              blue: 0.507422,
              alpha: 0.4,
          ),
          pressed: (
              red: 0.17356041,
              green: 0.13935126,
              blue: 0.26325083,
              alpha: 0.625,
          ),
          selected: (
              red: 0.3920014,
              green: 0.36471617,
              blue: 0.507422,
              alpha: 0.4,
          ),
          selected_text: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          focus: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          divider: (
              red: 0.8318802,
              green: 0.8318715,
              blue: 0.8090188,
              alpha: 0.2,
          ),
          on: (
              red: 0.8318802,
              green: 0.8318715,
              blue: 0.8090188,
              alpha: 1.0,
          ),
          disabled: (
              red: 0.62602556,
              green: 0.587263,
              blue: 0.7957552,
              alpha: 0.125,
          ),
          on_disabled: (
              red: 0.8318802,
              green: 0.8318715,
              blue: 0.8090188,
              alpha: 0.65,
          ),
          border: (
              red: 0.7484719,
              green: 0.70970017,
              blue: 0.92521137,
              alpha: 1.0,
          ),
          disabled_border: (
              red: 0.7484719,
              green: 0.70970017,
              blue: 0.92521137,
              alpha: 0.5,
          ),
      )
    '';

    "${themePath}/corner_radii".text = ''
      (
          radius_0: (0.0, 0.0, 0.0, 0.0),
          radius_xs: (4.0, 4.0, 4.0, 4.0),
          radius_s: (8.0, 8.0, 8.0, 8.0),
          radius_m: (16.0, 16.0, 16.0, 16.0),
          radius_l: (32.0, 32.0, 32.0, 32.0),
          radius_xl: (160.0, 160.0, 160.0, 160.0),
      )
    '';

    "${themePath}/destructive".text = ''
      (
          base: (
              red: 0.8627451,
              green: 0.4392157,
              blue: 0.4392157,
              alpha: 1.0,
          ),
          hover: (
              red: 0.7691847,
              green: 0.42245725,
              blue: 0.46091697,
              alpha: 1.0,
          ),
          pressed: (
              red: 0.47972786,
              green: 0.24150652,
              blue: 0.32370764,
              alpha: 1.0,
          ),
          selected: (
              red: 0.7691847,
              green: 0.42245725,
              blue: 0.46091697,
              alpha: 1.0,
          ),
          selected_text: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          focus: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          divider: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 1.0,
          ),
          on: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 1.0,
          ),
          disabled: (
              red: 0.8627451,
              green: 0.4392157,
              blue: 0.4392157,
              alpha: 1.0,
          ),
          on_disabled: (
              red: 0.43137255,
              green: 0.21960784,
              blue: 0.21960784,
              alpha: 1.0,
          ),
          border: (
              red: 0.8627451,
              green: 0.4392157,
              blue: 0.4392157,
              alpha: 1.0,
          ),
          disabled_border: (
              red: 0.8627451,
              green: 0.4392157,
              blue: 0.4392157,
              alpha: 0.5,
          ),
      )
    '';

    "${themePath}/destructive_button".text = ''
      (
          base: (
              red: 0.8627451,
              green: 0.4392157,
              blue: 0.4392157,
              alpha: 1.0,
          ),
          hover: (
              red: 0.7691847,
              green: 0.42245725,
              blue: 0.46091697,
              alpha: 1.0,
          ),
          pressed: (
              red: 0.47972786,
              green: 0.24150652,
              blue: 0.32370764,
              alpha: 1.0,
          ),
          selected: (
              red: 0.7691847,
              green: 0.42245725,
              blue: 0.46091697,
              alpha: 1.0,
          ),
          selected_text: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          focus: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          divider: (
              red: 0.017995808,
              green: 0.000000003008172,
              blue: 0.07722523,
              alpha: 1.0,
          ),
          on: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 1.0,
          ),
          disabled: (
              red: 0.8627451,
              green: 0.4392157,
              blue: 0.4392157,
              alpha: 1.0,
          ),
          on_disabled: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 0.5,
          ),
          border: (
              red: 0.8627451,
              green: 0.4392157,
              blue: 0.4392157,
              alpha: 1.0,
          ),
          disabled_border: (
              red: 0.8627451,
              green: 0.4392157,
              blue: 0.4392157,
              alpha: 0.5,
          ),
      )
    '';

    "${themePath}/icon_button".text = ''
      (
          base: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 0.0,
          ),
          hover: (
              red: 0.39494303,
              green: 0.35542342,
              blue: 0.547722,
              alpha: 0.2,
          ),
          pressed: (
              red: 0.0967106,
              green: 0.04379733,
              blue: 0.20819956,
              alpha: 0.5,
          ),
          selected: (
              red: 0.39494303,
              green: 0.35542342,
              blue: 0.547722,
              alpha: 0.2,
          ),
          selected_text: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          focus: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          divider: (
              red: 0.7484719,
              green: 0.70970017,
              blue: 0.92521137,
              alpha: 0.2,
          ),
          on: (
              red: 0.7484719,
              green: 0.70970017,
              blue: 0.92521137,
              alpha: 1.0,
          ),
          disabled: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 0.0,
          ),
          on_disabled: (
              red: 0.7484719,
              green: 0.70970017,
              blue: 0.92521137,
              alpha: 0.65,
          ),
          border: (
              red: 0.7484719,
              green: 0.70970017,
              blue: 0.92521137,
              alpha: 1.0,
          ),
          disabled_border: (
              red: 0.7484719,
              green: 0.70970017,
              blue: 0.92521137,
              alpha: 0.5,
          ),
      )
    '';

    "${themePath}/link_button".text = ''
      (
          base: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 0.0,
          ),
          hover: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 0.0,
          ),
          pressed: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 0.0,
          ),
          selected: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 0.0,
          ),
          selected_text: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          focus: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          divider: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 0.2,
          ),
          on: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          disabled: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 0.0,
          ),
          on_disabled: (
              red: 0.34117648,
              green: 0.25294116,
              blue: 0.5,
              alpha: 0.5,
          ),
          border: (
              red: 0.7484719,
              green: 0.70970017,
              blue: 0.92521137,
              alpha: 1.0,
          ),
          disabled_border: (
              red: 0.7484719,
              green: 0.70970017,
              blue: 0.92521137,
              alpha: 0.5,
          ),
      )
    '';

    "${themePath}/primary".text = ''
      (
          base: (
              red: 0.23137255,
              green: 0.21176471,
              blue: 0.30588236,
              alpha: 1.0,
          ),
          component: (
              base: (
                  red: 0.2993137,
                  green: 0.2796541,
                  blue: 0.37786072,
                  alpha: 1.0,
              ),
              hover: (
                  red: 0.36938232,
                  green: 0.35168356,
                  blue: 0.44007462,
                  alpha: 1.0,
              ),
              pressed: (
                  red: 0.43945098,
                  green: 0.42371303,
                  blue: 0.5022886,
                  alpha: 1.0,
              ),
              selected: (
                  red: 0.36938232,
                  green: 0.35168356,
                  blue: 0.44007462,
                  alpha: 1.0,
              ),
              selected_text: (
                  red: 0.68235296,
                  green: 0.5058823,
                  blue: 1.0,
                  alpha: 1.0,
              ),
              focus: (
                  red: 0.68235296,
                  green: 0.5058823,
                  blue: 1.0,
                  alpha: 1.0,
              ),
              divider: (
                  red: 0.89666945,
                  green: 0.89666504,
                  blue: 0.8734908,
                  alpha: 0.2,
              ),
              on: (
                  red: 0.89666945,
                  green: 0.89666504,
                  blue: 0.8734908,
                  alpha: 1.0,
              ),
              disabled: (
                  red: 0.2993137,
                  green: 0.2796541,
                  blue: 0.37786072,
                  alpha: 0.5,
              ),
              on_disabled: (
                  red: 0.89666945,
                  green: 0.89666504,
                  blue: 0.8734908,
                  alpha: 0.65,
              ),
              border: (
                  red: 0.7484719,
                  green: 0.70970017,
                  blue: 0.92521137,
                  alpha: 1.0,
              ),
              disabled_border: (
                  red: 0.7484719,
                  green: 0.70970017,
                  blue: 0.92521137,
                  alpha: 0.5,
              ),
          ),
          divider: (
              red: 0.3489046,
              green: 0.33321646,
              blue: 0.40395325,
              alpha: 1.0,
          ),
          on: (
              red: 0.8190329,
              green: 0.81902343,
              blue: 0.7962367,
              alpha: 1.0,
          ),
          small_widget: (
              red: 0.2818724,
              green: 0.27495083,
              blue: 0.29795256,
              alpha: 0.25,
          ),
      )
    '';

    "${themePath}/secondary".text = ''
      (
          base: (
              red: 0.2627451,
              green: 0.24313726,
              blue: 0.3372549,
              alpha: 1.0,
          ),
          component: (
              base: (
                  red: 0.29957208,
                  green: 0.2799033,
                  blue: 0.37611777,
                  alpha: 1.0,
              ),
              hover: (
                  red: 0.36961487,
                  green: 0.35190785,
                  blue: 0.43850598,
                  alpha: 1.0,
              ),
              pressed: (
                  red: 0.4396577,
                  green: 0.4239124,
                  blue: 0.50089425,
                  alpha: 1.0,
              ),
              selected: (
                  red: 0.36961487,
                  green: 0.35190785,
                  blue: 0.43850598,
                  alpha: 1.0,
              ),
              selected_text: (
                  red: 0.68235296,
                  green: 0.5058823,
                  blue: 1.0,
                  alpha: 1.0,
              ),
              focus: (
                  red: 0.68235296,
                  green: 0.5058823,
                  blue: 1.0,
                  alpha: 1.0,
              ),
              divider: (
                  red: 0.89666945,
                  green: 0.89666504,
                  blue: 0.8734908,
                  alpha: 0.2,
              ),
              on: (
                  red: 0.89666945,
                  green: 0.89666504,
                  blue: 0.8734908,
                  alpha: 1.0,
              ),
              disabled: (
                  red: 0.29957208,
                  green: 0.2799033,
                  blue: 0.37611777,
                  alpha: 0.5,
              ),
              on_disabled: (
                  red: 0.89666945,
                  green: 0.89666504,
                  blue: 0.8734908,
                  alpha: 0.65,
              ),
              border: (
                  red: 0.7484719,
                  green: 0.70970017,
                  blue: 0.92521137,
                  alpha: 1.0,
              ),
              disabled_border: (
                  red: 0.7484719,
                  green: 0.70970017,
                  blue: 0.92521137,
                  alpha: 0.5,
              ),
          ),
          divider: (
              red: 0.3817333,
              green: 0.36604565,
              blue: 0.4367432,
              alpha: 1.0,
          ),
          on: (
              red: 0.8576859,
              green: 0.8576792,
              blue: 0.83469623,
              alpha: 1.0,
          ),
          small_widget: (
              red: 0.31392285,
              green: 0.3071084,
              blue: 0.33057305,
              alpha: 0.25,
          ),
      )
    '';

    "${themePath}/spacing".text = ''
      (
          space_none: 0,
          space_xxxs: 4,
          space_xxs: 8,
          space_xs: 12,
          space_s: 16,
          space_m: 24,
          space_l: 32,
          space_xl: 48,
          space_xxl: 64,
          space_xxxl: 128,
      )
    '';

    "${themePath}/success".text = ''
      (
          base: (
              red: 0.5058823,
              green: 1.0,
              blue: 0.74509805,
              alpha: 1.0,
          ),
          hover: (
              red: 0.48369446,
              green: 0.8710847,
              blue: 0.70562285,
              alpha: 1.0,
          ),
          pressed: (
              red: 0.30129647,
              green: 0.5218987,
              blue: 0.4766488,
              alpha: 1.0,
          ),
          selected: (
              red: 0.48369446,
              green: 0.8710847,
              blue: 0.70562285,
              alpha: 1.0,
          ),
          selected_text: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          focus: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          divider: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 1.0,
          ),
          on: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 1.0,
          ),
          disabled: (
              red: 0.5058823,
              green: 1.0,
              blue: 0.74509805,
              alpha: 1.0,
          ),
          on_disabled: (
              red: 0.25294116,
              green: 0.5,
              blue: 0.37254903,
              alpha: 1.0,
          ),
          border: (
              red: 0.5058823,
              green: 1.0,
              blue: 0.74509805,
              alpha: 1.0,
          ),
          disabled_border: (
              red: 0.5058823,
              green: 1.0,
              blue: 0.74509805,
              alpha: 0.5,
          ),
      )
    '';

    "${themePath}/text_button".text = ''
      (
          base: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 0.0,
          ),
          hover: (
              red: 0.39494303,
              green: 0.35542342,
              blue: 0.547722,
              alpha: 0.2,
          ),
          pressed: (
              red: 0.0967106,
              green: 0.04379733,
              blue: 0.20819956,
              alpha: 0.5,
          ),
          selected: (
              red: 0.39494303,
              green: 0.35542342,
              blue: 0.547722,
              alpha: 0.2,
          ),
          selected_text: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          focus: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          divider: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 0.2,
          ),
          on: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          disabled: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 0.0,
          ),
          on_disabled: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 0.65,
          ),
          border: (
              red: 0.7484719,
              green: 0.70970017,
              blue: 0.92521137,
              alpha: 1.0,
          ),
          disabled_border: (
              red: 0.7484719,
              green: 0.70970017,
              blue: 0.92521137,
              alpha: 0.5,
          ),
      )
    '';

    "${themePath}/warning".text = ''
      (
          base: (
              red: 1.0,
              green: 0.96862745,
              blue: 0.5058823,
              alpha: 1.0,
          ),
          hover: (
              red: 0.8789886,
              green: 0.84598666,
              blue: 0.5142503,
              alpha: 1.0,
          ),
          pressed: (
              red: 0.5483553,
              green: 0.5062124,
              blue: 0.35704094,
              alpha: 1.0,
          ),
          selected: (
              red: 0.8789886,
              green: 0.84598666,
              blue: 0.5142503,
              alpha: 1.0,
          ),
          selected_text: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          focus: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          divider: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 1.0,
          ),
          on: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 1.0,
          ),
          disabled: (
              red: 1.0,
              green: 0.96862745,
              blue: 0.5058823,
              alpha: 1.0,
          ),
          on_disabled: (
              red: 0.5,
              green: 0.48431373,
              blue: 0.25294116,
              alpha: 1.0,
          ),
          border: (
              red: 1.0,
              green: 0.96862745,
              blue: 0.5058823,
              alpha: 1.0,
          ),
          disabled_border: (
              red: 1.0,
              green: 0.96862745,
              blue: 0.5058823,
              alpha: 0.5,
          ),
      )
    '';

    "${themePath}/warning_button".text = ''
      (
          base: (
              red: 1.0,
              green: 0.96862745,
              blue: 0.5058823,
              alpha: 1.0,
          ),
          hover: (
              red: 0.8789886,
              green: 0.84598666,
              blue: 0.5142503,
              alpha: 1.0,
          ),
          pressed: (
              red: 0.5483553,
              green: 0.5062124,
              blue: 0.35704094,
              alpha: 1.0,
          ),
          selected: (
              red: 0.8789886,
              green: 0.84598666,
              blue: 0.5142503,
              alpha: 1.0,
          ),
          selected_text: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          focus: (
              red: 0.68235296,
              green: 0.5058823,
              blue: 1.0,
              alpha: 1.0,
          ),
          divider: (
              red: 1.0,
              green: 0.9999488,
              blue: 1.0,
              alpha: 1.0,
          ),
          on: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 1.0,
          ),
          disabled: (
              red: 1.0,
              green: 0.96862745,
              blue: 0.5058823,
              alpha: 1.0,
          ),
          on_disabled: (
              red: 0.0,
              green: 0.0,
              blue: 0.0,
              alpha: 0.5,
          ),
          border: (
              red: 1.0,
              green: 0.96862745,
              blue: 0.5058823,
              alpha: 1.0,
          ),
          disabled_border: (
              red: 1.0,
              green: 0.96862745,
              blue: 0.5058823,
              alpha: 0.5,
          ),
      )
    '';

    # ── Builder config (so COSMIC Settings shows correct inputs) ──────

    "${builderPath}/palette".text = builtins.readFile ../themes/witch-hazel-hypercolor-palette.ron;

    "${builderPath}/accent".text = ''
      Some((
          red: 0.68235294,
          green: 0.50588235,
          blue: 1.00000000,
      ))
    '';

    "${builderPath}/bg_color".text = ''
      Some((
          red: 0.15686275,
          green: 0.14901961,
          blue: 0.20392157,
          alpha: 1.00000000,
      ))
    '';

    "${builderPath}/text_tint".text = ''
      Some((
          red: 0.97254902,
          green: 0.97254902,
          blue: 0.94901961,
      ))
    '';

    "${builderPath}/neutral_tint".text = ''
      Some((
          red: 0.44313725,
          green: 0.40392157,
          blue: 0.60000000,
      ))
    '';

    "${builderPath}/primary_container_bg".text = ''
      Some((
          red: 0.23137255,
          green: 0.21176471,
          blue: 0.30588235,
          alpha: 1.00000000,
      ))
    '';

    "${builderPath}/secondary_container_bg".text = ''
      Some((
          red: 0.26274510,
          green: 0.24313725,
          blue: 0.33725490,
          alpha: 1.00000000,
      ))
    '';

    "${builderPath}/window_hint".text = ''
      Some((
          red: 0.68235294,
          green: 0.50588235,
          blue: 1.00000000,
      ))
    '';

    "${builderPath}/success".text = ''
      Some((
          red: 0.50588235,
          green: 1.00000000,
          blue: 0.74509804,
      ))
    '';

    "${builderPath}/warning".text = ''
      Some((
          red: 1.00000000,
          green: 0.96862745,
          blue: 0.50588235,
      ))
    '';

    "${builderPath}/destructive".text = ''
      Some((
          red: 0.86274510,
          green: 0.43921569,
          blue: 0.43921569,
      ))
    '';

    "${builderPath}/corner_radii".text = ''
      (
          radius_0: (0.0, 0.0, 0.0, 0.0),
          radius_xs: (4.0, 4.0, 4.0, 4.0),
          radius_s: (8.0, 8.0, 8.0, 8.0),
          radius_m: (16.0, 16.0, 16.0, 16.0),
          radius_l: (32.0, 32.0, 32.0, 32.0),
          radius_xl: (160.0, 160.0, 160.0, 160.0),
      )
    '';

    "${builderPath}/spacing".text = ''
      (
          space_none: 0,
          space_xxxs: 4,
          space_xxs: 8,
          space_xs: 12,
          space_s: 16,
          space_m: 24,
          space_l: 32,
          space_xl: 48,
          space_xxl: 64,
          space_xxxl: 128,
      )
    '';

    "${builderPath}/is_frosted".text = "false";
    "${builderPath}/gaps".text = "(0, 8)";
    "${builderPath}/active_hint".text = "3";
  };

  # Importable .ron files for sharing/backup
  xdg.dataFile = {
    "cosmic-themes/witch-hazel-hypercolor-dark.ron".source = ../themes/witch-hazel-hypercolor-dark.ron;
    "cosmic-themes/witch-hazel-hypercolor-terminal.ron".source = ../themes/witch-hazel-hypercolor-terminal.ron;
  };
}
