Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB88CAC5B8
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 08:29:45 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web11.4041.1759393778046424026
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 02 Oct 2025 01:29:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=jS6wqRUw;
 spf=pass (domain: gmail.com, ip: 209.85.221.48, mailfrom: alex.kanavin@gmail.com)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3f0308469a4so356994f8f.0
        for <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 01:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759393776; x=1759998576; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i8qqT3sN+iuVfNxkatQt7RoqzzONzAC1cNfVfZc6Y7I=;
        b=jS6wqRUw3Vm7/5JGtcC1RXtRHDlICA+pEMG5uqdA/CzZhaXQrrWHDIOvUvugz3dFVh
         BZiRk6AYdT3t5yCbNj0ZrC0KIpX3DbsDwNYm6HRlmyJCuGTJEOMaumQcIjjaGZt+aTGu
         dFWF+b+oCI+hwsbxYIMIY7tA4bvkvvSzbwevBejJQK119z2s6OlFpoC0BKTRpHaeLSpQ
         VrxFhKd/hkq9HfciMteozaY/La6ZITHJKNHsY8JqbqH90Ewlw9uDP3K8Q++YoEQEeo88
         x+MAWzQf3qNmtvkXm4tGtBRSnZRUVRJdY2eZzPWw7E9ntsobvXmVS9gUbF3qyW05s3vF
         J+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759393776; x=1759998576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8qqT3sN+iuVfNxkatQt7RoqzzONzAC1cNfVfZc6Y7I=;
        b=ltAEHa6TYR/AgJSkVaVnsjKqjIkOwtkItpTe9J9GDHXo2Ncjqe+EGtOfNpR/O0yDeV
         MSNF8IOEzkxjKVMZ5TDqTJKqlQXaiEQx3ZokHT19FRYeEvEoEDxXZYxaFeeMwnbnoSJ5
         Nd8JAqAVqiEgjwIVmZP6nMUsVsK74TMcOWLBrfM7qjGKh/KnfsuL2miwKmwgldwSYZ1U
         GkKRzOnWQ76t0n82NZnLuQxTrrL4NMwC1N59C6b0YcXBXgz+0A6Mr4G9X+OqMcFIfwev
         XDl9LVbAMvmZLRVYYfmYIxIx8Na7fmcQJDmHifhkCQ7bvkhR5BD2MBMWvr90JEkgMcE/
         FETQ==
X-Gm-Message-State: AOJu0YyXELyVOKcMwwEiieU0KgStFUrUV5luCphdJhP9peaqWOHh80KH
	bs0HHzDXhtJTc61C8lGl/akwn30YTHGpAsacRq3Um5KEQxetR1tdAXUTwhc2TA==
X-Gm-Gg: ASbGncsVC17wIvLMCHbNsApWhEy3knDDe0KPwcSMTNEuQ74hTimd0enUDNPNAWlHUtx
	vpOjv+fpLcYbl53Sfza9wqjCH7oqRNUlonUAws5Tv6JM1aAqIKILFzAu0eKcV2W2GArEu/2pWeM
	QhPjj3Ok0C2H7W6MoUZJKDyUisXIK0PUKI+bjdcU8AXhgrg5yUHR2UZgstmFih6atqaadHg5GBL
	tq8XIYt7asgLTfZAg81wmFES4rUukIyw1mFD/FXVQ63IV+e9AaDxqNZxzByvGpGue4whTiBELLN
	p9+Pk9ClhOiv/Vp7aIo6KKbwSez7m60X8+i5d5+30Tq7H3WUD17RwwgSZc7dLGOhuaCBecqj15O
	2aZTNRj+/OE3KjrqtebtQwhYnK2p4vGppisa9Jk59XysJbq6T5Oj4ePPy2cVRY3u+b+VBw0/LLP
	oT/BQ4X5neItmoxWhzz0vR9poxb7PYsgVjxXkDNPbjhhIXWp8tpvjlBSHhPDwqcGh8DmCWcEboI
	mSVcGAW1jqRr+3N+Sf4
X-Google-Smtp-Source: AGHT+IF3wntYIaH+Fan1iy7KhOEVFHOcyF5QXjRZ1SLTclPqO0EUy4QpBwtssGedWH/xvPr3l2cvug==
X-Received: by 2002:a5d:64e6:0:b0:3ec:e152:e2ce with SMTP id ffacd0b85a97d-4255780b3bfmr4543153f8f.32.1759393776283;
        Thu, 02 Oct 2025 01:29:36 -0700 (PDT)
Received: from Zen2.lab.linutronix.de. (drugstore.linutronix.de. [80.153.143.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8a6b5csm2625403f8f.5.2025.10.02.01.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 01:29:35 -0700 (PDT)
From: Alexander Kanavin <alex.kanavin@gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Alexander Kanavin <alex@linutronix.de>
Subject: [PATCH] bitbake: registry: make a separate configuration for poky with sstate mirror
Date: Thu,  2 Oct 2025 10:29:32 +0200
Message-Id: <20251002082932.978214-1-alex.kanavin@gmail.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 02 Oct 2025 08:29:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18114

From: Alexander Kanavin <alex@linutronix.de>

Using sstate mirror places much higher requirements on both network robustness
and network bandwidth than just fetching source code. When the network doesn't meet
those, the user experience can be very frustrating as errors can be cryptic and
intermittent, or bitbake would just seemingly do nothing for a long time.

Let's make sstate an opt-in, and provide a caution for using it. When it does
work, it works wonderfully and does accelerate builds significantly.

Signed-off-by: Alexander Kanavin <alex@linutronix.de>
---
 .../configurations/poky-master.conf.json           | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/default-registry/configurations/poky-master.conf.json b/default-registry/configurations/poky-master.conf.json
index 3f1299179..60531ba02 100644
--- a/default-registry/configurations/poky-master.conf.json
+++ b/default-registry/configurations/poky-master.conf.json
@@ -53,10 +53,7 @@
     "bitbake-setup": {
         "configurations": [
         {
-            "name": "poky",
-            "description": "Poky - The Yocto Project testing distribution",
             "bb-layers": ["openembedded-core/meta","meta-yocto/meta-yocto-bsp","meta-yocto/meta-poky"],
-            "oe-fragments": ["core/yocto/sstate-mirror-cdn"],
             "oe-fragments-one-of": {
                 "machine": {
                     "description": "Target machines",
@@ -66,7 +63,18 @@
                     "description": "Distribution configuration variants",
                     "options" : ["distro/poky", "distro/poky-altcfg", "distro/poky-tiny"]
                 }
+            },
+            "configurations": [
+            {
+                "name": "poky",
+                "description": "Poky - The Yocto Project testing distribution"
+            },
+            {
+                "name": "poky-with-sstate",
+                "description": "Poky - The Yocto Project testing distribution with internet sstate acceleration. Use with caution as it requires a completely robust local network with sufficient bandwidth.",
+                "oe-fragments": ["core/yocto/sstate-mirror-cdn"]
             }
+            ]
         }
         ]
     },
-- 
2.39.5


