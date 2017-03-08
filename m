Return-Path: <msm-oss@mcclintock.net>
Received: from mail-oi0-f54.google.com (mail-oi0-f54.google.com
	[209.85.218.54])
	by mail.openembedded.org (Postfix) with ESMTP id D3F0F72F44
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Mar 2017 02:57:32 +0000 (UTC)
Received: by mail-oi0-f54.google.com with SMTP id 126so12571159oig.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 07 Mar 2017 18:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mcclintock.net; s=google;
	h=from:to:cc:subject:date:message-id;
	bh=JBFFzcSYBk/duaeO2nNIMBQEJe7UK4jlNipk6/Yr7o0=;
	b=BTFVdRFLrpjInXJiaTlIJDYTjtQRFDUdAp/Dw3SqwvUzGN23gUJf8V2jBqc8ndMj9l
	XI5cDmnIsxtMHLfLmvLceyqD7qFoeTdxFliX4CwmXxj6Fiqu9h0e1m5WiJ12EkAUmbzS
	lZDGusGPt2OOfj+Oi8olY4G3JwQBygV7W4OfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=JBFFzcSYBk/duaeO2nNIMBQEJe7UK4jlNipk6/Yr7o0=;
	b=V3YLaNfBHa49QKdl692r5tNTOcRbdmrWQYDnMiBfw1rX6aQw7wjsl/D3JwO+KT36IR
	aonR22ewSHZJgMtsplKgW6H51+2qWSI/QRkI49q0qeEuhggt9ueUVGr6gW3ohtbV7wU6
	IGT1W86Y4yr41hMlIcQpc0qWyT/ix4cY5w2KvjupgXqWJB4T4qQf5KcEEB1ZPqkh4u6W
	l4v9mkKqvegbbukHAHcA3iTyNiXqLveiTmJkIEPLfi6UWlLmbw9DRMbd9H8iuiawufw4
	kN4qLOWH5kJJDHnTwWm15QgcLD9UYNNS4bYR8u63JVMbixGTF2lWYWUrM70Q32Jtyu8q
	9Tmw==
X-Gm-Message-State: AMke39luW+wCer4k77SZXMKEF23Ird1GzbohvlzQsf2i5Ta6WkB6p/IznN2r9XdYlJnxcg==
X-Received: by 10.202.55.197 with SMTP id e188mr2459504oia.12.1488941853453;
	Tue, 07 Mar 2017 18:57:33 -0800 (PST)
Received: from pandora.lan ([2605:6000:1019:e0:8dd6:e37:4e89:ef9c])
	by smtp.gmail.com with ESMTPSA id 33sm939891ots.16.2017.03.07.18.57.32
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 07 Mar 2017 18:57:32 -0800 (PST)
From: Matthew McClintock <msm-oss@mcclintock.net>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  7 Mar 2017 20:57:30 -0600
Message-Id: <1488941850-22002-1-git-send-email-msm-oss@mcclintock.net>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH v2] runqueue: add option to run all tasks in specific build target
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
X-List-Received-Date: Wed, 08 Mar 2017 02:57:33 -0000

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
 lib/bb/runqueue.py   | 14 ++++++++++++++
 3 files changed, 18 insertions(+)

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
index a3b451a..61fca75 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -803,6 +803,20 @@ class RunQueueData:
 
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


