Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7F6E77172
	for <webhook@archiver.kernel.org>; Wed,  4 Dec 2024 20:33:56 +0000 (UTC)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
 by mx.groups.io with SMTP id smtpd.web10.25352.1733344429323093475
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Dec 2024 12:33:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=r2MQd4A7;
 spf=softfail (domain: sakoman.com, ip: 209.85.215.180, mailfrom: steve@sakoman.com)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fc93152edcso221265a12.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 12:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1733344428; x=1733949228; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vKvxFq/N9OJ/SZuT8jOJKH8KhtMqzB1+XF8+xConujw=;
        b=r2MQd4A7J5M7EfWSqxCsRi+/axUhQ2XDkNgnDO56U7uEiilMnCGGv/Im6AYS63ZN0L
         zdEG58QaWJKPMqe8/C4BGx0GajouheX1xYOJqHs3YjCyBOo4+8mAN379a95LeJcli9e0
         Z6SLdl5b5on++grwOD4IrP78ecNd7uP+4vwfPnhOGQFgDESP2LL55dHnXy4rnrY8BBCO
         TQaTQoeLVeFrAqFwOkFtLy7CyzTSWYx1C+RmVHD/ZKGpoZ9XQ6+HZgP6gW+ivsia2EBk
         COSzycZiz4aqXnwQNFCipRzJRk4K8nd1eIo4IsANbsaU3bVXznlqdJeluMUDPHBX+K55
         HoIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733344428; x=1733949228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKvxFq/N9OJ/SZuT8jOJKH8KhtMqzB1+XF8+xConujw=;
        b=oWKUsjM5cOEmBnYByiLUBo03gLX/bwV0P/CPikGDslSFIxU12jjWt2Qb5fpHwC8l7H
         d6EdxLCA1XlwfL+UR3UHQnVVeEidNcJ4GC37gtXHDOi6Eo919DD6z/rsNhfzdfTfg+ZK
         M1mfcw3dWwa7XqqHX7BPdvq6w4NXVxyP1RwkE32nlZ9mlSjY6EsTdaTc9XU0ANaA1n2b
         sAnVNz3nxbBKohuCY3DSvGMUzYfqpUlDJ4k6iw/m3jkFgl5TizYC8LohG+UjJgeZZ/aP
         P07FUv8AznCZn7BbMIxb5VO2uxBgfhB0TZUnHUPVcniVoKfTwIhBul0X7+ya4b+pvaV6
         M2jQ==
X-Gm-Message-State: AOJu0YzzDZQnK5CArjC+SSlucRgSBuHqbwuiqg+lEwlvkkpyuqLRjnfU
	IY5Tl3QJc3kt9sq5wvN8SfRODa49FdPFRcC9IXnK98nOhP1pABW7Nsz4qITpvMqegy3pQ0o6ucT
	t
X-Gm-Gg: ASbGncvvMBBLtPKeqFq4RLyQGuenoto/vvk5PxQVaDX8BibPPMTqSsfktuWV1eUS6wd
	+lxet/a7Auj5irt4nS3kIYg7CzrM8Amzf7Xakp1YYL8OhAcNqUHUTg2pnxUlPoi9Kr4h07AVFj1
	jVaAUpsTS1X9RnsWtO+L1XihPbpvVnHfK0Wb3DFIt/S4gvd4hpOPOA4gGajJgK2jlTbpPjVRKVt
	/HK1nbHjUpgHANe4u8uv3XLGmf7HKYJWWklejU=
X-Google-Smtp-Source: AGHT+IGg/6ss+68tbTq7MuUO9qAzSxlmugOSZ3tJ5SOdxKuF3Wq89h2rth+vdKlF9eilft20Qi19ng==
X-Received: by 2002:a17:90b:17d2:b0:2ee:7504:bb3d with SMTP id 98e67ed59e1d1-2ef41923751mr1235680a91.0.1733344428565;
        Wed, 04 Dec 2024 12:33:48 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ef27062fa1sm1873984a91.45.2024.12.04.12.33.48
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 12:33:48 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][scarthgap][2.8][PATCH 1/3] runqueue: Fix performance of multiconfigs with large overlap
Date: Wed,  4 Dec 2024 12:33:38 -0800
Message-Id: <db083cfe9e33c9fd7ffeead7b8c6023a5d581976.1733344286.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733344286.git.steve@sakoman.com>
References: <cover.1733344286.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 20:33:56 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16870

From: Richard Purdie <richard.purdie@linuxfoundation.org>

There have been complaints about the performance of large multiconfig builds
for a while. The key missing data point was that the builds needed to have large
overlaps in sstate objects. This can be simulated by building the same things with
just different TMPDIRs. In runqueue/bitbake terms this equates to large numbers of
deferred tasks.

The issue is that the expensive checks in the setscene loop were hit every time
through runqueue's execute function before the check on deferred tasks. This leads
to task execution starvation as that only happens once per iteration.

Move the skip check earlier in the function which speeds things up enormously
and should improve performance of such builds for users.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 9c6c506757f2b3e28c8b20513b45da6b4659c95f)
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 93079a977..744542b08 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2195,6 +2195,9 @@ class RunQueueExecute:
             # Find the next setscene to run
             for nexttask in self.sorted_setscene_tids:
                 if nexttask in self.sq_buildable and nexttask not in self.sq_running and self.sqdata.stamps[nexttask] not in self.build_stamps.values() and nexttask not in self.sq_harddep_deferred:
+                    if nexttask in self.sq_deferred and self.sq_deferred[nexttask] not in self.runq_complete:
+                        # Skip deferred tasks quickly before the 'expensive' tests below - this is key to performant multiconfig builds
+                        continue
                     if nexttask not in self.sqdata.unskippable and self.sqdata.sq_revdeps[nexttask] and \
                             nexttask not in self.sq_needed_harddeps and \
                             self.sqdata.sq_revdeps[nexttask].issubset(self.scenequeue_covered) and \
@@ -2224,8 +2227,7 @@ class RunQueueExecute:
                         if t in self.runq_running and t not in self.runq_complete:
                             continue
                     if nexttask in self.sq_deferred:
-                        if self.sq_deferred[nexttask] not in self.runq_complete:
-                            continue
+                        # Deferred tasks that were still deferred were skipped above so we now need to process
                         logger.debug("Task %s no longer deferred" % nexttask)
                         del self.sq_deferred[nexttask]
                         valid = self.rq.validate_hashes(set([nexttask]), self.cooker.data, 0, False, summary=False)
-- 
2.34.1


