Return-Path: <jpewhacker@gmail.com>
Received: from mail-it1-f195.google.com (mail-it1-f195.google.com
	[209.85.166.195])
	by mail.openembedded.org (Postfix) with ESMTP id AC1856C657;
	Tue,  4 Dec 2018 03:46:30 +0000 (UTC)
Received: by mail-it1-f195.google.com with SMTP id i7so13181776iti.2;
	Mon, 03 Dec 2018 19:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=fQjKHu3QcOeIXVq3VlMqIosIYEyaDWMaN3GgAS3Wq6c=;
	b=ab9h3R4Sq4wTN/E1xgDeOGAlUr8/IYAa478YyOidan32MZp4i7GJbFIHIrDeZdm0yx
	pul6vEHzYJ7eSlRGXw7DDlKW1g8raFMjauBDaMGKVKROiDhC+VQWyyPzk/BcEU+MTBlq
	pLFj0PL0zRw2lLE8uKV/RQbZdPLve2ONIjamfkk4K1laQWydBvXBviaPQBqvUXI6JYW7
	/JyT6cfjI6niQxFQXdAJtgPa8e/PBYfgZD36VPoT4mfMRZ8Mg+pUHh6wE8lyKoCaXeJi
	Oa4iOzkWmWSVnP5Aqhug8lZxlItxi6Fr+xab1fD7eAdrHyhDuP7lhZsE6EAk+yywvMh2
	SNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=fQjKHu3QcOeIXVq3VlMqIosIYEyaDWMaN3GgAS3Wq6c=;
	b=ZG1RaeYnXiByy8jfKuUZQb5FI2+yMutAEwobx1a7aqW+Fb7gZnDL+4swhBoPWiiINO
	QYO+0+UdD6ed2dfvp4aUA5VG9r8SaiY0OGgbu4lyMJmgeIBxlEj/o5/GoQIy6pc+aIE3
	5aPexSCR/aRLKxMOk//EV64kST4cdhoXqKUhw+xYLzHOyrn4DzvJSlKJXLsIzUYAwERC
	jnrytL2HC7AJHwB870M5DBjMasLlPZtevFiHNt28VGhA57wVJw+K/rd/5Nha2Qga6FEP
	qvnRKswMpl6tKu+j9pijtBz9+LeLlvtqBAvTGNt2zps7vn7DKzxKqTiXiSrkOskEpcg7
	JGcw==
X-Gm-Message-State: AA+aEWbeLFE28juQZfvHW+CIrFP65Tbhg1hcFMLDn8Me0jvuueHm9Gjd
	pRG9WGx/A6lcPbVEtBZarXnQ+42vI7A=
X-Google-Smtp-Source: AFSGD/UfbpPFbP532CMguKlzM9mXbdZzN5IUQ8UtFXu7eBQ8yDDUkQQgIgg3lI8nXyqN6pj9Z++CqQ==
X-Received: by 2002:a24:2912:: with SMTP id p18mr10160039itp.16.1543895191613; 
	Mon, 03 Dec 2018 19:46:31 -0800 (PST)
Received: from ola-842mrw1.ad.garmin.com ([204.77.163.55])
	by smtp.gmail.com with ESMTPSA id
	q23sm6216824ioi.66.2018.12.03.19.46.30
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Mon, 03 Dec 2018 19:46:30 -0800 (PST)
From: Joshua Watt <jpewhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: openembedded-core@lists.openembedded.org,
	bitbake-devel@lists.openembedded.org
Date: Mon,  3 Dec 2018 21:42:39 -0600
Message-Id: <20181204034245.25461-12-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181204034245.25461-1-JPEWhacker@gmail.com>
References: <20180809220840.26697-1-JPEWhacker@gmail.com>
	<20181204034245.25461-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Subject: [OE-core][PATCH v3 11/17] bitbake: runqueue: Track task dependency ID
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
X-List-Received-Date: Tue, 04 Dec 2018 03:46:31 -0000
Content-Transfer-Encoding: 8bit

Requests the task dependency ID from siggen and tracks it

[YOCTO #13030]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index f2b95a9829b..32dcd84e175 100644
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
@@ -2081,7 +2088,8 @@ class RunQueueExecuteTasks(RunQueueExecute):
                 deps = self.rqdata.runtaskentries[revdep].depends
                 provides = self.rqdata.dataCaches[mc].fn_provides[taskfn]
                 taskhash = self.rqdata.runtaskentries[revdep].hash
-                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash]
+                depid = self.rqdata.runtaskentries[revdep].depid
+                taskdepdata[revdep] = [pn, taskname, fn, deps, provides, taskhash, depid]
                 for revdep2 in deps:
                     if revdep2 not in taskdepdata:
                         additional.append(revdep2)
@@ -2524,7 +2532,8 @@ class RunQueueExecuteScenequeue(RunQueueExecute):
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
2.19.1


