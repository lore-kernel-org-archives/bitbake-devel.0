Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C191FD116EA
	for <webhook@archiver.kernel.org>; Thu, 27 Nov 2025 10:29:45 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.15741.1764239376364525650
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Nov 2025 02:29:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=IyJYZ2Pi;
 spf=pass (domain: gmail.com, ip: 209.85.208.52, mailfrom: alex.kanavin@gmail.com)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6418738efa0so1255413a12.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 27 Nov 2025 02:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764239374; x=1764844174; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bDx2ZgvcQyT35l+YEdYSU4nMh8imeSLCeknPMd/ZeDM=;
        b=IyJYZ2PiXB0E2YssQlER6v+OWLxLpRHYw/NFz6NlpxGoJVCtwkDpfsc8lpXn08QKes
         Lb/64wj1VlGkrFsO9taCY8GwkqZFw4iGFSgnAiZJ3L4eOHc10QihOkmrzhz874I0Zc1D
         hB23eqVWFnNT8bK+1mtN1hS4hn4sQply48+um9yZmbX+ryCfT4CdviSPYmODhs02kFvE
         DWHlMFCwl0kTmi6wWXEGjWnBq0B+S6v5scjMEK6xXLfGC/PuXhyOzexrbsvaWxYNmdyi
         E0kXB4KC5JlrBb1q37gZwc3EkRA5rDs5nw7z3CSCDVpnruEe0F5KYK9aTDWwDsR6nx6j
         Vn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764239374; x=1764844174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDx2ZgvcQyT35l+YEdYSU4nMh8imeSLCeknPMd/ZeDM=;
        b=s+S9jcuH9tJjUPcHO4f3nZz1px6Hip3JgG/Go5BjaEiSHhoKHtSvtGVKwznVzoIXKF
         0vpL9zXOD3jvbYgHjkt+6XDRA4Z25SQTF6cHMPINeFgZ017RFGH/vwlJq/RVpwBMS088
         ukgpn0P+Q5i8aRo1H2XgMtqREgtI0q9P2YKPSjAZjLb9Jjv+Z/KbmGAnJ/0peBsLfIxF
         8LnMh/y+sKb9/hJot7/ALbwMg7HbrDxXsaF4ghzwtonNiI6ACxjO9SKz0543o5rXuy/Q
         sbkNUJoEU1H2rd7xxDg7NLVLYHQS5bjWQGb3QfbbX/m/rmGGMkENOf/u1143kH5PFjr3
         Q49A==
X-Gm-Message-State: AOJu0YzdtXiC5JEmwmAHtg1CyHExvMEOoUddcml6MDg3cK8GCVgLlKgB
	xMGkkGwQs901pbehVRc3MPJLLqHBzgLv7gqQbI7q9mZZf/CaC9SkU1t6zMhKRw==
X-Gm-Gg: ASbGncuxeL3SyYbx1o3X9j3wRKOlC8P9cvq3rjJ7rszGzi2uTDLoCarG+BtdckFpQ0w
	qQ84lgOrrkPqxjQ8tiIQAR9z6WRXUx5r3aZDjbRd6inWgDwhqXHYOU+iKgnqBFo0aVFgvUry2+O
	6KxDK+xcjtielbzTZpW0bjAaMo1OmUGxEDnAZc6dzvMi+hOj5UJWsDu4Gz+YKMewS0oZ9ukvosB
	0RFn5NMTEl8fG+s24WI5nU0HQEMKmcU/oNTfHyBbmkCi7ZdH/fmN8U6hTabO1bMe2bwDgB2iCdl
	BJagWcWjf3p+yYuM9LgwYXbye6SWi6ICCloSwPKv3RETChEiKOsDAtzDSiQnNe4TFecovAvIvMS
	9x3g1tOVuXqF9l6r8+hGSnPIFcAMTYMIU6YlqhFSUcNj0eYE3XH/htF2e7+HnV+PnaaeFIg/KYu
	iBRUT4CwOG5dbMppqoZJJBEStDMaa/sC5LM/1/bveSuJaIA897/uk=
X-Google-Smtp-Source: AGHT+IF8woOomNGzFnnhPDeDqAu+gKiEvqlkkcmNqZzjCR2C3q3wRtNqA0vZA+XSC0ZkYmZvkbulag==
X-Received: by 2002:a17:906:1d0d:b0:b76:8671:6cc5 with SMTP id a640c23a62f3a-b7686716d5amr1623699466b.53.1764239374265;
        Thu, 27 Nov 2025 02:29:34 -0800 (PST)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59a6a74sm122661566b.45.2025.11.27.02.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 02:29:33 -0800 (PST)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH v2 1/3] bitbake-setup: rename oe-nodistro to oe-nodistro-master
Date: Thu, 27 Nov 2025 11:29:26 +0100
Message-Id: <20251127102928.3647918-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Nov 2025 10:29:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18500

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


