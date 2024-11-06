Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0449AD44D5C
	for <webhook@archiver.kernel.org>; Wed,  6 Nov 2024 13:37:47 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.45881.1730900264958813039
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Nov 2024 05:37:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=E8dmsY/w;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.182, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c7ee8fe6bso64405925ad.2
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 Nov 2024 05:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1730900264; x=1731505064; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=huzZgW2OnBXGGkOwSDHQD/8adtSfb1EAl6blOGXxe8Y=;
        b=E8dmsY/wCHgaKGgh9MTxyjpj1RnrWr7+LCmrshYEKP0GqIxteIFq0JMeGC5aeJ4GBl
         8rhyL/QFacolaAHwBlbwLAhN9k1CXXxMYVuKOKNLvJLNbITQB6p4F/sdWC8BZhw3eLVI
         oUdSM8s7LW8Fkif5UsuJ/dcpEga2tUa0Qw1T6HeP3cKWMszC3ruh3ydHfN3gRvSQA6yi
         4LAvna9m1R4ohEBAqMjL7lJPL9xz31R2Fl3gyH9jck/8jAZzc4KAPBfoXcwUHPnM3oGC
         Doj3jfYehevT54HOpECutBsKaF7ssVqgoO5d9i7YLoRxmOaQwEcggCn1RCbC5LlQbunS
         zUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730900264; x=1731505064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huzZgW2OnBXGGkOwSDHQD/8adtSfb1EAl6blOGXxe8Y=;
        b=CsU0Yezwa+fOwTRRUiuBSuzV9cr4MEhFwYkixW1u8svg7yC2TMQ33YpuugMkfan2Jg
         XMqcB5vpyVkNhRoHZcgGTyYH2RcKPHawsG1N0L1IJu5DIC4W1zKFhP/LwnIle25H2maq
         BMytOVWMkNBSVUJ1A8zV0m3L/ts01RXPNTkBE42mZ62NSf6RFGDL+bgSvhvRyGEHJKT6
         nXx2m9zErsdtIA/raESEKfBblp57chfjY21FBl0Ohlk1UuEucegO9gKBtq3rbwxGHJ/m
         svCOuZAwLnglDXNtsc2/BG+GIZsqZSEu6b6xUANhS8UpL1olgXiBFs6zTj6NBu5dRmeL
         5p4w==
X-Gm-Message-State: AOJu0YxzKbjmKkhgxNHO0hmWp0ZAYMgcPjfAjPi5VCpETPfqp4nvltG/
	rGWgHup/4DXi2i4hF7vs3NgaZM7XiWEohgMcsiohSVbyw3EF4AvJEYL+pbGgfkTAcOq+Mrr7idM
	+
X-Google-Smtp-Source: AGHT+IGmFm/MdWVz/vVm749AOQ5yORa5KYMrNLexb8PXG6hAnm6dC23qkRn7YtahbTSU6t3Y4Ap6aQ==
X-Received: by 2002:a17:902:cf0a:b0:20c:9d79:cf85 with SMTP id d9443c01a7336-210c6c932ecmr542652045ad.54.1730900264061;
        Wed, 06 Nov 2024 05:37:44 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057c110csm95707665ad.219.2024.11.06.05.37.43
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 05:37:43 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 1/1] codeparser: Fix handling of string AST nodes with older Python versions
Date: Wed,  6 Nov 2024 05:37:33 -0800
Message-Id: <fb73c495c45d1d4107cfd60b67a5b4f11a99647b.1730900054.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1730900054.git.steve@sakoman.com>
References: <cover.1730900054.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Nov 2024 13:37:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16786

From: Philip Lorenz <philip.lorenz@bmw.de>

Commits 4591011449212c8e494ea42348acb2d27a82a51b and
6c19b6cf105ac321ec89da1a876a317020c45ab7 unconditionally changed
codeparser to rely on CPython 3.8 semantics. However, kirkstone
continues to support CPython versions >= 3.6.0 and as such string AST
nodes were no longer correctly identified.

Fix this by continuing to use `ast.Str` for Python versions < 3.8.0 and
only using the new code path for more recent versions. Detecting which
version of the AST API to use seems to be non-trivial so the Python
feature version is used instead.

Instances of this issue can be identified when executing bitbake with
debug logging:

    while parsing MACHINE_ARCH, in call of d.getVar, argument
        ''TUNE_PKGARCH'' is not a string literal

As a consequence of these parsing issues, bitbake may assume that task
inputs haven't changed and as such erroneously reuse sstate objects when
it shouldn't.

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/codeparser.py | 46 +++++++++++++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 13 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index 6ce0c5182..39dba266c 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -201,6 +201,22 @@ class DummyLogger():
     def flush(self):
         return
 
+
+# Starting with Python 3.8, the ast module exposes all string nodes as a
+# Constant. While earlier versions of the module also have the Constant type
+# those use the Str type to encapsulate strings.
+if sys.version_info < (3, 8):
+    def node_str_value(node):
+        if isinstance(node, ast.Str):
+            return node.s
+        return None
+else:
+    def node_str_value(node):
+        if isinstance(node, ast.Constant) and isinstance(node.value, str):
+            return node.value
+        return None
+
+
 class PythonParser():
     getvars = (".getVar", ".appendVar", ".prependVar", "oe.utils.conditional")
     getvarflags = (".getVarFlag", ".appendVarFlag", ".prependVarFlag")
@@ -225,19 +241,22 @@ class PythonParser():
     def visit_Call(self, node):
         name = self.called_node_name(node.func)
         if name and (name.endswith(self.getvars) or name.endswith(self.getvarflags) or name in self.containsfuncs or name in self.containsanyfuncs):
-            if isinstance(node.args[0], ast.Constant) and isinstance(node.args[0].value, str):
-                varname = node.args[0].value
-                if name in self.containsfuncs and isinstance(node.args[1], ast.Constant):
+            varname = node_str_value(node.args[0])
+            if varname is not None:
+                arg_str_value = None
+                if len(node.args) >= 2:
+                    arg_str_value = node_str_value(node.args[1])
+                if name in self.containsfuncs and arg_str_value is not None:
                     if varname not in self.contains:
                         self.contains[varname] = set()
-                    self.contains[varname].add(node.args[1].value)
-                elif name in self.containsanyfuncs and isinstance(node.args[1], ast.Constant):
+                    self.contains[varname].add(arg_str_value)
+                elif name in self.containsanyfuncs and arg_str_value is not None:
                     if varname not in self.contains:
                         self.contains[varname] = set()
-                    self.contains[varname].update(node.args[1].value.split())
+                    self.contains[varname].update(arg_str_value.split())
                 elif name.endswith(self.getvarflags):
-                    if isinstance(node.args[1], ast.Constant):
-                        self.references.add('%s[%s]' % (varname, node.args[1].value))
+                    if arg_str_value is not None:
+                        self.references.add('%s[%s]' % (varname, arg_str_value))
                     else:
                         self.warn(node.func, node.args[1])
                 else:
@@ -245,10 +264,10 @@ class PythonParser():
             else:
                 self.warn(node.func, node.args[0])
         elif name and name.endswith(".expand"):
-            if isinstance(node.args[0], ast.Constant):
-                value = node.args[0].value
+            arg_str_value = node_str_value(node.args[0])
+            if arg_str_value is not None:
                 d = bb.data.init()
-                parser = d.expandWithRefs(value, self.name)
+                parser = d.expandWithRefs(arg_str_value, self.name)
                 self.references |= parser.references
                 self.execs |= parser.execs
                 for varname in parser.contains:
@@ -256,8 +275,9 @@ class PythonParser():
                         self.contains[varname] = set()
                     self.contains[varname] |= parser.contains[varname]
         elif name in self.execfuncs:
-            if isinstance(node.args[0], ast.Constant):
-                self.var_execs.add(node.args[0].value)
+            arg_str_value = node_str_value(node.args[0])
+            if arg_str_value is not None:
+                self.var_execs.add(arg_str_value)
             else:
                 self.warn(node.func, node.args[0])
         elif name and isinstance(node.func, (ast.Name, ast.Attribute)):
-- 
2.34.1


