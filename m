Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f195.google.com (mail-it1-f195.google.com
	[209.85.166.195])
	by mail.openembedded.org (Postfix) with ESMTP id 974F77C04B;
	Tue, 18 Dec 2018 15:31:14 +0000 (UTC)
Received: by mail-it1-f195.google.com with SMTP id c9so4800881itj.1;
	Tue, 18 Dec 2018 07:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=dFNBwPqLWN4rf74yhLcG+OG1CRR4suOHe3oyurGq5dM=;
	b=SLN34obX61v7nJ3jJsTM/fp5m1zC0C2Q6G/Af9NumR5BIfz+jTRINq/RoW0H2w/6Uo
	J7e1BnbKckbP04Oywn+rqvkFykcd85vBMClAcyRXH8E1gf4Dn/xns5cOO2q3MrG9a8yT
	usZdlfdnIQUMYzMwwAnxINnZZOETdvrFuiszZaXNEpDXoBUOSSu/9PqrS+Rx1gLPDQs+
	ABOlPEZD/BNAjcS6HF9XvguoTEhBqW7jhMy0lq56PEbUJTTXCKklOGnEuF7O4zxI9OAm
	QKB8jVGTQgDPYz3D/Y5o5ODCWiHzRNc+1wTdLfcVwvqafjXyo0uEAR2oS9pA6z5bHcM3
	jZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=dFNBwPqLWN4rf74yhLcG+OG1CRR4suOHe3oyurGq5dM=;
	b=DDypDCRrlVkC63C90kZDfX+6ZkHztQ1Chis2cS9kHZlILxg3I3f/oM056UaXivem98
	QObINOSsCH2cp3S8uZvnsOAIQZMGRrFcpTmgvWYEeryUnebuzNl3q3ga1wqKvr7f/jmH
	rqQH2xBHoaa9ai98v2bgkL6c3IbIWzz+bHCcm4RGKtIoHTtFOmDikyj93/hxm5RZo4Gk
	DK6ke8pzni22gDxzdWF76BlPIY+6gM1KeSpWv7gEeGKqQjVhOHULPHpuO7IQlbxzfMZe
	aLHW9p1ji1N+pZUJR79GpYWre203tYBt3HEy+jXmF/btXUUf7J9e0hiU4YIQKFKT9pQz
	RmtA==
X-Gm-Message-State: AA+aEWY7SqOn60LuDypqXrWdyq+dpvVNiuDkK0UU90Q2auFuJid1ZxgT
	OxBjf7iEIIewH8RMkJ5ZgPSaGag/
X-Google-Smtp-Source: AFSGD/Wm5SpxtYVpRzt1s0kqOyDaXWfCTymaB/KbzipP1wtlxDB+SB+6+B/c5kE1+FlMUZHf2crUVg==
X-Received: by 2002:a02:8cce:: with SMTP id n14mr16826330jal.125.1545147074834;
	Tue, 18 Dec 2018 07:31:14 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id 18sm1652072itk.28.2018.12.18.07.31.13
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 07:31:13 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Dec 2018 09:30:56 -0600
Message-Id: <20181218153101.9212-6-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218153101.9212-1-JPEWhacker@gmail.com>
References: <20181204034245.25461-1-JPEWhacker@gmail.com>
	<20181218153101.9212-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v4 05/10] bitbake: runqueue: Track task unique hash
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
X-List-Received-Date: Tue, 18 Dec 2018 15:31:14 -0000
Content-Transfer-Encoding: 8bit

Requests the task unique hash from siggen and tracks it

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index f2b95a9829b..27b188256dd 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -346,6 +346,7 @@ class RunTaskEntry(object):
         self.depends = set()
         self.revdeps = set()
         self.hash = None
+        self.unihash = None
         self.task = None
         self.weight = 1
 
@@ -385,6 +386,9 @@ class RunQueueData:
     def get_task_hash(self, tid):
         return self.runtaskentries[tid].hash
 
+    def get_task_unihash(self, tid):
+        return self.runtaskentries[tid].unihash
+
     def get_user_idstring(self, tid, task_name_suffix = ""):
         return tid + task_name_suffix
 
@@ -1150,18 +1154,21 @@ class RunQueueData:
                 if len(self.runtaskentries[tid].depends - dealtwith) == 0:
                     dealtwith.add(tid)
                     todeal.remove(tid)
-                    procdep = []
-                    for dep in self.runtaskentries[tid].depends:
-                        procdep.append(fn_from_tid(dep) + "." + taskname_from_tid(dep))
-                    (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
-                    self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.dataCaches[mc])
-                    task = self.runtaskentries[tid].task
+                    self.prepare_task_hash(tid)
 
         bb.parse.siggen.writeout_file_checksum_cache()
 
         #self.dump_data()
         return len(self.runtaskentries)
 
+    def prepare_task_hash(self, tid):
+        procdep = []
+        for dep in self.runtaskentries[tid].depends:
+            procdep.append(fn_from_tid(dep) + "." + taskname_from_tid(dep))
+        (mc, fn, taskname, taskfn) = split_tid_mcfn(tid)
+        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(taskfn, taskname, procdep, self.dataCaches[mc])
+        self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(fn + "." + taskname)
+
     def dump_data(self):
         """
         Dump some debug information on the internal data structures
@@ -2081,7 +2088,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 deps = self.rqdata.runtaskentries[revdep].depends
                 provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
                 taskhash = self.rqdata.runtaskentries[revdep].hash
-                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash]
+                unihash = self.rqdata.runtaskentries[revdep].unihash
+                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash]
                 for revdep2 in deps:
                     if revdep2 not in taskdepdata:
                         additional.append(revdep2)
@@ -2524,7 +2532,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 deps = getsetscenedeps(revdep)
                 provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
                 taskhash = self.rqdata.runtaskentries[revdep].hash
-                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash]
+                unihash = self.rqdata.runtaskentries[revdep].unihash
+                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, unihash]
                 for revdep2 in deps:
                     if revdep2 not in taskdepdata:
                         additional.append(revdep2)
-- 
2.19.2


