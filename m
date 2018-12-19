Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f195.google.com (mail-it1-f195.google.com
	[209.85.166.195])
	by mail.openembedded.org (Postfix) with ESMTP id 5EC137BEAB;
	Wed, 19 Dec 2018 03:10:40 +0000 (UTC)
Received: by mail-it1-f195.google.com with SMTP id x124so9840354itd.1;
	Tue, 18 Dec 2018 19:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=dFNBwPqLWN4rf74yhLcG+OG1CRR4suOHe3oyurGq5dM=;
	b=K67z2PCXnTwvAhkvoiOBeNANXOdUi+5+lERDkkzFI2JhWrAbo0yJBCtQiOT826/e5h
	8pU6dm4u2UFRejanGJEE9QiUao6DKoR2Dxgly5IXEND6yIPkq2hX8/MwQFbQWAJXQl5D
	KaESQNxdlYEXCKBCkqan6c2m0k6wNuXzGAM3n3ZonvxP5auH/YtwT/SoXvzr1pVAEsEx
	R5GRcZF2tqgJXLzKJ8Y8m+N/80oebuFHVAhWRBkT8sT6lhyLf6CkOO4jxQXSGkRN0MFg
	9fXeXYDemr9kRilG4buSzpfUlPiBSv4oJnZMeZTGQNvudUbG4xCREd73/IHra34JQKCY
	r0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=dFNBwPqLWN4rf74yhLcG+OG1CRR4suOHe3oyurGq5dM=;
	b=ShyPevItdFVVZV43mB/aD2vq8XmzOZruK4vEBwpzH1rdLnkABJPo8h4v8N80NHVrDh
	VUSLF0bln09NdPD2jer3Ptit7RUCQnEia1awOfhLwcx/u/0DxN69VR0VQ1la86Uqr3g8
	THEVVwlbP267wq14f+fjvQxLPc0GmZdBftj+GwkjBYaYubpzMoWrg2Ooa2K0kxeHujtZ
	e1IXc1/beR8MocZu9ituNPNltGYGKWpwO22K7Lm4GIItgIYLaj0s0CSxWDVeG+dm2iA+
	ZyAVNSqmJyDUE4IBE+rwhlpBFtMx7D/r5wZFWn6ojh0SXDk5I/YVkXkWHGnjMVGyW2m8
	0FSQ==
X-Gm-Message-State: AA+aEWaX/oPPj2rV1fnUKoJXKEnx3ykBr2Ypvk4wNQXGmwznwxuadnDR
	VZXI7Y2+e//UUuiWNVmP2tDq60NY
X-Google-Smtp-Source: AFSGD/X8T7kh7GwCQVa9uvwEMMvUx8nGYLyxBzR4Ex752BawNTk8XAfl8PjphDqq7hERAs1gkb2+GA==
X-Received: by 2002:a24:9dce:: with SMTP id f197mr5208733itd.13.1545189041040; 
	Tue, 18 Dec 2018 19:10:41 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id r63sm2795992ita.2.2018.12.18.19.10.40
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 18 Dec 2018 19:10:40 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Tue, 18 Dec 2018 21:10:28 -0600
Message-Id: <20181219031033.28045-4-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181219031033.28045-1-JPEWhacker@gmail.com>
References: <20181218153101.9212-1-JPEWhacker@gmail.com>
	<20181219031033.28045-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v5 3/8] bitbake: runqueue: Track task unique hash
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
X-List-Received-Date: Wed, 19 Dec 2018 03:10:40 -0000
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


