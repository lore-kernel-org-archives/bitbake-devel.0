Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
	[209.85.210.182])
	by mail.openembedded.org (Postfix) with ESMTP id 19A1060F3C
	for <bitbake-devel@openembedded.org>;
	Sun,  9 Feb 2020 16:03:21 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id y73so2423238pfg.2
	for <bitbake-devel@openembedded.org>;
	Sun, 09 Feb 2020 08:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=WMXjOfphD+RTQDjpGHNTi9q42NX3RyuPjJiVhZGr2pE=;
	b=WzbQUyDGWXQWpskZdPYiP1oUA1ShPdDVpeatpVOME9sVsxanhpJH/6yDTYmN/G5LJu
	dICSQ+52NNnzKG41jYpuWGFcubnUntCshNpQwFhlAvh6F/xjyAOdycKeKEvohWbvn3Cx
	/w4VxafNR9UYdjKwjqQltYuCvcixQlAmvQJi0UrtTsQfVx99d4zdrLtXOQZa357a6Btc
	4hXM5YIo23Qr369v/kQZYZ0LPdpFvcV8Eltk8r4M7nyOaKpijB0zJsI0JasVti1BMb3C
	It3zanXUENQ6fGpkJ91mGsAlLeaDmNAigJn8vYUHWATTyWX3GqJFLqryJR03uy4KsDSN
	NG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=WMXjOfphD+RTQDjpGHNTi9q42NX3RyuPjJiVhZGr2pE=;
	b=mmFCEk3XVbLkn90dnVOiw9vTO9hlTGHN+sM2qSIn3hWSI2eIooy3q8t4qNCJ7vLYbU
	n8ZAHk/kv+Am1ERJFPZuIismj9R/vEkNtBcNqssVqcmf/L40k7XlIypPqwGdTUBLl+3j
	qPE6MOJ54nooQ+ULcEZX1JzZ6Vx1nsUerAJQc4qr+NDJ9KBER6rLb6BIb1PP7fZXLnfy
	MfN2hvqwpQptJ6rBTM8ErQ3Eo+kHn9uzZ8wTcUdLU3jC3x8SYLNhFpuvz4lso5XTbu6s
	dRE/jM2dQ5KoVDyW7exxSdSh+oROc0pVbahmYF2mpK1cnMnmHgoqec7KrmOnkeDPXNLA
	1//g==
X-Gm-Message-State: APjAAAUz2Q3ozd43JkZl3twCw7eC4IUTv5jQpg4fLy1vGOvREOvGUvzF
	x74iihqcJ94jdlG98E8v2gymeKQ/
X-Google-Smtp-Source: APXvYqxsLQrt3WfcgoNo6u7Y+A/UWyR41zGUW7HBdMUscdM9ERlzspoeEOTNr3m9LYTHdToXPnhlxg==
X-Received: by 2002:a63:3305:: with SMTP id z5mr5778469pgz.319.1581264202809; 
	Sun, 09 Feb 2020 08:03:22 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:154b:3780:5122:4aa9])
	by smtp.gmail.com with ESMTPSA id d3sm8529353pjx.10.2020.02.09.08.03.22
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sun, 09 Feb 2020 08:03:22 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Sun,  9 Feb 2020 08:03:13 -0800
Message-Id: <8f4f6c2f9acab23bc795ffe389c4cd74711d10ff.1581264053.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1581264053.git.akuster808@gmail.com>
References: <cover.1581264053.git.akuster808@gmail.com>
Subject: [1.44 5/7] siggen: Optimise get_unihash disk based cache handling
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
X-List-Received-Date: Sun, 09 Feb 2020 16:03:22 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

Currently the cache can grow huge since any previously used hash is
retained in the cache. This change moves to use one hash per task
which improves the speed of the functions considerably. Currently
performance is an issue, as are very large cache files and cache
load time.

By moving to a single hash per task, the shorted filename as a key
is no longer usable as the same recipe has multiple variants for
the same filename so this has to change.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit ed764e7fcf04b6d0ba6b4cac7415b1ee8f492865)
Signed-off-by: Armin Kuster <akuster808@gmail.com>
---
 lib/bb/siggen.py | 50 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index ded1da02..209a3428 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -44,6 +44,7 @@ class SignatureGenerator(object):
         self.file_checksum_values = {}
         self.taints = {}
         self.unitaskhashes = {}
+        self.tidtopn = {}
         self.setscenetasks = set()
 
     def finalise(self, fn, d, varient):
@@ -79,19 +80,19 @@ class SignatureGenerator(object):
         return
 
     def get_taskdata(self):
-        return (self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints, self.basehash, self.unitaskhashes, self.setscenetasks)
+        return (self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints, self.basehash, self.unitaskhashes, self.tidtopn, self.setscenetasks)
 
     def set_taskdata(self, data):
-        self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints, self.basehash, self.unitaskhashes, self.setscenetasks = data
+        self.runtaskdeps, self.taskhash, self.file_checksum_values, self.taints, self.basehash, self.unitaskhashes, self.tidtopn, self.setscenetasks = data
 
     def reset(self, data):
         self.__init__(data)
 
     def get_taskhashes(self):
-        return self.taskhash, self.unitaskhashes
+        return self.taskhash, self.unitaskhashes, self.tidtopn
 
     def set_taskhashes(self, hashes):
-        self.taskhash, self.unitaskhashes = hashes
+        self.taskhash, self.unitaskhashes, self.tidtopn = hashes
 
     def save_unitaskhashes(self):
         return
@@ -124,9 +125,10 @@ class SignatureGeneratorBasic(SignatureGenerator):
         else:
             self.checksum_cache = None
 
-        self.unihash_cache = bb.cache.SimpleCache("1")
+        self.unihash_cache = bb.cache.SimpleCache("3")
         self.unitaskhashes = self.unihash_cache.init_cache(data, "bb_unihashes.dat", {})
         self.localdirsexclude = (data.getVar("BB_SIGNATURE_LOCAL_DIRS_EXCLUDE") or "CVS .bzr .git .hg .osc .p4 .repo .svn").split()
+        self.tidtopn = {}
 
     def init_rundepcheck(self, data):
         self.taskwhitelist = data.getVar("BB_HASHTASK_WHITELIST") or None
@@ -210,6 +212,9 @@ class SignatureGeneratorBasic(SignatureGenerator):
         self.runtaskdeps[tid] = []
         self.file_checksum_values[tid] = []
         recipename = dataCache.pkg_fn[fn]
+
+        self.tidtopn[tid] = recipename
+
         for dep in sorted(deps, key=clean_basepath):
             (depmc, _, deptaskname, depfn) = bb.runqueue.split_tid_mcfn(dep)
             if mc != depmc:
@@ -407,24 +412,35 @@ class SignatureGeneratorUniHashMixIn(object):
             self._client = hashserv.create_client(self.server)
         return self._client
 
-    def __get_task_unihash_key(self, tid):
-        # TODO: The key only *needs* to be the taskhash, the tid is just
-        # convenient
-        return '%s:%s' % (tid.rsplit("/", 1)[1], self.taskhash[tid])
-
     def get_stampfile_hash(self, tid):
         if tid in self.taskhash:
             # If a unique hash is reported, use it as the stampfile hash. This
             # ensures that if a task won't be re-run if the taskhash changes,
             # but it would result in the same output hash
-            unihash = self.unitaskhashes.get(self.__get_task_unihash_key(tid), None)
+            unihash = self._get_unihash(tid)
             if unihash is not None:
                 return unihash
 
         return super().get_stampfile_hash(tid)
 
     def set_unihash(self, tid, unihash):
-        self.unitaskhashes[self.__get_task_unihash_key(tid)] = unihash
+        (mc, fn, taskname, taskfn) = bb.runqueue.split_tid_mcfn(tid)
+        key = mc + ":" + self.tidtopn[tid] + ":" + taskname
+        self.unitaskhashes[key] = (self.taskhash[tid], unihash)
+
+    def _get_unihash(self, tid, checkkey=None):
+        if tid not in self.tidtopn:
+            return None
+        (mc, fn, taskname, taskfn) = bb.runqueue.split_tid_mcfn(tid)
+        key = mc + ":" + self.tidtopn[tid] + ":" + taskname
+        if key not in self.unitaskhashes:
+            return None
+        if not checkkey:
+            checkkey = self.taskhash[tid]
+        (key, unihash) = self.unitaskhashes[key]
+        if key != checkkey:
+            return None
+        return unihash
 
     def get_unihash(self, tid):
         taskhash = self.taskhash[tid]
@@ -433,11 +449,9 @@ class SignatureGeneratorUniHashMixIn(object):
         if self.setscenetasks and tid not in self.setscenetasks:
             return taskhash
 
-        key = self.__get_task_unihash_key(tid)
-
         # TODO: This cache can grow unbounded. It probably only needs to keep
         # for each task
-        unihash = self.unitaskhashes.get(key, None)
+        unihash =  self._get_unihash(tid)
         if unihash is not None:
             return unihash
 
@@ -472,7 +486,7 @@ class SignatureGeneratorUniHashMixIn(object):
         except hashserv.client.HashConnectionError as e:
             bb.warn('Error contacting Hash Equivalence Server %s: %s' % (self.server, str(e)))
 
-        self.unitaskhashes[key] = unihash
+        self.set_unihash(tid, unihash)
         return unihash
 
     def report_unihash(self, path, task, d):
@@ -484,13 +498,13 @@ class SignatureGeneratorUniHashMixIn(object):
         tempdir = d.getVar('T')
         fn = d.getVar('BB_FILENAME')
         tid = fn + ':do_' + task
-        key = tid.rsplit("/", 1)[1] + ':' + taskhash
+        key = tid + ':' + taskhash
 
         if self.setscenetasks and tid not in self.setscenetasks:
             return
 
         # Sanity checks
-        cache_unihash = self.unitaskhashes.get(key, None)
+        cache_unihash = self._get_unihash(tid, checkkey=taskhash)
         if cache_unihash is None:
             bb.fatal('%s not in unihash cache. Please report this error' % key)
 
-- 
2.17.1


