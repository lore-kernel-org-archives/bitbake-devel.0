Return-Path: <liu.ming50@gmail.com>
Received: from mail-lf0-f53.google.com (mail-lf0-f53.google.com
	[209.85.215.53])
	by mail.openembedded.org (Postfix) with ESMTP id 73EE377309
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Nov 2015 18:15:56 +0000 (UTC)
Received: by lffz63 with SMTP id z63so57254328lff.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Nov 2015 10:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=jdlrorhPTvuYxj2kpQwA7w/PMKfEfcyYmsjsc2sPJSU=;
	b=KTktFYw8LFFSPtoeLJ86X1qtUZm2Ubj4wAqwu7WPbyve/w/lFMZCrLKh6Lqp0IUVVd
	mRMbRv3fi1Pno7Ui93ji4mipUWU9BV5mD3VRaWGaXGSnEsxkChgWfdgi22Z9yowgcbS7
	7uHtclcy72sCDq3NRbj66DY2xLNm382jBc4IpSyE+/4eZs7mR9HTIeSp8M4Tldw5QGgN
	vIgr+F2nKtma4Oo90fnf63akUqZtzm0dEQrg8P47lCpfViAEJ5G3CgHNAXbqq2IUxmvJ
	8YjcWQDhJcHfuK3puDoMfyOH5bveMRQHZxMzPN1qwqlOIfRLo1vM1DvpJVcXs2Rf/aEE
	E6cA==
X-Received: by 10.25.162.65 with SMTP id l62mr1101666lfe.64.1447438556208;
	Fri, 13 Nov 2015 10:15:56 -0800 (PST)
Received: from localhost.localdomain (m77-218-247-203.cust.tele2.se.
	[77.218.247.203]) by smtp.gmail.com with ESMTPSA id
	au8sm3290941lbc.31.2015.11.13.10.15.55
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 13 Nov 2015 10:15:55 -0800 (PST)
From: Ming Liu <liu.ming50@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Nov 2015 19:15:32 +0100
Message-Id: <1447438532-9595-2-git-send-email-liu.ming50@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1447438532-9595-1-git-send-email-liu.ming50@gmail.com>
References: <1447438532-9595-1-git-send-email-liu.ming50@gmail.com>
Cc: Ming Liu <peter.x.liu@external.atlascopco.com>
Subject: [OE-core] [PATCH 2/2] tests/fetch.py: adds test_local_dir_subdirparam test case
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
X-List-Received-Date: Fri, 13 Nov 2015 18:15:56 -0000

From: Ming Liu <peter.x.liu@external.atlascopco.com>

Also renames test_local_subdirparam to test_local_file_subdirparam to
distinguish with test_local_dir_subdirparam.

Signed-off-by: Ming Liu <peter.x.liu@external.atlascopco.com>
---
 lib/bb/tests/fetch.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 94173c1..435cd91 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -469,10 +469,14 @@ class FetcherLocalTest(FetcherTest):
         tree = self.fetchUnpack(['file://dir/subdir/e'])
         self.assertEqual(tree, ['dir/subdir/e'])
 
-    def test_local_subdirparam(self):
+    def test_local_file_subdirparam(self):
         tree = self.fetchUnpack(['file://a;subdir=bar'])
         self.assertEqual(tree, ['bar/a'])
 
+    def test_local_dir_subdirparam(self):
+        tree = self.fetchUnpack(['file://dir;subdir=bar'])
+        self.assertEqual(tree, ['bar/dir/c', 'bar/dir/d', 'bar/dir/subdir/e'])
+
     def test_local_deepsubdirparam(self):
         tree = self.fetchUnpack(['file://dir/subdir/e;subdir=bar'])
         self.assertEqual(tree, ['bar/dir/subdir/e'])
-- 
1.9.1


