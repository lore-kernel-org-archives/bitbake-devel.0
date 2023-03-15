Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856C3C61DA4
	for <webhook@archiver.kernel.org>; Wed, 15 Mar 2023 13:15:30 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
 by mx.groups.io with SMTP id smtpd.web11.7578.1678886127159255658
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 15 Mar 2023 06:15:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=a7hltox5;
 spf=pass (domain: gmail.com, ip: 209.85.221.46, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-wr1-f46.google.com with SMTP id o7so7894803wrg.5
        for <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 06:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678886125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSByCSFAw/oVU1Yr2RHDris4wKib9wDuatqZlqERMNM=;
        b=a7hltox5Bm20rGIHeSxH3g9nreLceqpsDt6IsbikulVw/FpS25jmt6e9lWFtTIIyp9
         EsUQOt4p4fubDL+pNUKuTO4d1FZ3v7cG/PS12rcAh7S6zoPdS5H9zM47uAostxwcjThV
         SRxyWeuU3ww4Fb24lETKcpzzhlTLRq4NKRdb/clj9jqRicj7XjyOpBRw3kGo5QcdpFfk
         SvGmfdpGNo4p5b7b7FeqWMNhyvSb/HTTf0cotWkMZ26qDPXl9BwwGVRNJdsyWwVwK9hB
         A/iHNMiKBcIf7/B9cJO7k7h81Rev4Ay2mhZZYaFU/b7/U67G3d8Y2DI9GPLhO1BVM3Hm
         O9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678886125;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSByCSFAw/oVU1Yr2RHDris4wKib9wDuatqZlqERMNM=;
        b=ltBVKtFWN5ga8x0/p+i4sMlq3oDf3ubZIVud9nbWXw0iZS7e+X8MNPfgp7FsF0CPEB
         ImmKT7cPbKwZuGtS2fSKIi8TvguuuD4u6OqBhW5VaqAordyMlp4FrIOBXuph+1BaO3r4
         0FMV7nhvwn7bemWW0uALztBNYeVZPa8rqPYTqsxP0e7ahrbIfR5kyDtknmqrANBWdFKI
         pqXFSGPyEbPxhOEabWt+mVFDx32RQ/d6yQCBQgQX2g0qHvOFiAFEmuE4B+wWBNvSJzkZ
         qb9CRqQrXSXvpJHvpMWjiEcQQkeC3Vrk3hHjs0JPU0oVkkC4bpWqUZao5LKa4LYm2Ur5
         931w==
X-Gm-Message-State: AO0yUKVFDSj+Y59aSJR2uNB4qz+LQNwzk+4C5rzo8QWExPVAvxgnMbh9
	k4V0IzHNr0Cvo6BYB77/EeRCy/4TAXA=
X-Google-Smtp-Source: AK7set/nzSG7WNwiMg8vAsXNFkp6XqYqhEv1S+zYXY+TCZDXvwM0hJm1327La6YJFvUBtyr0rvY7zw==
X-Received: by 2002:a5d:474e:0:b0:2ce:9f35:b645 with SMTP id o14-20020a5d474e000000b002ce9f35b645mr2113953wrs.20.1678886125200;
        Wed, 15 Mar 2023 06:15:25 -0700 (PDT)
Received: from work-pc.core.sigfox.net ([2a01:e0a:8d5:c6c0:de0b:a9f8:3449:816c])
        by smtp.gmail.com with ESMTPSA id o6-20020a5d4086000000b002c5694aef92sm4728997wrp.21.2023.03.15.06.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 06:15:24 -0700 (PDT)
From: frederic.martinsons@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Frederic Martinsons <frederic.martinsons@gmail.com>
Subject: [PATCH] fetch2: Add checksum capability for crate fetcher
Date: Wed, 15 Mar 2023 14:15:13 +0100
Message-Id: <20230315131513.50635-1-frederic.martinsons@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Mar 2023 13:15:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14563

From: Frederic Martinsons <frederic.martinsons@gmail.com>

This change brings checksum verification of each crate
in a recipe, e.g

| SRC_URI += " \
|     crate://crates.io/aho-corasick/0.7.20 \
|     crate://crates.io/atomic-waker/1.1.0 \
|     crate://crates.io/cc/1.0.79 \
| "
|
| SRC_URI[aho-corasick.sha256sum] = "cc936419f96fa211c1b9166887b38e5e40b19958e5b895be7c1f93adec7071ac"
| SRC_URI[atomic-waker.sha256sum] = "debc29dde2e69f9e47506b525f639ed42300fc014a3e007832592448fa8e4599"
| SRC_URI[cc.sha256sum] = "50d30906286121d95be3d479533b458f87493b30a4b5f79a607db8f5d11aa91f"

That will require to move the checksum initialization
after the possible call to urldata_init method in order
for the crate fetcher to parse the url.

Another way of doing could have been implementing a decodeurl
method that would have been specific for each fetcher class.

Signed-off-by: Frederic Martinsons <frederic.martinsons@gmail.com>
---
 lib/bb/fetch2/__init__.py | 12 ++++++------
 lib/bb/tests/fetch.py     | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index cf65727a..3ae83fa8 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -1291,18 +1291,13 @@ class FetchData(object):
 
             if checksum_name in self.parm:
                 checksum_expected = self.parm[checksum_name]
-            elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "s3", "az"]:
+            elif self.type not in ["http", "https", "ftp", "ftps", "sftp", "s3", "az", "crate"]:
                 checksum_expected = None
             else:
                 checksum_expected = d.getVarFlag("SRC_URI", checksum_name)
 
             setattr(self, "%s_expected" % checksum_id, checksum_expected)
 
-        for checksum_id in CHECKSUM_LIST:
-            configure_checksum(checksum_id)
-
-        self.ignore_checksums = False
-
         self.names = self.parm.get("name",'default').split(',')
 
         self.method = None
@@ -1324,6 +1319,11 @@ class FetchData(object):
         if hasattr(self.method, "urldata_init"):
             self.method.urldata_init(self, d)
 
+        for checksum_id in CHECKSUM_LIST:
+            configure_checksum(checksum_id)
+
+        self.ignore_checksums = False
+
         if "localpath" in self.parm:
             # if user sets localpath for file, use it instead.
             self.localpath = self.parm["localpath"]
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 73eefc59..fd089bc8 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -2377,6 +2377,13 @@ class CrateTest(FetcherTest):
         d = self.d
 
         fetcher = bb.fetch2.Fetch(uris, self.d)
+        ud = fetcher.ud[fetcher.urls[0]]
+
+        self.assertIn("name", ud.parm)
+        self.assertEqual(ud.parm["name"], "glob")
+        self.assertIn("downloadfilename", ud.parm)
+        self.assertEqual(ud.parm["downloadfilename"], "glob-0.2.11.crate")
+
         fetcher.download()
         fetcher.unpack(self.tempdir)
         self.assertEqual(sorted(os.listdir(self.tempdir)), ['cargo_home', 'download' , 'unpacked'])
@@ -2394,6 +2401,19 @@ class CrateTest(FetcherTest):
         d = self.d
 
         fetcher = bb.fetch2.Fetch(uris, self.d)
+        ud = fetcher.ud[fetcher.urls[0]]
+
+        self.assertIn("name", ud.parm)
+        self.assertEqual(ud.parm["name"], "glob")
+        self.assertIn("downloadfilename", ud.parm)
+        self.assertEqual(ud.parm["downloadfilename"], "glob-0.2.11.crate")
+
+        ud = fetcher.ud[fetcher.urls[1]]
+        self.assertIn("name", ud.parm)
+        self.assertEqual(ud.parm["name"], "time")
+        self.assertIn("downloadfilename", ud.parm)
+        self.assertEqual(ud.parm["downloadfilename"], "time-0.1.35.crate")
+
         fetcher.download()
         fetcher.unpack(self.tempdir)
         self.assertEqual(sorted(os.listdir(self.tempdir)), ['cargo_home', 'download' , 'unpacked'])
@@ -2403,6 +2423,18 @@ class CrateTest(FetcherTest):
         self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitbake/time-0.1.35/.cargo-checksum.json"))
         self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitbake/time-0.1.35/src/lib.rs"))
 
+    @skipIfNoNetwork()
+    def test_crate_incorrect_cksum(self):
+        uri = "crate://crates.io/aho-corasick/0.7.20"
+        self.d.setVar('SRC_URI', uri)
+        self.d.setVarFlag("SRC_URI", "aho-corasick.sha256sum", hashlib.sha256("Invalid".encode("utf-8")).hexdigest())
+
+        uris = self.d.getVar('SRC_URI').split()
+
+        fetcher = bb.fetch2.Fetch(uris, self.d)
+        with self.assertRaisesRegexp(bb.fetch2.FetchError, "Fetcher failure for URL"):
+            fetcher.download()
+
 class NPMTest(FetcherTest):
     def skipIfNoNpm():
         import shutil
-- 
2.34.1


