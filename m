Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DEEC4332F
	for <webhook@archiver.kernel.org>; Mon, 28 Nov 2022 16:35:01 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.122726.1669653297922387112
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 28 Nov 2022 08:34:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=b0TWTMlx;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id bs21so17777757wrb.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 28 Nov 2022 08:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8DHjju/lk23wuurqzn4xQBG4D/TWartcMcbJ/t+cmIA=;
        b=b0TWTMlxN6EvjwSdLB9EZ4Y2RHNeHBfXGhWGo5osZqk/aDHtRNZJB2rMNXSsFBrifJ
         FGiQXqIOgW/Ayp+MTQWITnzxGUMVVknLPo6vzIjR9JyS7LMXQq44gXzy5XlCLXjX4W+v
         tqLZMdEsJyqX0QmzaOi9buvsqEr4MRZv0aVvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8DHjju/lk23wuurqzn4xQBG4D/TWartcMcbJ/t+cmIA=;
        b=3K715KO500FfmO6zdjWXzE4O6nUiyMymh+bUfQmlNwWza14kqkA7nKZmFD/InQnqkw
         Lh+6iSS6QjOOjjD2oRpCLZhuseH0TMtkamySED2s+o8j7hvHjiLt8IoCTv8683t2sVK2
         HX2/PQ26BSKfgK+AO+DuNVn2m9td/5VATLnfs8F9R5nZkYZ1BdEC+WPhiKemoRQLJy6E
         TV063BqWWVzb8ZrXzQOjqTdtjAEJ1Gpb7rjgDXthDQoOYtAWOzTux5MnGWDnFEY9I/eN
         5QqZc3MYRcxEgy7Mf/4noA30yaTZcl6uegy/5YFe4wiGK3WYeVIpR8Ruz9kcR/KCcQk8
         +0fw==
X-Gm-Message-State: ANoB5pmfrXzvJRbIvxJm0PPqO/o3D0SY+0+VcTn24hQhXNIabx6nbWvJ
	yjy6TLQPzhg2lruTp4N4jAZQZm9jRbUoug==
X-Google-Smtp-Source: AA0mqf7RluAEuCsl+5NSet4w1esgB4Jc8Vjy9IuGT6b1dpowiWi8RT0Q2QkQ0o23QlKdoZ6NaYmI2g==
X-Received: by 2002:adf:eb81:0:b0:236:4ba1:fb2d with SMTP id t1-20020adfeb81000000b002364ba1fb2dmr33035462wrn.570.1669653295719;
        Mon, 28 Nov 2022 08:34:55 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1da4:7286:b644:a924])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c198d00b003cf54b77bfesm22333208wmq.28.2022.11.28.08.34.55
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 08:34:55 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH RFC 2/2 v2] ast/data: Add dependencies from python module functions
Date: Mon, 28 Nov 2022 16:34:53 +0000
Message-Id: <20221128163453.685533-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 28 Nov 2022 16:35:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14122

Moving code into python modules is a very effective way to reduce parsing
time and overhead in recipes. The downside has always been that any
dependency information on which variables those functions access is lost
and the hashes can therefore become less reliable.

This patch adds parsing of the imported module functions and that dependency
information is them injected back into the hash dependency information.

Intermodule function references are resolved to the full function
call names in our module namespace to ensure interfunction dependencies
are correctly handled too.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/codeparser.py |  2 ++
 lib/bb/data.py       | 40 +++++++++++++++++++++++-----------------
 lib/bb/parse/ast.py  | 26 +++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 18 deletions(-)

v2: Drop dict merging code that doesn't work with python pre 3.9
    Fix parser.copy

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 9d66d3ae41..e7d7ebe048 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -36,6 +36,8 @@ from bb.cache import MultiProcessCache
 
 logger = logging.getLogger('BitBake.CodeParser')
 
+modulecode_deps = {}
+
 def bbhash(s):
     return hashlib.sha256(s.encode("utf-8")).hexdigest()
 
diff --git a/lib/bb/data.py b/lib/bb/data.py
index 22d314d6c2..ab1a5959ba 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -261,22 +261,9 @@ def emit_func_python(func, o=sys.__stdout__, d = init()):
                newdeps |= set((d.getVarFlag(dep, "vardeps") or "").split())
         newdeps -= seen
 
-def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_vars, d):
+def build_dependencies(key, keys, mod_funcs, shelldeps, varflagsexcl, ignored_vars, d):
     deps = set()
     try:
-        if key[-1] == ']':
-            vf = key[:-1].split('[')
-            if vf[1] == "vardepvalueexclude":
-                return deps, ""
-            value, parser = d.getVarFlag(vf[0], vf[1], False, retparser=True)
-            deps |= parser.references
-            deps = deps | (keys & parser.execs)
-            deps -= ignored_vars
-            return frozenset(deps), value
-        varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude", "exports", "postfuncs", "prefuncs", "lineno", "filename"]) or {}
-        vardeps = varflags.get("vardeps")
-        exclusions = varflags.get("vardepsexclude", "").split()
-
         def handle_contains(value, contains, exclusions, d):
             newvalue = []
             if value:
@@ -294,6 +281,24 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_vars, d):
                         newvalue.append("\n%s{%s} = Set" % (k, item))
             return "".join(newvalue)
 
+        if key in mod_funcs:
+            exclusions = set()
+            moddep = bb.codeparser.modulecode_deps[key]
+            value = handle_contains("", moddep[3], exclusions, d)
+            return frozenset(moddep[0] - ignored_vars), value
+        if key[-1] == ']':
+            vf = key[:-1].split('[')
+            if vf[1] == "vardepvalueexclude":
+                return deps, ""
+            value, parser = d.getVarFlag(vf[0], vf[1], False, retparser=True)
+            deps |= parser.references
+            deps = deps | (keys & parser.execs)
+            deps -= ignored_vars
+            return frozenset(deps), value
+        varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude", "exports", "postfuncs", "prefuncs", "lineno", "filename"]) or {}
+        vardeps = varflags.get("vardeps")
+        exclusions = varflags.get("vardepsexclude", "").split()
+
         def handle_remove(value, deps, removes, d):
             for r in sorted(removes):
                 r2 = d.expandWithRefs(r, None)
@@ -367,7 +372,8 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_vars, d):
 
 def generate_dependencies(d, ignored_vars):
 
-    keys = set(key for key in d if not key.startswith("__"))
+    mod_funcs = set(bb.codeparser.modulecode_deps.keys())
+    keys = set(key for key in d if not key.startswith("__")) | mod_funcs
     shelldeps = set(key for key in d.getVar("__exportlist", False) if d.getVarFlag(key, "export", False) and not d.getVarFlag(key, "unexport", False))
     varflagsexcl = d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS')
 
@@ -376,7 +382,7 @@ def generate_dependencies(d, ignored_vars):
 
     tasklist = d.getVar('__BBTASKS', False) or []
     for task in tasklist:
-        deps[task], values[task] = build_dependencies(task, keys, shelldeps, varflagsexcl, ignored_vars, d)
+        deps[task], values[task] = build_dependencies(task, keys, mod_funcs, shelldeps, varflagsexcl, ignored_vars, d)
         newdeps = deps[task]
         seen = set()
         while newdeps:
@@ -385,7 +391,7 @@ def generate_dependencies(d, ignored_vars):
             newdeps = set()
             for dep in nextdeps:
                 if dep not in deps:
-                    deps[dep], values[dep] = build_dependencies(dep, keys, shelldeps, varflagsexcl, ignored_vars, d)
+                    deps[dep], values[dep] = build_dependencies(dep, keys, mod_funcs, shelldeps, varflagsexcl, ignored_vars, d)
                 newdeps |=  deps[dep]
             newdeps -= seen
         #print "For %s: %s" % (task, str(deps[task]))
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 7bfee9ed67..07993a3cdb 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -10,6 +10,7 @@
 #
 
 import sys
+import inspect
 import bb
 from bb import methodpool
 from bb.parse import logger
@@ -284,7 +285,30 @@ class PyLibNode(AstNode):
             bb.utils._context[self.namespace] = __import__(self.namespace)
             toimport = getattr(bb.utils._context[self.namespace], "BBIMPORTS", [])
             for i in toimport:
-                bb.utils._context[i.split(".", 1)[0]] = __import__(i)
+                base = i.split(".", 1)[0]
+                bb.utils._context[base] = __import__(i)
+                if "." in i:
+                    mod = getattr(bb.utils._context[base], i.split(".", 1)[1])
+                    funcs = dir(mod)
+                    for f in funcs:
+                        if f.startswith("_"):
+                            continue
+                        fcall = getattr(mod, f)
+                        if not callable(fcall):
+                            continue
+                        src = inspect.getsource(fcall)
+                        name = "%s.%s" % (i, f)
+                        parser = bb.codeparser.PythonParser(name, logger)
+                        parser.parse_python(src, filename=inspect.getfile(fcall), lineno=1)
+                        execs = parser.execs.copy()
+                        # Expand internal module exec references
+                        for e in parser.execs:
+                            if e in funcs:
+                                execs.remove(e)
+                                execs.add(i + "." + e)
+                        bb.codeparser.modulecode_deps[name] = [parser.references.copy(), execs, parser.var_execs.copy(), parser.contains.copy()]
+                        #bb.warn("%s: %s\nRefs:%s Execs: %s %s %s" % (name, src, parser.references, parser.execs, parser.var_execs, parser.contains))
+
         except AttributeError as e:
             bb.error("Error importing OE modules: %s" % str(e))
 
-- 
2.34.1


