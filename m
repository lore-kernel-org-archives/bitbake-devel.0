Return-Path: <yoann.congal@smile.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36083D59F71
	for <webhook@archiver.kernel.org>; Wed,  6 Nov 2024 20:20:19 +0000 (UTC)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
 by mx.groups.io with SMTP id smtpd.web11.56032.1730924410590174641
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 06 Nov 2024 12:20:11 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@smile.fr header.s=google header.b=dkiz/iPe;
 spf=pass (domain: smile.fr, ip: 209.85.128.50, mailfrom: yoann.congal@smile.fr)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43155afca99so7892645e9.1
        for <bitbake-devel@lists.openembedded.org>; Wed, 06 Nov 2024 12:20:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile.fr; s=google; t=1730924408; x=1731529208; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sswZnjcaI3SvmGDJVoTJVi1axotZ/Rqpw9Nj0LwnQCU=;
        b=dkiz/iPeQkQ3aQTIiK2ZZ2d5wquRKMhf/kzm3LxLCy3ZmtbQuDxFetFkgj+SWbpesa
         76W+P78U/Eqo/SYF9JUgN2Eu84fDNT/7MYfIF/wImb9iKipIgNR6+/j5aTHUTBGQZUFi
         HJqMYHPohhJGWcRe3eUvcLU0QhmbSWa8r2zrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730924408; x=1731529208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sswZnjcaI3SvmGDJVoTJVi1axotZ/Rqpw9Nj0LwnQCU=;
        b=cOXblEGUHA2GJCAZlMKYUip20TgU9SfB8Hg9pqVxM4YeytFU6ia4tXSNvp/eVrqkuB
         BLRj7ZuTl1MJuO9FA7NIVkPlS56hVrxDn1XfLpkbVcN4E6/s9d35x1w6ngmP1uZKLJE7
         7Pn0w36QBqO5qW0ZD/O7I3RgJeXYJHOZtPn2cKMV8PHm0p0g+zFY4tjyOCqZDz5aqRXJ
         UXEhZYTw0bGuwPwThmCqw3BLBGQ/bdOhiZIHHXTivytD6/TAKD6Y9m5mtwrTl6euHe8P
         JSkG5580cZsbvDWD/vMQEdvh4Z7FS8PpPxhvA4pGp+5EAYjoZNglpxfuKkYVqzDfMQo9
         mYbw==
X-Gm-Message-State: AOJu0YxH4XzfElYMHvZpwb3VOzTd2gUEtZMMDPTEjCny7sZhNOligfHo
	OrUXLWlgVeLT/3++dzSAEpYr6hh+sxqiczX0LB4bF6UaDIL5dv9ZTYbz3bXATYGZLZw253BYcRG
	p
X-Google-Smtp-Source: AGHT+IEQIyZJbMoer8xUNaWSRorDsphlM/dUzJa8iya5sFkcuZFkWVm67xg3/OnNaN7GddPYOt2xDg==
X-Received: by 2002:a05:6000:4006:b0:37d:47eb:b586 with SMTP id ffacd0b85a97d-381ec5c9395mr448376f8f.4.1730924407802;
        Wed, 06 Nov 2024 12:20:07 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.local (53.1.159.89.rev.sfr.net. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa709f3fsm37204545e9.32.2024.11.06.12.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 12:20:07 -0800 (PST)
From: Yoann Congal <yoann.congal@smile.fr>
To: bitbake-devel@lists.openembedded.org
Cc: Yoann Congal <yoann.congal@smile.fr>
Subject: [PATCH] command: fix needconfig for revalidateCaches
Date: Wed,  6 Nov 2024 21:18:59 +0100
Message-Id: <20241106201858.1689813-1-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 06 Nov 2024 20:20:19 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16787

From: Yoann Congal <yoann.congal@smile.fr>

Fixes what looked like a type since parseConfiguration.needconfig is
already set just after parseConfiguration() definition.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
Note: Only tested bitbake-selftest, I have not checked if this code is
covered by tests.
---
 lib/bb/command.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/command.py b/lib/bb/command.py
index 1fcb9bf14..695277f1e 100644
--- a/lib/bb/command.py
+++ b/lib/bb/command.py
@@ -310,7 +310,7 @@ class CommandsSync:
     def revalidateCaches(self, command, params):
         """Called by UI clients when metadata may have changed"""
         command.cooker.revalidateCaches()
-    parseConfiguration.needconfig = False
+    revalidateCaches.needconfig = False
 
     def getRecipes(self, command, params):
         try:

