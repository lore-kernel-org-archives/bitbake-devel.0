Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
	[209.85.210.175])
	by mail.openembedded.org (Postfix) with ESMTP id 5D9187F896
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Dec 2019 04:50:55 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id q10so8562926pfs.6
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 22 Dec 2019 20:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=gMs67D8Uhe3aVMcJuU3/DRNnuP9T63PhZNG9/cKAnko=;
	b=uVtm4OfyPpRORzPcbLdsPs2e1Co8JX9ZDpTBzW/lu/yqPsajkuuz/9L5BrRQnJwDwa
	lYQNxr1gxXHIHV3oN4YvCTEqFkMS6Oe0dqk+7v/HDAeB2DJnFz3PV6Kv7/4k3OciFxZE
	D2TV08/Nj4llV+BW3H1uoNoXMYzWIE3Eza8J3gOYzqQ+ncXO6dGrsQFqoiKMmNrEq3xc
	FLMvrzrjP9YDZnxR8qMTc58j5ZeA7uHaXOdDl+DqGwr28FKHKFfpSHngJ68iLyMa5+oM
	KuGfSixRFo5JcmV/9lz8bypLAkgXNokKW69lIkDQIhg4R9aco8nHXf6D3iPmLTzI6F5G
	QpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=gMs67D8Uhe3aVMcJuU3/DRNnuP9T63PhZNG9/cKAnko=;
	b=ZYT80o3eMpUtefHqIKTIltVODPKQdL9uetY2q/T/uNyBjNP6Fm+4eUpzGHbFUviUq7
	t0/K/HihgjCTd+dZOMAyb1ZL/WTyKK9+Btb+FPvYc/V2UqjcL8mR1rdHveFw/bhvIr6b
	u0i8F15Rf2yqygVMWe1U3IDhk/QcGMH5DLHYMoI6ZqllWEpnbUPNFAA2LAG/N64O5Ofz
	4yZtW0KyV9OlOlIPFdtl82unoVrUAG02DvqhL81dP/j7gY32cx58Gy4pEQZ4Vt8XgOit
	5/WJ16mF/CdoZQaEhQuA4ISrBzLpCTD6+qtGAADKJaQd7t9I9UAk/5CvEfiXd6h9oVee
	50VQ==
X-Gm-Message-State: APjAAAUBF8lS2DhD/+MfAuGRRgEk+Irpb8n+MjHa2KToxEvtVltoZM9x
	jeqTrWQVD7B1ZHy/Oc++broCuNU7Xf0=
X-Google-Smtp-Source: APXvYqzB4yCA7J1pPANlYrM+fl8f/j9lEqKx/L0RfGniOfVtRXenEtaSVnveIdkvZbhN4Cp7JmuRbA==
X-Received: by 2002:a62:28e:: with SMTP id 136mr15514861pfc.256.1577076656371; 
	Sun, 22 Dec 2019 20:50:56 -0800 (PST)
Received: from akuster-ThinkPad-T460s.hsd1.ca.comcast.net
	([2601:202:4180:a5c0:30f1:af1:c5e0:a746])
	by smtp.gmail.com with ESMTPSA id
	q11sm22276726pff.111.2019.12.22.20.50.55
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sun, 22 Dec 2019 20:50:56 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 22 Dec 2019 20:50:36 -0800
Message-Id: <c4ce216b4c5a1626764752edd21005750d05a0c2.1577076251.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1577076251.git.akuster808@gmail.com>
References: <cover.1577076251.git.akuster808@gmail.com>
Subject: [1.44 12/18] siggen: Split get_tashhash for performance
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
X-List-Received-Date: Mon, 23 Dec 2019 04:50:55 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

There are two operations happening in get_taskhash, the building of the
underlying data and the calculation of the hash.

Split these into two funtions since the preparation part doesn't need
to rerun when unihash changes, only the calculation does.

This split allows sigificant performance improvements for hashequiv
in builds where many hashes are equivalent and many hashes are changing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 6a32af2808d748819f4af55c443578c8a63062b3)
---
 lib/bb/runqueue.py |  1 +
 lib/bb/siggen.py   | 33 ++++++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b3648dd..515e9d4 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1185,6 +1185,7 @@ class RunQueueData:
         procdep = []
         for dep in self.runtaskentries[tid].depends:
             procdep.append(dep)
+        bb.parse.siggen.prep_taskhash(tid, procdep, self.dataCaches[mc_from_tid(tid)])
         self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, procdep, self.dataCaches[mc_from_tid(tid)])
         self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(tid)
 
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 2fec859..e484e5e 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -52,6 +52,9 @@ class SignatureGenerator(object):
     def get_unihash(self, tid):
         return self.taskhash[tid]
 
+    def prep_taskhash(self, tid, deps, dataCache):
+        return
+
     def get_taskhash(self, tid, deps, dataCache):
         self.taskhash[tid] = hashlib.sha256(tid.encode("utf-8")).hexdigest()
         return self.taskhash[tid]
@@ -198,12 +201,11 @@ class SignatureGeneratorBasic(SignatureGenerator):
             pass
         return taint
 
-    def get_taskhash(self, tid, deps, dataCache):
+    def prep_taskhash(self, tid, deps, dataCache):
 
         (mc, _, task, fn) = bb.runqueue.split_tid_mcfn(tid)
 
-        data = dataCache.basetaskhash[tid]
-        self.basehash[tid] = data
+        self.basehash[tid] = dataCache.basetaskhash[tid]
         self.runtaskdeps[tid] = []
         self.file_checksum_values[tid] = []
         recipename = dataCache.pkg_fn[fn]
@@ -216,7 +218,6 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 continue
             if dep not in self.taskhash:
                 bb.fatal("%s is not in taskhash, caller isn't calling in dependency order?" % dep)
-            data = data + self.get_unihash(dep)
             self.runtaskdeps[tid].append(dep)
 
         if task in dataCache.file_checksums[fn]:
@@ -226,27 +227,41 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename)
             for (f,cs) in checksums:
                 self.file_checksum_values[tid].append((f,cs))
-                if cs:
-                    data = data + cs
 
         taskdep = dataCache.task_deps[fn]
         if 'nostamp' in taskdep and task in taskdep['nostamp']:
             # Nostamp tasks need an implicit taint so that they force any dependent tasks to run
             if tid in self.taints and self.taints[tid].startswith("nostamp:"):
                 # Don't reset taint value upon every call
-                data = data + self.taints[tid][8:]
+                pass
             else:
                 import uuid
                 taint = str(uuid.uuid4())
-                data = data + taint
                 self.taints[tid] = "nostamp:" + taint
 
         taint = self.read_taint(fn, task, dataCache.stamp[fn])
         if taint:
-            data = data + taint
             self.taints[tid] = taint
             logger.warning("%s is tainted from a forced run" % tid)
 
+        return
+
+    def get_taskhash(self, tid, deps, dataCache):
+
+        data = self.basehash[tid]
+        for dep in self.runtaskdeps[tid]:
+            data = data + self.get_unihash(dep)
+
+        for (f, cs) in self.file_checksum_values[tid]:
+            if cs:
+                data = data + cs
+
+        if tid in self.taints:
+            if self.taints[tid].startswith("nostamp:"):
+                data = data + self.taints[tid][8:]
+            else:
+                data = data + self.taints[tid]
+
         h = hashlib.sha256(data.encode("utf-8")).hexdigest()
         self.taskhash[tid] = h
         #d.setVar("BB_TASKHASH_task-%s" % task, taskhash[task])
-- 
2.7.4


