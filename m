Return-Path: <adrian.freihofer@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB170C48BF0
	for <webhook@archiver.kernel.org>; Thu, 15 Feb 2024 20:45:44 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
 by mx.groups.io with SMTP id smtpd.web11.1545.1708029939191865065
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Feb 2024 12:45:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=lvKqHzay;
 spf=pass (domain: gmail.com, ip: 209.85.208.51, mailfrom: adrian.freihofer@gmail.com)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso587725a12.2
        for <bitbake-devel@lists.openembedded.org>; Thu, 15 Feb 2024 12:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708029937; x=1708634737; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGN+3iVizbVqbr5nfFYQZb6BbBtAbiJWBm6qymvdvzM=;
        b=lvKqHzayMOSfsIkxRb78kb0Wury5xr4WiqKv/MTq5+gvLu6H/JJA/U2NiAOBHGPxPS
         VgN9IZN6zYckvm/CNXx1O6pZ7EZ25JpePod90TVLmEQPN0UZ7L/de2AtsXn0GJTSWUxR
         azRGKOzfBJw/Fy531ZhTPs8Q8Z36NeFxYLLhzA8g85v8wLwWeEFIxHvRLgdIHR5fCRaK
         YGGHauqNALjqYjnm6VrqIdvjY0lGjQKYabn4hlkm1B17rx647xqDJmXOjAxj0AWfdF1X
         vN5/UtHLhihC4GxgjMjqazThOnVRnV1/rNo+R2SOEULOkDu0ObWW4AomdBj1YWICBKU8
         x3rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708029937; x=1708634737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGN+3iVizbVqbr5nfFYQZb6BbBtAbiJWBm6qymvdvzM=;
        b=KwYVYODsDMLJem5ndUPVJAqm/l5Wn+2GtaYBDxiDpCN3mdTzBP9zj7j46gedtWsfI5
         yaiYab+RbYpAxNzepjnGK+cD4VyZgfTqRQWQkmWpYtkAoH20i/sjWnJbuif/ll70p26S
         t9LKt5IVZPUoCjk290xQaL156tEDUmaprqXpB5knZB7v581omZH/N27C9xDZEp0zhUHp
         N1J8QZd7Vo7WqcSyN4tqu9Yltcpq9OioKOEX1dEwUuOgk5+rPKfwL2aTkNxUomp+thjg
         H1/H2GgAZUuxKjxpMK78nm85RPWU9vYNl6prLtb/rcnu/oZ0KYoZItNp7OBl9y52UU19
         ZT7Q==
X-Gm-Message-State: AOJu0YyOplRt83qx5hQYWxzM/Kgx6wfJ72l1f35gwzumFrYgk5aBQ/0l
	6Jl1S/YfFN7mTIa+tkU6ab5nd4RrjhZaLtnHkhJtOV/vxHkxVt/wWoMoeVU3eaQ=
X-Google-Smtp-Source: AGHT+IGe6TuTUssorpVm1Gi54D/wyZW4kfLUnu0PvkAph/JJgrxuUeaeUfPOAtRjR2yWGNA3noAwqA==
X-Received: by 2002:a05:6402:17c4:b0:563:ccd1:26bd with SMTP id s4-20020a05640217c400b00563ccd126bdmr1002781edy.2.1708029936909;
        Thu, 15 Feb 2024 12:45:36 -0800 (PST)
Received: from wsadrian16.fritz.box ([2a02:169:59a6:0:55c4:f628:91f3:4287])
        by smtp.gmail.com with ESMTPSA id er17-20020a056402449100b0056058f2603asm883058edb.3.2024.02.15.12.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 12:45:36 -0800 (PST)
From: Adrian Freihofer <adrian.freihofer@gmail.com>
X-Google-Original-From: Adrian Freihofer <adrian.freihofer@siemens.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex.kanavin@gmail.com>,
	Alexander Kanavin <alex@linutronix.de>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: [2.0][kirkstone][PATCH 2/3] bitbake/codeparser.py: address ast module deprecations in py 3.12
Date: Thu, 15 Feb 2024 21:44:51 +0100
Message-ID: <20240215204524.320874-3-adrian.freihofer@siemens.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240215204524.320874-1-adrian.freihofer@siemens.com>
References: <20240215204524.320874-1-adrian.freihofer@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Feb 2024 20:45:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15902

From: Alexander Kanavin <alex.kanavin@gmail.com>

Specifically:
/srv/work/alex/poky/bitbake/lib/bb/codeparser.py:279: DeprecationWarning: ast.Str is deprecated and will be removed in Python 3.14; use ast.Constant instead
  if isinstance(node.args[0], ast.Str):
/srv/work/alex/poky/bitbake/lib/bb/codeparser.py:280: DeprecationWarning: Attribute s is deprecated and will be removed in Python 3.14; use value instead
  value = node.args[0].s

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/codeparser.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index bb890ddd..6ce0c518 100644
--- a/lib/bb/codeparser.py
+++ b/lib/bb/codeparser.py
@@ -227,17 +227,17 @@ class PythonParser():
         if name and (name.endswith(self.getvars) or name.endswith(self.getvarflags) or name in self.containsfuncs or name in self.containsanyfuncs):
             if isinstance(node.args[0], ast.Constant) and isinstance(node.args[0].value, str):
                 varname = node.args[0].value
-                if name in self.containsfuncs and isinstance(node.args[1], ast.Str):
+                if name in self.containsfuncs and isinstance(node.args[1], ast.Constant):
                     if varname not in self.contains:
                         self.contains[varname] = set()
-                    self.contains[varname].add(node.args[1].s)
-                elif name in self.containsanyfuncs and isinstance(node.args[1], ast.Str):
+                    self.contains[varname].add(node.args[1].value)
+                elif name in self.containsanyfuncs and isinstance(node.args[1], ast.Constant):
                     if varname not in self.contains:
                         self.contains[varname] = set()
-                    self.contains[varname].update(node.args[1].s.split())
+                    self.contains[varname].update(node.args[1].value.split())
                 elif name.endswith(self.getvarflags):
-                    if isinstance(node.args[1], ast.Str):
-                        self.references.add('%s[%s]' % (varname, node.args[1].s))
+                    if isinstance(node.args[1], ast.Constant):
+                        self.references.add('%s[%s]' % (varname, node.args[1].value))
                     else:
                         self.warn(node.func, node.args[1])
                 else:
@@ -245,8 +245,8 @@ class PythonParser():
             else:
                 self.warn(node.func, node.args[0])
         elif name and name.endswith(".expand"):
-            if isinstance(node.args[0], ast.Str):
-                value = node.args[0].s
+            if isinstance(node.args[0], ast.Constant):
+                value = node.args[0].value
                 d = bb.data.init()
                 parser = d.expandWithRefs(value, self.name)
                 self.references |= parser.references
@@ -256,8 +256,8 @@ class PythonParser():
                         self.contains[varname] = set()
                     self.contains[varname] |= parser.contains[varname]
         elif name in self.execfuncs:
-            if isinstance(node.args[0], ast.Str):
-                self.var_execs.add(node.args[0].s)
+            if isinstance(node.args[0], ast.Constant):
+                self.var_execs.add(node.args[0].value)
             else:
                 self.warn(node.func, node.args[0])
         elif name and isinstance(node.func, (ast.Name, ast.Attribute)):
-- 
2.43.1


