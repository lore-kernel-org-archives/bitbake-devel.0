Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96EDC46CD2
	for <webhook@archiver.kernel.org>; Tue,  2 Jan 2024 22:59:10 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.1069.1704236347012369241
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Jan 2024 14:59:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=cWscNXoh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.46, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3373bc6d625so2040528f8f.3
        for <bitbake-devel@lists.openembedded.org>; Tue, 02 Jan 2024 14:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704236345; x=1704841145; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lfyFCKIupoPFso0x7L/JeTax09rLZuAnjI9J/fHAyLU=;
        b=cWscNXohxzZFWzHRCI7uBDp1FMQS0jcRHPveijwJiJjvcH8aL4+YHd6K/+RPKTJFge
         /Mx7OkgGU4o44mJpvxNwXg9IJ4x9khyfaEmxb7k8E5fFUSSYGZ2zY6r3zOh4nfw1n9My
         Mf2IgP8LN2GslJw/6yDCDGvIKr3ukGnMagHvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704236345; x=1704841145;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lfyFCKIupoPFso0x7L/JeTax09rLZuAnjI9J/fHAyLU=;
        b=dHTIhgW6QT+8XuAbX/KPSjldZ4Ers4LWf/yt1YhJZ0gIK+cMEkOg3kW+s0a/E3a/9c
         fersjJmmRuqPddkPhxK8lpjMQ1azE2EqKjYYo2GNhvQB38ObQjtk2rB3WdK09Qxybox/
         AfGnFuyjfNyxOTc3tdzdRv5RcNoomN67BwWHgGc18AAsDPjGjXN+p5GBeX3CP1f1X5Dz
         aG89Dll8r7CLwDvGANjjcEwksngmCF8DxDIourEm6kHj60SmqAJWoMBwKt2LT1hT2fdz
         jFQoxSCnRgIxcJRuy/o2pnqq218o0F7Ym6LLYW9WiuEp0ICFX8NFF5oTkT+Ui3VYSOmE
         hoDw==
X-Gm-Message-State: AOJu0Yz6R5817RH6Z74Iuree96D3jIlbKFaE69nxgDAWUq5fvP3ra/Gm
	qXeKbkcmzk8Amy+KEcb60m/nG3YhqfjS2JGC0W8W+3yT8m4=
X-Google-Smtp-Source: AGHT+IEPI1POzrqg21CWCZhRhA6Y6ooAYazovIDLJydNI37QpLX2Q1OT5bdEzJ8VXNe0SCAybPNoAQ==
X-Received: by 2002:a5d:65cc:0:b0:336:5e6c:a1ee with SMTP id e12-20020a5d65cc000000b003365e6ca1eemr10069637wrw.85.1704236345210;
        Tue, 02 Jan 2024 14:59:05 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:8ee8:87cd:f714:75d2])
        by smtp.gmail.com with ESMTPSA id y8-20020a056000108800b0033642a9a1eesm29297964wrw.21.2024.01.02.14.59.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jan 2024 14:59:04 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [RFC PATCH] ast/BBHandler: Add inherit_deferred support
Date: Tue,  2 Jan 2024 22:59:03 +0000
Message-Id: <20240102225903.2025526-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Jan 2024 22:59:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15738

Add support for an inherit_deferred statement which works as
inherit does but is only evaulated at the end of parsing.

This allows conditional expressions to be evaulated 'late' meaning changes
to PACKAGECONFIG from bbappends can be applied for example. This addresses
a usability/confusion issue users have with the current conditional
inherit mechanism since they don't realise the condition has to be
expanded immediately with the current model.

There is a commented out warning we could enable in future which
warns about the use of a conditional inherit that isn't deferred.

There is a behaviour difference in the placement of the inherit,
particularly around variables set using ?= which means wen swapping
from one to the other, caution must be used as values can change.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/ast.py                | 22 ++++++++++++++++++++++
 lib/bb/parse/parse_py/BBHandler.py | 10 +++++++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 6441c5cf7c..09dacbc44c 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -313,6 +313,16 @@ class InheritNode(AstNode):
     def eval(self, data):
         bb.parse.BBHandler.inherit(self.classes, self.filename, self.lineno, data)
 
+class InheritDeferredNode(AstNode):
+    def __init__(self, filename, lineno, classes):
+        AstNode.__init__(self, filename, lineno)
+        self.inherit = (classes, filename, lineno)
+
+    def eval(self, data):
+        inherits = data.getVar('__BBDEFINHERITS', False) or []
+        inherits.append(self.inherit)
+        data.setVar('__BBDEFINHERITS', inherits)
+
 def handleInclude(statements, filename, lineno, m, force):
     statements.append(IncludeNode(filename, lineno, m.group(1), force))
 
@@ -363,6 +373,10 @@ def handleInherit(statements, filename, lineno, m):
     classes = m.group(1)
     statements.append(InheritNode(filename, lineno, classes))
 
+def handleInheritDeferred(statements, filename, lineno, m):
+    classes = m.group(1)
+    statements.append(InheritDeferredNode(filename, lineno, classes))
+
 def runAnonFuncs(d):
     code = []
     for funcname in d.getVar("__BBANONFUNCS", False) or []:
@@ -429,6 +443,14 @@ def multi_finalize(fn, d):
         logger.debug("Appending .bbappend file %s to %s", append, fn)
         bb.parse.BBHandler.handle(append, d, True)
 
+    while True:
+        inherits = d.getVar('__BBDEFINHERITS', False) or []
+        if not inherits:
+            break
+        inherit, filename, lineno = inherits.pop(0)
+        d.setVar('__BBDEFINHERITS', inherits)
+        bb.parse.BBHandler.inherit(inherit, filename, lineno, d, deferred=True)
+
     onlyfinalise = d.getVar("__ONLYFINALISE", False)
 
     safe_d = d
diff --git a/lib/bb/parse/parse_py/BBHandler.py b/lib/bb/parse/parse_py/BBHandler.py
index 4d5b45e1ef..31a2ea5cac 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -21,6 +21,7 @@ from .ConfHandler import include, init
 
 __func_start_regexp__    = re.compile(r"(((?P<py>python(?=(\s|\()))|(?P<fr>fakeroot(?=\s)))\s*)*(?P<func>[\w\.\-\+\{\}\$:]+)?\s*\(\s*\)\s*{$" )
 __inherit_regexp__       = re.compile(r"inherit\s+(.+)" )
+__inherit_def_regexp__   = re.compile(r"inherit_deferred\s+(.+)" )
 __export_func_regexp__   = re.compile(r"EXPORT_FUNCTIONS\s+(.+)" )
 __addtask_regexp__       = re.compile(r"addtask\s+(?P<func>\w+)\s*((before\s*(?P<before>((.*(?=after))|(.*))))|(after\s*(?P<after>((.*(?=before))|(.*)))))*")
 __deltask_regexp__       = re.compile(r"deltask\s+(.+)")
@@ -40,8 +41,10 @@ def supports(fn, d):
     """Return True if fn has a supported extension"""
     return os.path.splitext(fn)[-1] in [".bb", ".bbclass", ".inc"]
 
-def inherit(files, fn, lineno, d):
+def inherit(files, fn, lineno, d, deferred=False):
     __inherit_cache = d.getVar('__inherit_cache', False) or []
+    #if "${" in files and not deferred:
+    #    bb.warn("%s:%s has non deferred conditional inherit" % (fn, lineno))
     files = d.expand(files).split()
     for file in files:
         classtype = d.getVar("__bbclasstype", False)
@@ -265,6 +268,11 @@ def feeder(lineno, s, fn, root, statements, eof=False):
         ast.handleInherit(statements, fn, lineno, m)
         return
 
+    m = __inherit_def_regexp__.match(s)
+    if m:
+        ast.handleInheritDeferred(statements, fn, lineno, m)
+        return
+
     return ConfHandler.feeder(lineno, s, fn, statements, conffile=False)
 
 # Add us to the handlers list
-- 
2.39.2


