Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B42C3527E
	for <webhook@archiver.kernel.org>; Mon,  4 Apr 2022 18:46:41 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by mx.groups.io with SMTP id smtpd.web10.21740.1648981309462523314
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 03 Apr 2022 03:21:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=GN0BVbi9;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.51,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f51.google.com with SMTP id
 f6-20020a1c3806000000b0038e4a0fc5easo3944011wma.3
        for <bitbake-devel@lists.openembedded.org>;
 Sun, 03 Apr 2022 03:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=ShS6ahVR1DSBAP71BnNT7RVSKwzYR387v0pRmkonUSw=;
        b=GN0BVbi9xvPdgg6x9xNJr8ThgCG458C5/QbkTHY6rJ8fqOn4LyRgLkGArBXTMiIK33
         jtl+5DW6cGkRF+e6tQHyF5+KYd4Ti71+XwCRU31kBwDEMLcvsg/XYkTZrNA+1Xe8G01P
         TosKrJmdoV0IPLK84+wv50JaESWz4yzseuofI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ShS6ahVR1DSBAP71BnNT7RVSKwzYR387v0pRmkonUSw=;
        b=Q1NsSKQAZ39BWpTZCHsFuHjU4mMDOAO487xlNh6k9bwbruCc3t6DmcFaYbhWiCRB6R
         Dj4Y13jPBNcritIlvQB6wOep84Hs52yo2UIY1WTtT285aznzR9wnxU7sg02It6UoJvLo
         srKS3agtw/rsMYGhwspHYnQmP6aubgcDpMoIzpzjvCkZppItfFwCQ0KcmNgR+n9ge9gQ
         E/AERna5UTrfB79W9o4n0HAM41TNBLN+5ySEzV40csU+qJ42QdrOANYWQIKrI/MfxJIR
         WJUQktm1KFyceaiSvG4W6UYM2/q1OM5tNs2dYlgmxknG9jyVjTU4K1hLn42CeEG+Pf6N
         Ra8A==
X-Gm-Message-State: AOAM532iPQ9e8jT3LhiDDD4EkKx29I0bBXeDX72UuEf79UTrc/p1LlvY
	XOMR+2VUIxCtLKe07nJ7tO1+JAU29e88Mxa0
X-Google-Smtp-Source: 
 ABdhPJy0284Qa15wwCqxSFIeFh+9GFf9QDGkagZ1k11lF6X8HkLr6EPkhM/V47NmVDFS82omYes4hA==
X-Received: by 2002:a05:600c:ca:b0:38c:b426:3124 with SMTP id
 u10-20020a05600c00ca00b0038cb4263124mr15457826wmm.59.1648981307716;
        Sun, 03 Apr 2022 03:21:47 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:819:f853:3436:28c4])
        by smtp.gmail.com with ESMTPSA id
 z3-20020a1cf403000000b0037d1f4a2201sm6327981wma.21.2022.04.03.03.21.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 03:21:46 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 2/5] data: Ensure vardepsexclude or BB_BASEHASH_IGNORE_VARS
 covers contains items
Date: Sun,  3 Apr 2022 11:21:41 +0100
Message-Id: <20220403102144.1679700-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220403102144.1679700-1-richard.purdie@linuxfoundation.org>
References: <20220403102144.1679700-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 04 Apr 2022 18:46:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13572

Adding bb.utils.filter('WARN_QA', 'patch-fuzz', d) when WARN_QA is in
BB_BASEHASH_IGNORE_VARS or in vardepsexclude should not add a dependency
on WARN_QA.

Fix it and add some tests.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/data.py             | 21 ++++++++++++---------
 lib/bb/tests/codeparser.py | 28 +++++++++++++++++++++++-----
 2 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/lib/bb/data.py b/lib/bb/data.py
index 5d02bab99b..363901b5d3 100644
--- a/lib/bb/data.py
+++ b/lib/bb/data.py
@@ -272,7 +272,7 @@ def update_data(d):
     """Performs final steps upon the datastore, including application of overrides"""
     d.finalize(parent = True)
 
-def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
+def build_dependencies(key, keys, shelldeps, varflagsexcl, ignored_vars, d):
     deps = set()
     try:
         if key[-1] == ']':
@@ -283,12 +283,15 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
             return deps, value
         varflags = d.getVarFlags(key, ["vardeps", "vardepvalue", "vardepsexclude", "exports", "postfuncs", "prefuncs", "lineno", "filename"]) or {}
         vardeps = varflags.get("vardeps")
+        exclusions = varflags.get("vardepsexclude", "").split()
 
-        def handle_contains(value, contains, d):
+        def handle_contains(value, contains, exclusions, d):
             newvalue = []
             if value:
                 newvalue.append(str(value))
             for k in sorted(contains):
+                if k in exclusions or k in ignored_vars:
+                    continue
                 l = (d.getVar(k) or "").split()
                 for item in sorted(contains[k]):
                     for word in item.split():
@@ -316,7 +319,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
                 parser.parse_python(value, filename=varflags.get("filename"), lineno=varflags.get("lineno"))
                 deps = deps | parser.references
                 deps = deps | (keys & parser.execs)
-                value = handle_contains(value, parser.contains, d)
+                value = handle_contains(value, parser.contains, exclusions, d)
             else:
                 value, parsedvar = d.getVarFlag(key, "_content", False, retparser=True)
                 parser = bb.codeparser.ShellParser(key, logger)
@@ -324,9 +327,9 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
                 deps = deps | shelldeps
                 deps = deps | parsedvar.references
                 deps = deps | (keys & parser.execs) | (keys & parsedvar.execs)
-                value = handle_contains(value, parsedvar.contains, d)
+                value = handle_contains(value, parsedvar.contains, exclusions, d)
                 if hasattr(parsedvar, "removes"):
-                    value = handle_remove(value, deps, parsedvar.removes, d)
+                    value = handle_remove(value, deps, parsedvar.removes, varflags, d)
             if vardeps is None:
                 parser.log.flush()
             if "prefuncs" in varflags:
@@ -339,7 +342,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
             value, parser = d.getVarFlag(key, "_content", False, retparser=True)
             deps |= parser.references
             deps = deps | (keys & parser.execs)
-            value = handle_contains(value, parser.contains, d)
+            value = handle_contains(value, parser.contains, exclusions, d)
             if hasattr(parser, "removes"):
                 value = handle_remove(value, deps, parser.removes, d)
 
@@ -359,7 +362,7 @@ def build_dependencies(key, keys, shelldeps, varflagsexcl, d):
                 deps |= set(varfdeps)
 
         deps |= set((vardeps or "").split())
-        deps -= set(varflags.get("vardepsexclude", "").split())
+        deps -= set(exclusions)
     except bb.parse.SkipRecipe:
         raise
     except Exception as e:
@@ -380,7 +383,7 @@ def generate_dependencies(d, ignored_vars):
 
     tasklist = d.getVar('__BBTASKS', False) or []
     for task in tasklist:
-        deps[task], values[task] = build_dependencies(task, keys, shelldeps, varflagsexcl, d)
+        deps[task], values[task] = build_dependencies(task, keys, shelldeps, varflagsexcl, ignored_vars, d)
         newdeps = deps[task]
         seen = set()
         while newdeps:
@@ -389,7 +392,7 @@ def generate_dependencies(d, ignored_vars):
             newdeps = set()
             for dep in nextdeps:
                 if dep not in deps:
-                    deps[dep], values[dep] = build_dependencies(dep, keys, shelldeps, varflagsexcl, d)
+                    deps[dep], values[dep] = build_dependencies(dep, keys, shelldeps, varflagsexcl, ignored_vars, d)
                 newdeps |=  deps[dep]
             newdeps -= seen
         #print "For %s: %s" % (task, str(deps[task]))
diff --git a/lib/bb/tests/codeparser.py b/lib/bb/tests/codeparser.py
index f485204791..71ed382ab8 100644
--- a/lib/bb/tests/codeparser.py
+++ b/lib/bb/tests/codeparser.py
@@ -318,7 +318,7 @@ d.getVar(a(), False)
             "filename": "example.bb",
         })
 
-        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), self.d)
+        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), self.d)
 
         self.assertEqual(deps, set(["somevar", "bar", "something", "inexpand", "test", "test2", "a"]))
 
@@ -365,7 +365,7 @@ esac
         self.d.setVarFlags("FOO", {"func": True})
         self.setEmptyVars(execs)
 
-        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), self.d)
+        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), self.d)
 
         self.assertEqual(deps, set(["somevar", "inverted"] + execs))
 
@@ -375,7 +375,7 @@ esac
         self.d.setVar("FOO", "foo=oe_libinstall; eval $foo")
         self.d.setVarFlag("FOO", "vardeps", "oe_libinstall")
 
-        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), self.d)
+        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), self.d)
 
         self.assertEqual(deps, set(["oe_libinstall"]))
 
@@ -384,7 +384,7 @@ esac
         self.d.setVar("FOO", "foo=oe_libinstall; eval $foo")
         self.d.setVarFlag("FOO", "vardeps", "${@'oe_libinstall'}")
 
-        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), self.d)
+        deps, values = bb.data.build_dependencies("FOO", set(self.d.keys()), set(), set(), set(), self.d)
 
         self.assertEqual(deps, set(["oe_libinstall"]))
 
@@ -399,7 +399,7 @@ esac
         # Check dependencies
         self.d.setVar('ANOTHERVAR', expr)
         self.d.setVar('TESTVAR', 'anothervalue testval testval2')
-        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), self.d)
+        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), set(), self.d)
         self.assertEqual(sorted(values.splitlines()),
                          sorted([expr,
                           'TESTVAR{anothervalue} = Set',
@@ -412,6 +412,24 @@ esac
         # Check final value
         self.assertEqual(self.d.getVar('ANOTHERVAR').split(), ['anothervalue', 'yetanothervalue', 'lastone'])
 
+    def test_contains_vardeps_excluded(self):
+        # Check the ignored_vars option to build_dependencies is handled by contains functionality
+        varval = '${TESTVAR2} ${@bb.utils.filter("TESTVAR", "somevalue anothervalue", d)}'
+        self.d.setVar('ANOTHERVAR', varval)
+        self.d.setVar('TESTVAR', 'anothervalue testval testval2')
+        self.d.setVar('TESTVAR2', 'testval3')
+        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), set(["TESTVAR"]), self.d)
+        self.assertEqual(sorted(values.splitlines()), sorted([varval]))
+        self.assertEqual(deps, set(["TESTVAR2"]))
+        self.assertEqual(self.d.getVar('ANOTHERVAR').split(), ['testval3', 'anothervalue'])
+
+        # Check the vardepsexclude flag is handled by contains functionality
+        self.d.setVarFlag('ANOTHERVAR', 'vardepsexclude', 'TESTVAR')
+        deps, values = bb.data.build_dependencies("ANOTHERVAR", set(self.d.keys()), set(), set(), set(), self.d)
+        self.assertEqual(sorted(values.splitlines()), sorted([varval]))
+        self.assertEqual(deps, set(["TESTVAR2"]))
+        self.assertEqual(self.d.getVar('ANOTHERVAR').split(), ['testval3', 'anothervalue'])
+
     #Currently no wildcard support
     #def test_vardeps_wildcards(self):
     #    self.d.setVar("oe_libinstall", "echo test")
-- 
2.32.0


