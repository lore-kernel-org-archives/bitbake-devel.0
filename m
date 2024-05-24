Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D238C25B7A
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 15:12:12 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
 by mx.groups.io with SMTP id smtpd.web10.18340.1716563527433556294
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 May 2024 08:12:07 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=bHDf4pgf;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.47, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-420180b5897so30379305e9.3
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 08:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716563526; x=1717168326; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s50+QmbbVCh1Kn71NtkSqBhDOjNbtsk6XB7tf6bNMXA=;
        b=bHDf4pgfh6yWEdC64H20SYAfQ/sabyZpl0BfvAFa48SntA3LuBE5UMqgcTZqy9ZY99
         JYr2cn91mZ6UpYN3L/BZ5OfAB4F1bpWf6ayVivPc7rLGz9uta3Lk4+cQ6t1OgUOprTO6
         WaWFUk5tZEPkBQJ7tve/79ZrwnRlYL0bLtYq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716563526; x=1717168326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s50+QmbbVCh1Kn71NtkSqBhDOjNbtsk6XB7tf6bNMXA=;
        b=UxawHIe7M2Q0p8yDyw2a91AxL+blnS10ND3dYqdfDrxHLsLlsyalGOAxibH9lb2+mW
         Miie92x6foSBJt5lmYACF3v5tgCWxFVgwaIXoykURgrgxXVubXraMrYe4IRqPVCgedF7
         VM1ESvUAdbpNpxcixp14rPzMhVwfgtVjims7afED4sKPESWoUWl5GjV9q9rW1MZ8c72O
         jbV7mxQYMugQLaMMOJcQ10vP06mhy6NG10K22skpuMwQ5Mb1frdZ26fhaqaAnC/LfBKt
         dgLem+vPw2n9hK5at1MO/LiHcrteDxuQ7NaoOmEaWzK5umdRmIOxVkGxYJDF0eXia927
         kSxg==
X-Gm-Message-State: AOJu0Yz3dhynf+ZA/kbWMi0418P1W9N5azxiR01fQeNnOwBhyFlXTwga
	5RmjdCt9eHkAS17CZgAfdFRiRrdwQf/QFMACl70cJqfjMxuxeeLpitFzsvQbYeBrKPYaU8w4pOr
	G
X-Google-Smtp-Source: AGHT+IFWu8UWcn1pSN02UzAUF3wLiuCHzrwk1XsektiB9iCCdHTSK9EsEsB6E90PO1ohoMSW24KAPA==
X-Received: by 2002:adf:fc89:0:b0:355:148:ea23 with SMTP id ffacd0b85a97d-3552fdc7ca9mr1676754f8f.56.1716563525492;
        Fri, 24 May 2024 08:12:05 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9ca4:3686:8521:57da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7db23sm1841759f8f.23.2024.05.24.08.12.04
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 08:12:05 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 6/6] siggen/runqueue: Allow skipping of rehash if not present on hashserve
Date: Fri, 24 May 2024 16:12:00 +0100
Message-Id: <20240524151200.2449512-6-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240524151200.2449512-1-richard.purdie@linuxfoundation.org>
References: <20240524151200.2449512-1-richard.purdie@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 15:12:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16260

If a unihash isn't present on the hashserver, it is extremely unlikely any
following unihashes would be either. Use this information to skip unihash
checks in that scenario where there is low matching to allow the build
to proceed more quickly. This significantly improves performance on the
low match scenario.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py | 35 ++++++++++++++++++++++++++----
 lib/bb/siggen.py   | 54 +++++++++++++++++++++++++---------------------
 2 files changed, 61 insertions(+), 28 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 5626ffcccb..0fb9edc77e 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -472,6 +472,7 @@ class RunQueueData:
         self.reset()
 
     def reset(self):
+        self.hashserve_valid = set()
         self.runtaskentries = {}
 
     def runq_depends_names(self, ids):
@@ -1287,11 +1288,23 @@ class RunQueueData:
                     # get_taskhash for a given tid *must* be called before get_unihash* below
                     self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
                     ready.add(tid)
-            unihashes = bb.parse.siggen.get_unihashes(ready)
+
+            ready2 = set()
+            for tid in ready:
+                if self.runtaskentries[tid].depends.issubset(self.hashserve_valid):
+                    ready2.add(tid)
+            unihashes = bb.parse.siggen.get_unihashes(ready2)
             for tid in ready:
                 dealtwith.add(tid)
                 todeal.remove(tid)
-                self.runtaskentries[tid].unihash = unihashes[tid]
+                if tid in unihashes:
+                    self.runtaskentries[tid].unihash, present = unihashes[tid]
+                    if present:
+                        self.hashserve_valid.add(tid)
+                else:
+                    taskhash = self.runtaskentries[tid].hash
+                    bb.parse.siggen.set_unihash(tid, taskhash, False)
+                    self.runtaskentries[tid].unihash = taskhash
 
             bb.event.check_for_interrupts(self.cooker.data)
 
@@ -2585,13 +2598,25 @@ class RunQueueExecute:
                 # get_taskhash for a given tid *must* be called before get_unihash* below
                 ready[tid] = bb.parse.siggen.get_taskhash(tid, self.rqdata.runtaskentries[tid].depends, self.rqdata.dataCaches)
 
-            unihashes = bb.parse.siggen.get_unihashes(ready.keys())
+            toquery = set()
+            for tid in ready:
+                if self.rqdata.runtaskentries[tid].depends.issubset(self.rqdata.hashserve_valid):
+                    toquery.add(tid)
+
+            unihashes = bb.parse.siggen.get_unihashes(toquery)
 
             for tid in ready:
                 orighash = self.rqdata.runtaskentries[tid].hash
                 newhash = ready[tid]
                 origuni = self.rqdata.runtaskentries[tid].unihash
-                newuni = unihashes[tid]
+
+                if tid in unihashes:
+                    newuni, present = unihashes[tid]
+                    if present:
+                        self.rqdata.hashserve_valid.add(tid)
+                else:
+                    bb.parse.siggen.set_unihash(tid, origuni, False)
+                    newuni = origuni
 
                 # FIXME, need to check it can come from sstate at all for determinism?
                 remapped = False
@@ -2623,6 +2648,8 @@ class RunQueueExecute:
         if (endtime-starttime > 60):
             hashequiv_logger.verbose("Rehash loop took more than 60s: %s" % (endtime-starttime))
 
+        bb.parse.siggen.save_unitaskhashes()
+
         if changed:
             for mc in self.rq.worker:
                 RunQueue.send_pickled_data(self.rq.worker[mc].process, bb.parse.siggen.get_taskhashes(), "newtaskhashes")
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index e8fe806c36..56528ea10a 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -112,16 +112,19 @@ class SignatureGenerator(object):
                 self.datacaches[mc].stamp_extrainfo[mcfn][t] = flag
 
     def get_cached_unihash(self, tid):
-        return None
-
-    def get_unihash(self, tid):
-        unihash = self.get_cached_unihash(tid)
-        if unihash:
+        return None, False
+
+    def get_unihash(self, tid, presenceinfo=False):
+        unihash, present = self.get_cached_unihash(tid)
+        if not unihash:
+            unihash, present = self.taskhash[tid], False
+        if presenceinfo:
+            return unihash, present
+        else:
             return unihash
-        return self.taskhash[tid]
 
     def get_unihashes(self, tids):
-        return {tid: self.get_unihash(tid) for tid in tids}
+        return {tid: self.get_unihash(tid, True) for tid in tids}
 
     def prep_taskhash(self, tid, deps, dataCaches):
         return
@@ -624,7 +627,7 @@ class SignatureGeneratorUniHashMixIn(object):
             # If a unique hash is reported, use it as the stampfile hash. This
             # ensures that if a task won't be re-run if the taskhash changes,
             # but it would result in the same output hash
-            unihash = self._get_unihash(tid)
+            unihash, _ = self._get_unihash(tid)
             if unihash is not None:
                 return unihash
 
@@ -638,17 +641,17 @@ class SignatureGeneratorUniHashMixIn(object):
 
     def _get_unihash(self, tid, checkkey=None):
         if tid not in self.tidtopn:
-            return None
+            return None, False
         (mc, fn, taskname, taskfn) = bb.runqueue.split_tid_mcfn(tid)
         key = mc + ":" + self.tidtopn[tid] + ":" + taskname
         if key not in self.hashserv_cache:
-            return None
+            return None, False
         if not checkkey:
             checkkey = self.taskhash[tid]
         (key, unihash, present) = self.hashserv_cache[key]
         if key != checkkey:
-            return None
-        return unihash
+            return None, False
+        return unihash, present
 
     def get_cached_unihash(self, tid):
         taskhash = self.taskhash[tid]
@@ -656,16 +659,16 @@ class SignatureGeneratorUniHashMixIn(object):
         # If its not a setscene task we can return
         if self.setscenetasks and tid not in self.setscenetasks:
             self.unihash[tid] = None
-            return taskhash
+            return taskhash, True
 
         # TODO: This cache can grow unbounded. It probably only needs to keep
         # for each task
-        unihash =  self._get_unihash(tid)
+        unihash, present =  self._get_unihash(tid)
         if unihash is not None:
             self.unihash[tid] = unihash
-            return unihash
+            return unihash, present
 
-        return None
+        return None, False
 
     def _get_method(self, tid):
         method = self.method
@@ -703,8 +706,10 @@ class SignatureGeneratorUniHashMixIn(object):
 
         return result
 
-    def get_unihash(self, tid):
-        return self.get_unihashes([tid])[tid]
+    def get_unihash(self, tid, presenceinfo=False):
+        if presenceinfo:
+            return self.get_unihashes([tid])[tid]
+        return self.get_unihashes([tid])[tid][0]
 
     def get_unihashes(self, tids):
         """
@@ -716,9 +721,9 @@ class SignatureGeneratorUniHashMixIn(object):
         query_result = {}
 
         for tid in tids:
-            unihash = self.get_cached_unihash(tid)
+            unihash, present = self.get_cached_unihash(tid)
             if unihash:
-                result[tid] = unihash
+                result[tid] = (unihash, present)
             else:
                 queries[tid] = (self._get_method(tid), self.taskhash[tid])
 
@@ -754,14 +759,15 @@ class SignatureGeneratorUniHashMixIn(object):
                 # so it is reported it at debug level 2. If they differ, that
                 # is much more interesting, so it is reported at debug level 1
                 hashequiv_logger.bbdebug((1, 2)[unihash == taskhash], 'Found unihash %s in place of %s for %s from %s' % (unihash, taskhash, tid, self.server))
-                self.set_unihash(tid, unihash, True)
+                present = True
             else:
                 hashequiv_logger.debug2('No reported unihash for %s:%s from %s' % (tid, taskhash, self.server))
                 unihash = taskhash
-                self.set_unihash(tid, unihash, False)
+                present = False
 
+            self.set_unihash(tid, unihash, present)
             self.unihash[tid] = unihash
-            result[tid] = unihash
+            result[tid] = (unihash, present)
 
         return result
 
@@ -784,7 +790,7 @@ class SignatureGeneratorUniHashMixIn(object):
             return
 
         # Sanity checks
-        cache_unihash = self._get_unihash(tid, checkkey=taskhash)
+        cache_unihash, _ = self._get_unihash(tid, checkkey=taskhash)
         if cache_unihash is None:
             bb.fatal('%s not in unihash cache. Please report this error' % key)
 
-- 
2.40.1


