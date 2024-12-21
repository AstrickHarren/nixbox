{
  programs.git = {
    aliases = {
      a = "add";
      aa = "add --all";

      b = "branch";
      ba = "branch -a";
      bc = "rev-parse --abbrev-ref HEAD";
      bd = "branch -d";
      bm = "branch -m";
      br = "branch -r";

      c = "commit";
      ca = "commit -a";
      cad = "commit -a --amend";
      cadn = "commit -a --amend --no-edit";
      cam = "commit -am";
      cd = "commit --amend";
      cdn = "commit --amend --no-edit";
      cm = "commit -m";

      d = "diff";
      ds = "diff --staged";

      f = "fetch";

      l = "log --oneline --decorate --graph -n 10";
      ll = "log --oneline --decorate --graph";

      m = "merge";
      ma = "merge --abort";
      mc = "merge --continue";

      psot = "git push origin tag";
      pl = "pull";
      ps = "push";
      psf = "push --force";
      psfl = "push --force-with-lease";
      psuoc = "!git push -u origin $(git bc)";

      o = "checkout";
      ob = "checkout -b";

      r = "remote";
      rao = "remote add origin";

      rb = "rebase";
      rba = "rebase --abort";
      rbc = "rebase --continue";
      rbi = "rebase -i";
      rbih = "!f() { git rebase -i HEAD~$1; }; f";

      reh = "reset --hard";
      rehh = "!f() { git reset --hard HEAD~$1; }; f";
      reho = "!f() { git reset --hard origin/$(git bc); }; f";
      rem = "reset --mixed";
      remh = "!f() { git reset --mixed HEAD~$1; }; f";
      remo = "!f() { git reset --mixed origin/$(git bc); }; f";
      res = "reset --soft";
      resh = "!f() { git reset --soft HEAD~$1; }; f";
      reso = "!f() { git reset --soft origin/$(git bc); }; f";

      s = "status -s -b";
      sa = "stash apply";
      sc = "stash clear";
      sd = "stash drop";
      sl = "stash list";
      sp = "stash pop";
      ss = "stash save";
      ssm = "stash save -m";
      sw = "stash show";

      t = "tag";
      td = "tag -d";

      u = "restore";
      us = "restore --staged";

      w = "show";
      ws = "show --stat";

      undo = "reset HEAD~1 --mixed";
      fork = "!f() { git l $(git bc) $1 --not $(git merge-base $(git bc) $1)^; };f";
    };
  };

  home.shellAliases = {
    g = "git";
  };
}
