{
  lib,
  ...
}@input:
let
  chain = fns: m: lib.foldl (x: f: f x) m fns;
  condChain =
    fns:
    (chain (
      [
        (m: {
          val = m;
          return = false;
        })
      ]
      ++ lib.map (
        {
          cond,
          fn,
          return ? false,
        }:
        m:
        if cond m.val && !m.return then
          {
            val = fn m.val;
            return = m.return || return;
          }
        else
          m
      ) fns
      ++ [ (m: m.val) ]
    ));

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
        config = m;
      };
    }
    {
      cond = m: !m ? imports;
      fn = m: m // { imports = [ ]; };
    }
    {
      cond = m: !m ? options;
      fn = m: m // { options = { }; };
    }
  ];

  isNotMergable = value: (lib.isBool value || lib.isInt value || lib.isFloat value);
  mkDefault = condChain [
    {
      cond = lib.isType "override";
      fn = m: m;
      return = true;
    }
    {
      cond = lib.isType "merge";
      fn = m: {
        _type = "merge";
        content = lib.map mkDefault m.content;
      };
      return = true;
    }
    {
      cond = m: m ? _type && m ? content;
      fn = m: m // { content = mkDefault m.content; };
      return = true;
    }
    {
      cond = isNotMergable;
      fn = lib.mkDefault;
    }
  ];

  mkModuleIf =
    cond:
    chain [
      normalizeMod
      (mod: {
        imports = lib.map (mkModuleIf cond) mod.imports;
        options = mod.options;
        config = lib.mkIf cond (
          lib.mapAttrsRecursiveCond (m: !(m ? _type && m ? content)) (_: mkDefault) mod.config
        );
      })
    ];
in
{
  inherit mkModuleIf;
}
