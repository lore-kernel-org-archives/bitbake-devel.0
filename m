Return-Path: <frederic.martinsons@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243A4C74A5B
	for <webhook@archiver.kernel.org>; Fri, 17 Mar 2023 08:19:37 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
 by mx.groups.io with SMTP id smtpd.web10.14421.1679041171843108404
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 17 Mar 2023 01:19:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=OOoAaEbi;
 spf=pass (domain: gmail.com, ip: 209.85.128.49, mailfrom: frederic.martinsons@gmail.com)
Received: by mail-wm1-f49.google.com with SMTP id r19-20020a05600c459300b003eb3e2a5e7bso2746545wmo.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 17 Mar 2023 01:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679041170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSByCSFAw/oVU1Yr2RHDris4wKib9wDuatqZlqERMNM=;
        b=OOoAaEbiEclmC5KxMsfWODJlyhxWLk+wDukVEGL1aTdhHLkaPjMd9COnDtjIV969A5
         nym+oe/2DkEtelB/DVx04uiUfl/sNn60GESneGRCedSGoZqjg/dIWo3QCtQGu3SVzijb
         L7xsbkcarZ09U4UrROBPRtDWRns4cNU/3mp7krRz7x9uPBbaBE0IQ6f8t7XcS0XaFPa0
         a6KfvzIhljKQofl/cuXQx2C9jDI7fCd7gkCeoe47accVmFK5U19aD30CoPXuu+9vkkH3
         uvaTvtX67UgyHjyLZKCxGt7lzqMKW2n1jM3RfM8fcpBjk/ooqhJaazKvMuOcuNEAp2tE
         9Z3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679041170;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lSByCSFAw/oVU1Yr2RHDris4wKib9wDuatqZlqERMNM=;
        b=DF4ljCMjf4RDzPniZIAhjeWFM9EtEmOGPAjDIPVdYYYzHCwVro7KcJfED2+tgKG/C9
         osDU3/Xz0wmZZ8SyJCdcZLkzEZtAIhwsXw8H4FtZNprpsloaaAwOc/rhyMLTv60LLTjH
         p+jNbO/xCN62lyW2Sya23Vo5iIP+VBCX4ivErI5ia4fuuPs4qH4/pdoZmk5t++JnR71i
         wWTeQd6wPabDcS+AFp4Jba12SJHeM6HaH6SzRsRHjXql52vGfpURdaUvUOwInzzn19AS
         9Kz2i8WlXCuVYgxfGHZ5tISGJImwitcxZ3KpCk3TgKtRZrs9Z5OEez4/B50s0hVgLrpY
         5uDQ==
X-Gm-Message-State: AO0yUKUQzV9tf5ofz1H/57H5DaUl6eKMLWZgitFF2GuHUvfM9nScXTxD
	mF4AWkszC1sXuWnmTqc9JXdbt6FsQkU=
X-Google-Smtp-Source: AK7set+iF/KHHU5N1pLu9ac2HeaLBifTCh08LR5uLfU9XinGsu7RV7rh8NLid8lQFwZpZqfZ7EGHIg==
X-Received: by 2002:a7b:cb98:0:b0:3ed:8360:e54 with SMTP id m24-20020a7bcb98000000b003ed83600e54mr990302wmi.8.1679041169732;
        Fri, 17 Mar 2023 01:19:29 -0700 (PDT)
Received: from work-pc.. ([2a01:e0a:8d5:c6c0:7a1:ff32:1d50:1429])
        by smtp.gmail.com with ESMTPSA id c24-20020a05600c0ad800b003e22508a343sm1293819wmr.12.2023.03.17.01.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 01:19:29 -0700 (PDT)
From: frederic.martinsons@gmail.com
To: bitbake-devel@lists.openembedded.org
Cc: Frederic Martinsons <frederic.martinsons@gmail.com>
Subject: [bitbake-devel][PATCH v2 1/3] fetch2: Add checksum capability for crate fetcher
Date: Fri, 17 Mar 2023 09:19:14 +0100
Message-Id: <20230317081916.1857201-1-frederic.martinsons@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 17 Mar 2023 08:19:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14602

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


