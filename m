Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0DEC00145
	for <webhook@archiver.kernel.org>; Mon, 12 Dec 2022 16:03:41 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
 by mx.groups.io with SMTP id smtpd.web11.47288.1670861019936433436
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Dec 2022 08:03:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=VkbcHH/W;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.44, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f44.google.com with SMTP id o15so5842796wmr.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 12 Dec 2022 08:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=q+6oGzT1xHHhJo1KIauV8dl+6J6ff/EZ+DlJrwWODm8=;
        b=VkbcHH/W4vchibtyTqjVFSRvcwl3mlG4qWVEoNjhaCy74mTjNl9J9VEFODqKxwiI+7
         GONHcgf5ZLGA7L76iaQpPSBnxleq5vbJ4YuiYUzIgfE6fQA6RIV5VKbZcW4AM5M/iSJO
         FZpSve73UMT0adm7QkP14/4VUFr23qoUpT22o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+6oGzT1xHHhJo1KIauV8dl+6J6ff/EZ+DlJrwWODm8=;
        b=fIiWXicwp7Q7CPNTnFpJtsmpquyGmIKQ321UZbAg2us0Sn1Tfd91jSGDil9sf7Uhr7
         iEUc15tJh30GkVwRhbGTxiuEfQP+Mowv/UUnmvFPvcZIF1gZr9lCC02w7xCQlJ2wptpC
         xyjEC9IeFOcY7cBdUXk3V2E5ZPvKRW3WlcNDQgbSrnihZhmV6VI8ncHPJpfcHa8gJEpR
         EeNLw7k254X+6JX2SNK8vZQKqfPZ186jK0DUAjFv/5rCYwwQRrAVEleHL5vqNsI6i3Ht
         Assjy8fHWJBEJ6B6BGlzqz4RGBAgp1NmcwSMVjkt6+zh0D1WzMbf3Ym9uvc83T5FRARB
         6KlQ==
X-Gm-Message-State: ANoB5pmyeYC1EIGQanha3qvm2upMdzvHK7HOAURrX/YlJC497dAl8xTh
	FbKuRFE/dT9XYjzxq2ZdevSDwviAcIV6JXKz
X-Google-Smtp-Source: AA0mqf4YnvoBg3Vg04ay7f8yqaD29tdVYQIjLpWGs5AYt7qcJrdIwu0TbAXjFoUmJZTyQURLIwUzJQ==
X-Received: by 2002:a05:600c:348a:b0:3cf:69f4:bfd4 with SMTP id a10-20020a05600c348a00b003cf69f4bfd4mr13097312wmq.7.1670861017316;
        Mon, 12 Dec 2022 08:03:37 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:cbbc:8f6d:4f6e:ffe4])
        by smtp.gmail.com with ESMTPSA id n14-20020a05600c500e00b003cf774c31a0sm9984764wmr.16.2022.12.12.08.03.36
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 08:03:36 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] ast/data/codeparser: Add dependencies from python module functions
Date: Mon, 12 Dec 2022 16:03:34 +0000
Message-Id: <20221212160334.54431-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Dec 2022 16:03:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14182

Moving code into python modules is a very effective way to reduce parsing
time and overhead in recipes. The downside has always been that any
dependency information on which variables those functions access is lost
and the hashes can therefore become less reliable.

This patch adds parsing of the imported module functions and that dependency
information is them injected back into the hash dependency information.

Intermodule function references are resolved to the full function
call names in our module namespace to ensure interfunction dependencies
are correctly handled too.

(Bitbake rev: 605c478ce14cdc3c02d6ef6d57146a76d436a83c)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/codeparser.py       | 44 +++++++++++++++++++++++++++++++++-----
 lib/bb/data.py             | 15 +++++++++----
 lib/bb/parse/ast.py        | 12 +++++++++++
 lib/bb/tests/codeparser.py | 14 ++++++------
 4 files changed, 69 insertions(+), 16 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 9d66d3ae41..87846d85d6 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -27,6 +27,7 @@ import ast
 import sys
 import codegen
 import logging
+import inspect
 import bb.pysh as pysh
 import bb.utils, bb.data
 import hashlib
@@ -58,10 +59,34 @@ def check_indent(codestr):
 
     return codestr
 
-# A custom getstate/setstate using tuples is actually worth 15% cachesize by
-# avoiding duplication of the attribute names!
+modulecode_deps = {}
 
+def add_module_functions(fn, functions, namespace):
+    fstat = os.stat(fn)
+    fixedhash = fn + ":" + str(fstat.st_size) +  ":" + str(fstat.st_mtime)
+    #bb.warn(fixedhash)
+    for f in functions:
+        name = "%s.%s" % (namespace, f)
+        parser = bb.codeparser.PythonParser(name, logger)
+        try:
+            parser.parse_python(None, filename=fn, lineno=1, fixedhash=fixedhash+f)
+            #bb.warn("Cached %s" % f)
+        except KeyError:
+            lines, lineno = inspect.getsourcelines(functions[f])
+            src = "".join(lines)
+            parser.parse_python(src, filename=fn, lineno=lineno, fixedhash=fixedhash+f)
+            #bb.warn("Not cached %s" % f)
+        execs = parser.execs.copy()
+        # Expand internal module exec references
+        for e in parser.execs:
+            if e in functions:
+                execs.remove(e)
+                execs.add(namespace + "." + e)
+        bb.codeparser.modulecode_deps[name] = [parser.references.copy(), execs, parser.var_execs.copy(), parser.contains.copy()]
+        #bb.warn("%s: %s\nRefs:%s Execs: %s %s %s" % (name, src, parser.references, parser.execs, parser.var_execs, parser.contains))
 
+# A custom getstate/setstate using tuples is actually worth 15% cachesize by
+# avoiding duplication of the attribute names!
 class SetCache(object):
     def __init__(self):
         self.setcache = {}
@@ -289,11 +314,17 @@ class PythonParser():
         self.unhandled_message = "in call of %s, argument '%s' is not a string literal"
         self.unhandled_message = "while parsing %s, %s" % (name, self.unhandled_message)
 
-    def parse_python(self, node, lineno=0, filename="<string>"):
-        if not node or not node.strip():
+    # For the python module code it is expensive to have the function text so it is
+    # uses a different fixedhash to cache against. We can take the hit on obtaining the
+    # text if it isn't in the cache.
+    def parse_python(self, node, lineno=0, filename="<string>", fixedhash=None):
+        if not fixedhash and (not node or not node.strip()):
             return
 
-        h = bbhash(str(node))
+        if fixedhash:
+            h = fixedhash
+        else:
+            h = bbhash(str(node))
 
         if h in codeparsercache.pythoncache:
             self.references = set(codeparsercache.pythoncache[h].refs)
@@ -311,6 +342,9 @@ class PythonParser():
                 self.contains[i] = set(codeparsercache.pythoncacheextras[h].contains[i])
             return
 
+        if fixedhash and not node:
+            raise KeyError
+
         # Need to parse so take the hit on the real log buffer
         self.log = BufferedLogger('BitBake.Data.PythonParser', logging.DEBUG, self._log)
 
diff --git a/lib/bb/data.py b/lib/bb/data.py
index bfaa0410ea..841369699e 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -261,7 +261,7 @@ def emit_func_python(func, o=sys.__stdout__, d = init()):
                newdeps |= set((d.getVarFlag(dep, "vardeps") or "").split())
         newdeps -= seen
 
-def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_vars, d):
+def build_dependencies(key, keys, mod_funcs, shelldeps, varflagsexcl, ignored_vars, d):
     def handle_contains(value, contains, exclusions, d):
         newvalue = []
         if value:
@@ -289,6 +289,12 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_vars, d):
 
     deps = set()
     try:
+        if key in mod_funcs:
+            exclusions = set()
+            moddep = bb.codeparser.modulecode_deps[key]
+            value = handle_contains("", moddep[3], exclusions, d)
+            return frozenset((moddep[0] | keys & moddep[1]) - ignored_vars), value
+
         if key[-1] == ']':
             vf = key[:-1].split('[')
             if vf[1] == "vardepvalueexclude":
@@ -367,7 +373,8 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_vars, d):
 
 def generate_dependencies(d, ignored_vars):
 
-    keys = set(key for key in d if not key.startswith("__"))
+    mod_funcs = set(bb.codeparser.modulecode_deps.keys())
+    keys = set(key for key in d if not key.startswith("__")) | mod_funcs
     shelldeps = set(key for key in d.getVar("__exportlist", False) if d.getVarFlag(key, "export", False) and not d.getVarFlag(key, "unexport", False))
     varflagsexcl = d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS')
 
@@ -376,7 +383,7 @@ def generate_dependencies(d, ignored_vars):
 
     tasklist = d.getVar('__BBTASKS', False) or []
     for task in tasklist:
-        deps[task], values[task] = build_dependencies(task, keys, shelldeps, varflagsexcl, ignored_vars, d)
+        deps[task], values[task] = build_dependencies(task, keys, mod_funcs, shelldeps, varflagsexcl, ignored_vars, d)
         newdeps = deps[task]
         seen = set()
         while newdeps:
@@ -385,7 +392,7 @@ def generate_dependencies(d, ignored_vars):
             newdeps = set()
             for dep in nextdeps:
                 if dep not in deps:
-                    deps[dep], values[dep] = build_dependencies(dep, keys, shelldeps, varflagsexcl, ignored_vars, d)
+                    deps[dep], values[dep] = build_dependencies(dep, keys, mod_funcs, shelldeps, varflagsexcl, ignored_vars, d)
                 newdeps |=  deps[dep]
             newdeps -= seen
         #print "For %s: %s" % (task, str(deps[task]))
diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 862087c77d..375ba3cb79 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -290,6 +290,18 @@ class PyLibNode(AstNode):
             toimport = getattr(bb.utils._context[self.namespace], "BBIMPORTS", [])
             for i in toimport:
                 bb.utils._context[self.namespace] = __import__(self.namespace + "." + i)
+                mod = getattr(bb.utils._context[self.namespace], i)
+                fn = getattr(mod, "__file__")
+                funcs = {}
+                for f in dir(mod):
+                    if f.startswith("_"):
+                        continue
+                    fcall = getattr(mod, f)
+                    if not callable(fcall):
+                        continue
+                    funcs[f] = fcall
+                bb.codeparser.add_module_functions(fn, funcs, "%s.%s" % (self.namespace, i))
+
         except AttributeError as e:
             bb.error("Error importing OE modules: %s" % str(e))
 
diff --git a/lib/bb/tests/codeparser.py b/lib/bb/tests/codeparser.py
index 71ed382ab8..a508f23bcb 100644
--- a/lib/bb/tests/codeparser.py
+++ b/lib/bb/tests/codeparser.py
@@ -318,7 +318,7 @@ d.getVar(a(), False)
             "filename": "example.bb",
         })
 
-        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), self.d)
+        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), set(), self.d)
 
         self.assertEqual(deps, set(["somevar", "bar", "something", "inexpand", "test", "test2", "a"]))
 
@@ -365,7 +365,7 @@ esac
         self.d.setVarFlags("FOO", {"func": True})
         self.setEmptyVars(execs)
 
-        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), self.d)
+        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), set(), self.d)
 
         self.assertEqual(deps, set(["somevar", "inverted"] + execs))
 
@@ -375,7 +375,7 @@ esac
         self.d.setVar("FOO", "foo=oe_libinstall; eval $foo")
         self.d.setVarFlag("FOO", "vardeps", "oe_libinstall")
 
-        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), self.d)
+        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), set(), self.d)
 
         self.assertEqual(deps, set(["oe_libinstall"]))
 
@@ -384,7 +384,7 @@ esac
         self.d.setVar("FOO", "foo=oe_libinstall; eval $foo")
         self.d.setVarFlag("FOO", "vardeps", "${@'oe_libinstall'}")
 
-        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), self.d)
+        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), set(), self.d)
 
         self.assertEqual(deps, set(["oe_libinstall"]))
 
@@ -399,7 +399,7 @@ esac
         # Check dependencies
         self.d.setVar('ANOTHERVAR', expr)
         self.d.setVar('TESTVAR', 'anothervalue testval testval2')
-        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), set(), self.d)
+        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), set(), set(), self.d)
         self.assertEqual(sorted(values.splitlines()),
                          sorted([expr,
                           'TESTVAR{anothervalue} = Set',
@@ -418,14 +418,14 @@ esac
         self.d.setVar('ANOTHERVAR', varval)
         self.d.setVar('TESTVAR', 'anothervalue testval testval2')
         self.d.setVar('TESTVAR2', 'testval3')
-        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), set(["TESTVAR"]), self.d)
+        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), set(), set(["TESTVAR"]), self.d)
         self.assertEqual(sorted(values.splitlines()), sorted([varval]))
         self.assertEqual(deps, set(["TESTVAR2"]))
         self.assertEqual(self.d.getVar('ANOTHERVAR').split(), ['testval3', 'anothervalue'])
 
         # Check the vardepsexclude flag is handled by contains functionality
         self.d.setVarFlag('ANOTHERVAR', 'vardepsexclude', 'TESTVAR')
-        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), set(), self.d)
+        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), set(), set(), self.d)
         self.assertEqual(sorted(values.splitlines()), sorted([varval]))
         self.assertEqual(deps, set(["TESTVAR2"]))
         self.assertEqual(self.d.getVar('ANOTHERVAR').split(), ['testval3', 'anothervalue'])
-- 
2.37.2


