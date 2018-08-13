Return-Path: <schnitzeltony@gmail.com>
Received: from mail-wm0-f66.google.com (mail-wm0-f66.google.com [74.125.82.66])
	by mail.openembedded.org (Postfix) with ESMTP id 4280978F85
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 21:04:58 +0000 (UTC)
Received: by mail-wm0-f66.google.com with SMTP id q8-v6so10186200wmq.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Aug 2018 14:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=PVzCBZ/81NRBg/q7djC36zOhrFfKvU+tCpizzmml6jo=;
	b=byY6jiT3agSgQ5GJla3rU2JsuTP75qw0MCFn4TuHL/4iYAQ7KgBRopR0wQtCKyIseZ
	7dTX4XKzAmba7ZvkNLrtt3C65xr+gefxBwyUyFt2QsNmCcvOCNy5hS297EWw7jHLpeBl
	Cn+2gAjDM3Jxuq6LA5iAHtj/txN3WrSBuXqIPNaWw8THeGpWd3tp2+OeQ/lLQWTHuBha
	xnDj7vVyH0qWnri1La9jyJXaoiP0/xmZMlJvKwalkaL4CNnM93VNmTInrgu79ddadRWn
	jBNyJiBTSBRLHAzcHadfB8Vlbo508RKvls7Uk7uMpvaXKil2FA0DAxomtV52hHM4qzBr
	hMiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=PVzCBZ/81NRBg/q7djC36zOhrFfKvU+tCpizzmml6jo=;
	b=kSJ0McyhkI1RSNjpFR74SfmdSeY+OU20UF4lzZwhyUeetphgsIV7aY9t480BWvKxhH
	68f7lkKoRXi7kJpDliMC/skDaoxvomfBeLS8gigIP3JgF6S5x9cAQvCwGBxBI2aCOr4m
	9H3U9x2Qjg6zw4YrF9SfkPdHrAkLmtIebQzq8dv4xjtSoWyAqlpTGX7TE2qIlMs5vTjm
	XjhW/iQPhPMNE1sb5R/9Ay5zatdO7UGF/r3Mni4W/0xn/4nTY4sNFkJD8rPafxwHcZLF
	3z19hRLog+4Aar9UFUX57GO661cR+A7sdbzeEy/PBwpawaUeNbXc7no4Yp5tr7iTHnfq
	/qXw==
X-Gm-Message-State: AOUpUlGQkLIuyIyvAJ3uD5WWtuOIsZvnO59t9BjZs/0g+qrQpEQQDq7Q
	0o5WK0o4sGOdpIDrL+YuOg1RtkSq
X-Google-Smtp-Source: AA+uWPw1i5sm1eVqgFZE413Pd7wJXhCkUsLZ22/+4OX39/DlmUluRQ9a6kBMryPqR6gJNuK/gIIxPg==
X-Received: by 2002:a1c:d98a:: with SMTP id
	q132-v6mr9570533wmg.78.1534194298566; 
	Mon, 13 Aug 2018 14:04:58 -0700 (PDT)
Received: from localhost.localdomain
	(p200300F07BC4D1601E6F65FFFE3E7F61.dip0.t-ipconnect.de.
	[2003:f0:7bc4:d160:1e6f:65ff:fe3e:7f61])
	by smtp.gmail.com with ESMTPSA id
	j8-v6sm12256559wrn.50.2018.08.13.14.04.57
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 13 Aug 2018 14:04:57 -0700 (PDT)
From: =?UTF-8?q?Andreas=20M=C3=BCller?= <schnitzeltony@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Aug 2018 23:04:45 +0200
Message-Id: <20180813210445.32496-3-schnitzeltony@gmail.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180813210445.32496-1-schnitzeltony@gmail.com>
References: <20180813210445.32496-1-schnitzeltony@gmail.com>
MIME-Version: 1.0
Subject: [PATCH 2/2] runqueue: Introduce load balanced task spawning
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

To get most out of build host, bitbake now detects if the CPU workload is low.
If so, additional tasks are spawned. Maximum 'dynamic' tasks are set by
BB_NUMBER_THREADS_LOW_CPU.

So now user can set a range for the count of tasks:

Min: BB_NUMBER_THREADS
Min: BB_NUMBER_THREADS_LOW_CPU

in which bitbake can operate on demand.

Some numbers for 6 core AMD bulldozer 12GB RAM / build image from scratch with
3104 tasks / PARALLEL_MAKE = "-j6" / PARALLEL_MAKEINST="-j6":

Before the patch (same as BB_NUMBER_THREADS_LOW_CPU = "0" or not set):

 BB_NUMBER_THREADS | Build time [s]
------------------------------------
 2                 | 156m48.741s
------------------------------------
 3                 | 126m27.426s
------------------------------------
 4                 | 114m30.560s  <-- winner (as suggested in doc!)
------------------------------------
 5                 | 117m2.679s
------------------------------------
 6                 | 116m37.515s
------------------------------------
 8                 | 116m37.515s
------------------------------------
 10                | 118m18.441s
------------------------------------
 12                | 117m38.264s

With the patch applied and BB_NUMBER_THREADS_LOW_CPU = "20" (as written in docs
for max thread count)

 BB_NUMBER_THREADS | Build time [s]
------------------------------------
 3                 | 114m48.105s
------------------------------------
 4                 | 113m26.502s
------------------------------------

Some additional notes:

+ Although not tested I expect better enhancement for setscene sessions
+ At times back when do_package_qa was a dependency for do_rootfs, the
  performance win would have been more significant: For the image tested only
  very few do_package_qa were performed while do_rootfs. The static threads = 4
  winner had more of them and would have waited longer - sigh :)
+ It's more fun to watch bitbake at work torturing CPU. If you want to do so
  and use gnome's system monitor, be aware that CPU History is delayed for
  2-3s. I was sometimes wondering 'why more task's now?
- For building image from scratch the performace win is somewhat dissapointing ~1%
- Patch creates a dependecy on psutils
- time.monotonic is not yet used. It was introduced in python 3.3 (2012) and is
  considered supported in all environments (whatever that means) since 3.5
  (2015).

Signed-off-by: Andreas Müller <schnitzeltony@gmail.com>
---
 lib/bb/runqueue.py | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 7095ea5a..2690c2a2 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -37,6 +37,8 @@ from bb import monitordisk
 import subprocess
 import pickle
 from multiprocessing import Process
+import psutil
+import time
 
 bblogger = logging.getLogger("BitBake")
 logger = logging.getLogger("BitBake.RunQueue")
@@ -1668,6 +1670,7 @@ class RunQueueExecute:
         self.rqdata = rq.rqdata
 
         self.number_tasks = int(self.cfgData.getVar("BB_NUMBER_THREADS") or 1)
+        self.number_tasks_low_cpu = int(self.cfgData.getVar("BB_NUMBER_THREADS_LOW_CPU") or 0)
         self.scheduler = self.cfgData.getVar("BB_SCHEDULER") or "speed"
 
         self.runq_buildable = set()
@@ -1679,6 +1682,8 @@ class RunQueueExecute:
         self.failed_tids = []
 
         self.stampcache = {}
+        self.last_cpu_percent = psutil.cpu_percent()
+        self.last_cpu_percent_time = time.monotonic()
 
         for mc in rq.worker:
             rq.worker[mc].pipe.setrunqueueexec(self)
@@ -1687,6 +1692,8 @@ class RunQueueExecute:
 
         if self.number_tasks <= 0:
              bb.fatal("Invalid BB_NUMBER_THREADS %s" % self.number_tasks)
+        if self.number_tasks_low_cpu < 0:
+             bb.fatal("Invalid BB_NUMBER_THREADS_LOW_CPU %s" % self.number_tasks_low_cpu)
 
     def runqueue_process_waitpid(self, task, status):
 
@@ -1756,6 +1763,17 @@ class RunQueueExecute:
 
     def can_start_task(self):
         can_start = self.stats.active < self.number_tasks
+        # Can we inject extra tasks for low workload?
+        if not can_start and self.number_tasks_low_cpu > 0:
+            _time = time.monotonic()
+            # avoid workload inaccuray
+            if _time - self.last_cpu_percent_time >= 0.1:
+                cpu_percent = psutil.cpu_percent()
+                self.last_cpu_percent = cpu_percent
+                self.last_cpu_percent_time = _time
+                if cpu_percent < 90 and self.stats.active < self.number_tasks_low_cpu:
+                    can_start = True
+
         return can_start
 
 class RunQueueExecuteDummy(RunQueueExecute):
-- 
2.14.4


