Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C94C25B74
	for <webhook@archiver.kernel.org>; Fri, 24 May 2024 15:12:12 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
 by mx.groups.io with SMTP id smtpd.web11.18332.1716563524037604594
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 24 May 2024 08:12:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=e4lMJMX+;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.128.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-420180b58c3so68664705e9.2
        for <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 08:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1716563522; x=1717168322; darn=lists.openembedded.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMrCgvPprdokXnS838ol6IhhnYIcvh7LraWq8nbScHI=;
        b=e4lMJMX+GBvWJjt+N54nHwLjDpn9dh/SnFoymZT0aVuL2rzYskU/Gmy57sW78SWyyo
         /kwowjIRwDhJfjTj7SynnMYcHNZXnhM5sZOkrm4R6Baun7XF1g622MZtUOGfxX9T5xPd
         gYYMMQd524CE34NeGng4mzewv0TB3Sjv23lRM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716563522; x=1717168322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TMrCgvPprdokXnS838ol6IhhnYIcvh7LraWq8nbScHI=;
        b=eW4+ra0OKEaSB0lu+MBG+cjU9rFtKPvvkR+ePIGrcxTErVv2v47V0oeGRQ1Goz7EaZ
         wwbak3Ug5DlV9TVvEL3LeTs+kT6DRxY2pdoSgn5fXIGmunPvBVVmx8LTlT80QM3lMkjY
         6mt/urlwL/QnIV0ggiLG8S9C0GP3cFoTzJ8ap+wG/1KXisWw5D3eikRwwbggBzzJFcTR
         XTtHx3Tvr6+DtmL4b4Sichl7dG9pUdyTOGHqeYm8CdzbYRYU/Vngx/NI94QLAaN9k0Fj
         zV/l1bYun1MGQVQqtEQMNVFKMCz5eaQr2IMiZn9hlTqJfDbwCBVgqMJWTPUlM8ywl1w1
         ymtw==
X-Gm-Message-State: AOJu0YwhSpC/liVo7RzPypyTQcUvsD7bGKGqpyXt6h9LMs+1vVA57zvT
	c3GhkHAD2pT0ToMLFaUp6jyhsYEgxqjnE7z37TDw8ODKzJi9Bbuivida5Jbp9QmYMWE0KPNX9Fa
	D
X-Google-Smtp-Source: AGHT+IEl4wtt9Uz+cBZ5LsHj0vDvdfnQdiJe8vXkhMeQ0AufKJPbDsPvNRKQ8CevVo2yH6h8fae55A==
X-Received: by 2002:a05:600c:6b1a:b0:416:6af1:27af with SMTP id 5b1f17b1804b1-42108aba785mr21749325e9.35.1716563521819;
        Fri, 24 May 2024 08:12:01 -0700 (PDT)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:9ca4:3686:8521:57da])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7db23sm1841759f8f.23.2024.05.24.08.12.01
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 08:12:01 -0700 (PDT)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH 1/6] siggen/runqueue: Store whether the hash was present on the hashserver or not
Date: Fri, 24 May 2024 16:11:55 +0100
Message-Id: <20240524151200.2449512-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 24 May 2024 15:12:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16255

We need to be able to know if a unihash came from the hashequivalence
server or not. Add this information to the cache data so we can use
it in later code changes.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py |  2 +-
 lib/bb/siggen.py   | 32 ++++++++++++++++----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index 6b43f303d5..6c2034176e 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -2530,7 +2530,7 @@ class RunQueueExecute:
                 for hashtid in torehash:
                     hashequiv_logger.verbose("Task %s unihash changed to %s" % (hashtid, unihash))
                     self.rqdata.runtaskentries[hashtid].unihash = unihash
-                    bb.parse.siggen.set_unihash(hashtid, unihash)
+                    bb.parse.siggen.set_unihash(hashtid, unihash, True)
                     toprocess.add(hashtid)
                 if torehash:
                     # Need to save after set_unihash above
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 03dfda6f3c..e8fe806c36 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -80,7 +80,7 @@ class SignatureGenerator(object):
         self.runtaskdeps = {}
         self.file_checksum_values = {}
         self.taints = {}
-        self.unitaskhashes = {}
+        self.hashserv_cache = {}
         self.tidtopn = {}
         self.setscenetasks = set()
 
@@ -184,19 +184,19 @@ class SignatureGenerator(object):
         return
 
     def get_taskdata(self):
-        return (self.runtaskdeps, self.taskhash, self.unihash, self.file_checksum_values, self.taints, self.basehash, self.unitaskhashes, self.tidtopn, self.setscenetasks)
+        return (self.runtaskdeps, self.taskhash, self.unihash, self.file_checksum_values, self.taints, self.basehash, self.hashserv_cache, self.tidtopn, self.setscenetasks)
 
     def set_taskdata(self, data):
-        self.runtaskdeps, self.taskhash, self.unihash, self.file_checksum_values, self.taints, self.basehash, self.unitaskhashes, self.tidtopn, self.setscenetasks = data
+        self.runtaskdeps, self.taskhash, self.unihash, self.file_checksum_values, self.taints, self.basehash, self.hashserv_cache, self.tidtopn, self.setscenetasks = data
 
     def reset(self, data):
         self.__init__(data)
 
     def get_taskhashes(self):
-        return self.taskhash, self.unihash, self.unitaskhashes, self.tidtopn
+        return self.taskhash, self.unihash, self.hashserv_cache, self.tidtopn
 
     def set_taskhashes(self, hashes):
-        self.taskhash, self.unihash, self.unitaskhashes, self.tidtopn = hashes
+        self.taskhash, self.unihash, self.hashserv_cache, self.tidtopn = hashes
 
     def save_unitaskhashes(self):
         return
@@ -238,8 +238,8 @@ class SignatureGeneratorBasic(SignatureGenerator):
         else:
             self.checksum_cache = None
 
-        self.unihash_cache = bb.cache.SimpleCache("3")
-        self.unitaskhashes = self.unihash_cache.init_cache(data, "bb_unihashes.dat", {})
+        self.unihash_cache = bb.cache.SimpleCache("4")
+        self.hashserv_cache = self.unihash_cache.init_cache(data, "bb_unihashes.dat", {})
         self.localdirsexclude = (data.getVar("BB_SIGNATURE_LOCAL_DIRS_EXCLUDE") or "CVS .bzr .git .hg .osc .p4 .repo .svn").split()
         self.tidtopn = {}
 
@@ -416,7 +416,7 @@ class SignatureGeneratorBasic(SignatureGenerator):
             bb.fetch2.fetcher_parse_done()
 
     def save_unitaskhashes(self):
-        self.unihash_cache.save(self.unitaskhashes)
+        self.unihash_cache.save(self.hashserv_cache)
 
     def copy_unitaskhashes(self, targetdir):
         self.unihash_cache.copyfile(targetdir)
@@ -630,10 +630,10 @@ class SignatureGeneratorUniHashMixIn(object):
 
         return super().get_stampfile_hash(tid)
 
-    def set_unihash(self, tid, unihash):
+    def set_unihash(self, tid, unihash, present):
         (mc, fn, taskname, taskfn) = bb.runqueue.split_tid_mcfn(tid)
         key = mc + ":" + self.tidtopn[tid] + ":" + taskname
-        self.unitaskhashes[key] = (self.taskhash[tid], unihash)
+        self.hashserv_cache[key] = (self.taskhash[tid], unihash, present)
         self.unihash[tid] = unihash
 
     def _get_unihash(self, tid, checkkey=None):
@@ -641,11 +641,11 @@ class SignatureGeneratorUniHashMixIn(object):
             return None
         (mc, fn, taskname, taskfn) = bb.runqueue.split_tid_mcfn(tid)
         key = mc + ":" + self.tidtopn[tid] + ":" + taskname
-        if key not in self.unitaskhashes:
+        if key not in self.hashserv_cache:
             return None
         if not checkkey:
             checkkey = self.taskhash[tid]
-        (key, unihash) = self.unitaskhashes[key]
+        (key, unihash, present) = self.hashserv_cache[key]
         if key != checkkey:
             return None
         return unihash
@@ -754,12 +754,12 @@ class SignatureGeneratorUniHashMixIn(object):
                 # so it is reported it at debug level 2. If they differ, that
                 # is much more interesting, so it is reported at debug level 1
                 hashequiv_logger.bbdebug((1, 2)[unihash == taskhash], 'Found unihash %s in place of %s for %s from %s' % (unihash, taskhash, tid, self.server))
+                self.set_unihash(tid, unihash, True)
             else:
                 hashequiv_logger.debug2('No reported unihash for %s:%s from %s' % (tid, taskhash, self.server))
                 unihash = taskhash
+                self.set_unihash(tid, unihash, False)
 
-
-            self.set_unihash(tid, unihash)
             self.unihash[tid] = unihash
             result[tid] = unihash
 
@@ -835,7 +835,7 @@ class SignatureGeneratorUniHashMixIn(object):
                 if new_unihash != unihash:
                     hashequiv_logger.debug('Task %s unihash changed %s -> %s by server %s' % (taskhash, unihash, new_unihash, self.server))
                     bb.event.fire(bb.runqueue.taskUniHashUpdate(mcfn + ':do_' + task, new_unihash), d)
-                    self.set_unihash(tid, new_unihash)
+                    self.set_unihash(tid, new_unihash, True)
                     d.setVar('BB_UNIHASH', new_unihash)
                 else:
                     hashequiv_logger.debug('Reported task %s as unihash %s to %s' % (taskhash, unihash, self.server))
@@ -875,7 +875,7 @@ class SignatureGeneratorUniHashMixIn(object):
                 hashequiv_logger.verbose('Task %s unihash %s unchanged by server' % (tid, finalunihash))
             elif finalunihash == wanted_unihash:
                 hashequiv_logger.verbose('Task %s unihash changed %s -> %s as wanted' % (tid, current_unihash, finalunihash))
-                self.set_unihash(tid, finalunihash)
+                self.set_unihash(tid, finalunihash, True)
                 return True
             else:
                 # TODO: What to do here?
-- 
2.40.1


