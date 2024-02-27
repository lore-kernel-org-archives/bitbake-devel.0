Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9E9C5478C
	for <webhook@archiver.kernel.org>; Tue, 27 Feb 2024 22:04:41 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web10.2140.1709071480453462217
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 27 Feb 2024 14:04:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=FFrAUP50;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.182, mailfrom: steve@sakoman.com)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e4e7e2594cso2719790b3a.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 27 Feb 2024 14:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1709071480; x=1709676280; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rKIvVPMI1PYCZdh2qsONOH7vYiuZFtGOzCSLzCBz7ws=;
        b=FFrAUP50JPvPgBGJVJ87nVrOMGml8yyjwR3hrK45kKnPO0Bm7jKrx2OS34cOBJcnzy
         5X+rGoL88kaWSP43bU8s02nCGrFO/pjfCOzyhO8aEnFeT+pomnQ5h7MmIGtuxCG1FGYR
         oVtM7ABRn6vHEmdt3lusVBSr6cQSWC1YdxcPLWzCi7H1MU9uB3rCTlkvH12DJmI9EYdp
         Nc26zG8jO63U//YSHceI6W9oMa5DUiifIPSoytVBkgriJIi5ApNb6dJ//5zRA2JkzWmH
         Qid+ktru2epI5C569WMWgylylZRYy6lbG01WdqSQ2saFYb0/9Cbx6CikRXnSt85I1jjI
         WDbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071480; x=1709676280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKIvVPMI1PYCZdh2qsONOH7vYiuZFtGOzCSLzCBz7ws=;
        b=VKBrxItUsQ3f00bD/0jWHpd4R8chFQ8LqaH83PPfdCyc2Mvutpqbl3TczKX1NDzdo2
         +4kJrMA6lO7xhE2YyHH4v0Cbt7UmDwy+gveGO1TSw36d5lY2vVM00V3VpuAAMUpnZyzI
         HQ3yzTFn23q08XTTsLbMLavdun3tO+A0fq3d37mJHDZ45y823KeJFpNm6ZtVs5n0mo4J
         CX7lsn1AP1vxsnFYCSwt5KdoY0e5iMbv+mMFcnJwpGeLmJ0FVqqkyJGuwSaYMueQDTES
         9ux7WPKok0jXzT4KpQKb4W108PS+DPf3VwWua9dEMeZoPhWfiv74Pny37CptKtVhL2aW
         WKlA==
X-Gm-Message-State: AOJu0Yxa91UEF4H5vz0TKxGXFXnSFToFpC2NTqE0I7VGEp8+hB1lTuy1
	vzGQZpzqro3IWuoNbAeJ1TN9ttotVvegHqBx6dkUpbneD5jHL7PWpwGNiQw20dr29W27X4hW3+D
	BHUk=
X-Google-Smtp-Source: AGHT+IEUvheXQnX/mqpgEGQ7FPodfc4t3eRB4cjIxSgcPKP+qLL2o3yf7Ew3s6T3jWQIYXecLS9DRw==
X-Received: by 2002:aa7:98c2:0:b0:6e3:6c9f:599e with SMTP id e2-20020aa798c2000000b006e36c9f599emr10746300pfm.22.1709071479803;
        Tue, 27 Feb 2024 14:04:39 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-234-108-41.hawaiiantel.net. [72.234.108.41])
        by smtp.gmail.com with ESMTPSA id t13-20020a056a0021cd00b006e50c0d6421sm5059772pfj.11.2024.02.27.14.04.39
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 14:04:39 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 2/6] bitbake/codeparser.py: address ast module deprecations in py 3.12
Date: Tue, 27 Feb 2024 12:04:21 -1000
Message-Id: <6c19b6cf105ac321ec89da1a876a317020c45ab7.1709071317.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1709071317.git.steve@sakoman.com>
References: <cover.1709071317.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 27 Feb 2024 22:04:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15968

From: Alexander Kanavin <alex.kanavin@gmail.com>

Specifically:
/srv/work/alex/poky/bitbake/lib/bb/codeparser.py:279: DeprecationWarning: ast.Str is deprecated and will be removed in Python 3.14; use ast.Constant instead
  if isinstance(node.args[0], ast.Str):
/srv/work/alex/poky/bitbake/lib/bb/codeparser.py:280: DeprecationWarning: Attribute s is deprecated and will be removed in Python 3.14; use value instead
  value = node.args[0].s

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/codeparser.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/bb/codeparser.py b/lib/bb/codeparser.py
index bb890dddd..6ce0c5182 100644
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
2.34.1


