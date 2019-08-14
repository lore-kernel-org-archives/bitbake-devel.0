Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
	[209.85.221.51])
	by mail.openembedded.org (Postfix) with ESMTP id ED78F7E6F8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 13:53:23 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id u16so153634wrr.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Aug 2019 06:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=+jBrf7qVKXp1lRT2+JrGzpGtPcTZI2g9DrbJLDLgnio=;
	b=JjOPn+8Lhsu5mJNrjoiXv9hy9KOdfpRHntrbEkhnR3um7OwHlrpZZtoRGbMMobvDib
	Uvl6D+zoJ3H4Ak79EhZWXqeWLyq4jBKd3AZz7mN7+jzEQTvEmthZsXT8SIbR1d2qvFU3
	p/igO2u/YUZAviDHMFa3Nld49w+x3YzyM7mWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=+jBrf7qVKXp1lRT2+JrGzpGtPcTZI2g9DrbJLDLgnio=;
	b=TjtuddFjEedTV8aH6M13PbSOoYvrMQdArLBSB5a7f75hRzKUaMkvHuF71P+XscjvH8
	0/eHjEIQvaLGnBkw+fyzXoWRPqBc4aC6Vy2f/9RC5mDt07dXgersEkomWQDSKHmQC6uL
	QQKXGAAHe8uiXE+jFrjAwE5wB76NU62obC8lbeNb5h9HZPoKcKoU8OHpKCY0+d1xS7oD
	0aYyScTeR3twoqVhbhdY1xv0FmPvFHR8E5t9wD1F2+QBjU6D6LqaQFOhrxrCOYGL217B
	9FT+mUiBFmFl75NnXnBZJi1JZRH4XAE/AyaiV2zCwK/ADBgkt3tMdA1sk8Jm+UGarApa
	LXgw==
X-Gm-Message-State: APjAAAXTYwlo2z0ap99OzlPVgR1969tYyE9qbEAGzbYIpBqMI5DPMz58
	XdOu0MkyAKr6eQJQ+9KSMblkptV2DLBcOA==
X-Google-Smtp-Source: APXvYqwA/D/ndwhibvdBkGnYehkeDbpyu9Tm6kjMh5CGGtTr02apO/hxc2bha+4duEaxo5dROhXPRQ==
X-Received: by 2002:adf:d188:: with SMTP id v8mr30948133wrc.213.1565790804310; 
	Wed, 14 Aug 2019 06:53:24 -0700 (PDT)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e6sm1859275wrr.14.2019.08.14.06.53.23
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
	Wed, 14 Aug 2019 06:53:23 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 14 Aug 2019 14:53:14 +0100
Message-Id: <20190814135317.28887-7-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814135317.28887-1-richard.purdie@linuxfoundation.org>
References: <20190814135317.28887-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 07/10] runqueue: Improve scenequeue debugging
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
X-List-Received-Date: Wed, 14 Aug 2019 13:53:24 -0000
Content-Transfer-Encoding: 8bit

Whilst we had good runqueue failure mode debug, it hadn't adapted to the
scenequeue changes. Run the scenequeue sanity tests at the end of
a build and output the results regardless of whether all setscene tasks
completed or not. This *massively* improves the ability to debug runqueue
problems.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 61 +++++++++++++++++++++++++++++++---------------
 1 file changed, 42 insertions(+), 19 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 3bcbaee12a..a1e3285821 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1746,9 +1746,9 @@ class RunQueueExecute:
             bb.fatal("Invalid scheduler '%s'.  Available schedulers: %s" %
                      (self.scheduler, ", ".join(obj.name for obj in schedulers)))
 
-        if len(self.rqdata.runq_setscene_tids) > 0:
-            self.sqdata = SQData()
-            build_scenequeue_data(self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self)
+        #if len(self.rqdata.runq_setscene_tids) > 0:
+        self.sqdata = SQData()
+        build_scenequeue_data(self.sqdata, self.rqdata, self.rq, self.cooker, self.stampcache, self)
 
     def runqueue_process_waitpid(self, task, status):
 
@@ -1901,6 +1901,35 @@ class RunQueueExecute:
         self.stats.taskSkipped()
         self.stats.taskCompleted()
 
+    def summarise_scenequeue_errors(self):
+        err = False
+        if not self.sqdone:
+            logger.debug(1, 'We could skip tasks %s', "\n".join(sorted(self.scenequeue_covered)))
+            completeevent = sceneQueueComplete(self.sq_stats, self.rq)
+            bb.event.fire(completeevent, self.cfgData)
+        if self.sq_deferred:
+            logger.error("Scenequeue had deferred entries: %s" % pprint.pformat(self.sq_deferred))
+            err = True
+        if self.changed_setscene:
+            logger.error("Scenequeue had unprocessed changed entries: %s" % pprint.pformat(self.changed_setscene))
+            err = True
+        if self.holdoff_tasks:
+            logger.error("Scenequeue had holdoff tasks: %s" % pprint.pformat(self.holdoff_tasks))
+            err = True
+
+        for x in self.rqdata.runtaskentries:
+            if x not in self.tasks_covered and x not in self.tasks_notcovered:
+                logger.error("Task %s was never moved from the setscene queue" % x)
+                err = True
+            if x not in self.tasks_scenequeue_done:
+                logger.error("Task %s was never processed by the setscene code" % x)
+                err = True
+            if len(self.rqdata.runtaskentries[x].depends) == 0 and x not in self.runq_buildable:
+                logger.error("Task %s was never marked as buildable by the setscene code" % x)
+                err = True
+        return err
+
+
     def execute(self):
         """
         Run the tasks in a queue prepared by prepare_runqueue
@@ -1996,22 +2025,8 @@ class RunQueueExecute:
 
         if not self.sq_live and not self.sqdone and not self.sq_deferred and not self.changed_setscene and not self.holdoff_tasks:
             logger.info("Setscene tasks completed")
-            logger.debug(1, 'We could skip tasks %s', "\n".join(sorted(self.scenequeue_covered)))
 
-            completeevent = sceneQueueComplete(self.sq_stats, self.rq)
-            bb.event.fire(completeevent, self.cfgData)
-
-            err = False
-            for x in self.rqdata.runtaskentries:
-                if x not in self.tasks_covered and x not in self.tasks_notcovered:
-                    logger.error("Task %s was never moved from the setscene queue" % x)
-                    err = True
-                if x not in self.tasks_scenequeue_done:
-                    logger.error("Task %s was never processed by the setscene code" % x)
-                    err = True
-                if len(self.rqdata.runtaskentries[x].depends) == 0 and x not in self.runq_buildable:
-                    logger.error("Task %s was never marked as buildable by the setscene code" % x)
-                    err = True
+            err = self.summarise_scenequeue_errors()
             if err:
                 self.rq.state = runQueueFailed
                 return True
@@ -2107,14 +2122,22 @@ class RunQueueExecute:
             return True
 
         # Sanity Checks
+        err = self.summarise_scenequeue_errors()
         for task in self.rqdata.runtaskentries:
             if task not in self.runq_buildable:
                 logger.error("Task %s never buildable!", task)
+                err = True
             elif task not in self.runq_running:
                 logger.error("Task %s never ran!", task)
+                err = True
             elif task not in self.runq_complete:
                 logger.error("Task %s never completed!", task)
-        self.rq.state = runQueueComplete
+                err = True
+
+        if err:
+            self.rq.state = runQueueFailed
+        else:
+            self.rq.state = runQueueComplete
 
         return True
 
-- 
2.20.1


