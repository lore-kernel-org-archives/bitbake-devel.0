Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
	[209.85.221.49])
	by mail.openembedded.org (Postfix) with ESMTP id E1B177F948
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Dec 2019 16:13:34 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id c14so7234989wrn.7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Dec 2019 08:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=aMJls9K0zWQQkJpLLaump1FdC778v2w6guEEhommSJA=;
	b=ZT3IGE9s43FH/YunXRarKs+GOhpebzqLLxcLLSzbnsyb3BXx9xmQnigdwM2+pgDTY0
	oodh7hOfL4ZO5CgV9AWXm9DUMlMR7xEJ75yXW5WyyBRe4tV5WO4vKNK4fv4XNn4hTASG
	SF9p15NAaeAkgaWaQrwtb/mouxA4qHu2HG0Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=aMJls9K0zWQQkJpLLaump1FdC778v2w6guEEhommSJA=;
	b=JqrTBwYdHCr45aLiOEWjgsDjYb6iRtZrUojjhTXe3V4UtVfi9xhni/3L6Am+XoT+e/
	j4IfOmAYJYFKH7zxrj2L7rjy0iKrXzcSusO7D9KjuWerFkFZk81MyhAM9q8j0YGP7Aw9
	uuOiWT2CaDonJ2kGl91Nf0z8Oh1BE0aFasdbF40UsmQd5fFYQXSJPah49U7Q2ILUXYGF
	sq/L+2cQ7KpkLtOQYju19okna0g8NCP0MsGzFBO0ZQBz8HELvoq0Z15Ymj/PqJEZctBg
	9B5ukQsNrGfPbfQDSAI1J3AzArpIPP3scBPcNTAk9fmS9b+o7YYxEIG9+h1rkvnBPtq+
	5JTA==
X-Gm-Message-State: APjAAAUHFCC/Ca0HxKSvalwBhG5N5PfqrOQ5Ge32s1rt8EqOGJIIRLzM
	VqWPZG/GPD1JSZFa5gChgfPwpyypepo=
X-Google-Smtp-Source: APXvYqyx8jrj24OOxfL3hsOAub3uPgO1Oiu1ka/f8/q2cHgNP47v/MqKLoK427hGJdRcjF66QS0Bvw==
X-Received: by 2002:a05:6000:50:: with SMTP id
	k16mr13508614wrx.145.1576253615293; 
	Fri, 13 Dec 2019 08:13:35 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	s8sm10215648wrt.57.2019.12.13.08.13.34
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Fri, 13 Dec 2019 08:13:34 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Dec 2019 16:13:32 +0000
Message-Id: <20191213161332.28125-2-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213161332.28125-1-richard.purdie@linuxfoundation.org>
References: <20191213161332.28125-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Subject: [PATCH 2/2] siggen: Split get_tashhash for performance
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
X-List-Received-Date: Fri, 13 Dec 2019 16:13:35 -0000
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
index bbd585306c..2829247d94 100644
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
index dbf510238f..5c1301d24f 100644
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


