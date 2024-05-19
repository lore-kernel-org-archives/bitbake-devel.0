Return-Path: <adrian.freihofer@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D08DC25B75
	for <webhook@archiver.kernel.org>; Sun, 19 May 2024 14:30:39 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
 by mx.groups.io with SMTP id smtpd.web11.40063.1716129032154845974
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 19 May 2024 07:30:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=eLAngLex;
 spf=pass (domain: gmail.com, ip: 209.85.208.46, mailfrom: adrian.freihofer@gmail.com)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-574b3d6c0f3so6843120a12.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 19 May 2024 07:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716129030; x=1716733830; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jXa3oMb3pxFucs2xNJrpiBkoOgP00JXDahnE7bipgMI=;
        b=eLAngLexBttSCYXqHRQ8vvtJhAtWDWpTvv0HPnqCqcE+Vo6g5zzCVdnPrcuNLiN+78
         wQGW64Slk1zAO+Gicd0/T6XgGYxNKdQ0wzm0JCpCEKybHZTnLDYkPTszxGDO0Lrfl+Cg
         Zhg92bAqgR7J6KYe3pgSAfyi4PeVpSPA7WQhbArx4A5kYskdCtzVEIbv8m+leJdUSM0G
         lQRdkjeXPBA7W6mkYdMCFQSxCvxMWOHnYrF5pWRiyhewX0MjxxVxQJktOorpDuXalA/u
         dT1fuSInnOloPuyNAGJpG+DgEHyxnuoCCtPdTgIYsGWU74f+GSi5Sr0CId7pmzYHUxsx
         Z5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716129030; x=1716733830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXa3oMb3pxFucs2xNJrpiBkoOgP00JXDahnE7bipgMI=;
        b=Z6C8FuprYVh8NcnXO0hqNxpKpVZveiu4eCNG1l5T/3j94Epx2zPoVr3Md307f+mKZZ
         cC/y4GsQBMABAY5UMSK5gd48BUlNAGc3aEbNSURKjXYZG1kiejF6FUFmrH2EwbH29tO0
         Vv2ZNUN2v3Ys/l9jKWj8kCMG/OFfLELrlfjfF/oKOYrPzMzG2zhBQzjEJqERvnyqL44x
         YVaI+C3ZgUTDigLknn0IZ0M0aQe/gBMIwNWsLmdLTLvSzGrCAXN1OlOFy/rHx98ihdXI
         mLjL4YwPFfrDS9eZIcirUrFVRmIl79arIug7VMxl5mnA8yHV8aMt4uFkoYcJl8HmL2Qv
         d0Yg==
X-Gm-Message-State: AOJu0Yzd9B+jadxtGUPFjIiXq8nKf/EIhykOELDaJtTPLISo24N3nkI8
	WctOh+cTZaM7/x28GSQakEOBaHRBAMgIyg7R/B8Ki28AZvZ9DjOIRJNlDg==
X-Google-Smtp-Source: AGHT+IF8IpYJGrwVbgMFgc67vjb/gnrTfv4nBedvguV/o0EgzVTEcx5cfXvNDgK9wfAivYqRDhPFLg==
X-Received: by 2002:a17:906:40d2:b0:a5a:1f4f:cb4c with SMTP id a640c23a62f3a-a5a2d54c80amr1649211666b.7.1716129029580;
        Sun, 19 May 2024 07:30:29 -0700 (PDT)
Received: from wsadrian16.fritz.box ([2a02:169:59a6:0:55c4:f628:91f3:4287])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781e97bsm1335989766b.32.2024.05.19.07.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 07:30:29 -0700 (PDT)
From: Adrian Freihofer <adrian.freihofer@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: eric.sun@meraki.net,
	Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [kirkstone][PATCH] bitbake: bitbake/codeparser.py fix python 3.6 compatibilty
Date: Sun, 19 May 2024 16:30:25 +0200
Message-ID: <20240519143025.72402-1-adrian.freihofer@gmail.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 19 May 2024 14:30:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16230

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Commits
- d4ad54a401031346727ec6c1337f4b0211b5cc47
- 8ec4f29e432feec9d8deedc06bfb90d57e7436cf
break compatibility with Python 3.6. However, kirkstone is supposed to
be backward compatible which this old version.

Restore the old code if the Python version is less than 3.8. This adds
some not so nice code dublication. But the implementation like:
  if sys.version_info[:3] < (3,8,0):
      old code
  else:
      new code
makes it possible to fix the problem without much thought and without
the risk of new problems.

The issue can be reproduced e.g. in an old Ubuntu container by running:
  bitbake-selftest bb.tests.codeparser.PythonReferenceTest

It works with an older version of bibake:

$ git checkout kirkstone-4.0.16
$ podman run --rm -it --security-opt label=disable --userns=keep-id \
  -v /home/adrian/projets/oss/poky-wt-1:/home/yoctouser/workdir \
  crops/yocto:ubuntu-18.04-base

$ python3 --version
Python 3.6.9

$ cd workdir/
$ . oe-init-build-env
$ bitbake-selftest bb.tests.codeparser.PythonReferenceTest
...............
----------------------------------------------------------------------
Ran 15 tests in 0.001s
OK

The same with latest commit from kirkstone fails 7 errors like:

FAIL: test_contains (bb.tests.codeparser.PythonReferenceTest)
----------------------------------------------------------------------
Traceback (most recent call last):
  File "/home/yoctouser/workdir/bitbake/lib/bb/tests/codeparser.py",
    line 268, in test_contains
    self.assertContains({'TESTVAR': {'one'}})
  File "/home/yoctouser/workdir/bitbake/lib/bb/tests/codeparser.py",
    line 40, in assertContains
    self.assertEqual(self.contains, contains)
AssertionError: {} != {'TESTVAR': {'one'}}
- {}
+ {'TESTVAR': {'one'}}

Reported-by: Eric Sun <eric.sun@meraki.net>
Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
---
 lib/bb/codeparser.py | 112 +++++++++++++++++++++++++++++--------------
 1 file changed, 76 insertions(+), 36 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 6ce0c5182..afde88f44 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -224,44 +224,84 @@ class PythonParser():
 
     def visit_Call(self, node):
         name = self.called_node_name(node.func)
-        if name and (name.endswith(self.getvars) or name.endswith(self.getvarflags) or name in self.containsfuncs or name in self.containsanyfuncs):
-            if isinstance(node.args[0], ast.Constant) and isinstance(node.args[0].value, str):
-                varname = node.args[0].value
-                if name in self.containsfuncs and isinstance(node.args[1], ast.Constant):
-                    if varname not in self.contains:
-                        self.contains[varname] = set()
-                    self.contains[varname].add(node.args[1].value)
-                elif name in self.containsanyfuncs and isinstance(node.args[1], ast.Constant):
-                    if varname not in self.contains:
-                        self.contains[varname] = set()
-                    self.contains[varname].update(node.args[1].value.split())
-                elif name.endswith(self.getvarflags):
-                    if isinstance(node.args[1], ast.Constant):
-                        self.references.add('%s[%s]' % (varname, node.args[1].value))
+        if sys.version_info[:3] < (3,8,0):
+            if name and (name.endswith(self.getvars) or name.endswith(self.getvarflags) or name in self.containsfuncs or name in self.containsanyfuncs):
+                if isinstance(node.args[0], ast.Str):
+                    varname = node.args[0].s
+                    if name in self.containsfuncs and isinstance(node.args[1], ast.Str):
+                        if varname not in self.contains:
+                            self.contains[varname] = set()
+                        self.contains[varname].add(node.args[1].s)
+                    elif name in self.containsanyfuncs and isinstance(node.args[1], ast.Str):
+                        if varname not in self.contains:
+                            self.contains[varname] = set()
+                        self.contains[varname].update(node.args[1].s.split())
+                    elif name.endswith(self.getvarflags):
+                        if isinstance(node.args[1], ast.Str):
+                            self.references.add('%s[%s]' % (varname, node.args[1].s))
+                        else:
+                            self.warn(node.func, node.args[1])
                     else:
-                        self.warn(node.func, node.args[1])
+                        self.references.add(varname)
                 else:
-                    self.references.add(varname)
-            else:
-                self.warn(node.func, node.args[0])
-        elif name and name.endswith(".expand"):
-            if isinstance(node.args[0], ast.Constant):
-                value = node.args[0].value
-                d = bb.data.init()
-                parser = d.expandWithRefs(value, self.name)
-                self.references |= parser.references
-                self.execs |= parser.execs
-                for varname in parser.contains:
-                    if varname not in self.contains:
-                        self.contains[varname] = set()
-                    self.contains[varname] |= parser.contains[varname]
-        elif name in self.execfuncs:
-            if isinstance(node.args[0], ast.Constant):
-                self.var_execs.add(node.args[0].value)
-            else:
-                self.warn(node.func, node.args[0])
-        elif name and isinstance(node.func, (ast.Name, ast.Attribute)):
-            self.execs.add(name)
+                    self.warn(node.func, node.args[0])
+            elif name and name.endswith(".expand"):
+                if isinstance(node.args[0], ast.Str):
+                    value = node.args[0].s
+                    d = bb.data.init()
+                    parser = d.expandWithRefs(value, self.name)
+                    self.references |= parser.references
+                    self.execs |= parser.execs
+                    for varname in parser.contains:
+                        if varname not in self.contains:
+                            self.contains[varname] = set()
+                        self.contains[varname] |= parser.contains[varname]
+            elif name in self.execfuncs:
+                if isinstance(node.args[0], ast.Str):
+                    self.var_execs.add(node.args[0].s)
+                else:
+                    self.warn(node.func, node.args[0])
+            elif name and isinstance(node.func, (ast.Name, ast.Attribute)):
+                self.execs.add(name)
+        else:
+            if name and (name.endswith(self.getvars) or name.endswith(self.getvarflags) or name in self.containsfuncs or name in self.containsanyfuncs):
+                if isinstance(node.args[0], ast.Constant) and isinstance(node.args[0].value, str):
+                    varname = node.args[0].value
+                    if name in self.containsfuncs and isinstance(node.args[1], ast.Constant):
+                        if varname not in self.contains:
+                            self.contains[varname] = set()
+                        self.contains[varname].add(node.args[1].value)
+                    elif name in self.containsanyfuncs and isinstance(node.args[1], ast.Constant):
+                        if varname not in self.contains:
+                            self.contains[varname] = set()
+                        self.contains[varname].update(node.args[1].value.split())
+                    elif name.endswith(self.getvarflags):
+                        if isinstance(node.args[1], ast.Constant):
+                            self.references.add('%s[%s]' % (varname, node.args[1].value))
+                        else:
+                            self.warn(node.func, node.args[1])
+                    else:
+                        self.references.add(varname)
+                else:
+                    self.warn(node.func, node.args[0])
+            elif name and name.endswith(".expand"):
+                if isinstance(node.args[0], ast.Constant):
+                    value = node.args[0].value
+                    d = bb.data.init()
+                    parser = d.expandWithRefs(value, self.name)
+                    self.references |= parser.references
+                    self.execs |= parser.execs
+                    for varname in parser.contains:
+                        if varname not in self.contains:
+                            self.contains[varname] = set()
+                        self.contains[varname] |= parser.contains[varname]
+            elif name in self.execfuncs:
+                if isinstance(node.args[0], ast.Constant):
+                    self.var_execs.add(node.args[0].value)
+                else:
+                    self.warn(node.func, node.args[0])
+            elif name and isinstance(node.func, (ast.Name, ast.Attribute)):
+                self.execs.add(name)
 
     def called_node_name(self, node):
         """Given a called node, return its original string form"""
-- 
2.44.0


