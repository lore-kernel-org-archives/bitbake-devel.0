Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8F9C3DA6E
	for <webhook@archiver.kernel.org>; Sun, 31 Dec 2023 10:04:42 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
 by mx.groups.io with SMTP id smtpd.web11.217427.1704017072918287663
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 31 Dec 2023 02:04:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=GEGtq7W0;
 spf=pass (domain: gmail.com, ip: 209.85.218.47, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a27cc46d40bso72001566b.0
        for <bitbake-devel@lists.openembedded.org>; Sun, 31 Dec 2023 02:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704017071; x=1704621871; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OOEb5yFo1LGPv9AgeMTc4Moaz0ouhjsx0UGK2DtdOgI=;
        b=GEGtq7W02Wpga6Gn/8HiAZqW2XOOuvZTnoKqJKUHx8k8Rh6nV2YiCWI2E/pykmfgBL
         B0TylLYQZsPe/UZAXMzwKpDICO0IQUDQd4uVrorVfdkUqYOgomgm5EFrf1G3yMGbZm4+
         W5itL71LAN3wjQRsui1/0s3j8x03jM+2fcj79iYuC75CiT87ACl1skUzR9xwzW2w0Hej
         l/EGdyHawtvSORzNiuAiazb+skdVL0XLmSKOQfSAyH5LvJ7pkNGeJ/r7MWqtn+wB+zhu
         uwtFKC3C3SJN2BsQ+OJVl3pSGMlGiCnwLAobV9DYsh2Gk4iQKB68koZX5e6tX4qYTuyH
         ydcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704017071; x=1704621871;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOEb5yFo1LGPv9AgeMTc4Moaz0ouhjsx0UGK2DtdOgI=;
        b=FLheYN1wz+6ky4P3ZxCfUxtOUUbKGI/0Q9yfdySXFL00tSpANWv7Dwu+bZpZTKF1Pq
         to6xQiPPGEnI5MHlZQw+vYJO12RPYM8jwrwn+7Bv7v8ykv6jRcLQnW03cDrz0+GaHUpz
         mp/aMm9+hOvOqFr0KIfWxbNgXTSCEEwtkLILpjpou82/QeLZHS58Uxe/ktSrqvTEgj57
         +lUMNTrKjv1huYwASZIXu0/MeGkm5rIltp6jmvjGvChIK7y1gAztESE4FGYCumabfhke
         8qxVBWiHatSEHGt9xpEtlNT1BWuChJyWKkPLwsamu11fYpTNzpn/foUqGMSOo8z/zRph
         5hoA==
X-Gm-Message-State: AOJu0YyMSujMTbqtiRC4da1U68Of+yLs7Q5LzkvlaX61HTrCIi0+dAYJ
	zpAXfM8WgbTF03065w8l50qgDjiKg+k=
X-Google-Smtp-Source: AGHT+IHP6g7Ujfu+oCBItpqWLPs4/NTE/Mw+Z574t9XHdAg2sdbOqcm/kv9Y4pJ6yQGET7SRZH4nHg==
X-Received: by 2002:a17:906:2252:b0:a26:97f6:723a with SMTP id 18-20020a170906225200b00a2697f6723amr3957938ejr.103.1704017071006;
        Sun, 31 Dec 2023 02:04:31 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id fp21-20020a1709069e1500b00a26ade46619sm9149538ejc.121.2023.12.31.02.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Dec 2023 02:04:30 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
X-Google-Original-From: Alexander Kanavin <alex@linutronix.de>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake/codeparser.py: address ast module deprecations in py 3.12
Date: Sun, 31 Dec 2023 11:04:24 +0100
Message-Id: <20231231100424.3632395-1-alex@linutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 31 Dec 2023 10:04:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15733

Specifically:
/srv/work/alex/poky/bitbake/lib/bb/codeparser.py:279: DeprecationWarning: ast.Str is deprecated and will be removed in Python 3.14; use ast.Constant instead
  if isinstance(node.args[0], ast.Str):
/srv/work/alex/poky/bitbake/lib/bb/codeparser.py:280: DeprecationWarning: Attribute s is deprecated and will be removed in Python 3.14; use value instead
  value = node.args[0].s

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 bitbake/lib/bb/codeparser.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/codeparser.py b/bitbake/lib/bb/codeparser.py
index cd39409434b..2e8b7ced3c2 100644
--- a/bitbake/lib/bb/codeparser.py
+++ b/bitbake/lib/bb/codeparser.py
@@ -258,17 +258,17 @@ class PythonParser():
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
@@ -276,8 +276,8 @@ class PythonParser():
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
@@ -287,8 +287,8 @@ class PythonParser():
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
2.39.2


