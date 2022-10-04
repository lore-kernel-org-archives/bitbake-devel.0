Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B78DC433FE
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 15:55:28 +0000 (UTC)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mx.groups.io with SMTP id smtpd.web11.12406.1664898918135068556
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 08:55:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=6zxo2lZP;
 spf=softfail (domain: sakoman.com, ip: 209.85.210.182,
 mailfrom: steve@sakoman.com)
Received: by mail-pf1-f182.google.com with SMTP id f140so8228681pfa.1
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Oct 2022 08:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=dJN/iQdUKnAO96vhpniYvoPZSJmLqx5bazJL5maOIxQ=;
        b=6zxo2lZPmHuT02awghdjGICNM+p6SjdP9Z/7GwVl5BWGIn7a5OYAcvlEbV54WA4+xS
         wX+0+wNb8JJddNUHCoYUrmUs0JsrdO5DhIkOio2s/c5hmXiYf7reW1Yfw9bZg0jxHB0o
         XFQ1iqlQImh1rPGLtZHafIDdv3Hem2yvDtHy6oNHKpFmaEsacwSIekSbWPKome3sAtLL
         JCcZTF5bc0tUDXyrKvpJ9Put7TtZBagiWWvUupdCc5auJiu5QQrIW84Ou19jPXV4X+RO
         KPV412ZMg5S1i8ZwgLqhvDPHM8i5C4YMGXBhwPRLnZFw00uBxsfSckoef507DAl1tvuw
         dRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dJN/iQdUKnAO96vhpniYvoPZSJmLqx5bazJL5maOIxQ=;
        b=2ianNp2LLCMztBBLECBlsQZGoo71rWa5aUQYQ9cVUovhLbT+W6f02/PqA4XaI9IgGu
         XY5X+IQODLf0uT7kcGh1BubxRtLnX8/3jRnuFdz1zaurJx4ffa4gjV5Zm32+lVl74SEN
         Dcm9BtApjmIYySPBl/9T4heRB1JlLlSkq7nhlFPagd3C0fpJlcm+hYJw+v2hR/6B5LY1
         USvHi9z+TGrjh8aZdhQ1UjMB/MBbSQb6A0BEEFfiT1HswcMz7Qvs3qPmJlpegHamcjLy
         Wq6d+f4ymKpgrKkLTujRCPtCaNQiB5/2SDC6lKHJcXBdU/fIjXAG4OhwVIcE9tkJwsCz
         oUlw==
X-Gm-Message-State: ACrzQf1z6ttI892gp+YgCtKfC2YX6frzYzXE6fZ/OQ4nSERDLRsiXWgf
	6k0GanxKYtIsIlm9U2CbOxty5kx0ahJ6OhZU
X-Google-Smtp-Source: 
 AMsMyM5RSFrZKOCkRr7QoS2f3aEcsX72+NnfANFkrK+rRwl0Ekwc6GCQaFRZGLT5KQH2hCImg4vdsA==
X-Received: by 2002:a63:cf48:0:b0:439:7d1c:fedc with SMTP id
 b8-20020a63cf48000000b004397d1cfedcmr23960461pgj.281.1664898917175;
        Tue, 04 Oct 2022 08:55:17 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 k18-20020a170902c41200b0017e232b6724sm4716457plk.69.2022.10.04.08.55.16
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 08:55:16 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 2/8] runqueue: Improve deadlock
 warning messages
Date: Tue,  4 Oct 2022 05:54:53 -1000
Message-Id: 
 <d1b84e3cfe9fb8d282d4b700a9fe31891e00d837.1664898736.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1664898736.git.steve@sakoman.com>
References: <cover.1664898736.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Oct 2022 15:55:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14017

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Tweak the deadlock breaking messages to be explict about which task is
blocked on which other task. The messages currently imply it is "freeing"
the blocking task which is confusing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit cf7f60b83adaded180f6717cb4681edc1d65b66d)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a23f7a89..0d89740b 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2254,10 +2254,12 @@ class RunQueueExecute:
 
         # No more tasks can be run. If we have deferred setscene tasks we should run them.
         if self.sq_deferred:
-            tid = self.sq_deferred.pop(list(self.sq_deferred.keys())[0])
-            logger.warning("Runqeueue deadlocked on deferred tasks, forcing task %s" % tid)
-            if tid not in self.runq_complete:
-                self.sq_task_failoutright(tid)
+            deferred_tid = list(self.sq_deferred.keys())[0]
+            blocking_tid = self.sq_deferred.pop(deferred_tid)
+            logger.warning("Runqeueue deadlocked on deferred tasks, forcing task %s blocked by %s" % (deferred_tid, blocking_tid))
+            if blocking_tid not in self.runq_complete:
+                logger.warning("Failing blocking task %s" % (blocking_tid))
+                self.sq_task_failoutright(blocking_tid)
             return True
 
         if self.failed_tids:
-- 
2.25.1


