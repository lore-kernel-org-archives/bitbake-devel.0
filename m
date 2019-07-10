Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
	[209.85.128.45])
	by mail.openembedded.org (Postfix) with ESMTP id AEE9C7F023
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 23:54:32 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id 207so3908479wma.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jul 2019 16:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=iW+DurM9iU+4n8oESsZDiwoE+El58r+2kuYmjXbcz8U=;
	b=iV4RrSloGXV5U81gBA97X7yozm+qOR2K7wSiTRF4HJZmgZUqVXANDq3PtwW79KfUn9
	v8ZFBL3+5i6TZvrPg2BpWCCLh1EirCMZxmUAefotxz8IvMrgKCMnn4KiP3oqs7ehKV0U
	a6bpcI0g+sYtlU/7a+WUFiYRRtbzX38SFhR7E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=iW+DurM9iU+4n8oESsZDiwoE+El58r+2kuYmjXbcz8U=;
	b=eeg5IL2MK/3UWJ+o+0kBla6q8TbhMusyieEqgwPyHj/2u4zWXl80Gxgh1c+CVaK5AW
	RXsJ2oMusqA+1rD6MvWixqEvO9cywwieJLqTLbyt5G0fZhhuRrYJQHehNxOUxRViYUOx
	iUUOJ5X8GdLmu35/vELFIneH7XHuSUAYGJqQaWxvRdBFUBWdOmZQYiytXWqADGD/tXby
	NvMuKiBeW0PVZcGuJanG3osTQAao7J0U/lRhgC01Z1gP+9ROagqRFKfTEUR0Je7ZxwwE
	EXESrh1+b2eXuJgKw9n5VfOCHgjOBU83ZoGk6wn9mrspzSyVDVZOF+ojsh5VfHaORJh+
	Z3zQ==
X-Gm-Message-State: APjAAAXBOIQwXzxYxISJAu0j5HhY0dzCxAsQSF9PEv2WGi69PX5GVvRP
	y11i/mBtklFvhxodbRQTIHWwqs/DNJo=
X-Google-Smtp-Source: APXvYqwCmR89aZh/1Q+lh9EAefWMM2YBfTz7kSfgj5j+QqYNKLiAX2ekQ6jDQQgKWK62TVW4AstKgg==
X-Received: by 2002:a1c:a5c2:: with SMTP id o185mr285336wme.172.1562802873085; 
	Wed, 10 Jul 2019 16:54:33 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	r12sm4710783wrt.95.2019.07.10.16.54.32
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 10 Jul 2019 16:54:32 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Jul 2019 00:54:06 +0100
Message-Id: <20190710235420.23825-12-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
References: <20190710235420.23825-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 12/26] runqueue: Simplify _execute_runqueue logic
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
X-List-Received-Date: Wed, 10 Jul 2019 23:54:32 -0000
Content-Transfer-Encoding: 8bit

Cleanup to the _execute_runqueue logic to reduce indentation, drop the
dummy executor class concept and prepare for further changes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 46 ++++++++++++++++++++++++----------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 3456fd976b..a19fb61fe7 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1420,15 +1420,16 @@ class RunQueue:
                 self.state = runQueueComplete
             else:
                 self.state = runQueueSceneInit
-                self.rqdata.init_progress_reporter.next_stage()
-
-                # we are ready to run,  emit dependency info to any UI or class which
-                # needs it
-                depgraph = self.cooker.buildDependTree(self, self.rqdata.taskData)
-                self.rqdata.init_progress_reporter.next_stage()
-                bb.event.fire(bb.event.DepTreeGenerated(depgraph), self.cooker.data)
 
         if self.state is runQueueSceneInit:
+            self.rqdata.init_progress_reporter.next_stage()
+
+            # we are ready to run,  emit dependency info to any UI or class which
+            # needs it
+            depgraph = self.cooker.buildDependTree(self, self.rqdata.taskData)
+            self.rqdata.init_progress_reporter.next_stage()
+            bb.event.fire(bb.event.DepTreeGenerated(depgraph), self.cooker.data)
+
             if not self.dm_event_handler_registered:
                  res = bb.event.register(self.dm_event_handler_name,
                                          lambda x: self.dm.check(self) if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp] else False,
@@ -1444,13 +1445,13 @@ class RunQueue:
                 if 'printdiff' in dump:
                     self.write_diffscenetasks(invalidtasks)
                 self.state = runQueueComplete
-            else:
-                self.rqdata.init_progress_reporter.next_stage()
-                self.start_worker()
-                self.rqdata.init_progress_reporter.next_stage()
-                if not self.rqexe:
-                    self.rqexe = RunQueueExecute(self)
-                start_scenequeue_tasks(self.rqexe)
+
+        if self.state is runQueueSceneInit:
+            self.rqdata.init_progress_reporter.next_stage()
+            self.start_worker()
+            self.rqdata.init_progress_reporter.next_stage()
+            self.rqexe = RunQueueExecute(self)
+            start_scenequeue_tasks(self.rqexe)
 
         if self.state is runQueueSceneRun:
             retval = self.rqexe.sq_execute()
@@ -1458,14 +1459,15 @@ class RunQueue:
         if self.state is runQueueRunInit:
             if self.cooker.configuration.setsceneonly:
                 self.state = runQueueComplete
-            else:
-                # Just in case we didn't setscene
-                self.rqdata.init_progress_reporter.finish()
-                logger.info("Executing RunQueue Tasks")
-                if not self.rqexe:
-                    self.rqexe = RunQueueExecute(self)
-                start_runqueue_tasks(self.rqexe)
-                self.state = runQueueRunning
+
+        if self.state is runQueueRunInit:
+            # Just in case we didn't setscene
+            self.rqdata.init_progress_reporter.finish()
+            logger.info("Executing RunQueue Tasks")
+            if not self.rqexe:
+                self.rqexe = RunQueueExecute(self)
+            start_runqueue_tasks(self.rqexe)
+            self.state = runQueueRunning
 
         if self.state is runQueueRunning:
             retval = self.rqexe.execute()
-- 
2.20.1


