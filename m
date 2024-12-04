Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D3DE7716D
	for <webhook@archiver.kernel.org>; Wed,  4 Dec 2024 20:41:47 +0000 (UTC)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
 by mx.groups.io with SMTP id smtpd.web10.25538.1733344899164710199
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 04 Dec 2024 12:41:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20230601.gappssmtp.com header.s=20230601 header.b=P3rB9EnC;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.179, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2155312884fso1858305ad.0
        for <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 12:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20230601.gappssmtp.com; s=20230601; t=1733344898; x=1733949698; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kuhB8Ppi8qXiaTfyD1YRma1Ju7Rukir92bXRNBstZ+A=;
        b=P3rB9EnCEEPq1gphTOWhSK+rtk8jO0by1JoWwWzVn4HpS13kjm2GyHkgUzv131kJV6
         QrPYkmy/3iYdKQulJ6uqwruKhhiYWroYQGunZAam4sqALCAOXYbZQWx10erhJrOAez/5
         xhOYDeXLk/eGhLN4aIv9Jnk5ORXIYC0bLmLuC7Rbc7e6/BKgWpStTg5VQ+uwls+1d51x
         Ta7E10cwW98ZiQ9RXzjuLoWLjX+uFcQVeH8QNKArYjFKs8r6YS4obkGxbeMTNJCwkPso
         5zFGuVkZV320IluV+Ut1E2a7x2nzvKUbKU3vfDfM3+KnG1iQThAKLn3KMFctllf+gIyh
         tPAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733344898; x=1733949698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kuhB8Ppi8qXiaTfyD1YRma1Ju7Rukir92bXRNBstZ+A=;
        b=kmLOGbrRCGkTRwAhfxbZbXf+OTBXZNHGqTJpryBPbW7HZW6GCCUMuu+9EQR/TrB9kN
         jX+G2oV9a3ZappoGJug8pAsHpBvZcghdxXzsGOSZpzFwra7nj7A/mXE5NzoWlhwYicnd
         Dkvmn6wXonZMdtuCl/xMWYtcBMEGzoY3KC2Kt5z4AGYQzFTBul6AlXg0O2m7OciThm86
         210Bfk0qQQ7MbglZah3u6jEdNh7V5hiAHWU9RDzHwTJRb7ZdB6RQichbE9Wz4Zllvh7K
         CGEEa8xxrjsqvaIsBAxiqrKGNl4bF09/ZKkmFjzxwv1O4BzRiELBkr8U2H1+6mYYsogY
         XHhg==
X-Gm-Message-State: AOJu0YzTWyWlfQcR7sTIT6fagmEVQDzN09rWMtlVJ38Q2JAU/8ieUqA8
	m23h1knF51paiYx3Qhh8cqJaJNl7EdWi1HxFj+FPhvN+JsOFfJOgbGCL10uYCQFYBekw5qJTYTq
	s
X-Gm-Gg: ASbGncsVfhb+9RmwDwLHIeNscH/SvnlQtdzAasOMLdabwvjCWDC9Fi2HaEaIQ3+Cx/j
	8yRiUYwWDlRcxhdUJCTwARo98fguOvOY8o2HYh/zH8r0mhkUF27/gasB1Wr1OX9cN+gXqgwvaXq
	6uv1cmF7bkwvcVLEqm3WQWiR0X1fvxQw2JlZXXxeN6nKhF/tnpbbqKrD9iRHUOJEFBILXnANbd8
	BzlDOcWN1nuFQCyQUIEUXW3sw89Uqysl3Y7Oz4=
X-Google-Smtp-Source: AGHT+IFJUXRA51sQtiaIAXAQUzzEEM87APOUhGWeATtlrjIDeI8U1FO4YxAoLiavkGFK3FggRQaZ5w==
X-Received: by 2002:a17:902:c945:b0:215:a57e:88e7 with SMTP id d9443c01a7336-215bd1b46b0mr64710915ad.3.1733344898209;
        Wed, 04 Dec 2024 12:41:38 -0800 (PST)
Received: from hexa.. ([98.142.47.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2155abd92ecsm80057415ad.200.2024.12.04.12.41.37
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 12:41:37 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][styhead][2.10][PATCH 1/3] runqueue: Fix performance of multiconfigs with large overlap
Date: Wed,  4 Dec 2024 12:41:25 -0800
Message-Id: <5392a2bf6d82626e11eec5578eb4de53ba09f1fe.1733344775.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733344775.git.steve@sakoman.com>
References: <cover.1733344775.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 04 Dec 2024 20:41:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16874

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
index 3462ed445..9f3abff85 100644
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


