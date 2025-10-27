Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BE3CCF9E5
	for <webhook@archiver.kernel.org>; Mon, 27 Oct 2025 18:12:17 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
 by mx.groups.io with SMTP id smtpd.web11.39969.1761588733006344602
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 27 Oct 2025 11:12:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=cDd0FnK+;
 spf=pass (domain: gmail.com, ip: 209.85.218.49, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b6d53684cfdso1119586666b.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 27 Oct 2025 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761588731; x=1762193531; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MictPEZPgNacYXGWtGiS4pBveloEn1EFPMYL4UyJkzc=;
        b=cDd0FnK+D4XyqhnBpYB+ymTkaCwxVV2rC8ntdSWoOzq75c7McZBB+okwg5y0qPhxaN
         xqAtxP8yNnBus5JzCNEgwNz3H+2uRHpVW/8wHjZqlwd2TOn7PETj+cG2kmLjr220ZVPI
         WLS5xOmdNzVUVLS8XP0DWB2210Y+3FddZ1FNf+1tY0BZrQjk2cdK4rEJFCYIVRO6Q9TL
         y+0Ny32xoGFcuKmqpxFXP7D/hDjFfZlgTmjFxgeGMnZS6MhZGdrIhrP4IhuUqZkLOIh9
         uk6JPFAkeZ9QRsSxWd5/Hsk6LM1T3wXuVq7UFBy2oNZrSl+z6NV4NX178zVSA8njJW/J
         pB5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761588731; x=1762193531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MictPEZPgNacYXGWtGiS4pBveloEn1EFPMYL4UyJkzc=;
        b=fWQDI2nfOXXCsl25tV+NGwLnyBIBY7s62/Gt7w+UCn3GD0CuLPVubcdERclSzcs/OB
         d64L8OFMn/nvTHNgFrR17gVUqsvqq/LZPX8wRicPiTAF2kMY6CGLc+Fa7O6QGfma8gyZ
         8RNSczdPYcvLqW7U/rnJ31L3HNYc3iY0xJ4+tyJsOcayzgiEXhMH34U387Y3uJob/y6B
         jO6uoYNLWI/KxmBGlzYGbftZUgVMSrI/aTtzyiXR+MC6542MUVpSZSzvv+5yCZauR49M
         QEPDZ5l2mdykGoLXAI6yK12yc/JCzzjq9aRRJ+mNiMbcekLZMzXzb/bqNfzBudI+HraO
         nRqA==
X-Gm-Message-State: AOJu0YxGEQR2wU9wSDKoAbjQJUa6WLCLn4os952AsdAogPNiNKSQ6oA9
	ARWo0qDHmmtRcwvfUCp2hKxTsQ6r+YUebN2R3HZeg4uTY1FDyQqXZxsIaBrwqQ==
X-Gm-Gg: ASbGnctCBjg+TUCmOYO+3980cse0DRTqD/dK2k6GA5fldTjrMYqq5v6cQAiVUeD221K
	xX5LiGS4zqyvfsZ2WPAlPLX8QLrrYK+0YP0nwmokyou+KFG36ho2MY8HYgOevkJWh4uGahQ3xil
	FAkoy72gcVEDC6BeqZT8lqRvRLTmmSUsqKzgrDJiyMcGFJNwTSdyE+kFx2BgrUw3z9F+1bjPkch
	g8N/pTaBcQxfVDQMoCWWGXokRqVvIKBuh6ZQGV7uk+RH7JGI0XfO8Gim5GpPvXO07Dx1ppmBVvQ
	k47l8JvYtDGr5eaeU7lHZnTkMC/Si4yCvJ/UswZuD34BQSorT0rdbtSD1fL6eQ7sQ/rvqhx0ODH
	ElN6Xda6VeRbWkzBZccKuEIfXmKHXsSXbC0Ud+rblPB99PDejdsRfkeKBAj7HN5MVAMEvH11gGe
	2CmcogHxbZUJ0qjl3WZsHt/7i1GZRQu15DOpVydV05mx7l+XE+X7umPTAHGPsQvZ9Wz0IVxJQme
	nXHkG1S5oZRbjbWp47U59b745n+rHa880nSRjj/S06fDjha7Q==
X-Google-Smtp-Source: AGHT+IExYDtW/7vZ5Jnf/vSDiIQ48NK9IPlqFstAD/ZNP91jaUIuEkge1TIhHj8to0zstQYKNA2YNw==
X-Received: by 2002:a17:907:6e8a:b0:af9:eace:8a52 with SMTP id a640c23a62f3a-b6dba59ab8bmr81825066b.50.1761588731184;
        Mon, 27 Oct 2025 11:12:11 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853c5c0dsm824985166b.40.2025.10.27.11.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 11:12:10 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] parse: add bitbake version check via bitbake_min_version keyword
Date: Mon, 27 Oct 2025 19:12:06 +0100
Message-Id: <20251027181206.3798705-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 27 Oct 2025 18:12:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18223

From: Alexander Kanavin <alex@linutronix.de>

Layers (e.g. openembedded-core) can specify in conf/layer.conf:

bitbake_min_version 2.15.2

and if bitbake has a lesser version it will stop itself, as early
as possible, to avoid hitting cryptic compatibility issues later on,
with this error:

bb.parse.ParseError: ParseError at /home/alex/bitbake-builds/poky-master-poky-distro_poky-machine_qemux86-64/layers/openembedded-core/meta/conf/layer.conf:1: Bitbake version 2.15.3 is required and version 2.15.2 is used

Note that sanity.bbclass in oe-core has a similar check, but as
this thread [1] highlighted, compatibility issues can stop bitbake
sooner and the check is never reached, leaving the user with
confusing errors.

[1] https://lists.openembedded.org/g/openembedded-core/topic/115724008

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/parse/ast.py                  | 12 ++++++++++++
 bitbake/lib/bb/parse/parse_py/ConfHandler.py | 10 ++++++++++
 2 files changed, 22 insertions(+)

diff --git a/bitbake/lib/bb/parse/ast.py b/bitbake/lib/bb/parse/ast.py
index cfead466e1c..67104d5d724 100644
--- a/bitbake/lib/bb/parse/ast.py
+++ b/bitbake/lib/bb/parse/ast.py
@@ -412,6 +412,14 @@ class AddFragmentsNode(AstNode):
             else:
                 bb.error("Could not find fragment {} in enabled layers: {}".format(f, layers))
 
+class BbMinVersionNode(AstNode):
+    def __init__(self, filename, lineno, bb_min_version):
+        AstNode.__init__(self, filename, lineno)
+        self.bb_min_version = bb_min_version
+
+    def eval(self, data):
+        bb.parse.ConfHandler.check_bb_version(self.filename, self.lineno, data.expand(self.bb_min_version))
+
 def handleInclude(statements, filename, lineno, m, force):
     statements.append(IncludeNode(filename, lineno, m.group(1), force))
 
@@ -466,6 +474,10 @@ def handleAddFragments(statements, filename, lineno, m):
     builtin_fragments_variable = m.group(4)
     statements.append(AddFragmentsNode(filename, lineno, fragments_path_prefix, fragments_variable, flagged_variables_list_variable, builtin_fragments_variable))
 
+def handleBbMinVersion(statements, filename, lineno, m):
+    bb_min_version = m.group(1)
+    statements.append(BbMinVersionNode(filename, lineno, bb_min_version))
+
 def runAnonFuncs(d):
     code = []
     for funcname in d.getVar("__BBANONFUNCS", False) or []:
diff --git a/bitbake/lib/bb/parse/parse_py/ConfHandler.py b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
index 9ddbae123dc..eff7f67129d 100644
--- a/bitbake/lib/bb/parse/parse_py/ConfHandler.py
+++ b/bitbake/lib/bb/parse/parse_py/ConfHandler.py
@@ -49,6 +49,7 @@ __unset_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)\[([a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]+)\]$" )
 __addpylib_regexp__      = re.compile(r"addpylib\s+(.+)\s+(.+)" )
 __addfragments_regexp__  = re.compile(r"addfragments\s+(.+)\s+(.+)\s+(.+)\s+(.+)" )
+__bitbake_min_version_regexp__ = re.compile(r"bitbake_min_version\s+(.+)" )
 
 def init(data):
     return
@@ -102,6 +103,10 @@ def include_single_file(parentfn, fn, lineno, data, error_out):
             else:
                 raise ParseError("Error parsing %s: %s" % (fn, exc.strerror), parentfn, lineno)
 
+def check_bb_version(fn, lineno, min_version):
+    if bb.utils.vercmp_string_op(bb.__version__, min_version, "<"):
+        raise ParseError('Bitbake version %s is required and version %s is used\n' % (min_version, bb.__version__), fn, lineno)
+
 # We have an issue where a UI might want to enforce particular settings such as
 # an empty DISTRO variable. If configuration files do something like assigning
 # a weak default, it turns out to be very difficult to filter out these changes,
@@ -213,6 +218,11 @@ def feeder(lineno, s, fn, statements, baseconfig=False, conffile=True):
         ast.handleAddFragments(statements, fn, lineno, m)
         return
 
+    m = __bitbake_min_version_regexp__.match(s)
+    if m:
+        ast.handleBbMinVersion(statements, fn, lineno, m)
+        return
+
     raise ParseError("unparsed line: '%s'" % s, fn, lineno);
 
 # Add us to the handlers list
-- 
2.39.5


