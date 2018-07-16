Return-Path: <jpewhacker@gmail.com>
Received: from mail-it0-f65.google.com (mail-it0-f65.google.com
	[209.85.214.65])
	by mail.openembedded.org (Postfix) with ESMTP id 69A2B754B4;
	Mon, 16 Jul 2018 20:38:08 +0000 (UTC)
Received: by mail-it0-f65.google.com with SMTP id s7-v6so22802051itb.4;
	Mon, 16 Jul 2018 13:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=AJ3Vtv2nzIv2k9zSMZxW30sDdac2tE+UQoVo+f3Jr7A=;
	b=Kg2SlDjKS3LYYtuIcW5YGyGdT2lI6QeSkvSlcQ48aKXi7LQFwW5gTsfGUuSb/+kM5H
	UqqN5whM+Cvp976Pxcmu9HLSbTmwzzKwYKnhnD79U8Dk7F715Rr9lZUu6CKtv1WyoTfY
	5SisWcNGI+kVOCgi1ZvJbCEj20/awwkf73QQgnqEzbdYlsgS44jwB502f7v0cqKlMqUb
	6zoaQV6osP+WUaE0+ZCTFlq/CFalZ3/F6IPeU9MMfGvjJDxTnwIhPeJ52IB2PDkDjfxE
	WyD8ve3Aj+7tF2gmJ/d/YOZWwNiPBu91ey0vbtymVNYg+NtGykmZnG5l2UkFIY4S/nw9
	RjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=AJ3Vtv2nzIv2k9zSMZxW30sDdac2tE+UQoVo+f3Jr7A=;
	b=RaNy9XGq8jaBSweXIb20G+QTcy8MRtffp8W00hVcS0QNcx3AxIZ7aW0SPniYarLDBW
	JM3T2oA9sQT1HN7Or7O5/axyHd0z4qghP0oYJytszaZuiPjtP56uUE1WFhQHfD7VvEN7
	za7aTL8QDWYfDvh2RiR2sMQDj51uHhF3lM95zZYcclyzk0XxD/Wda8wMNvL0AkCb63hM
	zXfxojLWa6rGQauY78Se2n7QljoXqBC000Eyc23cMdP/eh0q80AoYmntiOb88ZbjmtSA
	8fVLKQLjRwQ2x03DxsFFRa+KA1/Z9X7rW0ULMALG3c87HJC5/iXUcsGb4TR2nIatctCU
	FlIg==
X-Gm-Message-State: AOUpUlENI9B31oVmUfvvvRuo+I+hBqMUur/omGmAlZ0lksBTJFUec35L
	Lpx8eje5eVED1awqSOf8/TpScf61
X-Google-Smtp-Source: AAOMgpeWW8pC4aXU5XMYaFS3DjSh0OnmhNNKQR0dENUGoRG393JNAZkYxVUb9hsSH0WWAz1XNeAvOw==
X-Received: by 2002:a24:624f:: with SMTP id
	d76-v6mr13826185itc.78.1531773489377; 
	Mon, 16 Jul 2018 13:38:09 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	r199-v6sm8988222itb.8.2018.07.16.13.38.08
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 16 Jul 2018 13:38:08 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Mon, 16 Jul 2018 15:37:25 -0500
Message-Id: <20180716203728.23078-7-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716203728.23078-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
Subject: [RFC 6/9] runqueue: Pass dependency ID to hash validate
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
X-List-Received-Date: Mon, 16 Jul 2018 20:38:08 -0000

If the dependency ID is being used to track task dependencies, the hash
validation function needs to know about it in order to properly validate
the hash.

TODO: This currently isn't going to be backward compatible with older
hashvalidate functions. Is that necessary, and if so are there any
suggestions for a good approach?

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 5922431bbe1..82dce426bd1 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1531,6 +1531,7 @@ class RunQueue:
         valid = []
         sq_hash = []
         sq_hashfn = []
+        sq_depid = []
         sq_fn = []
         sq_taskname = []
         sq_task = []
@@ -1549,15 +1550,16 @@ class RunQueue:
             sq_fn.append(fn)
             sq_hashfn.append(self.rqdata.dataCaches[mc].hashfn[taskfn])
             sq_hash.append(self.rqdata.runtaskentries[tid].hash)
+            sq_depid.append(self.rqdata.runtaskentries[tid].depid)
             sq_taskname.append(taskname)
             sq_task.append(tid)
-        locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
+        locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "sq_depid" : sq_depid, "d" : self.cooker.data }
         try:
-            call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d, siginfo=True)"
+            call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, sq_depid, d, siginfo=True)"
             valid = bb.utils.better_eval(call, locs)
         # Handle version with no siginfo parameter
         except TypeError:
-            call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
+            call = self.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, sq_depid, d)"
             valid = bb.utils.better_eval(call, locs)
         for v in valid:
             valid_new.add(sq_task[v])
@@ -2269,6 +2271,7 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
         if self.rq.hashvalidate:
             sq_hash = []
             sq_hashfn = []
+            sq_depid = []
             sq_fn = []
             sq_taskname = []
             sq_task = []
@@ -2300,10 +2303,11 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 sq_fn.append(fn)
                 sq_hashfn.append(self.rqdata.dataCaches[mc].hashfn[taskfn])
                 sq_hash.append(self.rqdata.runtaskentries[tid].hash)
+                sq_depid.append(self.rqdata.runtaskentries[tid].depid)
                 sq_taskname.append(taskname)
                 sq_task.append(tid)
-            call = self.rq.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, d)"
-            locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "d" : self.cooker.data }
+            call = self.rq.hashvalidate + "(sq_fn, sq_task, sq_hash, sq_hashfn, sq_depid, d)"
+            locs = { "sq_fn" : sq_fn, "sq_task" : sq_taskname, "sq_hash" : sq_hash, "sq_hashfn" : sq_hashfn, "sq_depid": sq_depid, "d" : self.cooker.data }
             valid = bb.utils.better_eval(call, locs)
 
             valid_new = stamppresent
-- 
2.17.1


