Return-Path: <philip.lorenz@bmw.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A1A5C61DFD
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 08:32:45 +0000 (UTC)
Received: from esa7.hc324-48.eu.iphmx.com (esa7.hc324-48.eu.iphmx.com [207.54.71.126])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7890.1788337962909257962
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 02 Sep 2026 01:32:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bmw.de header.s=mailing1 header.b=BDdVyM24;
 spf=permerror, err=parse error for token &{10 18 256wvd6dc.spf.checkpoint-spf.com}: parse error for token &{10 18 %{ir}.256wvd6dc.spf.checkpoint-spf.com}: invalid domain name (domain: bmw.de, ip: 207.54.71.126, mailfrom: prvs=698d5dd81=philip.lorenz@bmw.de)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=bmw.de; i=@bmw.de; q=dns/txt; s=mailing1;
  t=1788337967; x=1819873967;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=KK009R/8hGEhOrpbVeBeAcYs008M6m9fXexQ+Sipuyg=;
  b=BDdVyM24da1LF98f2z5akc/+xWhk6ZKC4uGa8jJ3eYuldd/ncbS4f+98
   6iZpE0CSiVNvJcejt5IRRut0ZO47rolY7a53WWuG3yiGaY/FrB+27W8m9
   g184JgB5ih7y5LjdumIPreCPrecbob7IKNLt+v0SIxzK5yOwVou9shtfR
   U=;
X-CSE-ConnectionGUID: T4N1o4cHQaasVP6kaTOl+g==
X-CSE-MsgGUID: RdsMdcJfQfaoO6V/CsUrmg==
Received: from esagw4.bmwgroup.com (HELO esagw4.muc) ([160.46.252.39]) by
 esa7.hc324-48.eu.iphmx.com with ESMTP/TLS; 02 Sep 2026 10:32:44 +0200
Received: from unknown (HELO esabb4.muc) ([10.31.187.135]) by esagw4.muc with
 ESMTP/TLS; 02 Sep 2026 10:32:40 +0200
Received: from smucmp21a.bmwgroup.net (HELO smucmp21a.europe.bmw.corp)
 ([10.100.172.92]) by esabb4.muc with ESMTP/TLS; 02 Sep 2026 10:32:40 +0200
Received: from marvin-ws (10.30.85.210) by smucmp21a.europe.bmw.corp
 (2a03:1e80:a01:524::1:44) with Microsoft SMTP Server (version=TLS;
 Wed, 2 Sep 2026 10:32:40 +0200
X-CSE-ConnectionGUID: WgsU/WHGTPKPDpiwTI9rcg==
X-CSE-MsgGUID: LGRQYj6DQRWyPHhNIDCf4g==
X-CSE-ConnectionGUID: qYtC6EgJTbqOOy71uEc19g==
X-CSE-MsgGUID: cSkwRMj1TbSwYEelalXAxg==
From: Philip Lorenz <philip.lorenz@bmw.de>
To: <bitbake-devel@lists.openembedded.org>
CC: Philip Lorenz <philip.lorenz@bmw.de>
Subject: [RFC PATCH] fetch: `touch` mirror tarball stamp files on download
Date: Wed, 2 Sep 2026 10:32:32 +0200
Message-ID: <20260902083232.825826-1-philip.lorenz@bmw.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: smucmp18a.europe.bmw.corp (2a03:1e80:a15:58f::1:50) To
 smucmp21a.europe.bmw.corp (2a03:1e80:a01:524::1:44)
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 02 Sep 2026 08:32:45 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20147

The mirror tarball stamp file's mtime is currently only updated on
creation / initial download. This makes it difficult to detect whether a
mirror tarball is still relevant in a given build.

Improve this by also `touch`ing the mirror tarball stamp files alongside
the sources primary stamp file.

Signed-off-by: Philip Lorenz <philip.lorenz@bmw.de>
---
 lib/bb/fetch2/__init__.py | 17 ++++++++++++++---
 lib/bb/tests/fetch.py     | 15 +++++++++++++++
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 9cb268be5..7b981b0f3 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -755,13 +755,24 @@ def update_stamp(ud, d):
     if not ud.needdonestamp:
         return
 
-    if os.path.exists(ud.donestamp):
-        # Touch the done stamp file to show active use of the download
+    def bump_utime(path):
         try:
-            os.utime(ud.donestamp, None)
+            os.utime(path, None)
         except:
             # Errors aren't fatal here
             pass
+
+    if os.path.exists(ud.donestamp):
+        # Touch the done stamp file to show active use of the download
+        bump_utime(ud.donestamp)
+
+        # Also mark any mirror tarballs related to the download as being active.
+        dl_dir = d.getVar("DL_DIR")
+        for mirrortarball in ud.mirrortarballs:
+            mirrortarball = os.path.join(dl_dir, mirrortarball) + ".done"
+            # There's no need to check if the file exists as `bump_utime` will
+            # ignore non-existent files.
+            bump_utime(mirrortarball)
     else:
         try:
             checksums = verify_checksum(ud, d)
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index a1e4b45f8..b29d5909f 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -21,6 +21,7 @@ import subprocess
 import json
 import tarfile
 import threading
+import time
 from bb.fetch2 import URI
 import bb
 import bb.utils
@@ -1101,18 +1102,32 @@ class FetcherNetworkTest(FetcherTest):
                                 cwd=os.path.join(self.unpackdir, 'git')).strip()
             self.assertEqual(revision, "270a05b0b4ba0959fe0624d2a4885d7b70426da5")
 
+        def checkdonestamp(fetcher, url, download_timestamp):
+            ud = fetcher.ud[url]
+            self.assertGreaterEqual(os.stat(ud.donestamp).st_mtime, download_timestamp)
+
+            dldir = self.d.getVar("DL_DIR")
+            for mirrortarball in ud.mirrortarballs:
+                mirrortarball = os.path.join(dldir, mirrortarball) + ".done"
+                if os.path.exists(mirrortarball):
+                    self.assertGreaterEqual(os.stat(mirrortarball).st_mtime, download_timestamp)
+
         self.d.setVar("BB_GENERATE_MIRROR_TARBALLS", "1")
         self.d.setVar("SRCREV", "270a05b0b4ba0959fe0624d2a4885d7b70426da5")
         fetcher = bb.fetch.Fetch([url1], self.d)
+        download_timestamp = time.time()
         fetcher.download()
         checkrevision(self, fetcher)
+        checkdonestamp(fetcher, url1, download_timestamp)
         # Wipe out the dldir clone and the unpacked source, turn off the network and check mirror tarball works
         bb.utils.prunedir(self.dldir + "/git2/")
         bb.utils.prunedir(self.unpackdir)
         self.d.setVar("BB_NO_NETWORK", "1")
         fetcher = bb.fetch.Fetch([url2], self.d)
+        download_timestamp = time.time()
         fetcher.download()
         checkrevision(self, fetcher)
+        checkdonestamp(fetcher, url2, download_timestamp)
 
     @skipIfNoNetwork()
     def test_gitfetch(self):
-- 
2.55.0


