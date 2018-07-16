Return-Path: <jpewhacker@gmail.com>
Received: from mail-io0-f169.google.com (mail-io0-f169.google.com
	[209.85.223.169])
	by mail.openembedded.org (Postfix) with ESMTP id 029DA7872C;
	Mon, 16 Jul 2018 20:38:06 +0000 (UTC)
Received: by mail-io0-f169.google.com with SMTP id q4-v6so39122047iob.2;
	Mon, 16 Jul 2018 13:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=8yH9aHl1K8vrlOQeMlo5St4Hr35noYSJiuZ2nTUqSrI=;
	b=j034mIuvR80Cq/vWCC3V3h/V2jK9Fo3jAc/APBYl5jac9sZnW6wHkr0o2/HCr8dzeA
	hkpRgUdPj+z+nv0xVojjYutY8S/xHk7dMqlp7lJyDLAA++4X9kw6bGXQJsFfVQc1660D
	MUWhIEVZLkiEz3OoZLvP6QkjPD+i46o3xPNSCaZqjed9Ivz+Nl1rzbcO4SMgbhTQN93G
	UxELIkJTrSFHWCVzFhlA9/DzLyRA6IX52DibMGwfnTsTX8cweTTNPy9Ke1PAoi7Vnt95
	QvTDEsDvr++qSM6L1a7JirKByOdhdn/MwlvEUoDxxCugojOMcOxpAOwTHBJXFgpeJqbx
	XFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=8yH9aHl1K8vrlOQeMlo5St4Hr35noYSJiuZ2nTUqSrI=;
	b=g5uM2UcKB+4Jg7zeFld3FAKNlF9yewgGajyJlN5PLLuiScDfCPxswddsQDmjEQ/1Te
	4/oa6U86ct+5+OHMe5ZHRh7LdAXlukw2o9e0Oc7O/ovdVik6x6Kqm3AJjoSNMuGgxA95
	yVKvTRQyPVuirNXB0yknhxPda1S+cpVLOAZy/795/7/YjtzTYIGEaOlo4eppLQ6jQouf
	FVqTf2TZ1TEJRO4vvjDki9glraEAtFgDi1VgH7eOEr+qeme6G/fFGnY2C8Bn7X0eeIHW
	gFvVVfgGwdpiP6QCmFIea2spkhItF/w7WmqT0Zm3ACXpQE9og7CmNwVjNiDZt2x0rbYB
	6CwA==
X-Gm-Message-State: AOUpUlE9cyd3KOr0fVGlW69PcHbV6bQ8JledEG3weFt5R8FsX5criTya
	d2Gu6NaNSkHnrGAmUruQH7ethqTk
X-Google-Smtp-Source: AAOMgpfYVbfnX+JWV333ZkE0sT7c/1njPh1eusez2Dv/O+cf6Xcq2m1blY8k3jM7z0YPc1wylcWKCw==
X-Received: by 2002:a6b:580c:: with SMTP id
	m12-v6mr29062611iob.228.1531773487921; 
	Mon, 16 Jul 2018 13:38:07 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	r199-v6sm8988222itb.8.2018.07.16.13.38.07
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 16 Jul 2018 13:38:07 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Mon, 16 Jul 2018 15:37:23 -0500
Message-Id: <20180716203728.23078-5-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716203728.23078-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
Subject: [RFC 4/9] runqueue: Track task dependency ID
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
X-List-Received-Date: Mon, 16 Jul 2018 20:38:07 -0000

Requests the task dependency ID from siggen and tracks it

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index f655614d1ce..97cc8a948af 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -346,6 +346,7 @@ class RunTaskEntry(object):
         self.depends = set()
         self.revdeps = set()
         self.hash = None
+        self.depid = None
         self.task = None
         self.weight = 1
 
@@ -385,6 +386,9 @@ class RunQueueData:
     def get_task_hash(self, tid):
         return self.runtaskentries[tid].hash
 
+    def get_task_depid(self, tid):
+        return self.runtaskentries[tid].depid
+
     def get_user_idstring(self, tid, task_name_suffix = ""):
         return tid + task_name_suffix
 
@@ -1133,18 +1137,21 @@ class RunQueueData:
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
+        self.runtaskentries[tid].depid = bb.parse.siggen.get_depid(fn + "." + taskname)
+
     def dump_data(self):
         """
         Dump some debug information on the internal data structures
@@ -2058,7 +2065,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 deps = self.rqdata.runtaskentries[revdep].depends
                 provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
                 taskhash = self.rqdata.runtaskentries[revdep].hash
-                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash]
+                depid = self.rqdata.runtaskentries[revdep].depid
+                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, depid]
                 for revdep2 in deps:
                     if revdep2 not in taskdepdata:
                         additional.append(revdep2)
@@ -2495,7 +2503,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
                 deps = getsetscenedeps(revdep)
                 provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
                 taskhash = self.rqdata.runtaskentries[revdep].hash
-                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash]
+                depid = self.rqdata.runtaskentries[revdep].depid
+                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, depid]
                 for revdep2 in deps:
                     if revdep2 not in taskdepdata:
                         additional.append(revdep2)
-- 
2.17.1


