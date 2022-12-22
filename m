Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9005EC4167B
	for <webhook@archiver.kernel.org>; Thu, 22 Dec 2022 23:47:44 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
 by mx.groups.io with SMTP id smtpd.web10.60849.1671752854374239049
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 22 Dec 2022 15:47:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=RYwF1pwm;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.52, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f52.google.com with SMTP id bi26-20020a05600c3d9a00b003d3404a89faso4559612wmb.1
        for <bitbake-devel@lists.openembedded.org>; Thu, 22 Dec 2022 15:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yel8xUuSTh7qI0L/QoYQd90wgnTdh60jHGEUPsPnbNA=;
        b=RYwF1pwmvbl5lftaxKq2aJe8dyb3VUG0THeQDmmkofahCSMNQCHrD82ndnAReFVGNo
         s8vQ1L98OS7DopWDSMj5PUdwlMp2S7JASB9zpJpWNvXmXE/L6LF0zN6BKWo07PmpZVfE
         LOF0US7vL8/d34hpSrrLJG5NtrOoAY24b+o6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yel8xUuSTh7qI0L/QoYQd90wgnTdh60jHGEUPsPnbNA=;
        b=g7wE/YWMNfoMrz7W/oUJ1WJxspdkjXDpDpbDqvbLqJyF/WLWfXJ10Uq/mHAfVhN/kt
         OU4+VXRsJnLe6fDDBsOxSGCe6MdFzKhli3qS7c2gSU7B4dlDkk8St+/R0wymvhhP+MNv
         5CTVdObqozbTheL9R5lETwgQumzYimZSCIusUPQ+dftcMjvg46I4eeeyYTcZLRQPhWbV
         Tcdy/Ke8+KQHh8suazyMwuWnOHaWCUjPMcccWsO5Ii3Ntp+31UxFioFTXgtPn7zzuraB
         1J5av3pfAHEcdJzoGg2GxkbV3/19HYLjE8wt8i1EC0WozMkBFVsrAsUVIXuLg4mMPWES
         nNiw==
X-Gm-Message-State: AFqh2kqGTaPUDbP62sVAdk1jxBS+VkQoiQmJROmlZBadT5twVT3F99cm
	6LWZrWayduviGGYWJfsmNZya+C0dxgEtOKLh
X-Google-Smtp-Source: AMrXdXvhLSp0tIY8JhqNg6TF5PHukbxg/MtB7gH71x7MZoN6z1fJbxM4kOUsv4wZtKxIfd5nv6JxVg==
X-Received: by 2002:a05:600c:4193:b0:3c6:e60f:3f4f with SMTP id p19-20020a05600c419300b003c6e60f3f4fmr5570810wmh.6.1671752852669;
        Thu, 22 Dec 2022 15:47:32 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:bc21:fec7:83cf:e0c3])
        by smtp.gmail.com with ESMTPSA id bd25-20020a05600c1f1900b003cfd4cf0761sm7322189wmb.1.2022.12.22.15.47.32
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 15:47:32 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 09/10] server/process: Improve exception logging
Date: Thu, 22 Dec 2022 23:47:25 +0000
Message-Id: <20221222234726.579702-9-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221222234726.579702-1-richard.purdie@linuxfoundation.org>
References: <20221222234726.579702-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 22 Dec 2022 23:47:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14238

Currently if either idle functions loop suffers a traceback, it is
silently dropped and there is no log message to say what happened.
This change at least means the traceback is in the cooker log, making
some debugging possible.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/server/process.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/bb/server/process.py b/lib/bb/server/process.py
index 63d37ae0d5..49cca8d23d 100644
--- a/lib/bb/server/process.py
+++ b/lib/bb/server/process.py
@@ -389,6 +389,7 @@ class ProcessServer():
                     if not isinstance(exc, bb.BBHandledException):
                         logger.exception('Running idle function')
                     del self._idlefuns[function]
+                    serverlog("Exception %s broke the idle_thread, exiting" % traceback.format_exc())
                     self.quit = True
 
             # FIXME - the 1 is the inotify processing in cooker which always runs
@@ -422,6 +423,7 @@ class ProcessServer():
                 except Exception as exc:
                     if not isinstance(exc, bb.BBHandledException):
                         logger.exception('Running heartbeat function')
+                    serverlog("Exception %s broke in idle_commands, exiting" % traceback.format_exc())
                     self.quit = True
         if nextsleep and bb.event._heartbeat_enabled and now + nextsleep > self.next_heartbeat:
             # Shorten timeout so that we we wake up in time for
-- 
2.37.2


