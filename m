Return-Path: <jpewhacker@gmail.com>
Received: from mail-it0-f48.google.com (mail-it0-f48.google.com
	[209.85.214.48])
	by mail.openembedded.org (Postfix) with ESMTP id E753578EB4;
	Thu,  9 Aug 2018 22:10:51 +0000 (UTC)
Received: by mail-it0-f48.google.com with SMTP id v71-v6so147795itb.3;
	Thu, 09 Aug 2018 15:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=IKroHTo+VyfX10aQZ6AUj+NxrNafNmybQR2kbhPTES8=;
	b=S77tbPuq+RN+LAkE6VPUg0FN60mclr+h/zw7Ll5cBzOkDRNt6ffVluyknE8j/4HtJz
	lZ9nRc2FcCpQ5Y7EuXkc/AyZR09li+ccoXDwYsOZXqp/blIw7Mra0XFpSKbvH+4gHdAV
	JtuY1oaLI5wPiBM/RK22ZGOJoWgyfSCp6jbnXhCUXcuLnKw6u8bpch6Ph9IGs+qJhaQR
	FV/mylV3+/Z0+eDgGv5RsXcdWE3q6mRuMj3nQECWLgome38tjA/DaLCdYTkXVK0cxwX+
	/HBs2lpF8G4H1iFJ7WF98ObuieoSlqTfRHDc+w3sZKwQb7tjjsmkCv1afzs5W4dS+64l
	/+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=IKroHTo+VyfX10aQZ6AUj+NxrNafNmybQR2kbhPTES8=;
	b=XwD/w4LXv4xQ/2hCK834T8rgcIMEg3765FzxatGwrPlCTWyo4C4XJ0DwtB5hoxokyq
	F7nbb9Aq/D1GWYMWaKvOYa3385iaWGAbum/vmY8IclBUBDwgeSNUSaF+Sw7qb9cxtxt1
	99ZU17sK+E0kb0JYSXrxPNjxqGrSFk5RlqhSm5m7CFNPaeRGFMkNchCR8EHD62S4A6fi
	cHUMRtjy8nvS70s+nKEY/yvxvvdgTOH5via+dycL6Ms4/A2IW3pdUquh1HByXnPyumI6
	LXv37mzmMK66baw/Y0zeiHFz1uONLXEXb3EblTwQSRAy1gkWDaHt60HKlQ96jJD1b2rS
	IyNw==
X-Gm-Message-State: AOUpUlEugB38SG1TOVt+mv5HPNVuowdsrOhIgvRulo/laizTSnw2Qg5U
	Qb+jMtqsWJlKKF8qd18CLFpKhvEi
X-Google-Smtp-Source: AA+uWPx5nJdyk23CU/NFFoUjPnrkfFBXVJSWRGDKm8OftLylJ7KBt1WQw4mbsju1q/KK3GfWEdQkAg==
X-Received: by 2002:a02:4c9b:: with SMTP id
	q27-v6mr3413951jad.38.1533852653000; 
	Thu, 09 Aug 2018 15:10:53 -0700 (PDT)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	z3-v6sm4404573ioz.85.2018.08.09.15.10.52
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 09 Aug 2018 15:10:52 -0700 (PDT)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Date: Thu,  9 Aug 2018 17:08:35 -0500
Message-Id: <20180809220840.26697-12-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180809220840.26697-1-JPEWhacker@gmail.com>
References: <20180716203728.23078-1-JPEWhacker@gmail.com>
	<20180809220840.26697-1-JPEWhacker@gmail.com>
Subject: [RFC v2 11/16] bitbake: runqueue: Track task dependency ID
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
X-List-Received-Date: Thu, 09 Aug 2018 22:10:52 -0000

Requests the task dependency ID from siggen and tracks it

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index b173cc0a951..3ae12d8e69f 100644
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
+        self.runtaskentries[tid].depid = bb.parse.siggen.get_depid(fn + "." + taskname)
+
     def dump_data(self):
         """
         Dump some debug information on the internal data structures
@@ -2075,7 +2082,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 deps = self.rqdata.runtaskentries[revdep].depends
                 provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
                 taskhash = self.rqdata.runtaskentries[revdep].hash
-                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash]
+                depid = self.rqdata.runtaskentries[revdep].depid
+                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, depid]
                 for revdep2 in deps:
                     if revdep2 not in taskdepdata:
                         additional.append(revdep2)
@@ -2517,7 +2525,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
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


