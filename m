Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B23E7717F
	for <webhook@archiver.kernel.org>; Mon, 16 Dec 2024 14:36:10 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
 by mx.groups.io with SMTP id smtpd.web11.57809.1734359761315541896
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 16 Dec 2024 06:36:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=YnY5VPsU;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.45, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so2726193f8f.0
        for <bitbake-devel@lists.openembedded.org>; Mon, 16 Dec 2024 06:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1734359759; x=1734964559; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=yUwUed360k5O14ZjVfgktxEwNCaL+oLf7myYJ3PHHtw=;
        b=YnY5VPsUz2zHbig+lqv8OhLJs/2UTkKdKCMK5GbNnroEdgyuyBm7VVurd/ltfARpa0
         pmFJI4y4vwoW8BPLBgJjkeKo+rTY5ijzeABIAnTxtIU8elR23S4b9PtK+Hwggdg4iPFm
         OWVDvrXmRoVT5g6a0NCQeC5hW62DKLNMfWkTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734359759; x=1734964559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yUwUed360k5O14ZjVfgktxEwNCaL+oLf7myYJ3PHHtw=;
        b=CsijxOS7Kc0WfIrbpAPjYEKd7tYSDjYb8iPeyz1y6DezMzN87o2/meNEdfn6XMyKid
         EJLhwzviOTcrZRfKJuYSdzRKk+9JOl6MRwj5NHZImhexsaQOmvNP23zoHa0h8aEv3Cxs
         /EJMFCivS467eJ/MP+wGLGCey7AMPxZbSyb2Vp7uO2HWjzzBC/XG+XsVroH+OhZ89qZu
         hFj2r6MTD3rQofuDgRN7SJ8xN18B5/+M4VMaAOHqGXAPyFLCmBA4rMjME9c61ZhfrN+d
         GHJS4nTCRBpTnU4cDgt1t0Zmj/5Exw8SgMa+mBzsmxMGdIPMyejvNyp0XafRlP1iAbq9
         mr4w==
X-Gm-Message-State: AOJu0Yz+V9J+GsMvTigqLeje7WcbZGdT52g980YfW3f1mGt+aatSetfr
	zd/BpEouXaR6NGoqBa9tOQL8m6OhCyX15WI2+OUz8WcaUsvSM86HixUWqdYbbyFg3oz5zI9Jshr
	c
X-Gm-Gg: ASbGncvNXw39Myv/LDXV2s1OlBj4TmqoCGdvrORJOFrf2cLUw4nY6+Pdv3Y5+an08Kq
	tEPm0Bb4s144BSqMJlt1qXv+6D1Hur4yUbMoSO6numMw3TjEQ2IlhdU8XczTJwi/SDpZFt082gC
	SuNbsoHFCfwtyLkM2oZD2zAFnXV5mi7MUfuSlHY+AqvG6sEQrgKSDyEEkwHhCXXQvrP4ld51VZE
	WhGyCYQmSozclbcchbXepf+0f9EfCijG5WRMVdxgxjYCVKrlHVUdBybzuFT9nAKCsCaKUUZ7fPw
	8Vq3s7B3Sg==
X-Google-Smtp-Source: AGHT+IEMk8Iwkey9DTyHVTG/7zfwBPDruyUVpd3gcKX/YMyHd58jhkrm6LGcTEVl0VXKOvRKfbeOdQ==
X-Received: by 2002:a05:6000:1fad:b0:386:42b1:d7e4 with SMTP id ffacd0b85a97d-3878884729bmr14638641f8f.19.1734359759130;
        Mon, 16 Dec 2024 06:35:59 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:1ad8:ac77:3170:84a7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-388c80473ffsm8501433f8f.72.2024.12.16.06.35.58
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 06:35:58 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] parse: Add include_all conf file directive
Date: Mon, 16 Dec 2024 14:35:57 +0000
Message-ID: <20241216143557.1484923-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 16 Dec 2024 14:36:10 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16912

In some cases it would be helpful to be able to have an include file
in a standard location which is included in all layers that are added
to the system. The intent is for these to provide configuration tweaks
of specific types so that a given file pattern can be adopted more widely
for such configuration.

The code will search for any named configuration file within BBPATH, so
a configuration directive of:

include_all conf/distro/include/myinc.conf

would include the myinc.conf file in that subpath if present in any
directory in BBPATH. Multiple files will be included if present.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/parse/ast.py                  | 18 ++++++++++++++++++
 lib/bb/parse/parse_py/ConfHandler.py |  6 ++++++
 2 files changed, 24 insertions(+)

diff --git a/lib/bb/parse/ast.py b/lib/bb/parse/ast.py
index 03370180e3..2f6c6a0055 100644
--- a/lib/bb/parse/ast.py
+++ b/lib/bb/parse/ast.py
@@ -43,6 +43,21 @@ class IncludeNode(AstNode):
         else:
             bb.parse.ConfHandler.include(self.filename, s, self.lineno, data, False)
 
+class IncludeAllNode(AstNode):
+    def __init__(self, filename, lineno, what_file):
+        AstNode.__init__(self, filename, lineno)
+        self.what_file = what_file
+
+    def eval(self, data):
+        """
+        Include the file and evaluate the statements
+        """
+        s = data.expand(self.what_file)
+        logger.debug2("CONF %s:%s: including %s", self.filename, self.lineno, s)
+
+        for path in data.getVar("BBPATH").split(":"):
+            bb.parse.ConfHandler.include(self.filename, os.path.join(path, s), self.lineno, data, False)
+
 class ExportNode(AstNode):
     def __init__(self, filename, lineno, var):
         AstNode.__init__(self, filename, lineno)
@@ -366,6 +381,9 @@ class AddFragmentsNode(AstNode):
 def handleInclude(statements, filename, lineno, m, force):
     statements.append(IncludeNode(filename, lineno, m.group(1), force))
 
+def handleIncludeAll(statements, filename, lineno, m):
+    statements.append(IncludeAllNode(filename, lineno, m.group(1)))
+
 def handleExport(statements, filename, lineno, m):
     statements.append(ExportNode(filename, lineno, m.group(1)))
 
diff --git a/lib/bb/parse/parse_py/ConfHandler.py b/lib/bb/parse/parse_py/ConfHandler.py
index d0711eda04..24f81f7e9e 100644
--- a/lib/bb/parse/parse_py/ConfHandler.py
+++ b/lib/bb/parse/parse_py/ConfHandler.py
@@ -43,6 +43,7 @@ __config_regexp__  = re.compile( r"""
     """, re.X)
 __include_regexp__ = re.compile( r"include\s+(.+)" )
 __require_regexp__ = re.compile( r"require\s+(.+)" )
+__includeall_regexp__ = re.compile( r"include_all\s+(.+)" )
 __export_regexp__ = re.compile( r"export\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)$" )
 __unset_flag_regexp__ = re.compile( r"unset\s+([a-zA-Z0-9\-_+.${}/~]+)\[([a-zA-Z0-9\-_+.][a-zA-Z0-9\-_+.@]+)\]$" )
@@ -178,6 +179,11 @@ def feeder(lineno, s, fn, statements, baseconfig=False, conffile=True):
         ast.handleInclude(statements, fn, lineno, m, True)
         return
 
+    m = __includeall_regexp__.match(s)
+    if m:
+        ast.handleIncludeAll(statements, fn, lineno, m)
+        return
+
     m = __export_regexp__.match(s)
     if m:
         ast.handleExport(statements, fn, lineno, m)

