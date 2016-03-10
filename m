Return-Path: <alex@stunpix.com>
Received: from forward20m.cmail.yandex.net (forward20m.cmail.yandex.net
	[5.255.216.151])
	by mail.openembedded.org (Postfix) with ESMTP id 200C8607F8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Mar 2016 22:00:27 +0000 (UTC)
Received: from smtp1m.mail.yandex.net (smtp1m.mail.yandex.net
	[IPv6:2a02:6b8:0:2519::121])
	by forward20m.cmail.yandex.net (Yandex) with ESMTP id 6CE5721F31
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Mar 2016 01:00:27 +0300 (MSK)
Received: from smtp1m.mail.yandex.net (localhost [127.0.0.1])
	by smtp1m.mail.yandex.net (Yandex) with ESMTP id 244E267405C3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Mar 2016 01:00:27 +0300 (MSK)
Received: by smtp1m.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	GEvv3rc66w-0QE48Eo0; Fri, 11 Mar 2016 01:00:26 +0300
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stunpix.com; s=mail;
	t=1457647226; bh=IHVzNZGOHbwCGFXxzpBE8pAq94lvC/NIFBYcKhq5XLc=;
	h=From:To:Subject:Date:Message-Id:X-Mailer;
	b=h8ES+vIdDvMcGKB1Ptw4VlyZi/JgpT+bcLRSlRZ/ylL28PMIaU1ZX0zA0DCBASGkF
	RPSPg9rEJHmxdz8w7vMKetSx8Fo9Sr/e4hoEq9NChFYWK5WKkHC/xrlP/oS3s82Eyn
	6BJXq5dz2AAXVWDvgAkelqiNK8tTXr7XR6nbLRtM=
Authentication-Results: smtp1m.mail.yandex.net; dkim=pass header.i=@stunpix.com
X-Yandex-ForeignMX: US
X-Yandex-Suid-Status: 1 0
From: Alexander Shashkevich <alex@stunpix.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 10 Mar 2016 23:58:07 +0200
Message-Id: <1457647087-97827-1-git-send-email-alex@stunpix.com>
X-Mailer: git-send-email 2.5.0
Subject: [PATCH] tests/fetch: new test case for absolute paths with wildcards
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 10 Mar 2016 22:00:30 -0000

Signed-off-by: Alexander Shashkevich <alex@stunpix.com>
---
 bitbake/lib/bb/tests/fetch.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index b3de37e..80b5f17 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -497,6 +497,11 @@ class FetcherLocalTest(FetcherTest):
         tree = self.fetchUnpack([abspath + '/dir/subdir/', abspath + '/dir/subdir/;subdir=bar'])
         self.assertEqual(tree, ['bar/subdir/e', 'subdir/e'])
 
+    def test_local_abspath_wildcard(self):
+        abspath = 'file://%s' % self.localsrcdir
+        tree = self.fetchUnpack([abspath + '/dir/*', abspath + '/dir/*;subdir=bar'])
+        self.assertEqual(tree, ['bar/c', 'bar/d', 'bar/subdir/e', 'c', 'd', 'subdir/e'])
+
 class FetcherNetworkTest(FetcherTest):
 
     if os.environ.get("BB_SKIP_NETTESTS") == "yes":
-- 
2.5.0


