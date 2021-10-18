Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD27C4332F
	for <webhook@archiver.kernel.org>; Mon, 18 Oct 2021 03:45:33 +0000 (UTC)
Received: from mail1.wrs.com (mail1.wrs.com [147.11.3.146])
 by mx.groups.io with SMTP id smtpd.web09.31593.1634528731675022712
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 17 Oct 2021 20:45:32 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=fail (domain: windriver.com, ip: 147.11.3.146, mailfrom: qi.chen@windriver.com)
Received: from mail.windriver.com (mail.wrs.com [147.11.1.11])
	by mail1.wrs.com (8.15.2/8.15.2) with ESMTPS id 19I3jUu8027675
	(version=TLSv1.1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>; Sun, 17 Oct 2021 20:45:30 -0700
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.corp.ad.wrs.com
 [147.11.82.252])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 19I3jTFn008258
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
Subject: [bitbake-devel][PATCH V2 3/3] tests/fetch.py: add test case to ensure
 downloadfilename is used for premirror
Date: Sun, 17 Oct 2021 20:45:29 -0700
Message-ID: <20211018034529.70236-3-Qi.Chen@windriver.com>
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
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12792

Add a test case test_fetch_premirror_use_downloadfilename_to_fetch to ensure
that 'downloadfilename' is used when fetching from premirror.

Although the other two previous test cases, test_fetch_premirror_specify_downloadfilename_regex_uri
and test_fetch_premirror_specify_downloadfilename_specific_uri already
implicitly contain such verification, we still need to add a very clear
case to ensure no regression.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
---
 bitbake/lib/bb/tests/fetch.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index d06580db88..a008e7cc5b 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -887,6 +887,14 @@ class FetcherNetworkTest(FetcherTest):
         fetcher.download()
         self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
 
+    @skipIfNoNetwork()
+    def test_fetch_premirror_use_downloadfilename_to_fetch(self):
+        # Ensure downloadfilename is used when fetching from premirror.
+        self.d.setVar("PREMIRRORS", "http://.*/.* https://downloads.yoctoproject.org/releases/bitbake")
+        fetcher = bb.fetch.Fetch(["http://invalid.yoctoproject.org/releases/bitbake/bitbake-1.1.tar.gz;downloadfilename=bitbake-1.0.tar.gz"], self.d)
+        fetcher.download()
+        self.assertEqual(os.path.getsize(self.dldir + "/bitbake-1.0.tar.gz"), 57749)
+
     @skipIfNoNetwork()
     def gitfetcher(self, url1, url2):
         def checkrevision(self, fetcher):
-- 
2.33.0


