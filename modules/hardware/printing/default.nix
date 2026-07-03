{ ... }:
{
  flake.nixosModules.printingModule = { ... }: {
    services.printing.enable = true;
  };
}

