Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9BA4C433F5
	for <webhook@archiver.kernel.org>; Thu, 24 Mar 2022 17:37:20 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by mx.groups.io with SMTP id smtpd.web09.13992.1648143440007187836
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Mar 2022 10:37:20 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=e2wBID/4;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.45,
 mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f45.google.com with SMTP id r64so3166290wmr.4
        for <bitbake-devel@lists.openembedded.org>;
 Thu, 24 Mar 2022 10:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5v3bDAuX6GiCDlQxcSczNlOvgkfLWJcPbJLyCsZy35Q=;
        b=e2wBID/4po2TBEjHYQG2q69pq/EA/arIoUxuAiAzEpcqk5J0PYabi/5J+umD0JaY3w
         t2i5llNBkCidxwH7Qt4WSU9QRfq+cER/cE6/wyJ3xInqrqzgJ7BuPlfP6ZUOABYbVsZi
         Jm/GqKutKlWESlV16jiuHwGyJl39sXHJhiMNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5v3bDAuX6GiCDlQxcSczNlOvgkfLWJcPbJLyCsZy35Q=;
        b=B1SZUjkpP+CAEQdAqhjoYsHIfYSM9DHnHf7t1v+UWsiwFj9C3dOxUoohtsnFEfVrRr
         s96L/EMdHcUieLy3bboO4rfvh/YmroLRdUl62FX3/0UZD86z6Su+XScGcwje7WeFhdw0
         1R5ufrtLkiSze2mVmiH9cTC/BVLILW4UHoYmdWgYTOQG7ajLFpP0Q4MyeFfXiyL+9lyZ
         e9ycXP9ejuzbUuM/jPHw8dy49KOkpwbKKp/QKk+EiSzEmm51foT70mvWNHLzLyTUychm
         HDSMXkk0BGaQiT7NoewESBDNAyDY8wU/6s9MgaqGd0MUaCrxtQwDvP2e2Qtohf4JLMy6
         qDyw==
X-Gm-Message-State: AOAM533hsjbv/JcG0TTTYi5TPFrAjc/kAJ1m23Hy+l6swjeNwPxrWpC9
	w+pI/MIesogr2znpCQaUacz0uTHlUkViMWxJ
X-Google-Smtp-Source: 
 ABdhPJw+/i07qxGZsJyyOGur9VKAzb/Z45NxQGNsPiQKV+NPapP87UQpuLy3rue+rYTmBMXRD3q6uQ==
X-Received: by 2002:a05:600c:3b8c:b0:38c:c1a8:7571 with SMTP id
 n12-20020a05600c3b8c00b0038cc1a87571mr9892685wms.136.1648143438054;
        Thu, 24 Mar 2022 10:37:18 -0700 (PDT)
Received: from hex.int.rpsys.net ([2001:8b0:aba:5f3c:468a:3ed0:d59:9804])
        by smtp.gmail.com with ESMTPSA id
 az26-20020adfe19a000000b00204154a1d1fsm3064056wrb.88.2022.03.24.10.37.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 10:37:17 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] tinfoil: Allow run_command not to wait on events
Date: Thu, 24 Mar 2022 17:37:16 +0000
Message-Id: <20220324173716.1325187-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 24 Mar 2022 17:37:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13502

There are some commands where we want to see the events returned so allow
the caller to request this. This also allows us to fix an infamous bug in
the tinfoil testsuite in OE-Core.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/tinfoil.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/tinfoil.py b/lib/bb/tinfoil.py
index 27a341541a..42e453469c 100644
--- a/lib/bb/tinfoil.py
+++ b/lib/bb/tinfoil.py
@@ -448,7 +448,7 @@ class Tinfoil:
         self.run_actions(config_params)
         self.recipes_parsed = True
 
-    def run_command(self, command, *params):
+    def run_command(self, command, *params, handle_events=True):
         """
         Run a command on the server (as implemented in bb.command).
         Note that there are two types of command - synchronous and
@@ -468,7 +468,7 @@ class Tinfoil:
         try:
             result = self.server_connection.connection.runCommand(commandline)
         finally:
-            while True:
+            while handle_events:
                 event = self.wait_event()
                 if not event:
                     break
-- 
2.32.0


