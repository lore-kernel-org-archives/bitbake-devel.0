Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1AEFEB64D7
	for <webhook@archiver.kernel.org>; Tue, 20 Jun 2023 11:36:15 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
 by mx.groups.io with SMTP id smtpd.web10.8141.1687260975102034069
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 20 Jun 2023 04:36:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="signature has expired" header.i=@linuxfoundation.org header.s=google header.b=bt6fDz7M;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.51, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-30fcde6a73cso3953773f8f.2
        for <bitbake-devel@lists.openembedded.org>; Tue, 20 Jun 2023 04:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1687260973; x=1689852973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2k9YvjUyQfkm5NfmWEL18FXjQaFZTwztrD3vkKNYxO8=;
        b=bt6fDz7MT+00EqkuL+OWMVh403WzOXeSdBtLn8IZoi11iGDQPfmDO1wnFWM4HexdkX
         jkPStX6VkbAA8wn2V3re1SkJ172nDb5xURVdI091qPfmqOj6O4kgPXKuFaIOp06xID1R
         QaqwQtMYhYVO+adQH90b/fm+8lux0g47xIyUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687260973; x=1689852973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2k9YvjUyQfkm5NfmWEL18FXjQaFZTwztrD3vkKNYxO8=;
        b=DCdxQ/nhKi78ps25nGBsNkBdHeoMBorcf78wFGuBFz5qsedWlPV3G4Xe0QMXjzbKbm
         bbw7LRqPxdx73sc8OI++eDjGVL0CePue0ETb8IdKh0l9lteAx0h3BZ1AK6MMiYrJfAGI
         yl/+IVlJwjrK4m1wf0NfMdXFVIOUxgkGd6H4id3vgsUGtVX4H1r1vimYYioJh8FxVFCC
         3zzOTDKDUc5OjrvpXgSUNd6AnZcNCQYQovwHb+hg2PCox8bDKOO3+jWL2ArEsDibt4QP
         uJGBgW5rIQkqWmr15UhRO/Rm7t0y0d5XjDVNWGZ60msy9V92U7ScdkoWJ/penJe0oUis
         f5Qw==
X-Gm-Message-State: AC+VfDxxS146M49HOL2vya3V4+XIVRstJ/lrB1FC+fzGjQlcKHDgIIev
	cde6Ti7SKIlgpCcAQwXyEM3U5RPKmbxigrnn8Ng=
X-Google-Smtp-Source: ACHHUZ6ehMkXrOnq1euGJzDS74abu89Nar29VWlU9SecHOx/3p0H2aLzb1xdcL81wPnzqaq5zueOEA==
X-Received: by 2002:adf:ed0d:0:b0:30d:981d:a03f with SMTP id a13-20020adfed0d000000b0030d981da03fmr8776368wro.6.1687260973163;
        Tue, 20 Jun 2023 04:36:13 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:dcd0:3b81:1cae:b795])
        by smtp.gmail.com with ESMTPSA id o16-20020a5d6850000000b003047ae72b14sm1793467wrw.82.2023.06.20.04.36.12
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:36:12 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] runqueue: Fix handling of virtual files in layername calculation
Date: Tue, 20 Jun 2023 12:36:11 +0100
Message-Id: <20230620113611.2791054-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 20 Jun 2023 11:36:15 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14848

I'd tested target configurations but in real world use, it became clear
the layername functionality in worker context was failing for virtual
class extensions. Fix this.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 01701348ed..0bb3bc20ab 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2158,6 +2158,7 @@ class RunQueueExecute:
             bb.event.fire(startevent, self.cfgData)
 
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
+            realfn = bb.cache.virtualfn2realfn(taskfn)[0]
             runtask = {
                 'fn' : taskfn,
                 'task' : task,
@@ -2166,7 +2167,7 @@ class RunQueueExecute:
                 'unihash' : self.rqdata.get_task_unihash(task),
                 'quieterrors' : True,
                 'appends' : self.cooker.collections[mc].get_file_appends(taskfn),
-                'layername' : self.cooker.collections[mc].calc_bbfile_priority(taskfn)[2],
+                'layername' : self.cooker.collections[mc].calc_bbfile_priority(realfn)[2],
                 'taskdepdata' : self.sq_build_taskdepdata(task),
                 'dry_run' : False,
                 'taskdep': taskdep,
@@ -2252,6 +2253,7 @@ class RunQueueExecute:
                 bb.event.fire(startevent, self.cfgData)
 
             taskdep = self.rqdata.dataCaches[mc].task_deps[taskfn]
+            realfn = bb.cache.virtualfn2realfn(taskfn)[0]
             runtask = {
                 'fn' : taskfn,
                 'task' : task,
@@ -2260,7 +2262,7 @@ class RunQueueExecute:
                 'unihash' : self.rqdata.get_task_unihash(task),
                 'quieterrors' : False,
                 'appends' : self.cooker.collections[mc].get_file_appends(taskfn),
-                'layername' : self.cooker.collections[mc].calc_bbfile_priority(taskfn)[2],
+                'layername' : self.cooker.collections[mc].calc_bbfile_priority(realfn)[2],
                 'taskdepdata' : self.build_taskdepdata(task),
                 'dry_run' : self.rqdata.setscene_enforce,
                 'taskdep': taskdep,
-- 
2.39.2


