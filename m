Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AED4F9B5F6
	for <webhook@archiver.kernel.org>; Wed, 22 Apr 2026 09:18:34 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.76817.1776849509492130858
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 22 Apr 2026 02:18:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=AXBXKjh4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.49, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-43eada6d900so5128126f8f.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 22 Apr 2026 02:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1776849507; x=1777454307; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=PUTOygwDgP77eW+kxmSfELS8drI7WYvBEiFPHEMCEaU=;
        b=AXBXKjh4LXGEQQ1nLDIX5U/q51sdFUiS+nFe7U4CG4ASH9ufeo2rwQMIZ78tvEG1o+
         t6O24OIGyQEsyBKRmhB5jLyCHRyZKnyFUaCRGQl+w6Kfiwq5KvA3/yl2Sv/YcCJcFksa
         xjgDcJ8Ekmi7Y3adbWcI/kzQCw+9Li8/DHWCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776849507; x=1777454307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PUTOygwDgP77eW+kxmSfELS8drI7WYvBEiFPHEMCEaU=;
        b=azJy6KiQBKZJc5Q0BhEvQrqD65kK0kmNsqi3yqyh1f/A7jmWvwvXjD5DnwDgE4jhKp
         9hUh/5AD7cOxS3eoKNClzgaTf4kKefMf7fjMuzwnezPg+CvXpevvJWz9qrZ4T9BNDan4
         wOcFxYQaqD3+OBZte1lYKJLmsfCsshEtDLF6p6rESfuaHj4frItd+JJ81RpaC1YB+L3e
         q9oZywWLJWphSm5NzJIsnM/cnjPApzPjVZJ9xtRN0MZ9Tssy+J/4FyVAfywbOUyydrr+
         J1nEq2HJIDi5rGpiCwB4HusEIZHTj9OtTBtFm7QWo7/tZZhgGg/vG6yvLZ1EhY8cXW69
         qy2w==
X-Gm-Message-State: AOJu0YzcFgFvgvDWpbD6knX87rjvEIkxcrac8T0bdl676OOvxFIRKzev
	8gAWmxwjOFvl059KucEVFX7LRxwnnEytuzR4pGmD2XRH7RNIT0ShE/xI920f878zZvcVntht6WV
	c+e654TA=
X-Gm-Gg: AeBDietnYY2ZTAvC+wO4CLm7mOaQYEaX363jcMN6orY3RgsfejbAeTJsZWubUmvjMoW
	dUPg1QnhshSG4fYZWlpdAahczvD5uWdCg0rIFVPG+X2YLNeuTKy6rAxMI55nTPBnnsh/IbXfX9Z
	NJ2UwEVbWbDF2gR7bO2o9pktX+TeyIUn9kcjdoSzYKkFz2fXyUWOuXZXc4MMnnTwVbmAEQF+G+d
	Q3tOZxxdqVlphkYHb8baJw45ppwm91HJDjphLazji8//XUn9Li4HoWgWHGgm7zAL14riPTYneZJ
	22fT4pX0icqwXDlw10/Ra5Zwad+2yqxBpePgqum4IOvX2GE7kAm7QUZvpY/c260PrSKKDz+yuGk
	DETOBd5ix4UN6NofOIqt6/3e3BLGHMb2O/suQglSVsJoj0KALv0kuXDnrwFJkFkDnPGlUvSvQG7
	gjMLe3h1K2WrUxp9+eLaj2rj7Sv7pSIk6yc/8T0AHFrCGw6cgq7Chnnk1P0DRzmqA=
X-Received: by 2002:a05:6000:22c5:b0:43c:ef4f:79dc with SMTP id ffacd0b85a97d-43fe3db9b0emr33234699f8f.8.1776849507329;
        Wed, 22 Apr 2026 02:18:27 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:a9c6:3deb:bd01:ef01])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc09b1sm44755222f8f.9.2026.04.22.02.18.26
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 02:18:26 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] default-registry: Update whinlatter -> wrynose
Date: Wed, 22 Apr 2026 10:18:25 +0100
Message-ID: <20260422091826.135946-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 22 Apr 2026 09:18:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19372

Add the new release, replacing whinlatter which it supersedes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 ...onf.json => oe-nodistro-wrynose.conf.json} | 16 +++++++-------
 ...atter.conf.json => poky-wrynose.conf.json} | 22 +++++++++----------
 2 files changed, 19 insertions(+), 19 deletions(-)
 rename default-registry/configurations/{oe-nodistro-whinlatter.conf.json => oe-nodistro-wrynose.conf.json} (82%)
 rename default-registry/configurations/{poky-whinlatter.conf.json => poky-wrynose.conf.json} (84%)

diff --git a/default-registry/configurations/oe-nodistro-whinlatter.conf.json b/default-registry/configurations/oe-nodistro-wrynose.conf.json
similarity index 82%
rename from default-registry/configurations/oe-nodistro-whinlatter.conf.json
rename to default-registry/configurations/oe-nodistro-wrynose.conf.json
index 7b183ae1c43..45fe24a85fa 100644
--- a/default-registry/configurations/oe-nodistro-whinlatter.conf.json
+++ b/default-registry/configurations/oe-nodistro-wrynose.conf.json
@@ -1,5 +1,5 @@
 {
-    "description": "OpenEmbedded - 'nodistro' basic configuration, release 5.3 'whinlatter'",
+    "description": "OpenEmbedded - 'nodistro' basic configuration, release 6.0 'wrynose'",
     "expires": "2026-05-31",
     "sources": {
         "bitbake": {
@@ -9,8 +9,8 @@
                         "uri": "https://git.openembedded.org/bitbake"
                     }
                 },
-                "branch": "2.16",
-                "rev": "2.16"
+                "branch": "2.18",
+                "rev": "2.18"
             }
         },
         "openembedded-core": {
@@ -20,8 +20,8 @@
                         "uri": "https://git.openembedded.org/openembedded-core"
                     }
                 },
-                "branch": "whinlatter",
-                "rev": "whinlatter"
+                "branch": "wrynose",
+                "rev": "wrynose"
             }
         },
         "yocto-docs": {
@@ -31,8 +31,8 @@
                         "uri": "https://git.yoctoproject.org/yocto-docs"
                     }
                 },
-                "branch": "whinlatter",
-                "rev": "whinlatter"
+                "branch": "wrynose",
+                "rev": "wrynose"
             }
         }
     },
@@ -41,7 +41,7 @@
         {
             "name": "nodistro",
             "description": "OpenEmbedded 'nodistro'",
-            "setup-dir-name": "oe-nodistro-whinlatter",
+            "setup-dir-name": "oe-nodistro-wrynose",
             "bb-layers": ["openembedded-core/meta"],
             "oe-fragments-one-of": {
                 "machine": {
diff --git a/default-registry/configurations/poky-whinlatter.conf.json b/default-registry/configurations/poky-wrynose.conf.json
similarity index 84%
rename from default-registry/configurations/poky-whinlatter.conf.json
rename to default-registry/configurations/poky-wrynose.conf.json
index 4827ebe1148..c3a72a99fd7 100644
--- a/default-registry/configurations/poky-whinlatter.conf.json
+++ b/default-registry/configurations/poky-wrynose.conf.json
@@ -1,6 +1,6 @@
 {
-    "description": "Poky - The Yocto Project testing distribution configurations and hardware test platforms, release 5.3 'whinlatter'",
-    "expires": "2026-05-31",
+    "description": "Poky - The Yocto Project testing distribution configurations and hardware test platforms, release 6.0 'wrynose'",
+    "expires": "2030-05-31",
     "sources": {
         "bitbake": {
             "git-remote": {
@@ -9,8 +9,8 @@
                         "uri": "https://git.openembedded.org/bitbake"
                     }
                 },
-                "branch": "2.16",
-                "rev": "2.16"
+                "branch": "2.18",
+                "rev": "2.18"
             }
         },
         "openembedded-core": {
@@ -20,8 +20,8 @@
                         "uri": "https://git.openembedded.org/openembedded-core"
                     }
                 },
-                "branch": "whinlatter",
-                "rev": "whinlatter"
+                "branch": "wrynose",
+                "rev": "wrynose"
             }
         },
         "meta-yocto": {
@@ -31,8 +31,8 @@
                         "uri": "https://git.yoctoproject.org/meta-yocto"
                     }
                 },
-                "branch": "whinlatter",
-                "rev": "whinlatter"
+                "branch": "wrynose",
+                "rev": "wrynose"
             }
         },
         "yocto-docs": {
@@ -42,8 +42,8 @@
                         "uri": "https://git.yoctoproject.org/yocto-docs"
                     }
                 },
-                "branch": "whinlatter",
-                "rev": "whinlatter"
+                "branch": "wrynose",
+                "rev": "wrynose"
             }
         }
     },
@@ -51,7 +51,7 @@
         "configurations": [
         {
             "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
-            "setup-dir-name": "$distro-whinlatter",
+            "setup-dir-name": "$distro-wrynose",
             "oe-fragments-one-of": {
                 "machine": {
                     "description": "Target machines",

