Return-Path: <msm-oss@mcclintock.net>
Received: from mail-oi0-f48.google.com (mail-oi0-f48.google.com
	[209.85.218.48])
	by mail.openembedded.org (Postfix) with ESMTP id C37397777D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Mar 2017 02:54:48 +0000 (UTC)
Received: by mail-oi0-f48.google.com with SMTP id m124so12607245oig.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 Mar 2017 18:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mcclintock.net; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=LBf66fVQ6WriA9mO0OYJk3NFlNm30i9EXWRBtI7CSfY=;
	b=f4sb/4/c81l7EacNbLwGo0S9kygRxIXJHQPbRK0HJboZUw23P90SpWqU2AK5W4yXxA
	jz3vVZ34riqXFzDQ/dOZ9N5i0e8Qz+wN2HpmkKYxW5w6y3KbCUu45J5evnmGJ4TuPEaa
	X4AkZtmoJgeMRkNkYLh48hVUDOHWIcfiuw8aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=LBf66fVQ6WriA9mO0OYJk3NFlNm30i9EXWRBtI7CSfY=;
	b=riu/gLsOkbW77HbOb5qMed8E+Us2ddAOyQDv43lgoM/qtHbRi6K/x4q1NB0lSJrmQy
	6o2znVw5zRCfOhYdD133ZtcLyDymfV087lfRW5IEq03RNsDGz3Jw/qkDOWQ1QXt3nOZ3
	ZYOXVbo5vPyZXnjdhVFRszWF52nxzxf4m7xxcdyFh/fjmLLRPDgfiOtYyI0jjKT4Ud5A
	WrwV8XPtS//ncmFL73CDR7dSD/mLn2R38LSfhl2f792CY5wOW9eXMZ7MUtItNUsbHd6J
	+e7JdcGe6+Qte1cQdrWNoVC+RbmAX3vTpxQsqdi2oNdHA+UCYZollmbg9LNhCVgpCUpo
	TUxQ==
X-Gm-Message-State: AMke39ngGgdbsJFkW6BJRxqQDKHl72s7Uj9UVERxh/eBljMf7Z5WkOby5iNx5q39EGPxsQ==
X-Received: by 10.202.84.73 with SMTP id i70mr2306407oib.74.1488941689369;
	Tue, 07 Mar 2017 18:54:49 -0800 (PST)
Received: from pandora.lan ([2605:6000:1019:e0:8dd6:e37:4e89:ef9c])
	by smtp.gmail.com with ESMTPSA id
	u131sm934624oig.24.2017.03.07.18.54.48
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 07 Mar 2017 18:54:48 -0800 (PST)
From: Matthew McClintock <msm-oss@mcclintock.net>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Mar 2017 20:54:43 -0600
Message-Id: <1488941683-21232-1-git-send-email-msm-oss@mcclintock.net>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] runqueue: add option to run all tasks in specific build target
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
X-List-Received-Date: Wed, 08 Mar 2017 02:54:49 -0000

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
 lib/bb/cookerdata.py |  1 +
 lib/bb/main.py       |  3 +++
 lib/bb/runqueue.py   | 15 +++++++++++++++
 3 files changed, 19 insertions(+)

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
index 3ff43cf..bda3e0c 100755
--- a/lib/bb/main.py
+++ b/lib/bb/main.py
@@ -287,6 +287,9 @@ class BitBakeConfigParameters(cookerdata.ConfigParameters):
                           help="Writes the event log of the build to a bitbake event json file. "
                                "Use '' (empty string) to assign the name automatically.")
 
+        parser.add_option("", "--runall", action="store", dest="runall",
+                          help="Run all tasks in build target that is specified.")
+
         options, targets = parser.parse_args(argv)
 
         if options.quiet and options.verbose:
diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index a3b451a..1edc721 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -768,6 +768,7 @@ class RunQueueData:
 
             # fn already has mc prefix
             tid = fn + ":" + task
+            bb.warn("building tid %s" % tid)
             self.target_tids.append(tid)
             if tid not in taskData[mc].taskentries:
                 import difflib
@@ -803,6 +804,20 @@ class RunQueueData:
 
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
         #
         # Step D - Sanity checks and computation
         #
-- 
2.7.4


