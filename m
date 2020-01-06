Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
	[209.85.210.178])
	by mail.openembedded.org (Postfix) with ESMTP id 540857FCC7
	for <bitbake-devel@openembedded.org>;
	Mon,  6 Jan 2020 16:27:01 +0000 (UTC)
Received: by mail-pf1-f178.google.com with SMTP id p14so27175213pfn.4
	for <bitbake-devel@openembedded.org>;
	Mon, 06 Jan 2020 08:27:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=fKX7d5X/cvw+75ZMjBFcuvTYPTHQ86Z8fEA7fwiH1bg=;
	b=i3EF6dWBN9tki3syB+BnhDs93lAm138hOpLOeqUIcQ+UMskeXkwo+/k9Yrqoz+OdGm
	V3TBUV0oKUF/n/nbr77V/zjroFTnZLeYUgrGkWdT4nddV2uB7E1rzTHtBLkFp+clZr1q
	7ed2MUlhxEdX7CJVbbbEdfcAhtMDux/lpqwPxc5ZS8ZFhdZlJa2cfQ+tYEnvkZ2O6xT5
	+4G3FJTGVpYh/obpUq1ISv34VYsGrA2Jtc504EtOn9nywG0U/isn32VQI20y23/5NNoG
	j1iCVMEuHbpbndgHmfobUZnbpHnDdZh3yYLj6/7Z1QCOijyloruDAj0tSXk/gq+9Omc3
	yp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=fKX7d5X/cvw+75ZMjBFcuvTYPTHQ86Z8fEA7fwiH1bg=;
	b=MpaxuZordEoBzYag8O65iTZBgEScgC52uhKdrDNPxSQf7fU+5+KP0KsuVF2EqvcPOi
	dELhlqzCteY3b4czaet3MSFaX6AJ6caA1IpsbF6u7TkKHcsudPiR8Pg43fjB5ZmbhrZt
	9b46+pThPSjvnUQLmh684XEBzEWv+WNF0h6pgDe29cNjHYI79zf08e+qM+vcUXgbKUmy
	en+FzIJtf3xbZPMezFivWPLCMquyp7+tTjctrs6d6BK4Xw3GCh6ps8ps5RojdgViwQjt
	HK1ZUbWZowM//3meILhaz/BfUtnCAc/IjY0Po4AORJeeeSDLyZyKcpWfhkFiWv8u4vXM
	SN2g==
X-Gm-Message-State: APjAAAUF2u89qKAmJBBoLy8wmmH+CGVGQKe+2pqYONa04WHgFuDpgAkE
	LUMbVyPLb4vJqhexmKrC3Wyy+31i
X-Google-Smtp-Source: APXvYqwgo0IdBGFgcClh6HmiZtEZMuYhYLAcftNkPNsN2k8bLRfrWve+vsrizKGfZIRwQ4JVUDe0hg==
X-Received: by 2002:a63:2a06:: with SMTP id q6mr107031811pgq.92.1578328022147; 
	Mon, 06 Jan 2020 08:27:02 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:6832:e19c:36b9:d5e])
	by smtp.gmail.com with ESMTPSA id
	d3sm24538668pjx.16.2020.01.06.08.27.01
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 06 Jan 2020 08:27:01 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon,  6 Jan 2020 08:26:33 -0800
Message-Id: <c4ce216b4c5a1626764752edd21005750d05a0c2.1578327474.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578327474.git.akuster808@gmail.com>
References: <cover.1578327474.git.akuster808@gmail.com>
Subject: [1.44 12/25] siggen: Split get_tashhash for performance
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
X-List-Received-Date: Mon, 06 Jan 2020 16:27:01 -0000

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
index b3648ddb..515e9d43 100644
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
index 2fec8599..e484e5e3 100644
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
2.17.1


