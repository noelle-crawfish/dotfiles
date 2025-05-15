{ lib, pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      hello
    ];

    username = "noelle";
    homeDirectory = "/home/noelle";

    stateVersion = "23.11";
  };
}
