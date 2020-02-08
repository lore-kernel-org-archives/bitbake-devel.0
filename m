Return-Path: <richard.purdie@linuxfoundation.org>
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
	[209.85.128.42])
	by mail.openembedded.org (Postfix) with ESMTP id A29A760EAD
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  8 Feb 2020 16:01:12 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id s10so5481542wmh.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 08 Feb 2020 08:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linuxfoundation.org; s=google;
	h=from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=EdQU4A8JsxcLsdkn+m20F2v47E6ggxi41CMAQh+VmsI=;
	b=fjohJ62a2o7rY0Fy04lb54MgkQmE5fdJO4NXPSkXdmdAUsACxfW/uq2NIy8lO6ocaf
	frjc31yrBmV3241H057oLQOV51I5uXCFeecsZ9iWZzHWw7uEMeGZgjSJ2aAdnnK1oBwv
	YnRyyi6fuZLYQacJ24MJ4gHmNSXIknPCZAyic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=EdQU4A8JsxcLsdkn+m20F2v47E6ggxi41CMAQh+VmsI=;
	b=e8hBQI7FRs4z7LgCa7ESQWPX9oBhptkvsybPhrPIqO5fy6t7K4UaNY2WpjqYPWjJVT
	Eg1wT9Jyoznmu2Eu1VvEBQwItUemi8OzL5Oyf3Ac/+yhdgP+9Lie1GEyy36OIacJ4txg
	ROEW5K5lFVQJoiFjdJYU3V+CECPBBO4C0CdC0quA/lf2ebYDP3OM/HBstQedElPeiPeM
	elUHPD5XR91hhc7tn0JOoRL/qeIwSDpUZdCmJBFYdTfyXKFfGP1wH6YqF350JhyUGr5k
	T8Kq77t5g0WrI6JkgxLewe11fsGb6/ll9l+hXxVGxm+A1JEW016DACjTb+29j43AoTWX
	cC1w==
X-Gm-Message-State: APjAAAVGO8e43Ok1aQz5XYvAOcNZckzJYwOAgbSEBbr0uUY9HWd2+i+6
	KvzXE+y0Bz1FO9S8Z6AXgOrZRZioTNE=
X-Google-Smtp-Source: APXvYqx6LgNFydAThezjdiCf8VnaCbX/kLGnf7WgGiHLfATn/dNSYE61Az5T33NqnuOuWgu6jy7E1g==
X-Received: by 2002:a7b:c8d7:: with SMTP id f23mr4795002wml.173.1581177672785; 
	Sat, 08 Feb 2020 08:01:12 -0800 (PST)
Received: from hex.int.rpsys.net (5751f4a1.skybroadband.com. [87.81.244.161])
	by smtp.gmail.com with ESMTPSA id
	s23sm2512996wra.15.2020.02.08.08.01.11
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Sat, 08 Feb 2020 08:01:12 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Sat,  8 Feb 2020 16:01:09 +0000
Message-Id: <20200208160111.13305-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 1/3] siggen: Optimise get_unihash disk based cache handling
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
X-List-Received-Date: Sat, 08 Feb 2020 16:01:13 -0000
Content-Transfer-Encoding: 8bit

Currently the cache can grow huge since any previously used hash is
retained in the cache. This change moves to use one hash per task
which improves the speed of the functions considerably. Currently
performance is an issue, as are very large cache files and cache
load time.

By moving to a single hash per task, the shorted filename as a key
is no longer usable as the same recipe has multiple variants for
the same filename so this has to change.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/siggen.py | 50 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index ded1da020f..209a342883 100644
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
2.20.1


