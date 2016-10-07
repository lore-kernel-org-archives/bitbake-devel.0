Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
	[209.85.220.42])
	by mail.openembedded.org (Postfix) with ESMTP id D409C71993
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  7 Oct 2016 04:07:52 +0000 (UTC)
Received: by mail-pa0-f42.google.com with SMTP id cd13so17561753pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 06 Oct 2016 21:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=274m1uq3HYWTYiEX2ZmsU6E/98Qf2KmqZyakT8qa4j8=;
	b=jeynD8ABO1rM03QbAXP1xgIWhNwdoycuMP2uoRie+1vxB1Y8ftJGgJCdiZmKknqlka
	h7tya08naRTzXMr9LDxxiay5/c9xpUOJLFViLo1qDD0U2zGDmBFwwI7XXhVdSsRLnR7a
	jH4zTRUwojn4IXYBnFXN1luftsShKU7+P4SV7uqgfY45f0362BN4ATD9cWoT5CGmIolM
	8szVPOXfCd8iUuRu3ArXqH2mix8B5nwpv31BIEffHIgdlyjZfeWwsu2YdtErgi5aGcPp
	taUmZiqOAbdDG4X8ofCd6Klb3+TKBlOqOzIsb9MOZVI7MFSDYo/2oF/N7oOhfjavuF0Z
	g6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=274m1uq3HYWTYiEX2ZmsU6E/98Qf2KmqZyakT8qa4j8=;
	b=U9Q6mqkpkXrNzO4gfFZE+OcqA4B5R17wdxa+H/YsUP7cOEtUG2AwGV+6X7VtHgApQA
	8a1vE2MxsodfWGZcJDi2b25dXDRvYgH/0nQ+kJasZGVejxv8H1pv9rXjuthODWIlPvTP
	cQOjro+dopNqPhmUrEPQD4J/+MqoJJ4/xXTGY6jR70/h7ghW9WzVHwgwnD3PTrrUydMz
	2RmJSILWMeYDLKrrOJd+XoS0dYsq29jlXNZTMzB6uYorO8Ioaa0B/3z26oChfGsYkp4F
	LnQO5V4CjgFYr+9OzMODCJXZcyoqGm4WwtLhUFUR1XbwIQiR52acKZLRmtZmtbi7skX3
	l+RA==
X-Gm-Message-State: AA6/9RmnH8ODPbD1qu9OpMFE5sIJimuL8c0HRca/He/gSpiS6AqpMQVaSdOUcaLNMgkTZw==
X-Received: by 10.66.22.162 with SMTP id e2mr7110284paf.3.1475813273602;
	Thu, 06 Oct 2016 21:07:53 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	i8sm26416886paw.25.2016.10.06.21.07.49
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 06 Oct 2016 21:07:52 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  6 Oct 2016 21:07:41 -0700
Message-Id: <1475813261-10429-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.8.0
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH] bb.runqueue: fix unexpected process death logic
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
X-List-Received-Date: Fri, 07 Oct 2016 04:07:54 -0000

From: Christopher Larson <chris_larson@mentor.com>

`if w in self.rq.worker` when w *is* self.rq.worker doesn't make a great deal
of sense, and results in this error:

      File ".../poky/bitbake/lib/bb/runqueue.py", line 2372, in runQueuePipe.read():
                             name = None
        >                    if w in self.rq.worker:
                                 name = "Worker"
    TypeError: unhashable type: 'dict'

Most likely this was meant to be 'is' rather than 'in', but rather than
checking after the fact, just include the name in the iteration, instead.

While we're here, also clean up and fix the broken error message.

Signed-off-by: Christopher Larson <chris_larson@mentor.com>
---
 lib/bb/runqueue.py | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 1571639..df7c50f 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2365,16 +2365,11 @@ class runQueuePipe():
         self.rqexec = rqexec
 
     def read(self):
-        for w in [self.rq.worker, self.rq.fakeworker]:
-            for mc in w:
-                w[mc].process.poll()
-                if w[mc].process.returncode is not None and not self.rq.teardown:
-                    name = None
-                    if w in self.rq.worker:
-                        name = "Worker"
-                    elif w in self.rq.fakeworker:
-                        name = "Fakeroot"
-                    bb.error("%s process (%s) exited unexpectedly (%s), shutting down..." % (name, w.pid, str(w.returncode)))
+        for workers, name in [(self.rq.worker, "Worker"), (self.rq.fakeworker, "Fakeroot")]:
+            for worker in workers.values():
+                worker.process.poll()
+                if worker.process.returncode is not None and not self.rq.teardown:
+                    bb.error("%s process (%s) exited unexpectedly (%s), shutting down..." % (name, worker.process.pid, str(worker.process.returncode)))
                     self.rq.finish_runqueue(True)
 
         start = len(self.queue)
-- 
2.8.0


