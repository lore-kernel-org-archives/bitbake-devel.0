Return-Path: <anuj.mittal@intel.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88835C43217
	for <webhook@archiver.kernel.org>; Tue,  2 Nov 2021 09:02:55 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by mx.groups.io with SMTP id smtpd.web10.6743.1635843773682662604
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 02 Nov 2021 02:02:55 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: intel.com, ip: 134.134.136.126, mailfrom: anuj.mittal@intel.com)
X-IronPort-AV: E=McAfee;i="6200,9189,10155"; a="218125276"
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800";
   d="scan'208";a="218125276"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2021 02:02:54 -0700
X-IronPort-AV: E=Sophos;i="5.87,202,1631602800";
   d="scan'208";a="496847332"
Received: from kehoh-mobl.gar.corp.intel.com (HELO
 anmitta2-mobl1.gar.corp.intel.com) ([10.215.233.28])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2021 02:02:53 -0700
From: Anuj Mittal <anuj.mittal@intel.com>
To: bitbake-devel@lists.openembedded.org
Subject: [1.52][PATCH 2/3] tests/fetch.py: add test case to ensure
 downloadfilename is used for premirror
Date: Tue,  2 Nov 2021 17:02:44 +0800
Message-Id: 
 <16c975f94a178e6f7a2a223b8e3e7450bd6bba85.1635843660.git.anuj.mittal@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1635843660.git.anuj.mittal@intel.com>
References: <cover.1635843660.git.anuj.mittal@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 02 Nov 2021 09:02:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12854

From: Chen Qi <Qi.Chen@windriver.com>

Add a test case test_fetch_premirror_use_downloadfilename_to_fetch to ensure
that 'downloadfilename' is used when fetching from premirror.

Although the other two previous test cases, test_fetch_premirror_specify_downloadfilename_regex_uri
and test_fetch_premirror_specify_downloadfilename_specific_uri already
implicitly contain such verification, we still need to add a very clear
case to ensure no regression.

Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
(cherry picked from commit 20aabc3d53f69949810ecf02295725db947ffef8)
Signed-off-by: Anuj Mittal <anuj.mittal@intel.com>
---
 lib/bb/tests/fetch.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index d06580db8..a008e7cc5 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
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
2.31.1


