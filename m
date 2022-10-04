Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4EEC43217
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 15:55:28 +0000 (UTC)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by mx.groups.io with SMTP id smtpd.web10.12291.1664898915909779205
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 08:55:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=nZLsNp4i;
 spf=softfail (domain: sakoman.com, ip: 209.85.216.41,
 mailfrom: steve@sakoman.com)
Received: by mail-pj1-f41.google.com with SMTP id l12so13051810pjh.2
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=kdSPLUVms5XZm3DMauYn+86F+BW4pJfYPBI5O+7Kudw=;
        b=nZLsNp4iUYI0ia7DL+jYJncHhn9Tk98CcIiLgY8/ZO6cHEkpAOYoLoOlhyTCGuZstj
         Beaxv6zFWgU9NvyndRabGySywbmtJaY1oZ3188Q7U4LwazFV0+e7KqaJji753ITRGn9n
         mR5klzth74OePzQH65XXLPM1lzGoAE77oOQ8ZLn4MHF9Cr30ouHWyx/ng7FjpTP++elB
         J/onN7h7bjrQGflH+/QXZJcPGiaKS3IQvh+Iwqm5LF7dVkY+pHlOnf8/iXwPor7jpwMS
         nGukowF+1hYS+kfQEi99hhR+dgj/AvarY0dJZUh/ByvD1MVe337Dk34jOBJ4FZUYRtb+
         dQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=kdSPLUVms5XZm3DMauYn+86F+BW4pJfYPBI5O+7Kudw=;
        b=y0vRuuw6F5a01XBZY9JSBYkm1ZyYmx2WQRy5b/D/r/fDrA+0tp8zRRIuLX41+K2RPP
         NwlQItSj0Hf4nz0nZ0Ts54sQnxy8y94m/LrPMrDsp1oKmdKD9j5Qoa9Ei3vC5/FP5azt
         Lu9JHhe4n2drGEsbY+QHMBUrVffVe1njQ2rJf2xUqTW9hDWC4yVojeC16k8cPrBNchBl
         leKtIig81Jqs8omS0VeyL3kv6dNsJrt+ZUrE9Ynu7WyMTytb18IrDDV7UqrCJT6fGhX+
         O4qKHYawruvgPWRlRWLaEoxgbVIFSBwJLj+80gMTnjyuvIiJfXrgPyE+yWfOT+wnbSHF
         ZdRQ==
X-Gm-Message-State: ACrzQf1r9PtU2zapLcjAGmlmi7rJtBkCSx6/feFmLMGnfW3f2JkFfHQI
	TuKAU3IOCL4oo8xqjv9g/UqLpiraCxltbVvA
X-Google-Smtp-Source: 
 AMsMyM4nCxtKZyyVpE/s+Z2GhliIVDVvCzn8Cx72qS/E5VyEAyurnh2vb/ZL0D8PiAoHQFusYEPA3g==
X-Received: by 2002:a17:90b:4f45:b0:203:6d82:205c with SMTP id
 pj5-20020a17090b4f4500b002036d82205cmr383204pjb.224.1664898920178;
        Tue, 04 Oct 2022 08:55:20 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 k18-20020a170902c41200b0017e232b6724sm4716457plk.69.2022.10.04.08.55.18
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:55:18 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 3/8] runqueue: Drop deadlock breaking
 force fail
Date: Tue,  4 Oct 2022 05:54:54 -1000
Message-Id: 
 <f386298fc056ef130c2eb6dabf25eafbd55f55ca.1664898736.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664898736.git.steve@sakoman.com>
References: <cover.1664898736.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Oct 2022 15:55:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14018

From: Richard Purdie <richard.purdie@linuxfoundation.org>

I'm 99% certain this failing of a scenequeue task corrupts runqueue and
causes all kinds of breakage. I'd rather runqueue deadlocked than corrupted
and did weird things so drop this code.

We've seen builds where the deadlock triggers and it then tries to run tasks
where the SQ task already ran with very confusing failures. It is likely it
is this code causing it.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 8efced47fcb47851a370fd6786df6fb377f99963)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 0d89740b..48e25401 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2257,9 +2257,6 @@ class RunQueueExecute:
             deferred_tid = list(self.sq_deferred.keys())[0]
             blocking_tid = self.sq_deferred.pop(deferred_tid)
             logger.warning("Runqeueue deadlocked on deferred tasks, forcing task %s blocked by %s" % (deferred_tid, blocking_tid))
-            if blocking_tid not in self.runq_complete:
-                logger.warning("Failing blocking task %s" % (blocking_tid))
-                self.sq_task_failoutright(blocking_tid)
             return True
 
         if self.failed_tids:
-- 
2.25.1


