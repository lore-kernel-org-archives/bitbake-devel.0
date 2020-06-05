Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
 by mx.groups.io with SMTP id smtpd.web11.1054.1591381081160475430
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 05 Jun 2020 11:18:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20161025 header.b=hqLoX7Q4;
 spf=pass (domain: gmail.com, ip: 209.85.214.193, mailfrom: jpewhacker@gmail.com)
Received: by mail-pl1-f193.google.com with SMTP id n2so4016777pld.13;
        Fri, 05 Jun 2020 11:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x328SfdN0JJXUqAHB9Nyce+TqCPyHOsWpxsjKMH+y9U=;
        b=hqLoX7Q4bBlwFNXqvUGPY1qZdqdzWbFnr7C3BmHfBCma1KoToTtlf5x+8Fp302E/bO
         vjlFmcQ6iaR2OQ5PNnNKlzzbKewnhX0PfqepVM85NAWdnZfDjZLo6OuMmrd4kVMPKS+q
         xILsQD0wUs2hEjC34QERp+4pYZffmG7NkvfoeyHjuT3r/NR1PZjKkNqWkHgOYab4m6Ju
         pVgqx0ZBFMZJGqYnLNCGPeh4hMI491B5/XjxEF35oBFVPj2rjv5mKikVF2CbZx8TXrxP
         l9k0uco4X/HbxYsfA+dllpjYnKx6lDeWVUWIWwHLjb9y5+RpwMp7OzQ8j2tOusYz7Qju
         2TWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x328SfdN0JJXUqAHB9Nyce+TqCPyHOsWpxsjKMH+y9U=;
        b=ofSe+7rs7QmO2jzPr4T7R3mttFhWoOPHTa93F16JA9PNBOH82yjwzh7NMusHcduCaS
         mN6aLMiwstwtWr75SfwcpxkEFq1h09f8UB+MEmmGPM/bqmVAEEYB3Wg4tL7gJG2u9Jlt
         kwkGrLKhmOPeBqV1ZGyAOsgeoKMrz7eC3P5yaM7r7JNGBljqWqnu+SxnySGGFpqeYS13
         M63/dcDENe3q4/vbqxQp9yYGtE4l76nndBo1zG6EipQUiDz1nwQfkzJKDIxDlcLvV7Aj
         N9zn3fTEskueTvemS+jdbOySXa9nVdVMXRNF2fmvpDC8YnCPbhHq11Jw57quqDLWeIrj
         kkyg==
X-Gm-Message-State: AOAM533o4T4ira7KBxxLHKhIXJ+HoytWku0wVBfb7NLIPq6+o9V/LOaG
	7ybMHMPVTbvM0xanawiXOqLvu+8OwIk=
X-Google-Smtp-Source: ABdhPJy0mDHjp6AQ9WHSMj/tZ1mEb8USIczZP/wgOADVm0zsaGcTKCjxVoK5W2yhaEhMzwmQLxuv9w==
X-Received: by 2002:a17:90a:f011:: with SMTP id bt17mr4450302pjb.179.1591381080249;
        Fri, 05 Jun 2020 11:18:00 -0700 (PDT)
Return-Path: <jpewhacker@gmail.com>
Received: from localhost.localdomain ([2605:a601:ac3d:c100:28:333f:5748:fb55])
        by smtp.gmail.com with ESMTPSA id g21sm246096pfh.134.2020.06.05.11.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:17:59 -0700 (PDT)
From: "Joshua Watt" <JPEWhacker@gmail.com>
X-Google-Original-From: Joshua Watt <JPEWhacker@gmail.com>
To: bitbake-devel@lists.openembedded.org,
	openembedded-core@lists.openembedded.org
Cc: Joshua Watt <JPEWhacker@gmail.com>
Subject: [RFC PATCH 1/3] bitbake: siggen: Pass all data caches to hash functions
Date: Fri,  5 Jun 2020 13:17:52 -0500
Message-Id: <20200605181754.32883-2-JPEWhacker@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605181754.32883-1-JPEWhacker@gmail.com>
References: <20200605181754.32883-1-JPEWhacker@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Passing all the data caches to the task hashing functions allows them to
correctly account for mcdepends in task signatures. This allows tasks to
be correctly re-run when a mcdepends changes.

[YOCTO #13724]

Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
---
 bitbake/lib/bb/runqueue.py |  6 +++---
 bitbake/lib/bb/siggen.py   | 32 +++++++++++++++-----------------
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 5b7dab8d79..372df63593 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -1190,8 +1190,8 @@ class RunQueueData:
         return len(self.runtaskentries)
 
     def prepare_task_hash(self, tid):
-        bb.parse.siggen.prep_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches[mc_from_tid(tid)])
-        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches[mc_from_tid(tid)])
+        bb.parse.siggen.prep_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
+        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
         self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(tid)
 
     def dump_data(self):
@@ -2305,7 +2305,7 @@ class RunQueueExecute:
                 if len(self.rqdata.runtaskentries[p].depends) and not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
                     continue
                 orighash = self.rqdata.runtaskentries[tid].hash
-                newhash = bb.parse.siggen.get_taskhash(tid, self.rqdata.runtaskentries[tid].depends, self.rqdata.dataCaches[mc_from_tid(tid)])
+                newhash = bb.parse.siggen.get_taskhash(tid, self.rqdata.runtaskentries[tid].depends, self.rqdata.dataCaches)
                 origuni = self.rqdata.runtaskentries[tid].unihash
                 newuni = bb.parse.siggen.get_unihash(tid)
                 # FIXME, need to check it can come from sstate at all for determinism?
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 4c8d81c5da..cffd0fa76d 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -58,10 +58,10 @@ class SignatureGenerator(object):
     def get_unihash(self, tid):
         return self.taskhash[tid]
 
-    def prep_taskhash(self, tid, deps, dataCache):
+    def prep_taskhash(self, tid, deps, dataCaches):
         return
 
-    def get_taskhash(self, tid, deps, dataCache):
+    def get_taskhash(self, tid, deps, dataCaches):
         self.taskhash[tid] = hashlib.sha256(tid.encode("utf-8")).hexdigest()
         return self.taskhash[tid]
 
@@ -200,7 +200,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
         self.lookupcache = {}
         self.taskdeps = {}
 
-    def rundep_check(self, fn, recipename, task, dep, depname, dataCache):
+    def rundep_check(self, fn, recipename, task, dep, depname, dataCaches):
         # Return True if we should keep the dependency, False to drop it
         # We only manipulate the dependencies for packages not in the whitelist
         if self.twl and not self.twl.search(recipename):
@@ -218,37 +218,35 @@ class SignatureGeneratorBasic(SignatureGenerator):
             pass
         return taint
 
-    def prep_taskhash(self, tid, deps, dataCache):
+    def prep_taskhash(self, tid, deps, dataCaches):
 
         (mc, _, task, fn) = bb.runqueue.split_tid_mcfn(tid)
 
-        self.basehash[tid] = dataCache.basetaskhash[tid]
+        self.basehash[tid] = dataCaches[mc].basetaskhash[tid]
         self.runtaskdeps[tid] = []
         self.file_checksum_values[tid] = []
-        recipename = dataCache.pkg_fn[fn]
+        recipename = dataCaches[mc].pkg_fn[fn]
 
         self.tidtopn[tid] = recipename
 
         for dep in sorted(deps, key=clean_basepath):
-            (depmc, _, deptaskname, depfn) = bb.runqueue.split_tid_mcfn(dep)
-            if mc != depmc:
-                continue
-            depname = dataCache.pkg_fn[depfn]
-            if not self.rundep_check(fn, recipename, task, dep, depname, dataCache):
+            (depmc, _, _, depmcfn) = bb.runqueue.split_tid_mcfn(dep)
+            depname = dataCaches[depmc].pkg_fn[depmcfn]
+            if not self.rundep_check(fn, recipename, task, dep, depname, dataCaches):
                 continue
             if dep not in self.taskhash:
                 bb.fatal("%s is not in taskhash, caller isn't calling in dependency order?" % dep)
             self.runtaskdeps[tid].append(dep)
 
-        if task in dataCache.file_checksums[fn]:
+        if task in dataCaches[mc].file_checksums[fn]:
             if self.checksum_cache:
-                checksums = self.checksum_cache.get_checksums(dataCache.file_checksums[fn][task], recipename, self.localdirsexclude)
+                checksums = self.checksum_cache.get_checksums(dataCaches[mc].file_checksums[fn][task], recipename, self.localdirsexclude)
             else:
-                checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename, self.localdirsexclude)
+                checksums = bb.fetch2.get_file_checksums(dataCaches[mc].file_checksums[fn][task], recipename, self.localdirsexclude)
             for (f,cs) in checksums:
                 self.file_checksum_values[tid].append((f,cs))
 
-        taskdep = dataCache.task_deps[fn]
+        taskdep = dataCaches[mc].task_deps[fn]
         if 'nostamp' in taskdep and task in taskdep['nostamp']:
             # Nostamp tasks need an implicit taint so that they force any dependent tasks to run
             if tid in self.taints and self.taints[tid].startswith("nostamp:"):
@@ -259,14 +257,14 @@ class SignatureGeneratorBasic(SignatureGenerator):
                 taint = str(uuid.uuid4())
                 self.taints[tid] = "nostamp:" + taint
 
-        taint = self.read_taint(fn, task, dataCache.stamp[fn])
+        taint = self.read_taint(fn, task, dataCaches[mc].stamp[fn])
         if taint:
             self.taints[tid] = taint
             logger.warning("%s is tainted from a forced run" % tid)
 
         return
 
-    def get_taskhash(self, tid, deps, dataCache):
+    def get_taskhash(self, tid, deps, dataCaches):
 
         data = self.basehash[tid]
         for dep in self.runtaskdeps[tid]:
-- 
2.26.2

