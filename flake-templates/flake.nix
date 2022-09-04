{
  description = "My personal flake templates";

  outputs = {self, ...}: {

    templates = {

      python = {
        path = ./python;
        description = "A simple python template using mach-nix";
      };

      ruby = {
        path = ./ruby;
        description = "A simple ruby template";
      };

    };

    defaultTemplate = self.templates.python;

  };
}
