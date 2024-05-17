Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D41C04FFE
	for <webhook@archiver.kernel.org>; Fri, 17 May 2024 10:56:44 +0000 (UTC)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
 by mx.groups.io with SMTP id smtpd.web11.37750.1715943394580480432
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 May 2024 03:56:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Fp/2IawZ;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.208.180, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2df83058d48so22323361fa.1
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 May 2024 03:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1715943392; x=1716548192; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mMOBy92VO6JZ89qv0TPbQkEUbACZ31OeJ7CYPz5RIZ8=;
        b=Fp/2IawZVNk8gc7x9ryGjamHF6t556KoJdYwq0UVsVtazJuJjgx3yoBh7h9gvmRkh1
         iCm6YeWOzpmEtVKa7EgOSV30nlLVT8XoS1krbVd80MoIa+cmBkm35aGPHTktZ3HO/I05
         uYRKcR7qBQ4CU5UpCDz91SYm8n1wyJrei6DFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715943392; x=1716548192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mMOBy92VO6JZ89qv0TPbQkEUbACZ31OeJ7CYPz5RIZ8=;
        b=UuBGCYKKNjHsAN3+zsammoTAkdjkL6KVWd0CwjnRFcmnqh4t3SFpJjmdIPmLbD9QU2
         orUO+RGFNPqsRw4appE2QwFbBaqwKFzGko0+qV0TZdH/tTlxrKHc+8C11I5+46fuAtSh
         TnV6KJ5jHSTtpGpe2AWQVIGBYevRj4HPufT1VpPishBHh5spakPOIK2X9yFxtRF+ctB2
         GRvuWBEtjY8cdZkRvKR9v1zuIKoKJaNxQ1vM6Mwt4sTD8YnUlLp3BzTwQ7IlxNUPUquh
         NGeNYEmlN8K2TefN7I/Su5t69QoVPy5U3qjF6ngQWjUC05UNYia+j1TdYSvyWlCK6ewK
         ouBw==
X-Gm-Message-State: AOJu0YwBr52nI98CbBwebtKSKdSXUop+d3AFj84bXXcre4VbmZs2yF5D
	jEtEMYYJO6JHk5Dq3tZz5nAVaNWQH3zlj2DSMbbJ6ubK9br/DPRoO2sbFH4nMgsqeUXf7QbtMNz
	Tx7Q=
X-Google-Smtp-Source: AGHT+IGw16/LwqH0SiIRsRXi0GwpYYczrIvuN66ZOVKVFuMlCuxusXZ301VjAvNAGp+BuoKLjC+SAg==
X-Received: by 2002:a2e:9584:0:b0:2e4:9606:6b88 with SMTP id 38308e7fff4ca-2e51fc36498mr150915161fa.3.1715943392234;
        Fri, 17 May 2024 03:56:32 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:ec9d:c0cc:86e8:686a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fa9dbab53sm315571775e9.13.2024.05.17.03.56.31
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 03:56:31 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] cooker: Ensure generateTaskDepTreeData fails for NoProvider
Date: Fri, 17 May 2024 11:56:30 +0100
Message-Id: <20240517105630.832343-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 May 2024 10:56:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16227

If an invalid provider is requested, error out early rather than trying
to build partial runqueue data structures as the taskdep UI will have
exited after seeing the bad provider.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/cooker.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index 939a999974..076ddaa58d 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -680,14 +680,14 @@ class BBCooker:
         bb.event.fire(bb.event.TreeDataPreparationCompleted(len(fulltargetlist)), self.data)
         return taskdata, runlist
 
-    def prepareTreeData(self, pkgs_to_build, task):
+    def prepareTreeData(self, pkgs_to_build, task, halt=False):
         """
         Prepare a runqueue and taskdata object for iteration over pkgs_to_build
         """
 
         # We set halt to False here to prevent unbuildable targets raising
         # an exception when we're just generating data
-        taskdata, runlist = self.buildTaskData(pkgs_to_build, task, False, allowincomplete=True)
+        taskdata, runlist = self.buildTaskData(pkgs_to_build, task, halt, allowincomplete=True)
 
         return runlist, taskdata
 
@@ -701,7 +701,7 @@ class BBCooker:
         if not task.startswith("do_"):
             task = "do_%s" % task
 
-        runlist, taskdata = self.prepareTreeData(pkgs_to_build, task)
+        runlist, taskdata = self.prepareTreeData(pkgs_to_build, task, halt=True)
         rq = bb.runqueue.RunQueue(self, self.data, self.recipecaches, taskdata, runlist)
         rq.rqdata.prepare()
         return self.buildDependTree(rq, taskdata)
-- 
2.40.1


