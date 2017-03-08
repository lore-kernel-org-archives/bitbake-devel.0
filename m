Return-Path: <msm-oss@mcclintock.net>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
	[209.85.218.48])
	by mail.openembedded.org (Postfix) with ESMTP id 345E572F45
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Mar 2017 20:24:41 +0000 (UTC)
Received: by mail-oi0-f48.google.com with SMTP id m124so26238085oig.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 08 Mar 2017 12:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mcclintock.net; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=CCOnmOWx+2qL43j4gTxbGmWll4al9Ki7nwJU0YN+Bk8=;
	b=aUOP/YuVcQCcKPY4vr9hbNyf59lbtV6gNROeDCTjuFkk0zKmAMRSRoA2NxaBpQ8zJ1
	R1o16pt7B8ypakZPfsK89Pejz+KtQ0g/PEQlbpiX2RB/azSbAL+N89QLyZpPW8RLyMkK
	HRlCr8grkhUZFwOzfMH7fRbputlQWaubw+mI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=CCOnmOWx+2qL43j4gTxbGmWll4al9Ki7nwJU0YN+Bk8=;
	b=GFORFnB8dUtDrZgTobh/JNr/3e4E4scqxKyoxKm8kGzcFKG/yYHmR2sV1Iq3qDba43
	FzJRoWIcXAZg7o9Fu+y++zLAvyL90Z+j2dzHjohjPxcklWc86jAMUwI5AiZGeNJuJON5
	iJx8tsgYrkqel+W5unjoFFwHTu8rD1GsNEh8GhEEiv0Ahg+2t05voBWLscrRl3E0jJNa
	n/eARM3SAgH80hPwZIdevVGP1173GvBTYP0S4sl87NYI9l7JbVix9sA6Esn4LjH6iGKx
	rc1mHtHPT5UDtnOA1mKr4ScOFNXBYg6IYZzU3gqt6b0X/mp8Zipt2gJMuEw4wIvy56UJ
	1asA==
X-Gm-Message-State: AMke39luAkltRQlN9oFsH1KjD0+9ZRmLkIfpwmMnthzjsuID0tJE/h1grBImN2echH4V+w==
X-Received: by 10.202.50.7 with SMTP id y7mr4833800oiy.111.1489004683235;
	Wed, 08 Mar 2017 12:24:43 -0800 (PST)
Received: from pandora.lan ([2605:6000:1019:e0:c0c6:fae8:f021:62cd])
	by smtp.gmail.com with ESMTPSA id
	u131sm1939398oig.24.2017.03.08.12.24.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 08 Mar 2017 12:24:42 -0800 (PST)
From: Matthew McClintock <msm-oss@mcclintock.net>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Mar 2017 14:24:38 -0600
Message-Id: <1489004678-31921-1-git-send-email-msm-oss@mcclintock.net>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH v3] runqueue: add option to run all tasks in specific build target
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
X-List-Received-Date: Wed, 08 Mar 2017 20:24:42 -0000

For example:

$ bitbake core-image-minimal --runall unpack
...
NOTE: Tasks Summary: Attempted 326 tasks of which 88 didn't need to be rerun and all succeeded.

$ bitbake core-image-minimal --runall patch
NOTE: Tasks Summary: Attempted 453 tasks of which 332 didn't need to be rerun and all succeeded.

This can replace fetchall as well:
$ bitbake core-image-minimal --runall fetch
NOTE: Tasks Summary: Attempted 135 tasks of which 119 didn't need to be rerun and all succeeded.

Signed-off-by: Matthew McClintock <msm-oss@mcclintock.net>
---

Notes:
        v2:
    	- removed debug code that was left behind
        v3:
    	- update help message
    	- emit fatal error if no tasks remain after runall filter

 lib/bb/cookerdata.py |  1 +
 lib/bb/main.py       |  3 +++
 lib/bb/runqueue.py   | 17 +++++++++++++++++
 3 files changed, 21 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 53f4587..722d860 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -148,6 +148,7 @@ class CookerConfiguration(object):
         self.writeeventlog = False
         self.server_only = False
         self.limited_deps = False
+        self.runall = None
 
         self.env = {}
 
diff --git a/lib/bb/main.py b/lib/bb/main.py
index 3ff43cf..b3cd2cf 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -287,6 +287,9 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                           help="Writes the event log of the build to a bitbake event json file. "
                                "Use '' (empty string) to assign the name automatically.")
 
+        parser.add_option("", "--runall", action="store", dest="runall",
+                          help="Run the specified task for all build targets and their dependencies.")
+
         options, targets = parser.parse_args(argv)
 
         if options.quiet and options.verbose:
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a3b451a..38304d1 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -803,6 +803,23 @@ class RunQueueData:
 
         self.init_progress_reporter.next_stage()
 
+        if self.cooker.configuration.runall is not None:
+            runall = "do_%s" % self.cooker.configuration.runall
+            runall_tids = { k: v for k, v in self.runtaskentries.items() if taskname_from_tid(k) == runall }
+
+            # re-run the mark_active and then drop unused tasks from new list
+            runq_build = {}
+            for tid in list(runall_tids):
+                mark_active(tid,1)
+
+            for tid in list(self.runtaskentries.keys()):
+                if tid not in runq_build:
+                    del self.runtaskentries[tid]
+                    delcount += 1
+
+            if len(self.runtaskentries) == 0:
+                bb.msg.fatal("RunQueue", "No remaining tasks to run run for build target %s with runall %s" % (target, runall))
+
         #
         # Step D - Sanity checks and computation
         #
-- 
2.7.4


