Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09A7C4332F
	for <webhook@archiver.kernel.org>; Tue, 10 May 2022 18:06:53 +0000 (UTC)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mx.groups.io with SMTP id smtpd.web09.629.1652206003451564122
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112
 header.b=eKpXmG8Y;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.172,
 mailfrom: steve@sakoman.com)
Received: by mail-pg1-f172.google.com with SMTP id g184so12766689pgc.1
        for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 May 2022 11:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=CK6I828emvT02CmhlQqIR1l0GCrKwgbOB0SrQ7GUOY4=;
        b=eKpXmG8YJFpswQ7Miy2tGA36ujyIPoaFNf+2J4BKeiOGmi1InH6C3pjOG3ytmNckzT
         i2vsPE00fVbOrzra2tZ4guzM30WbOk1raF9sCA1vz5rXr/aN8BwN6hwdHXODkIO7zHGC
         SO62LOFOMWq2z4znC+P0oBkXHmHQMPL49497TWImZSBPhZJ5VI38XswL/agMi2B9Wh4y
         HCJ2HxdEGfWs8ZtGZV9EsDCNKXFDDEbxbx2xgR9/Ax2E4JZkuTbyhQ8PkOOqqco4fRwJ
         AwmH4+7MH/6Qhuv/QCh8f4/LuRlctSzTgyaCfuEJVsGVWFzWADP0jAPiqZrkQi81zYrd
         jzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CK6I828emvT02CmhlQqIR1l0GCrKwgbOB0SrQ7GUOY4=;
        b=YIXEUoq1LgjaZWfy7nKJfkDFc3dfcMfL2fJF8/RMFE+QAA8GIPgylhDDWVnnKXkjDR
         tffjo9cGS/F/QIc3jK9KIr5+q910M/HK1fh6ftXYnEEl/DlPJmPZv7CeEG5/cdu0jsNa
         /ByQIz1lMQbuuyfM/mJnwh/ssycmjSq2t1xgdKT7XNBax5k/QPAeNPj0kkVqMLemImrN
         RCBpyg6KIxOSB7aSwHxneSxi3g0LCkMRyhCT2spLl9nxwHKdUxZSzSRo9KPDal6Ej1s6
         fJB+23vSF5NIVcQjdueUsPGs/sr1oM7uYOgjFsmmm9Z5/CmHw/Bq5h6sqnlXyD7QESWo
         8M5g==
X-Gm-Message-State: AOAM533wkyFX1SxwMvWo97FuV0pfRrCxAUosOK+vNflocWcq56034m0Z
	jJoSVhGfcV8UpNmqAWNZI5x0FaE89LcMip9v
X-Google-Smtp-Source: 
 ABdhPJzbNxQA4FfD3rPKPZ8q+86baF/YOiM1DAZfbG2W6nvB1ZMjdXc1BE32tgO055tygt6my3CrrA==
X-Received: by 2002:a62:6410:0:b0:4f3:9654:266d with SMTP id
 y16-20020a626410000000b004f39654266dmr2981626pfb.59.1652206002257;
        Tue, 10 May 2022 11:06:42 -0700 (PDT)
Received: from hexa.router0800d9.com (dhcp-72-253-6-214.hawaiiantel.net.
 [72.253.6.214])
        by smtp.gmail.com with ESMTPSA id
 12-20020aa7910c000000b0050dc76281c4sm10846777pfh.158.2022.05.10.11.06.40
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 11:06:41 -0700 (PDT)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][kirkstone][2.0][PATCH 16/18] runqueue: Fix sig file
 location when using multiconfig
Date: Tue, 10 May 2022 08:05:41 -1000
Message-Id: 
 <23d5829088147bb3d296558695833866d1bf04cd.1652205806.git.steve@sakoman.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1652205806.git.steve@sakoman.com>
References: <cover.1652205806.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 10 May 2022 18:06:53 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13696

From: Richard Purdie <richard.purdie@linuxfoundation.org>

We're using the wrong data store when trying to locate siginfo files,
fix this. Thanks to Gregory Lumen <gregorylumen@microsoft.com> for
spotting.

[YOCTO #14774]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 0ed800e19a3197f8e622c8d3b630aae384e60aba)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a4e82f37..f34f1568 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1674,7 +1674,7 @@ class RunQueue:
             (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
             pn = self.rqdata.dataCaches[mc].pkg_fn[taskfn]
             h = self.rqdata.runtaskentries[tid].hash
-            matches = bb.siggen.find_siginfo(pn, taskname, [], self.cfgData)
+            matches = bb.siggen.find_siginfo(pn, taskname, [], self.cooker.databuilder.mcdata[mc])
             match = None
             for m in matches:
                 if h in m:
-- 
2.25.1


