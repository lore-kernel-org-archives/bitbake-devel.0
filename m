Return-Path: <steve@sakoman.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00C6C61DA3
	for <webhook@archiver.kernel.org>; Mon, 20 Feb 2023 22:25:52 +0000 (UTC)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
 by mx.groups.io with SMTP id smtpd.web10.27829.1676931943167761918
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 20 Feb 2023 14:25:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@sakoman-com.20210112.gappssmtp.com header.s=20210112 header.b=wUWEC30S;
 spf=softfail (domain: sakoman.com, ip: 209.85.214.182, mailfrom: steve@sakoman.com)
Received: by mail-pl1-f182.google.com with SMTP id c1so3251719plg.4
        for <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 14:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sakoman-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qrp62N4m/KJgUUl9vEYDys9t6gRDYAoGrkEo6jg7RO4=;
        b=wUWEC30S7jx9eO5ZCI8C8oLPkVa8BK8eS6CbteII/cp+ZLmr9R6luSLfwguW/5roWz
         lgN93wXvnXnU1k9edHl2qwLkGktFBlZr2NSp2qFQkY8mUi1xwW4XLsitp2Aw9vzPOFoC
         SK//0NQgBpBvv17atLV2lCRMYBiqiauDE3poz8KRtiuGpz8Six8edGMxGbmUrhQyQi5E
         STxFnraxTkHohaUKNForaMb5f17BOVpDoxYrFerSlf6mShL3Ky7UiPaD6lNGM7PLAPq7
         ++nIHx0myGtwA/anfE1kSfkUUfOJ0DBL8MRMKkqb8KMN1M3uEG+u4Wfs0uoaA1bRUhjW
         3fJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qrp62N4m/KJgUUl9vEYDys9t6gRDYAoGrkEo6jg7RO4=;
        b=4UP0LGMvg1WRpgMl3qEM9wbUecsDKT+pTS2lEOX7skfBd7fIKqAC2ypzB31db5EY1O
         7dNjx3v7za6Yunx+4Eo88oYr4GdDYlpqr1eR/kOPtonisdOOvdQQstxFae7Oz0z1wj7Z
         tKOCOzpJxes2Lng3nilOOmiaStbYn+iHScCIitXdlNxK6L7Wki4UHUjlULZaI0DtoypP
         DHCvviLMvBZuftiMDcW3F5kN6lxGi7qINZ3y54deg5I4a3SXbgrsxYhqHwXgt8ZpqTsx
         kFoo3Fg2ez6fMOE45ziEpfta+r19UMPtZUz+8hve/qrXu3dZu3ruyIkknnYbXsSwb6/Q
         fjmg==
X-Gm-Message-State: AO0yUKUqjf5XDqhcY8qpaTy6yWkQcQVIfdXnAQXyMUy86P23Jh1NVx+A
	ZZ0tFJkiy5LrXs62RRWZ4E7V89OvAD5/nX5ySqM=
X-Google-Smtp-Source: AK7set/atCgO91EKUhmvMrGqAlbDzyVvkn40LjJCLDWwMw4oyj7UwkQ9m1Wzx1cVLnPodo9bxNtclA==
X-Received: by 2002:a05:6a20:8e23:b0:c7:26d0:1138 with SMTP id y35-20020a056a208e2300b000c726d01138mr3401095pzj.39.1676931942124;
        Mon, 20 Feb 2023 14:25:42 -0800 (PST)
Received: from hexa.router0800d9.com (dhcp-72-253-4-112.hawaiiantel.net. [72.253.4.112])
        by smtp.gmail.com with ESMTPSA id q21-20020a62ae15000000b005a9131b6668sm8191447pff.2.2023.02.20.14.25.41
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 14:25:41 -0800 (PST)
From: Steve Sakoman <steve@sakoman.com>
To: bitbake-devel@lists.openembedded.org
Subject: [bitbake][dunfell][1.46][PATCH 4/7] runqueue: Avoid deadlock avoidance task graph corruption
Date: Mon, 20 Feb 2023 12:25:20 -1000
Message-Id: <2e1354525217505ce34fe775ee6ec8af46ff5324.1676931822.git.steve@sakoman.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1676931822.git.steve@sakoman.com>
References: <cover.1676931822.git.steve@sakoman.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 20 Feb 2023 22:25:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14471

From: Richard Purdie <richard.purdie@linuxfoundation.org>

If the deferred task deadlock avoidance code triggers, it could mark an executed
task as failed which leads to "covered and not covered" error messages. Improve
the logic so if the deadlock code is triggered, it doesn't cause the errors.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 51bdd6cb3bd9e2c02e261fb578bb945b86b82c75)
Signed-off-by: Fabio Berton <fabio.berton@criticaltechworks.com>
Signed-off-by: Steve Sakoman <steve@sakoman.com>
---
 lib/bb/runqueue.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 9efd1c86..c7f50fde 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2234,7 +2234,8 @@ class RunQueueExecute:
         if self.sq_deferred:
             tid = self.sq_deferred.pop(list(self.sq_deferred.keys())[0])
             logger.warning("Runqeueue deadlocked on deferred tasks, forcing task %s" % tid)
-            self.sq_task_failoutright(tid)
+            if tid not in self.runq_complete:
+                self.sq_task_failoutright(tid)
             return True
 
         if len(self.failed_tids) != 0:
-- 
2.34.1


