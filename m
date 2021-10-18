Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EFCC433F5
	for <webhook@archiver.kernel.org>; Mon, 18 Oct 2021 03:45:33 +0000 (UTC)
Received: from mail1.wrs.com (mail1.wrs.com [147.11.3.146])
 by mx.groups.io with SMTP id smtpd.web09.31594.1634528731783725712
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 17 Oct 2021 20:45:32 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=fail (domain: windriver.com, ip: 147.11.3.146, mailfrom: qi.chen@windriver.com)
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
	by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 19I3jUOb027674
	(version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Sun, 17 Oct 2021 20:45:30 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com
 [147.11.82.252])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 19I3jTFm008258
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
 Sun, 17 Oct 2021 20:45:30 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Sun, 17 Oct 2021 20:45:29 -0700
Received: from ala-lpggp7.wrs.com (147.11.105.171) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2242.12 via Frontend Transport; Sun, 17 Oct 2021 20:45:29 -0700
From: Chen Qi <Qi.Chen@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [bitbake-devel][PATCH V2 2/3] tests/fetch.py: fix premirror test
 cases
Date: Sun, 17 Oct 2021 20:45:28 -0700
Message-ID: <20211018034529.70236-2-Qi.Chen@windriver.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211018034529.70236-1-Qi.Chen@windriver.com>
References: <20211018034529.70236-1-Qi.Chen@windriver.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Oct 2021 03:45:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12791

When downloadfilename is specified, it is used to fetch from premirror.
So fix the test cases accordingly.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/tests/fetch.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 8ad1c85990..d06580db88 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -875,17 +875,17 @@ class FetcherNetworkTest(FetcherTest):
     @skipIfNoNetwork()
     def test_fetch_premirror_specify_downloadfilename_regex_uri(self):
         self.d.setVar("PREMIRRORS", "http://.*/.* https://downloads.yoctoproject.org/releases/bitbake/")
-        fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz;downloadfilename=bitbake-v1.0.0.tar.gz"], self.d)
+        fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/1.0.tar.gz;downloadfilename=bitbake-1.0.tar.gz"], self.d)
         fetcher.download()
-        self.assertEqual(os.path.getsize(self.dldir + "/bitbake-v1.0.0.tar.gz"), 57749)
+        self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
 
     @skipIfNoNetwork()
     # BZ13039
     def test_fetch_premirror_specify_downloadfilename_specific_uri(self):
         self.d.setVar("PREMIRRORS", "http://invalid.yoctoproject.org/releases/bitbake https://downloads.yoctoproject.org/releases/bitbake")
-        fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz;downloadfilename=bitbake-v1.0.0.tar.gz"], self.d)
+        fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/1.0.tar.gz;downloadfilename=bitbake-1.0.tar.gz"], self.d)
         fetcher.download()
-        self.assertEqual(os.path.getsize(self.dldir + "/bitbake-v1.0.0.tar.gz"), 57749)
+        self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
 
     @skipIfNoNetwork()
     def gitfetcher(self, url1, url2):
-- 
2.33.0


