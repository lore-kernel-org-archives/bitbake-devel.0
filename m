Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD88D10392
	for <webhook@archiver.kernel.org>; Wed, 26 Nov 2025 08:38:34 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9034.1764146309306401800
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 26 Nov 2025 00:38:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=VQVBQ4vI;
 spf=pass (domain: gmail.com, ip: 209.85.218.42, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b737c6c13e1so620188466b.3
        for <bitbake-devel@lists.openembedded.org>; Wed, 26 Nov 2025 00:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764146307; x=1764751107; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bDx2ZgvcQyT35l+YEdYSU4nMh8imeSLCeknPMd/ZeDM=;
        b=VQVBQ4vIDlPUoraO/ojkht0m76QKdDY60RFQdeoQMmzIPOGkbkrC23+VsgfRZe1A0c
         UHh0/H2zer5PP4rUj1vwPmY/Dv0LlTt2ew93eB3IPkeHsSxNbXq46TteuMe5cdfdriV0
         oWMQX/Qrbk2S90zLLGSM5P6EMfhLkTz/BNkfMZ/sT2OWzS3z7kpsVu90nO41x9n8xpXw
         00LoLetDp81AIEpkVbi5XJGWXftckPRxco0Neh9ixSW4Lo0qnrN5aazNLzEfAem4HUMC
         pjdYYyt15UzjBAVUyUtAxtxeWLSrkiGUFI9VmL+d/FDgLdvD2k3I0eCztaCgicJZ8sWS
         GWDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764146307; x=1764751107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDx2ZgvcQyT35l+YEdYSU4nMh8imeSLCeknPMd/ZeDM=;
        b=bSg7lu28LnWyD1a43o21fmb0M5UmOuzkPInIZFBknDIANcrP1rRjnrguqc6zahgI3n
         3y49gVrmdKMzhFqT9jMMRm/hazOz6G61nnTPtKvCdAVZc0q7hOWbliaaGQwu3+O/nj87
         do8CWZ0C+P+VtX6XcCL17RdoRelgTeza2ZfYwe01tB/U+Fe05JxtRLyHQmypv6zsGY6M
         VMz3pCURYMpjUnkPHTmKH4t+zxv7UgdnWWLVUO+HSrDhoc37ZP4MkU5YjFjBBZv8XPGl
         HmpuiRKpVa9hm331w99cRDvchLHqO3qSMVckoQGgmz65Y4L85bPQSiv1aAwbZkHByhS/
         ZeRQ==
X-Gm-Message-State: AOJu0YwOGYQjVk7ntY8UODKXn6pNl4sbw3Xn24UrryNQTdaRUB+KvsmV
	ewbYRr1SMxt2AobwW04M0C1Yel9dM+ly5Xua77C0X1AJPM9vxHsaC6IkWJuRQA==
X-Gm-Gg: ASbGncuNzpxwX4zj5YDOsZLUtGHxnL92Q59C+zXYAkDFtMgdfqhaMIOD4+7JBV8SCqM
	Uie1mqFmLpQzMg5mGjb2Ab1ddo5he3s/UYA31McZHgiXTArP0EF/UT8joo/NPq+nW+fd9iwewDG
	BvoHORne3mS42nMRH98mkTZ83yBcCUfRs3Q/50Z7G8X39q8AJxHecKMVZquUrPfMxSLd//XNebY
	+x7Bv83xmIQbhvwc8tjvTKRqeU5YxszqLXHRh5s+mxH4bY+aUzhJ5vsKVFkcCNlayZycP6E15Uc
	RGBLYibrHzCcxeS9xnNKLNM/CuKwVM3tX89FYfbvj0vTcqKgDvoX21gw6oxilZ0G7mS6GzjBqHU
	YQGbfNs4yMEnhzvI0yyJH02gwSbJcAlIC8u6FCU+UgOkbGq86/Iyuz5L0LfbMxJVH3SrLffxIe0
	sN7/SN17JEPljP863H8Lrlj0tzKov4wyNinHKGnRpoL8HDXpHWuqw=
X-Google-Smtp-Source: AGHT+IFSUXkmynMJrZ4i0HUz0z0HJnrXzpvFD2N54OVsrh+Lt4WhOFkGg+0jpofp1ccay6vM4ire1Q==
X-Received: by 2002:a17:907:2d91:b0:b73:6e0d:4f6b with SMTP id a640c23a62f3a-b76c55f3f27mr681588766b.36.1764146307174;
        Wed, 26 Nov 2025 00:38:27 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4e6bsm1791097066b.34.2025.11.26.00.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:38:26 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake-setup: rename oe-nodistro to oe-nodistro-master
Date: Wed, 26 Nov 2025 09:38:18 +0100
Message-Id: <20251126083818.2499327-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 26 Nov 2025 08:38:34 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18494

From: Alexander Kanavin <alex@linutronix.de>

This makes it consistent with poky-master and upcoming
release-specific configurations (e.g. poky-whinlatter).

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 .../{oe-nodistro.conf.json => oe-nodistro-master.conf.json}   | 2 +-
 .../bitbake-user-manual-environment-setup.rst                 | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)
 rename default-registry/configurations/{oe-nodistro.conf.json => oe-nodistro-master.conf.json} (96%)

diff --git a/default-registry/configurations/oe-nodistro.conf.json b/default-registry/configurations/oe-nodistro-master.conf.json
similarity index 96%
rename from default-registry/configurations/oe-nodistro.conf.json
rename to default-registry/configurations/oe-nodistro-master.conf.json
index 9f9314399..180d2008a 100644
--- a/default-registry/configurations/oe-nodistro.conf.json
+++ b/default-registry/configurations/oe-nodistro-master.conf.json
@@ -40,7 +40,7 @@
         {
             "name": "nodistro",
             "description": "OpenEmbedded 'nodistro'",
-            "setup-dir-name": "oe-nodistro",
+            "setup-dir-name": "oe-nodistro-master",
             "bb-layers": ["openembedded-core/meta"],
             "oe-fragments-one-of": {
                 "machine": {
diff --git a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
index 2b8051bcb..962fc9463 100644
--- a/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
+++ b/doc/bitbake-user-manual/bitbake-user-manual-environment-setup.rst
@@ -334,7 +334,7 @@ In addition, the command can take the following arguments:
 
    .. code-block:: shell
 
-      $ ./bitbake/bin/bitbake-setup init https://git.openembedded.org/bitbake/plain/default-registry/configurations/oe-nodistro.conf.json
+      $ ./bitbake/bin/bitbake-setup init https://git.openembedded.org/bitbake/plain/default-registry/configurations/oe-nodistro-master.conf.json
 
 -  This example initializes a :term:`Setup` with: 
 
@@ -845,7 +845,7 @@ Generic Configuration Examples
 
 OpenEmbedded "nodistro" configuration for master branches:
 
-.. literalinclude:: ../../default-registry/configurations/oe-nodistro.conf.json
+.. literalinclude:: ../../default-registry/configurations/oe-nodistro-master.conf.json
    :language: json
 
 Poky distribution configuration for master branches:
-- 
2.39.5


