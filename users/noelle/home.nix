{ pkgs, username, ... }:
{
  specialArgs = { inherit username; };
  imports = [
    ../../home/default.nix
  ]

  programs.git = {
    userName = "Noelle Crawford";
    userEmail = "noellecrawfish@gmail.com";
  };
}
