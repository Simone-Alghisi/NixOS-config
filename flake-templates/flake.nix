{
  description = "My personal flake templates";

  outputs = {self, ...}: {

    templates = {

      python = {
        path = ./python;
        description = "A simple python template using mach-nix";
      };

    };

    defaultTemplate = self.templates.python;

  };
}
