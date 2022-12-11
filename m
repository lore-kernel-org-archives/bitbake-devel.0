Return-Path: <richard.purdie@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18075C4332F
	for <webhook@archiver.kernel.org>; Sun, 11 Dec 2022 16:12:54 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
 by mx.groups.io with SMTP id smtpd.web10.20125.1670775169265585154
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 11 Dec 2022 08:12:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@linuxfoundation.org header.s=google header.b=Go4HOtrh;
 spf=pass (domain: linuxfoundation.org, ip: 209.85.221.48, mailfrom: richard.purdie@linuxfoundation.org)
Received: by mail-wr1-f48.google.com with SMTP id u12so9657813wrr.11
        for <bitbake-devel@lists.openembedded.org>; Sun, 11 Dec 2022 08:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Tyimkye4JWGOFE6+DRsvxw2D60Ldem5gDb+iuzijmg=;
        b=Go4HOtrhVZWITR6ilFh5k9mNVM/bJjULh1Sg0u78ajSC0J8rY1BibX2QgdzBFCorRa
         tche0sWlrUCf6XInMEx0do+Xh5tRIhziApTCc9jD0NHY4SmL9dmtI82mSyDYCjPKTAOI
         bd9c8eS22T8LATDCPVRyQEMviOzx971xKOdSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Tyimkye4JWGOFE6+DRsvxw2D60Ldem5gDb+iuzijmg=;
        b=YBDoyVm08FQIL+xawhL76gGjkR36duuU3844UEyJrqa8lFKF0vEhXJQUkEOtlrfDOw
         YxaDVhScPJZc+yXzK4chyGVr5O7tdezy5029c9nk3DdJs5ozTV6TeATAClrumzpzMQ6s
         JOMKHqY661jH4Z0my2d7x1ImtXibq7mcyAolg3b5X+lcBfsaQ1qr/pJSz43OcQ1D69hc
         bIqmqbW40Xiz85D+89D3RGjVHX16b46VcrTL3W77Tu0KurOGN2i9MgYbhAjc3Dj0xREy
         lt2gFz0BwvFJNqL95WiAS+ToosgZVVan4Dd0ZbdNzz96vwsbTogXDrcuWUf9xQZgFH4Q
         5jQQ==
X-Gm-Message-State: ANoB5pkh2QpisqkqyOn4gg/4enwVA3zmQ9lenkNFj+9OIgRwPQa4IrvW
	1cBqPXNkJ8p4AB3aqWYmKZ31T8ghYDN1Lre5
X-Google-Smtp-Source: AA0mqf5K0FmaBA/Xg9owuc5ppPVrH6GTma4fgfFaT4snmzktPyazWe2Ts/jqJvYq0RuQ11YkdKQyyg==
X-Received: by 2002:adf:f58b:0:b0:242:5d8e:6c34 with SMTP id f11-20020adff58b000000b002425d8e6c34mr7965117wro.32.1670775167549;
        Sun, 11 Dec 2022 08:12:47 -0800 (PST)
Received: from max.int.rpsys.net ([2001:8b0:aba:5f3c:db5:b2f0:a022:4502])
        by smtp.gmail.com with ESMTPSA id bp8-20020a5d5a88000000b00241e8d00b79sm8371900wrb.54.2022.12.11.08.12.46
        for <bitbake-devel@lists.openembedded.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 08:12:47 -0800 (PST)
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Subject: [PATCH] siggen: Drop non-multiconfig aware siggen support
Date: Sun, 11 Dec 2022 16:12:46 +0000
Message-Id: <20221211161246.17726-1-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 11 Dec 2022 16:12:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14169

All siggens in common use should now support multiconfig, drop the
compatibility code.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/runqueue.py       |  8 +++----
 lib/bb/siggen.py         | 49 ----------------------------------------
 lib/bb/tests/runqueue.py |  2 +-
 3 files changed, 4 insertions(+), 55 deletions(-)

diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py
index cc36b84781..7451e5c56b 100644
--- a/lib/bb/runqueue.py
+++ b/lib/bb/runqueue.py
@@ -1245,9 +1245,8 @@ class RunQueueData:
         return len(self.runtaskentries)
 
     def prepare_task_hash(self, tid):
-        dc = bb.parse.siggen.get_data_caches(self.dataCaches, mc_from_tid(tid))
-        bb.parse.siggen.prep_taskhash(tid, self.runtaskentries[tid].depends, dc)
-        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, self.runtaskentries[tid].depends, dc)
+        bb.parse.siggen.prep_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
+        self.runtaskentries[tid].hash = bb.parse.siggen.get_taskhash(tid, self.runtaskentries[tid].depends, self.dataCaches)
         self.runtaskentries[tid].unihash = bb.parse.siggen.get_unihash(tid)
 
     def dump_data(self):
@@ -2434,8 +2433,7 @@ class RunQueueExecute:
                 if self.rqdata.runtaskentries[p].depends and not self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
                     continue
                 orighash = self.rqdata.runtaskentries[tid].hash
-                dc = bb.parse.siggen.get_data_caches(self.rqdata.dataCaches, mc_from_tid(tid))
-                newhash = bb.parse.siggen.get_taskhash(tid, self.rqdata.runtaskentries[tid].depends, dc)
+                newhash = bb.parse.siggen.get_taskhash(tid, self.rqdata.runtaskentries[tid].depends, self.rqdata.dataCaches)
                 origuni = self.rqdata.runtaskentries[tid].unihash
                 newuni = bb.parse.siggen.get_unihash(tid)
                 # FIXME, need to check it can come from sstate at all for determinism?
diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
index 3731cd6b69..be56b3a31c 100644
--- a/lib/bb/siggen.py
+++ b/lib/bb/siggen.py
@@ -53,11 +53,6 @@ class SignatureGenerator(object):
     """
     name = "noop"
 
-    # If the derived class supports multiconfig datacaches, set this to True
-    # The default is False for backward compatibility with derived signature
-    # generators that do not understand multiconfig caches
-    supports_multiconfig_datacaches = False
-
     def __init__(self, data):
         self.basehash = {}
         self.taskhash = {}
@@ -128,38 +123,6 @@ class SignatureGenerator(object):
     def set_setscene_tasks(self, setscene_tasks):
         return
 
-    @classmethod
-    def get_data_caches(cls, dataCaches, mc):
-        """
-        This function returns the datacaches that should be passed to signature
-        generator functions. If the signature generator supports multiconfig
-        caches, the entire dictionary of data caches is sent, otherwise a
-        special proxy is sent that support both index access to all
-        multiconfigs, and also direct access for the default multiconfig.
-
-        The proxy class allows code in this class itself to always use
-        multiconfig aware code (to ease maintenance), but derived classes that
-        are unaware of multiconfig data caches can still access the default
-        multiconfig as expected.
-
-        Do not override this function in derived classes; it will be removed in
-        the future when support for multiconfig data caches is mandatory
-        """
-        class DataCacheProxy(object):
-            def __init__(self):
-                pass
-
-            def __getitem__(self, key):
-                return dataCaches[key]
-
-            def __getattr__(self, name):
-                return getattr(dataCaches[mc], name)
-
-        if cls.supports_multiconfig_datacaches:
-            return dataCaches
-
-        return DataCacheProxy()
-
     def exit(self):
         return
 
@@ -298,11 +261,6 @@ class SignatureGeneratorBasic(SignatureGenerator):
         for dep in sorted(deps, key=clean_basepath):
             (depmc, _, _, depmcfn) = bb.runqueue.split_tid_mcfn(dep)
             depname = dataCaches[depmc].pkg_fn[depmcfn]
-            if not self.supports_multiconfig_datacaches and mc != depmc:
-                # If the signature generator doesn't understand multiconfig
-                # data caches, any dependency not in the same multiconfig must
-                # be skipped for backward compatibility
-                continue
             if not self.rundep_check(fn, recipename, task, dep, depname, dataCaches):
                 continue
             if dep not in self.taskhash:
@@ -726,13 +684,6 @@ class SignatureGeneratorTestEquivHash(SignatureGeneratorUniHashMixIn, SignatureG
         self.server = data.getVar('BB_HASHSERVE')
         self.method = "sstate_output_hash"
 
-#
-# Dummy class used for bitbake-selftest
-#
-class SignatureGeneratorTestMulticonfigDepends(SignatureGeneratorBasicHash):
-    name = "TestMulticonfigDepends"
-    supports_multiconfig_datacaches = True
-
 def dump_this_task(outfile, d):
     import bb.parse
     fn = d.getVar("BB_FILENAME")
diff --git a/lib/bb/tests/runqueue.py b/lib/bb/tests/runqueue.py
index 061a5a1f80..cc87e8d6a8 100644
--- a/lib/bb/tests/runqueue.py
+++ b/lib/bb/tests/runqueue.py
@@ -288,7 +288,7 @@ class RunQueueTests(unittest.TestCase):
         with tempfile.TemporaryDirectory(prefix="runqueuetest") as tempdir:
             extraenv = {
                 "BBMULTICONFIG" : "mc-1 mc_2",
-                "BB_SIGNATURE_HANDLER" : "TestMulticonfigDepends",
+                "BB_SIGNATURE_HANDLER" : "basichash",
                 "EXTRA_BBFILES": "${COREBASE}/recipes/fails-mc/*.bb",
             }
             tasks = self.run_bitbakecmd(["bitbake", "mc:mc-1:f1"], tempdir, "", extraenv=extraenv, cleanup=True)
-- 
2.37.2


