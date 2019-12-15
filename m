Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
	[209.85.221.44])
	by mail.openembedded.org (Postfix) with ESMTP id BA08D7F7C0
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Dec 2019 09:41:16 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id z3so3532210wru.3
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 15 Dec 2019 01:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=f1QaFqa3nGzDdsx0nI7+2DSCzUqugko8PG01nHbFK7g=;
	b=geHj0MtYb71xASMg40Oqh9JLHEKJuON2WqujzExRpYkBR4CxDBH9i1ld6h4W3ILH2c
	xM5nVa6v6oEglcQmkLVUOZ7G5ZkKSPiKAd2Yusu5johtFep9ea4UAR0IdoHbVcozThCG
	7sCq4FDmYuQ1bTIkgJ6wL3aB9ByvRRofQh7/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=f1QaFqa3nGzDdsx0nI7+2DSCzUqugko8PG01nHbFK7g=;
	b=dESrhuk7kzAbulUbGCIehDp9bbEBmWttcaWNJerP79lHS+F+Fd0m0piJuE733xrGB+
	6FXGtg52oR7GtIF36efN6l2GUmDBefdMKxe/Rn2oG6FbBP9VOqeCFGM/IYrDhpAyE9z+
	XCI7tK+Vb5cXdtjj5po82dW90Hk67TaBa8Bec24i2O5WRpV51YRj806Qf1CEo1pIv8kp
	4CESeLBeRWvtvFbeRZ997KCly2PF9Q2fKGKo2XTPE3KnQl7WF7qwNLZOMtsFmCcePDmi
	mDLZLrVj6I1ylIOGWwomJchd9kOTTLA0hI24mcYIieMRyQ2oTAMhYXLvZVgq66MpFvP6
	A0CA==
X-Gm-Message-State: APjAAAW3ALBAjNl0llbD0L5PDtavbQ7j3sj0pcngITDbQmNO6f0O2got
	BSadu9A2GX39aI1JYraFySeuTxkNJgI=
X-Google-Smtp-Source: APXvYqy3ikPvBvId1bjhp+R7pHD5j74RTjEFGuMHxM6syb6ueeez3I4JQSXDi1/+CADYjh4GCp52tg==
X-Received: by 2002:a05:6000:118e:: with SMTP id
	g14mr23608888wrx.39.1576402877014; 
	Sun, 15 Dec 2019 01:41:17 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	e8sm16877572wrt.7.2019.12.15.01.41.15
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 15 Dec 2019 01:41:16 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 15 Dec 2019 09:41:10 +0000
Message-Id: <20191215094112.28162-3-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191215094112.28162-1-richard.purdie@linuxfoundation.org>
References: <20191215094112.28162-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 3/5] siggen: Split get_tashhash for performance
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
X-List-Received-Date: Sun, 15 Dec 2019 09:41:17 -0000
Content-Transfer-Encoding: 8bit

There are two operations happening in get_taskhash, the building of the
underlying data and the calculation of the hash.

Split these into two funtions since the preparation part doesn't need
to rerun when unihash changes, only the calculation does.

This split allows sigificant performance improvements for hashequiv
in builds where many hashes are equivalent and many hashes are changing.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py |  1 +
 lib/bb/siggen.py   | 33 ++++++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index b3648ddb54..515e9d4314 100644
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
index 2fec8599b3..e484e5e37d 100644
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
2.20.1


