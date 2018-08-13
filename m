Return-Path: <schnitzeltony@gmail.com>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id C7BFE78F85
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 21:04:56 +0000 (UTC)
Received: by mail-wm0-f47.google.com with SMTP id q8-v6so10186145wmq.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=uE/4m0YbcmRTcdItqLDxqkgTjj7y0FLMJS5GfPiv924=;
	b=J/cVVYLKJQNlTOoeAbhxT42e2+91vXOzYcc2IYiwn0Ocq1crtAHedkcXIt8hSAEjCg
	gzG1Dxw8Vk04VJrS4JX8m7tkKfH7/azTPSVt3ruKSth/W9b2YETYjOmun0gV4rCtDR8m
	+nPQmsjoUENN9O7cBYHJoeBH7vjPdMwNPZURQIxWdlFV+wC77Znd3t32tNJAGYQibWAV
	QWFSUNnpOoM6ohkT1qMrcfQ7hf79dJLvkZDJhMSzTUFbRiKC2K7n5DwUs/mZV1EC9Hsi
	cLCZAR4x9RmbrxfYXUCvNeKiHkqGlKE/nZNxFo9LVwnY37Fs9Bv+uvp08bCjcuiInqdd
	xsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=uE/4m0YbcmRTcdItqLDxqkgTjj7y0FLMJS5GfPiv924=;
	b=nLXQFkE4yBWCmZW1Tp+x7W3fQ92II5h9aPkzuPpYNYrye4XTzb5Kxx8viij4+sq30g
	Lell+QSqpzuuNATUjQw4AqIfVkLrP64N/KGpV5m8Fx6okHEui3hT/szb3v8+hsIqD77N
	iYwELIUJXVjoyNx1g9Mb8NN9z2E+mOUE7rBZ2e/Jv/4uHWzuTXWv1MtTkv41VbBg2lvf
	K2HiX3PNGFhOn9gqGSj8xFsGkJ1I1K7+cIzT1Grm9hifRatCdWKNDi3rSk5YeK+bdHY0
	WisDhYLCmgVa+02zuIbVK4hmzvMtZdyHPGYg8dV6kD7sl/FqDnCmbLnPKaizLYYoo6KE
	rK/g==
X-Gm-Message-State: AOUpUlHoA76HLABjLoJAwRVNyI/1aXOi3tIsjEwy0SHt0ogq6sO75V6n
	hnr2yEiK0XibsPisy7AESJ10uIey
X-Google-Smtp-Source: AA+uWPyl7keOnT/dXNBhfbL8FtaEf9ZbWLZxgnvHdQq8DmLcZ4rKIgY9wUgc9ifnA7Y3Cf/UI1bHdQ==
X-Received: by 2002:a1c:b984:: with SMTP id
	j126-v6mr8625413wmf.25.1534194297374; 
	Mon, 13 Aug 2018 14:04:57 -0700 (PDT)
Received: from localhost.localdomain
	(p200300F07BC4D1601E6F65FFFE3E7F61.dip0.t-ipconnect.de.
	[2003:f0:7bc4:d160:1e6f:65ff:fe3e:7f61])
	by smtp.gmail.com with ESMTPSA id
	j8-v6sm12256559wrn.50.2018.08.13.14.04.56
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 13 Aug 2018 14:04:56 -0700 (PDT)
From: =?UTF-8?q?Andreas=20M=C3=BCller?= <schnitzeltony@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Aug 2018 23:04:44 +0200
Message-Id: <20180813210445.32496-2-schnitzeltony@gmail.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180813210445.32496-1-schnitzeltony@gmail.com>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 1/2] runqueue: Move decision if a task can be started to one common place
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 13 Aug 2018 21:04:58 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Andreas Müller <schnitzeltony@gmail.com>
---
 lib/bb/runqueue.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 400709c1..7095ea5a 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -199,7 +199,7 @@ class RunQueueScheduler(object):
         """
         Return the id of the task we should build next
         """
-        if self.rq.stats.active < self.rq.number_tasks:
+        if self.rq.can_start_task():
             return self.next_buildable_task()
 
     def newbuildable(self, task):
@@ -1754,6 +1754,10 @@ class RunQueueExecute:
         valid = bb.utils.better_eval(call, locs)
         return valid
 
+    def can_start_task(self):
+        can_start = self.stats.active < self.number_tasks
+        return can_start
+
 class RunQueueExecuteDummy(RunQueueExecute):
     def __init__(self, rq):
         self.rq = rq
@@ -2044,7 +2048,7 @@ class RunQueueExecuteTasks(RunQueueExecute):
             self.build_stamps2.append(self.build_stamps[task])
             self.runq_running.add(task)
             self.stats.taskActive()
-            if self.stats.active < self.number_tasks:
+            if self.can_start_task():
                 return True
 
         if self.stats.active > 0:
@@ -2404,7 +2408,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         self.rq.read_workers()
 
         task = None
-        if self.stats.active < self.number_tasks:
+        if self.can_start_task():
             # Find the next setscene to run
             for nexttask in self.rqdata.runq_setscene_tids:
                 if nexttask in self.runq_buildable and nexttask not in self.runq_running and self.stamps[nexttask] not in self.build_stamps.values():
@@ -2463,7 +2467,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
             self.build_stamps2.append(self.build_stamps[task])
             self.runq_running.add(task)
             self.stats.taskActive()
-            if self.stats.active < self.number_tasks:
+            if self.can_start_task():
                 return True
 
         if self.stats.active > 0:
-- 
2.14.4


