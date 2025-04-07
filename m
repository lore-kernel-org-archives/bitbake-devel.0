Return-Path: <JPEWhacker@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3628FC36010
	for <webhook@archiver.kernel.org>; Mon,  7 Apr 2025 21:52:55 +0000 (UTC)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
 by mx.groups.io with SMTP id smtpd.web10.60612.1744062772025147416
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Apr 2025 14:52:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=aEauRD/f;
 spf=pass (domain: gmail.com, ip: 209.85.160.48, mailfrom: jpewhacker@gmail.com)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2c77a5747e0so2666543fac.2
        for <bitbake-devel@lists.openembedded.org>; Mon, 07 Apr 2025 14:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744062771; x=1744667571; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=swIL6j3LP4xPssYIgh6NY9sV6ZmjHHPTI26b70ZcSd0=;
        b=aEauRD/fyzA25vb2vanmsTxd5LCbPOhgukOUWGFMBP2tAduARC34HR1W80OLdYdVag
         oDrfXfpNP5i8gyuFyqAtC3pJm8u88y9vObdJCs53M+T/O/Fi2G9tKn7oTh8XQ8oxgrjW
         GMO7TsdfkhWq+q3KRgBTI5CgqASwj3K1LZGmYH5nE74GePli9Y8tmKQTvJDwloMcJtHJ
         HoG6+TcgzVcwYYsa58J1CCKHEmdc4oeKsYCgbjHr66/gd7BSswIgorlzWrKxwHQZENO2
         GSADGghBzrioJ07FX6fLJ0wqUq41t9a4leYShe7+RGeQUOjdh+YN1j8cftryLhJwFOwl
         F22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744062771; x=1744667571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swIL6j3LP4xPssYIgh6NY9sV6ZmjHHPTI26b70ZcSd0=;
        b=Ai/7Od9UHrDdFav0wZJEP8wIlozGDSBjs2/xuq+0/LV9rxfnQ55UoBqeYWr83vO60E
         kmneZP/taLSsbD7vhw5BHC/me3HZ1gqo2bhJoT1gIDLylyeJEDEmN8bfKocM129T9QUL
         S0t48D+ZA29npCgP8v/Mwd+tPZtM/SwRzbXZQ0gdnQQYa3HGxizWw17TMx/fl4KK8/k0
         odrMsP0XV5UQne1VLaakwb9mQYBu8JXIaUuxrzd8t4tIvDLfDudzQ/KUH2c/Tp3qdLRL
         lVnoDy2XQmo7y8+J9/jNuD9gw513mO7Rpc8CsF0ibpFPHcMbcZj6NFn/DZ2edLfD2exV
         Gxww==
X-Gm-Message-State: AOJu0YwB/GNH4K3WbZ/bLXYdsxP+0woz/pO9cITjOxK5cTdRg68M1ipf
	2qducurx5dAWpHy/x/q35Oeeduz9UcW+IfeL7Ee8GV8c19O0RDHhDhMh1w==
X-Gm-Gg: ASbGncuQDVCpnVHHYsCWQbE/zn+BksrjkErsqcN+JuiGZbLC6bMCck7GgKfU3+iXIno
	SGIaINUULiYdulFvvLULe3Xv+P47Qi2n70Lf3J1dE+vlPMGtp/VVMQKTKNtsd6JZ7RiIrnvJh+D
	uNgC7nd05GoHP2uLyj3LGhV6zfeSdrZ+mRSUkLP7dhwZgtoM9lu8kruhSEjEr8Dr8U+zgJKYeyU
	WKgVF8DubdLAe0GGRqGcvab0nbnuD3W+8amLulBSMXvVIi/TfqY+NpdL/NNHo5rCxhWf7DRbsNP
	YYl/c01klbFZsJ/Bz+wug7icsfGgn88L0G+blaMDKbA=
X-Google-Smtp-Source: AGHT+IE0nQKb9vOPKejLHbz9OK4BWOwC3Rv3c3ZIsJ5Hn9k/nv3L+k3CQTHjS9Ipmfh4N3apjf/IaA==
X-Received: by 2002:a05:6870:1806:b0:2cf:bc73:7bb2 with SMTP id 586e51a60fabf-2cfbc744531mr4429760fac.14.1744062770490;
        Mon, 07 Apr 2025 14:52:50 -0700 (PDT)
Received: from localhost.localdomain ([2601:282:4300:19e0::bf01])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2cc845cc4e7sm2171047fac.14.2025.04.07.14.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 14:52:49 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [bitbake-devel][PATCH] codeparser: Add function decorators for vardeps
Date: Mon,  7 Apr 2025 15:52:44 -0600
Message-ID: <20250407215244.2024324-1-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Apr 2025 21:52:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17522

Adds bb.parse.vardeps bb.parse.excludevardeps function decorators that
can be used to explicitly add or exclude variables from a python
function parsed by bitbake

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/codeparser.py     | 10 ++++++---
 bitbake/lib/bb/parse/__init__.py | 37 ++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/codeparser.py b/bitbake/lib/bb/codeparser.py
index fd9d9435dfb..401eca216e6 100644
--- a/bitbake/lib/bb/codeparser.py
+++ b/bitbake/lib/bb/codeparser.py
@@ -69,7 +69,7 @@ def add_module_functions(fn, functions, namespace):
         name = "%s.%s" % (namespace, f)
         parser = PythonParser(name, logger)
         try:
-            parser.parse_python(None, filename=fn, lineno=1, fixedhash=fixedhash+f)
+            parser.parse_python(None, filename=fn, lineno=1, fixedhash=fixedhash+f, func=functions[f])
             #bb.warn("Cached %s" % f)
         except KeyError:
             try:
@@ -87,7 +87,7 @@ def add_module_functions(fn, functions, namespace):
                 # Builtin
                 continue
             src = "".join(lines)
-            parser.parse_python(src, filename=fn, lineno=lineno, fixedhash=fixedhash+f)
+            parser.parse_python(src, filename=fn, lineno=lineno, fixedhash=fixedhash+f, func=functions[f])
             #bb.warn("Not cached %s" % f)
         execs = parser.execs.copy()
         # Expand internal module exec references
@@ -354,7 +354,7 @@ class PythonParser():
     # For the python module code it is expensive to have the function text so it is
     # uses a different fixedhash to cache against. We can take the hit on obtaining the
     # text if it isn't in the cache.
-    def parse_python(self, node, lineno=0, filename="<string>", fixedhash=None):
+    def parse_python(self, node, lineno=0, filename="<string>", fixedhash=None, func=None):
         if not fixedhash and (not node or not node.strip()):
             return
 
@@ -396,6 +396,10 @@ class PythonParser():
             if n.__class__.__name__ == "Call":
                 self.visit_Call(n)
 
+        if func is not None:
+            self.references |= getattr(func, "bb_vardeps", set())
+            self.references -= getattr(func, "bb_vardepsexclude", set())
+
         self.execs.update(self.var_execs)
         self.extra = None
         if fixedhash:
diff --git a/bitbake/lib/bb/parse/__init__.py b/bitbake/lib/bb/parse/__init__.py
index 7ffdaa6fd7f..d428d8a4b44 100644
--- a/bitbake/lib/bb/parse/__init__.py
+++ b/bitbake/lib/bb/parse/__init__.py
@@ -176,4 +176,41 @@ def get_file_depends(d):
         dep_files.append(os.path.abspath(fn))
     return " ".join(dep_files)
 
+def vardeps(*varnames):
+    """
+    Function decorator that can be used to instruct the bitbake dependency
+    parsing to add a dependency on the specified variables names
+
+    Example:
+
+        @bb.parse.vardeps("FOO", "BAR")
+        def my_function():
+            ...
+
+    """
+    def inner(f):
+        if not hasattr(f, "bb_vardeps"):
+            f.bb_vardeps = set()
+        f.bb_vardeps |= set(varnames)
+        return f
+    return inner
+
+def vardepsexclude(*varnames):
+    """
+    Function decorator that can be used to instruct the bitbake dependency
+    parsing to ignore dependencies on the specified variable names in the code
+
+    Example:
+
+        @bb.parse.vardepsexclude("FOO", "BAR")
+        def my_function():
+            ...
+    """
+    def inner(f):
+        if not hasattr(f, "bb_vardepsexclude"):
+            f.bb_vardepsexclude = set()
+        f.bb_vardepsexclude |= set(varnames)
+        return f
+    return inner
+
 from bb.parse.parse_py import __version__, ConfHandler, BBHandler
-- 
2.49.0


