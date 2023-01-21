Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EEEC38142
	for <webhook@archiver.kernel.org>; Sat, 21 Jan 2023 21:23:18 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.6463.1674336190708745600
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 21 Jan 2023 13:23:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=hU4ZpRkG;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so6009234wms.2
        for <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 13:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SpZTXnUbhXiScHiSe/6y+1FKqxPAXZrlcCcvBfUPrs4=;
        b=hU4ZpRkGolPRfO4W962pVd6daWG1LWV8Db5r4i4J+GocabS31GiGRXgpKPKXLAB6f8
         c7eA4kuGzBRrBcwzV4QMXRTfgM6m6cxfbipB9pDPsLDf6EymqGFLpmTVwwhvXMAJsazo
         UmOqnOv8rEOzNkzXdTU8PXSh/xsYrFhIMErKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SpZTXnUbhXiScHiSe/6y+1FKqxPAXZrlcCcvBfUPrs4=;
        b=tFICr4Gk2mn7vAPGJQXweilmNudingn+yTzMNN9nPryd4YGLkYWGigEcOEBJmh+ITU
         /ckB3X8dn8/QOsXHxtdnWiFG/k/IapvS5epWwwiCa1Y/lqVSby/EYm76U3mg9C5O4p0n
         xkIA3500e2nwXg5vRTUYrXR5DmwIB3ARflb6IGnt+VHnkPHnnwNPRtY8+tkbL9YWXOKE
         SQGtiIdjeRXFaXp3oyLSS1IolqlZIuY7y/lTpoOKbqBQgJGUwK9xz0ejy8S5s6vq0KPn
         j3Ib7hA0/HTBPJ2tQnTMOj8sKHrYFjqgnxmkOMo7xEy7I1CiJZWK2CrmYuc1BlBy+N5g
         kz9Q==
X-Gm-Message-State: AFqh2koZONMXl23Nkg6Il0PbtFex5mnUOdJSIiF0tLLbdN4mG2IUJnGx
	bzZWz11Xvs8dyXacMP7226xTBwmxvMXMIBVR
X-Google-Smtp-Source: AMrXdXvjwKJq19seKy3cybVS0zA3beKUmf2r2JqUBiN7ARI6F81bCCuFAwXK6xZsZCAs0Hh4zsnvHw==
X-Received: by 2002:a05:600c:4928:b0:3d2:2043:9cb7 with SMTP id f40-20020a05600c492800b003d220439cb7mr18608010wmp.5.1674336188858;
        Sat, 21 Jan 2023 13:23:08 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:3f1f:fd3b:ca38:d2c5])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c359000b003da105437besm6713089wmq.29.2023.01.21.13.23.08
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 13:23:08 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 5/6] data: Add sup0port for new BB_HASH_CODEPARSER_VALS for cache optimisation
Date: Sat, 21 Jan 2023 21:23:04 +0000
Message-Id: <20230121212305.2171310-5-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230121212305.2171310-1-richard.purdie@linuxfoundation.org>
References: <20230121212305.2171310-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 21 Jan 2023 21:23:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14333

Currently the codeparser cache ends up being extended for every parse run
since there are values in the functions such as the result of os.getpid()
from LOGFIFO in OE-Core.

Digging into that issue, there are also lots of similar but different
functions being parsed where the change might just be a path to WORKDIR,
a change in PN or PV or something like DATE/TIME.

There is no reason we have to use these changing values when computing the
dependenies of the functions. Even with a small tweak like:

BB_HASH_CODEPARSER_VALS = "LOGFIFO=/ T=/ WORKDIR=/ DATE=1234 TIME=1234 PV=0.0-1 PN=nopn"

the cache is reduced from ~4.6MB, increasing by ~300kb for every parse run
to around 1.3MB and remaining static for oe-core and meta-oe. In my local
build, admittedly heavily experimented with, the cache had grown to 120MB.

The benefits of doing this are:

 * faster load time for bitbake since the cache is smaller to read from disk
   and load into memory
 * being able to skip saving the cache upon shutdown
 * lower memory footprint for bitbake
 * faster codeparser data lookups (since there is less data to search)

We only use these special values when passing code fragments to the codeparser
to parse so the real variable values should otherwise be used in the hash data.

The overall effect of this change, combined with others to avoid saving unchanged
cache files can be ~2s on a ~16s parse on my local system and results in a more
responsive feeling bitbake. It also allows parsing performance to be investigated
more consistently.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py             | 15 ++++++++++-----
 lib/bb/tests/codeparser.py | 14 +++++++-------
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 841369699e..f3ae062022 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -261,7 +261,7 @@ def emit_func_python(func, o=sys.__stdout__, d = init()):
                newdeps |= set((d.getVarFlag(dep, "vardeps") or "").split())
         newdeps -= seen
 
-def build_dependencies(key, keys, mod_funcs, shelldeps, varflagsexcl, ignored_vars, d):
+def build_dependencies(key, keys, mod_funcs, shelldeps, varflagsexcl, ignored_vars, d, codeparsedata):
     def handle_contains(value, contains, exclusions, d):
         newvalue = []
         if value:
@@ -312,14 +312,14 @@ def build_dependencies(key, keys, mod_funcs, shelldeps, varflagsexcl, ignored_va
             value = varflags.get("vardepvalue")
         elif varflags.get("func"):
             if varflags.get("python"):
-                value = d.getVarFlag(key, "_content", False)
+                value = codeparsedata.getVarFlag(key, "_content", False)
                 parser = bb.codeparser.PythonParser(key, logger)
                 parser.parse_python(value, filename=varflags.get("filename"), lineno=varflags.get("lineno"))
                 deps = deps | parser.references
                 deps = deps | (keys & parser.execs)
                 value = handle_contains(value, parser.contains, exclusions, d)
             else:
-                value, parsedvar = d.getVarFlag(key, "_content", False, retparser=True)
+                value, parsedvar = codeparsedata.getVarFlag(key, "_content", False, retparser=True)
                 parser = bb.codeparser.ShellParser(key, logger)
                 parser.parse_shell(parsedvar.value)
                 deps = deps | shelldeps
@@ -378,12 +378,17 @@ def generate_dependencies(d, ignored_vars):
     shelldeps = set(key for key in d.getVar("__exportlist", False) if d.getVarFlag(key, "export", False) and not d.getVarFlag(key, "unexport", False))
     varflagsexcl = d.getVar('BB_SIGNATURE_EXCLUDE_FLAGS')
 
+    codeparserd = d.createCopy()
+    for forced in (d.getVar('BB_HASH_CODEPARSER_VALS') or "").split():
+        key, value = forced.split("=", 1)
+        codeparserd.setVar(key, value)
+
     deps = {}
     values = {}
 
     tasklist = d.getVar('__BBTASKS', False) or []
     for task in tasklist:
-        deps[task], values[task] = build_dependencies(task, keys, mod_funcs, shelldeps, varflagsexcl, ignored_vars, d)
+        deps[task], values[task] = build_dependencies(task, keys, mod_funcs, shelldeps, varflagsexcl, ignored_vars, d, codeparserd)
         newdeps = deps[task]
         seen = set()
         while newdeps:
@@ -392,7 +397,7 @@ def generate_dependencies(d, ignored_vars):
             newdeps = set()
             for dep in nextdeps:
                 if dep not in deps:
-                    deps[dep], values[dep] = build_dependencies(dep, keys, mod_funcs, shelldeps, varflagsexcl, ignored_vars, d)
+                    deps[dep], values[dep] = build_dependencies(dep, keys, mod_funcs, shelldeps, varflagsexcl, ignored_vars, d, codeparserd)
                 newdeps |=  deps[dep]
             newdeps -= seen
         #print "For %s: %s" % (task, str(deps[task]))
diff --git a/lib/bb/tests/codeparser.py b/lib/bb/tests/codeparser.py
index a508f23bcb..7f5d59ca74 100644
--- a/lib/bb/tests/codeparser.py
+++ b/lib/bb/tests/codeparser.py
@@ -318,7 +318,7 @@ d.getVar(a(), False)
             "filename": "example.bb",
         })
 
-        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), set(), self.d)
+        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), set(), self.d, self.d)
 
         self.assertEqual(deps, set(["somevar", "bar", "something", "inexpand", "test", "test2", "a"]))
 
@@ -365,7 +365,7 @@ esac
         self.d.setVarFlags("FOO", {"func": True})
         self.setEmptyVars(execs)
 
-        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), set(), self.d)
+        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), set(), self.d, self.d)
 
         self.assertEqual(deps, set(["somevar", "inverted"] + execs))
 
@@ -375,7 +375,7 @@ esac
         self.d.setVar("FOO", "foo=oe_libinstall; eval $foo")
         self.d.setVarFlag("FOO", "vardeps", "oe_libinstall")
 
-        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), set(), self.d)
+        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), set(), self.d, self.d)
 
         self.assertEqual(deps, set(["oe_libinstall"]))
 
@@ -384,7 +384,7 @@ esac
         self.d.setVar("FOO", "foo=oe_libinstall; eval $foo")
         self.d.setVarFlag("FOO", "vardeps", "${@'oe_libinstall'}")
 
-        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), set(), self.d)
+        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), set(), self.d, self.d)
 
         self.assertEqual(deps, set(["oe_libinstall"]))
 
@@ -399,7 +399,7 @@ esac
         # Check dependencies
         self.d.setVar('ANOTHERVAR', expr)
         self.d.setVar('TESTVAR', 'anothervalue testval testval2')
-        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), set(), set(), self.d)
+        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), set(), set(), self.d, self.d)
         self.assertEqual(sorted(values.splitlines()),
                          sorted([expr,
                           'TESTVAR{anothervalue} = Set',
@@ -418,14 +418,14 @@ esac
         self.d.setVar('ANOTHERVAR', varval)
         self.d.setVar('TESTVAR', 'anothervalue testval testval2')
         self.d.setVar('TESTVAR2', 'testval3')
-        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), set(), set(["TESTVAR"]), self.d)
+        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), set(), set(["TESTVAR"]), self.d, self.d)
         self.assertEqual(sorted(values.splitlines()), sorted([varval]))
         self.assertEqual(deps, set(["TESTVAR2"]))
         self.assertEqual(self.d.getVar('ANOTHERVAR').split(), ['testval3', 'anothervalue'])
 
         # Check the vardepsexclude flag is handled by contains functionality
         self.d.setVarFlag('ANOTHERVAR', 'vardepsexclude', 'TESTVAR')
-        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), set(), set(), self.d)
+        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), set(), set(), self.d, self.d)
         self.assertEqual(sorted(values.splitlines()), sorted([varval]))
         self.assertEqual(deps, set(["TESTVAR2"]))
         self.assertEqual(self.d.getVar('ANOTHERVAR').split(), ['testval3', 'anothervalue'])
-- 
2.37.2


