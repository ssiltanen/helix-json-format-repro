{ pkgs, ... }:

{
  packages = [
    pkgs.git
    pkgs.typescript-language-server
    pkgs.vscode-json-languageserver
  ];

  languages.javascript.enable = true;
  languages.javascript.npm.enable = true;

  enterShell = ''
    echo node --version
    node --version
    echo npm --version
    npm --version

    npm ci

    npm ls typescript
    npm ls prettier
  '';
}
