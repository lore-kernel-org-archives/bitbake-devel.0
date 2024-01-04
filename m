Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2864C47074
	for <webhook@archiver.kernel.org>; Thu,  4 Jan 2024 11:29:21 +0000 (UTC)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
 by mx.groups.io with SMTP id smtpd.web10.51950.1704367754604393741
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 04 Jan 2024 03:29:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=WezyQU/R;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.217.42, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-466faf5846eso84584137.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 04 Jan 2024 03:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704367753; x=1704972553; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zTgxpT1OrW+IN586A0ZlmC/++agzYEkL7Bl5NrvZapw=;
        b=WezyQU/RID8RrrivIXYvkIVUoVDPoKoBom0CscTtQ2AJfD3AqPjtoMuTxSOVjY4wgH
         7jMANcgNjvZt9c/bB1VJDPwoARmQYcBrhFGQ4XMwYD9f1sL+EVPKHAbDEQybc5jBkaK2
         Rz5wbvEur2RTX+kTK3kB1pBULUfubpvTtcJW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704367753; x=1704972553;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zTgxpT1OrW+IN586A0ZlmC/++agzYEkL7Bl5NrvZapw=;
        b=rpiM/Y9QgRJuVmifUx9wg4mm9TMs8TavvrDthXVK6QncDHqZR+/JfKXdkhiKaCDsq1
         rkQO6I7EPAO9t7bRl7N5tfWcyH0psqMUBb4YYNlvn3hfbWMdMX4uayAKR1rEMPLnDqJ/
         JXstJu037VIXp8Hi6nzSH6pFLxccdkYmLcrLJYs2jaDQ4NUSrFv+EYCCdewNzkp9dSQ+
         tEJN0POlO7a3ivxlaCqjPtHZVANoC8r5xzJfcB3Na1iDFUl4exEmx9GG3VlZKB51SONM
         +UcCrNhNYTntlGkcnz7m9AmTPAV8xciXzZF/+R7XtByeoOJhkyVLgKgOI4rLj0hSK1Qk
         CT6Q==
X-Gm-Message-State: AOJu0YwQvcqFuTiPjnHBzilbUlrVjlFobavwmHcd0P51CrzXH6+pmber
	H15tNwHTBdmDhLrdddoVgEWGjmFC6XTdL9mua28aH3Qw8Hs=
X-Google-Smtp-Source: AGHT+IGHjoYDL85ylXCSsov1P3eSVmdhMD3XINJpY00Ccsy9MeID+g0IrCgkPM7pvmwkuVWNeHTSsw==
X-Received: by 2002:a05:6102:390d:b0:467:9973:2e75 with SMTP id e13-20020a056102390d00b0046799732e75mr263041vsu.11.1704367753410;
        Thu, 04 Jan 2024 03:29:13 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:7c49:db55:5c5b:1a5b])
        by smtp.gmail.com with ESMTPSA id x29-20020a056102091d00b00467639aaca3sm1157607vsh.4.2024.01.04.03.29.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 03:29:13 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [RFC PATCH v2] ast/BBHandler: Add inherit_defer support
Date: Thu,  4 Jan 2024 11:29:10 +0000
Message-Id: <20240104112910.2256948-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 04 Jan 2024 11:29:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15739

Add support for an inherit_defer statement which works as
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

v2 - inherit_deferred -> inherit_defer

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
index 4d5b45e1ef..cd1c998f8f 100644
--- a/lib/bb/parse/parse_py/BBHandler.py
+++ b/lib/bb/parse/parse_py/BBHandler.py
@@ -21,6 +21,7 @@ from .ConfHandler import include, init
 
 __func_start_regexp__    = re.compile(r"(((?P<py>python(?=(\s|\()))|(?P<fr>fakeroot(?=\s)))\s*)*(?P<func>[\w\.\-\+\{\}\$:]+)?\s*\(\s*\)\s*{$" )
 __inherit_regexp__       = re.compile(r"inherit\s+(.+)" )
+__inherit_def_regexp__   = re.compile(r"inherit_defer\s+(.+)" )
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


