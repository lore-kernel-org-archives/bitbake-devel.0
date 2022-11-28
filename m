Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6F9C433FE
	for <webhook@archiver.kernel.org>; Mon, 28 Nov 2022 14:32:20 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
 by mx.groups.io with SMTP id smtpd.web10.119166.1669645937812423601
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Nov 2022 06:32:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=q05zCweM;
 spf=pass (domain: gmail.com, ip: 209.85.218.45, mailfrom: jpewhacker@gmail.com)
Received: by mail-ej1-f45.google.com with SMTP id e27so26224466ejc.12
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Nov 2022 06:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CQQg1jDCquSeJEgb3kgZ0wa+yvuqZbOZMFJ1xg77iTI=;
        b=q05zCweMzC8JLmePyFI8T2rvj4USAVY0uDRfjIOROgBSX4CgLCMivS6VrOtYCz07E8
         GwrqbpjoB8ZYBisLctb6Uy2ORaKKH2kRfycdT1tQ41hzKNrP4daIhPXuthAF0wcDL0wl
         68Sd2IbvZCWu+UCgtrQ+666mH98vH/9haNEgXeEjnin88XTfW9BZAmhA44A+19YSoNmw
         D0Uc2vVUiG1sSsOQDQ5TZ0OHvIbGk74mXZs5bEjdmw3+1U7l+Rm90DCzKofAjwvzZlNw
         WInquh9t1RsnuqWzQlxK5WgcnKKYSBkcV1aR6txw7LPONdmRcfKuwdnVJFv0yPMz2dpr
         ZMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CQQg1jDCquSeJEgb3kgZ0wa+yvuqZbOZMFJ1xg77iTI=;
        b=aGRLUxKY5jTS1Gw2aUaTS8NjNPzMxJVMLRJOIyf9kyYABCYLMRiZesqKODWRlA/5p1
         GP2Xj8ewhjTB5niuxO9ncWGnKlFYd9aq/a9x5pSt0JGtdiVl/kxsD710JgUUplKMmoaH
         +NHo3L/PyYTfb943wheehzRo5RFD7MEUOOH6xjtLz9fUNEaeGMlT3WLis5bjQDx0T9NU
         KR1Cwr0gWugufMyTtpvwYR/SBRK4JYuZ59veP29RzJ10+3wza672dpemM9+sMbXHZC7b
         KP3uxDp9zN8tth1TulLy+Wt8Zxrj40in8NDmfQiQ3RhIbX71ZAig02EFM1EirPx4BU4C
         y0IA==
X-Gm-Message-State: ANoB5plFIIN9flq+FZWUpzkqiD+RIkcj+d654gNbA+ooKoqXAlMjNe64
	nPv6scaGbzPIzfuBzNhpxa87KixHsEFAP/V9Swo=
X-Google-Smtp-Source: AA0mqf7OJM/yCfECQBvmCNEY11PYJpf5zV0PCV1b4OPudUos13Rw/v4WHeTQ/3/cVR53D9+SRGY+zjGUnXNyQPQtJa4=
X-Received: by 2002:a17:906:3952:b0:7b9:2a28:f6ff with SMTP id
 g18-20020a170906395200b007b92a28f6ffmr25018910eje.61.1669645935988; Mon, 28
 Nov 2022 06:32:15 -0800 (PST)
MIME-Version: 1.0
References: <20221127213610.539976-1-richard.purdie@linuxfoundation.org> <20221127213610.539976-2-richard.purdie@linuxfoundation.org>
In-Reply-To: <20221127213610.539976-2-richard.purdie@linuxfoundation.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Mon, 28 Nov 2022 08:32:04 -0600
Message-ID: <CAJdd5GbhgOf_9fKvk==RXLiOdW57DHvcdktDAsU6aaSDM-d3Qw@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH RFC 2/2] ast/data: Add dependencies from
 python module functions
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Nov 2022 14:32:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14120

On Sun, Nov 27, 2022 at 3:36 PM Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
>
> Moving code into python modules is a very effective way to reduce parsing
> time and overhead in recipes. The downside has always been that any
> dependency information on which variables those functions access is lost
> and the hashes can therefore become less reliable.
>
> This patch adds parsing of the imported module functions and that dependency
> information is them injected back into the hash dependency information.
>
> Intermodule function references are resolved to the full function
> call names in our module namespace to ensure interfunction dependencies
> are correctly handled too.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/codeparser.py |  2 ++
>  lib/bb/data.py       | 40 +++++++++++++++++++++++-----------------
>  lib/bb/parse/ast.py  | 40 +++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 64 insertions(+), 18 deletions(-)
>
> diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
> index 9d66d3ae41..e7d7ebe048 100644
> --- a/lib/bb/codeparser.py
> +++ b/lib/bb/codeparser.py
> @@ -36,6 +36,8 @@ from bb.cache import MultiProcessCache
>
>  logger = logging.getLogger('BitBake.CodeParser')
>
> +modulecode_deps = {}
> +
>  def bbhash(s):
>      return hashlib.sha256(s.encode("utf-8")).hexdigest()
>
> diff --git a/lib/bb/data.py b/lib/bb/data.py
> index 22d314d6c2..ab1a5959ba 100644
> --- a/lib/bb/data.py
> +++ b/lib/bb/data.py
> @@ -261,22 +261,9 @@ def emit_func_python(func, o=sys.__stdout__, d = init()):
>                 newdeps |= set((d.getVarFlag(dep, "vardeps") or "").split())
>          newdeps -= seen
>
> -def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_vars, d):
> +def build_dependencies(key, keys, mod_funcs, shelldeps, varflagsexcl, ignored_vars, d):
>      deps = set()
>      try:
> -        if key[-1] == ']':
> -            vf = key[:-1].split('[')
> -            if vf[1] == "vardepvalueexclude":
> -                return deps, ""
> -            value, parser = d.getVarFlag(vf[0], vf[1], False, retparser=True)
> -            deps |= parser.references
> -            deps = deps | (keys & parser.execs)
> -            deps -= ignored_vars
> -            return frozenset(deps), value
> -        varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude", "exports", "postfuncs", "prefuncs", "lineno", "filename"]) or {}
> -        vardeps = varflags.get("vardeps")
> -        exclusions = varflags.get("vardepsexclude", "").split()
> -
>          def handle_contains(value, contains, exclusions, d):
>              newvalue = []
>              if value:
> @@ -294,6 +281,24 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_vars, d):
>                          newvalue.append("\n%s{%s} = Set" % (k, item))
>              return "".join(newvalue)
>
> +        if key in mod_funcs:
> +            exclusions = set()
> +            moddep = bb.codeparser.modulecode_deps[key]
> +            value = handle_contains("", moddep[3], exclusions, d)
> +            return frozenset(moddep[0] - ignored_vars), value
> +        if key[-1] == ']':
> +            vf = key[:-1].split('[')
> +            if vf[1] == "vardepvalueexclude":
> +                return deps, ""
> +            value, parser = d.getVarFlag(vf[0], vf[1], False, retparser=True)
> +            deps |= parser.references
> +            deps = deps | (keys & parser.execs)
> +            deps -= ignored_vars
> +            return frozenset(deps), value
> +        varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude", "exports", "postfuncs", "prefuncs", "lineno", "filename"]) or {}
> +        vardeps = varflags.get("vardeps")
> +        exclusions = varflags.get("vardepsexclude", "").split()
> +
>          def handle_remove(value, deps, removes, d):
>              for r in sorted(removes):
>                  r2 = d.expandWithRefs(r, None)
> @@ -367,7 +372,8 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_vars, d):
>
>  def generate_dependencies(d, ignored_vars):
>
> -    keys = set(key for key in d if not key.startswith("__"))
> +    mod_funcs = set(bb.codeparser.modulecode_deps.keys())
> +    keys = set(key for key in d if not key.startswith("__")) | mod_funcs
>      shelldeps = set(key for key in d.getVar("__exportlist", False) if d.getVarFlag(key, "export", False) and not d.getVarFlag(key, "unexport", False))
>      varflagsexcl = d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS')
>
> @@ -376,7 +382,7 @@ def generate_dependencies(d, ignored_vars):
>
>      tasklist = d.getVar('__BBTASKS', False) or []
>      for task in tasklist:
> -        deps[task], values[task] = build_dependencies(task, keys, shelldeps, varflagsexcl, ignored_vars, d)
> +        deps[task], values[task] = build_dependencies(task, keys, mod_funcs, shelldeps, varflagsexcl, ignored_vars, d)
>          newdeps = deps[task]
>          seen = set()
>          while newdeps:
> @@ -385,7 +391,7 @@ def generate_dependencies(d, ignored_vars):
>              newdeps = set()
>              for dep in nextdeps:
>                  if dep not in deps:
> -                    deps[dep], values[dep] = build_dependencies(dep, keys, shelldeps, varflagsexcl, ignored_vars, d)
> +                    deps[dep], values[dep] = build_dependencies(dep, keys, mod_funcs, shelldeps, varflagsexcl, ignored_vars, d)
>                  newdeps |=  deps[dep]
>              newdeps -= seen
>          #print "For %s: %s" % (task, str(deps[task]))
> diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
> index 7bfee9ed67..7dbb1adfa8 100644
> --- a/lib/bb/parse/ast.py
> +++ b/lib/bb/parse/ast.py
> @@ -10,6 +10,7 @@
>  #
>
>  import sys
> +import inspect
>  import bb
>  from bb import methodpool
>  from bb.parse import logger
> @@ -284,7 +285,44 @@ class PyLibNode(AstNode):
>              bb.utils._context[self.namespace] = __import__(self.namespace)
>              toimport = getattr(bb.utils._context[self.namespace], "BBIMPORTS", [])
>              for i in toimport:
> -                bb.utils._context[i.split(".", 1)[0]] = __import__(i)
> +                base = i.split(".", 1)[0]
> +                bb.utils._context[base] = __import__(i)
> +                if "." in i:
> +                    mod = getattr(bb.utils._context[base], i.split(".", 1)[1])
> +                    funcs = dir(mod)
> +                    for f in funcs:
> +                        if f.startswith("_"):
> +                            continue
> +                        fcall = getattr(mod, f)
> +                        if not callable(fcall):
> +                            continue
> +                        src = inspect.getsource(fcall)

While the text of a module should always be present, making python go
back to it is probably inefficient when it's already gone through the
effort of converting it to byte code (I beleive it has to go find the
corresponding .py file for the .pyc file it already loaded into
memory). Perhaps we can split out the part of PythonParser that deals
with the compiled AST to a new function and call that with inspect?

Maybe something like:

  bytecode = inspect.getmembers_static(fcall, "__code__")[0][1]
  parser.parse_python_ast(bytecode)

> +                        name = "%s.%s" % (i, f)
> +                        parser = bb.codeparser.PythonParser(name, logger)
> +                        parser.parse_python(src, filename=inspect.getfile(fcall), lineno=1)
> +                        execs = parser.execs
> +                        # Expand internal module exec references
> +                        for e in parser.execs:
> +                            if e in funcs:
> +                                execs.remove(e)

You are modifying parser.execs in place which will ruin your
iteration. I think you probably want:

 execs = {f"{i}.{e}" if e in funcs else e for e in parser.execs}

Or if you don't want list comprehension:

 execs = []
 for e in parse.execs:
   if e in funcs:
     execs.add(f"{i}.{e}")
  else:
     execs.add(e)

> +                                execs.add(i + "." + e)
> +                        bb.codeparser.modulecode_deps[name] = [parser.references.copy(), execs, parser.var_execs.copy(), parser.contains.copy()]
> +                        #bb.warn("%s: %s\nRefs:%s Execs: %s %s %s" % (name, src, parser.references, parser.execs, parser.var_execs, parser.contains))
> +
> +            # Resolve intermodule references now, stack dependencies
> +            found = True
> +            while found:
> +                found = False
> +                funcs = set(bb.codeparser.modulecode_deps.keys())
> +                for entry in bb.codeparser.modulecode_deps:
> +                    for dup in (bb.codeparser.modulecode_deps[entry][1] & funcs):
> +                        found = True
> +                        bb.codeparser.modulecode_deps[entry][1].remove(dup)
> +                        bb.codeparser.modulecode_deps[entry][0] |= bb.codeparser.modulecode_deps[dup][0]
> +                        bb.codeparser.modulecode_deps[entry][1] |= bb.codeparser.modulecode_deps[dup][1]
> +                        bb.codeparser.modulecode_deps[entry][2] |= bb.codeparser.modulecode_deps[dup][2]
> +                        bb.codeparser.modulecode_deps[entry][3] |= bb.codeparser.modulecode_deps[dup][3]
> +
>          except AttributeError as e:
>              bb.error("Error importing OE modules: %s" % str(e))
>
> --
> 2.34.1
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14116): https://lists.openembedded.org/g/bitbake-devel/message/14116
> Mute This Topic: https://lists.openembedded.org/mt/95297764/3616693
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [JPEWhacker@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

