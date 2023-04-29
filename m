Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D014C77B7F
	for <webhook@archiver.kernel.org>; Sat, 29 Apr 2023 01:23:42 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web10.38369.1682731417954797019
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Apr 2023 18:23:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=UY8H78dj;
 spf=pass (domain: axis.com, ip: 195.60.68.18, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1682731418;
  x=1714267418;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=fWiwaZCZ/msKyBBNzpjvwn/6DzODNNiXp5UyhbCo6XY=;
  b=UY8H78djIxuUn3F397J8p6wiFi8SKnmxA2c95jSJmpGBemPQA1+3VstX
   gjJLTlHK7uHVnRKpZwofKJnLxQR0c+dxoq4Q9omUHz2+CmMUy5lEe95ZY
   tNNq+C/XrRDZ67PDV4+KiCDgDgtdqb/loJL9vFQB6HjNtgX8hhtSlP1xX
   RY/Cumc8hTCoo9XKsN1sgA50nUeup64/46vMTtrK/izfHlx8zuPq1l4Qz
   le9Ask9XUUvghEmu0CQAvIiXYNMbfhdQHuSAfhVv5i8cF1kKuprxi3ZDb
   rpsy9Iiro7sU1+DiVn7yb0lQ//66aklw2QNIoHPfQ+C1bYZLC+AaClGd5
   A==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [master][mickledore][PATCH 2/2] fetch2/crate: Correct unpack for a crate that matches the recipe name
Date: Sat, 29 Apr 2023 03:23:29 +0200
Message-ID: <20230429012329.1799116-2-pkj@axis.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230429012329.1799116-1-pkj@axis.com>
References: <20230429012329.1799116-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 29 Apr 2023 01:23:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14758

The crate fetcher handles a crate with a name that matches the recipe's
name specially by placing the unpacked code in the current directory
(which typically is ${S}) rather than together with the sources for the
other crates. This broke when the URI names for all crates were changed
recently to include the version in the name.

Correct the crate fetcher to test against ${BP} instead of ${BPN}.
Also add a test case to the selftests to avoid this breaking again.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/fetch2/crate.py |  4 ++--
 bitbake/lib/bb/tests/fetch.py  | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/crate.py b/bitbake/lib/bb/fetch2/crate.py
index 2b8b6bc7a1..3310ed0050 100644
--- a/bitbake/lib/bb/fetch2/crate.py
+++ b/bitbake/lib/bb/fetch2/crate.py
@@ -98,8 +98,8 @@ class Crate(Wget):
         save_cwd = os.getcwd()
         os.chdir(rootdir)
 
-        pn = d.getVar('BPN')
-        if pn == ud.parm.get('name'):
+        bp = d.getVar('BP')
+        if bp == ud.parm.get('name'):
             cmd = "tar -xz --no-same-owner -f %s" % thefile
         else:
             cargo_bitbake = self._cargo_bitbake_path(rootdir)
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 6ef0836f2b..23bfa788db 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -2391,6 +2391,31 @@ class CrateTest(FetcherTest):
         self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitbake/glob-0.2.11/.cargo-checksum.json"))
         self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitbake/glob-0.2.11/src/lib.rs"))
 
+    @skipIfNoNetwork()
+    def test_crate_url_matching_recipe(self):
+
+        self.d.setVar('BP', 'glob-0.2.11')
+
+        uri = "crate://crates.io/glob/0.2.11"
+        self.d.setVar('SRC_URI', uri)
+
+        uris = self.d.getVar('SRC_URI').split()
+        d = self.d
+
+        fetcher = bb.fetch2.Fetch(uris, self.d)
+        ud = fetcher.ud[fetcher.urls[0]]
+
+        self.assertIn("name", ud.parm)
+        self.assertEqual(ud.parm["name"], "glob-0.2.11")
+        self.assertIn("downloadfilename", ud.parm)
+        self.assertEqual(ud.parm["downloadfilename"], "glob-0.2.11.crate")
+
+        fetcher.download()
+        fetcher.unpack(self.tempdir)
+        self.assertEqual(sorted(os.listdir(self.tempdir)), ['download', 'glob-0.2.11', 'unpacked'])
+        self.assertEqual(sorted(os.listdir(self.tempdir + "/download")), ['glob-0.2.11.crate', 'glob-0.2.11.crate.done'])
+        self.assertTrue(os.path.exists(self.tempdir + "/glob-0.2.11/src/lib.rs"))
+
     @skipIfNoNetwork()
     def test_crate_url_params(self):
 

