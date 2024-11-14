Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804F5D65C75
	for <webhook@archiver.kernel.org>; Thu, 14 Nov 2024 11:11:08 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
 by mx.groups.io with SMTP id smtpd.web11.34856.1731582658652534877
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Nov 2024 03:10:58 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=H+bu/mH0;
 spf=pass (domain: gmail.com, ip: 209.85.221.43, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37d5689eea8so339050f8f.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 14 Nov 2024 03:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731582657; x=1732187457; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uni6I9Uj7GnmDzWSZmnamv21HJl8iaq5lIitjAff0k4=;
        b=H+bu/mH0gkgGiY5s64mi7BB+/euA9kH44kiGKPED3yz4malwNdOXPE62EsyENsozVJ
         j7KcG9pIRfIi95IIf94fzJ3CD6roWj9uGW6sMHu8BqTUDDNGpLr68C2PCYCHzvBFROAe
         UeoMridhEzHcTvaIr9514K/qyfNM5PtTGV/9dfmiClcVxuvavalpk8tU2po+cn7KOSAE
         pW/GQdGJTPzX4mb4mMHRZjSP5ikx4K1sVURQqmRFcZTaxIE2/1r07RHOyY0ozANIqCFq
         MS1VZOvyrikykgeVwzURWbNfwsACIk25Jtlsx14POWpRFNjrqMJT56nv8M2C8O4dfTCe
         k/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731582657; x=1732187457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uni6I9Uj7GnmDzWSZmnamv21HJl8iaq5lIitjAff0k4=;
        b=aLCPoOAeOgs6SsZLcxHBn5dNLxTlg1xJEloBPonQ9eBUE+Zi110/JDrTmyEBvOp80j
         zmvJy0t4plMXndWtQy9b+gC/wwSWY/YexbBybCgJVdCmy/I2/QOYZhRKVqEo9/Xd8bhn
         3Msb9d+Xb/dPYqn7EGfHpngePQYAyv4LmDMqKqxBB62Cg0hdPfdMJQMcjvRCTUUNt3/v
         YtO5PF3/waD+Qvk+SKlO2+6atiTFOROZaJX01wnDLwOrSfyKukjbJGK01C0eGHcTOc8o
         SJTtfphJFMfjnWRg/OTTC/qPqEpK5KxvCfEh+tRi5fHGcpEZHDhAlRLuqU9lAfFwLRZT
         ZGZw==
X-Gm-Message-State: AOJu0Yyss+CGwb5MUWIp/wthEUTWGW/0mKcu9nwe89u2oObLyEgDpYTf
	oSq5Me3uVuDgVRjAIAWHY2XA6KTtmq7NHcx3pLowURgXkg5JvYV4IYcgMQ==
X-Google-Smtp-Source: AGHT+IG8gxhJKk7gacdXx/l6jtGMayNBvt3VzsbGHZ2fNE7p4IBe/k5/Y3l125OCZLcNaR4wAwgbzQ==
X-Received: by 2002:a5d:6d0e:0:b0:381:dff2:cf08 with SMTP id ffacd0b85a97d-381f18651e9mr18723418f8f.2.1731582656771;
        Thu, 14 Nov 2024 03:10:56 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ada31b0sm1199051f8f.1.2024.11.14.03.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 03:10:56 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH 2/3] parse: add support for 'addfragments' directive
Date: Thu, 14 Nov 2024 12:10:47 +0100
Message-Id: <20241114111048.2624711-2-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241114111048.2624711-1-alex.kanavin@gmail.com>
References: <20241114111048.2624711-1-alex.kanavin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Nov 2024 11:11:08 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16798

From: Alexander Kanavin <alex@linutronix.de>

It takes two parameters:
- location prefix for fragments
- name of variable that holds the list of enabled fragments

Implementation of this directive essentially expands the fragment list
obtained from it into 'require' entries and hands them to the
implementation of 'require'.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 lib/bb/parse/ast.py                  | 19 +++++++++++++++++++
 lib/bb/parse/parse_py/ConfHandler.py |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 001ba8d289a..b7272dfdc65 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -326,6 +326,20 @@ class InheritDeferredNode(AstNode):
         inherits.append(self.inherit)
         data.setVar('__BBDEFINHERITS', inherits)
 
+class AddFragmentsNode(AstNode):
+    def __init__(self, filename, lineno, fragments_path_prefix, fragments_variable):
+        AstNode.__init__(self, filename, lineno)
+        self.path = fragments_path_prefix
+        self.variable = fragments_variable
+
+    def eval(self, data):
+        fragments = data.getVar(self.variable)
+        if not fragments:
+            return
+        for f in fragments.split():
+            full_fragment_name = data.expand("{}/{}.conf".format(self.path, f))
+            bb.parse.ConfHandler.include(self.filename, full_fragment_name, self.lineno, data, "include fragment")
+
 def handleInclude(statements, filename, lineno, m, force):
     statements.append(IncludeNode(filename, lineno, m.group(1), force))
 
@@ -370,6 +384,11 @@ def handleInheritDeferred(statements, filename, lineno, m):
     classes = m.group(1)
     statements.append(InheritDeferredNode(filename, lineno, classes))
 
+def handleAddFragments(statements, filename, lineno, m):
+    fragments_path_prefix = m.group(1)
+    fragments_variable = m.group(2)
+    statements.append(AddFragmentsNode(filename, lineno, fragments_path_prefix, fragments_variable))
+
 def runAnonFuncs(d):
     code = []
     for funcname in d.getVar("__BBANONFUNCS", False) or []:
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index 7826dee7d3d..31001e2afe1 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -47,6 +47,7 @@ __export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)\[([a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]+)\]$" )
 __addpylib_regexp__      = re.compile(r"addpylib\s+(.+)\s+(.+)" )
+__addfragments_regexp__  = re.compile(r"addfragments\s+(.+)\s+(.+)" )
 
 def init(data):
     return
@@ -197,6 +198,11 @@ def feeder(lineno, s, fn, statements, baseconfig=False, conffile=True):
         ast.handlePyLib(statements, fn, lineno, m)
         return
 
+    m = __addfragments_regexp__.match(s)
+    if m:
+        ast.handleAddFragments(statements, fn, lineno, m)
+        return
+
     raise ParseError("unparsed line: '%s'" % s, fn, lineno);
 
 # Add us to the handlers list
-- 
2.39.5


