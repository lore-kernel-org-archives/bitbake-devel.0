Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5808C433FE
	for <webhook@archiver.kernel.org>; Sat, 29 Jan 2022 02:29:44 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web11.1501.1643423382962218181
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 28 Jan 2022 18:29:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=EgXR1rza;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1643423383;
  x=1674959383;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=lRDcb+2+5/hx8BqoxxfXEj3PXCvUFuPfhcfqxsm8bQw=;
  b=EgXR1rza8nQLrV2vUlU7UbyYXK+c9c1/wTlRD7oS3/jN0kE9uVk/UHKf
   YiLvTWU3DavxauO3hnnr8C9b1r+GpHH5P5OJKEjrccYbOklCkPgCpttuN
   QpHVq3yFxKiwz7lDvGAmBcz3SqHaE0JHn7K9/Jcw5mmotm1LrTIVgWw0y
   o4oS2HzVKHBMe7q3wsRj9GnqqrW90ytEGgmDGSAwuuGDRS3eNUpOIgruH
   N3VqmRCJqFH3LvIzaNP9iG8+6whB7qaTWVuZCHcK8/r3EeJZWoCdqUhnj
   94+FV0Afm6tBBwMCbMF8jJPO52TQ6whGo59UQdpyrMAfGuv6qDsM37i7W
   g==;
From: Peter Kjellerstedt <pkj@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Subject: [PATCH 3/9] tests/fetch: Skip the crate tests if network tests are
 disabled
Date: Sat, 29 Jan 2022 03:29:33 +0100
Message-ID: <20220129022939.19329-3-pkj@axis.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20220129022939.19329-1-pkj@axis.com>
References: <20220129022939.19329-1-pkj@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 29 Jan 2022 02:29:44 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13295

Both test_crate_url and test_crate_url_multi require Internet access.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/tests/fetch.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index e1d79bf964..c654662c02 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -2261,6 +2261,7 @@ class GitURLWithSpacesTest(FetcherTest):
             self.assertEqual(ud.fullmirror, os.path.join(self.dldir, "git2_" + ref['gitsrcname'] + '.tar.gz'))
 
 class CrateTest(FetcherTest):
+    @skipIfNoNetwork()
     def test_crate_url(self):
 
         uri = "crate://crates.io/glob/0.2.11"
@@ -2277,6 +2278,7 @@ class CrateTest(FetcherTest):
         self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitbake/glob-0.2.11/.cargo-checksum.json"))
         self.assertTrue(os.path.exists(self.tempdir + "/cargo_home/bitbake/glob-0.2.11/src/lib.rs"))
 
+    @skipIfNoNetwork()
     def test_crate_url_multi(self):
 
         uri = "crate://crates.io/glob/0.2.11 crate://crates.io/time/0.1.35"

