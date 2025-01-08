{
  lib,
  ...
}@input:
let
  chain = fns: m: lib.foldl (x: f: f x) m fns;
  condChain = fns: (chain (lib.map ({ cond, fn }: m: if cond m then fn m else m) fns));

  normalizeMod = condChain [
    {
      cond = lib.isPath;
      fn = import;
    }
    {
      cond = lib.isType "if";
      fn = m: {
        _type = "if";
        condition = m.condition;
        content = normalizeMod m.content;
      };
    }
    {
      cond = lib.isFunction;
      fn = m: m input;
    }
    {
      cond = m: !m ? config;
      fn = m: {
        imports = [ ];
        config = m;
        options = { };
      };
    }
  ];

  isNotMergable = value: (lib.isBool value || lib.isInt value || lib.isFloat value);
  mkDefault = condChain [
    {
      cond = lib.isType "override";
      fn = m: {
        _type = "override";
        priority = m.priority;
        content = mkDefault m.content;
      };
    }
    {
      cond = lib.isType "if";
      fn = m: {
        _type = "if";
        condition = m.condition;
        content = mkDefault m.content;
      };
    }
    {
      cond = isNotMergable;
      fn = lib.mkDefault;
    }
  ];

  mkDefaultModule = chain [
    normalizeMod
    (mod: {
      imports = lib.map mkDefaultModule mod.imports;
      options = mod.options;
      config = lib.mapAttrsRecursive (_: mkDefault) mod.config;
    })
  ];

  mkModuleIf =
    cond:
    chain [
      mkDefaultModule
      (mod: mod // { config = lib.mkIf cond mod.config; })
    ];
in
{
  inherit mkModuleIf;
}
