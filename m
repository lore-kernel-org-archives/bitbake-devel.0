Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 91CA760167
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 24 Sep 2014 14:23:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s8OEMcda018660 for <bitbake-devel@lists.openembedded.org>;
	Wed, 24 Sep 2014 15:23:16 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id BIZvo38WzoTm for <bitbake-devel@lists.openembedded.org>;
	Wed, 24 Sep 2014 15:23:16 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	s8OENB51018773
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 24 Sep 2014 15:23:12 +0100
Message-ID: <1411568594.4189.56.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 24 Sep 2014 15:23:14 +0100
X-Mailer: Evolution 3.10.4-0ubuntu2 
Mime-Version: 1.0
Subject: [PATCH] fetch: Extend testing of subdir unpack parameter and fix
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
X-List-Received-Date: Wed, 24 Sep 2014 14:23:23 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This fixes urls of the form file://some/path/file;subdir=b. It also
adds in a couple of tests so we now tests these corner cases.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 66f0e36..2e147ec 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1264,6 +1264,8 @@ class FetchMethod(object):
                     # items.  So, only do so for file:// entries.
                     if urldata.type == "file" and urldata.path.find("/") != -1:
                        destdir = urldata.path.rsplit("/", 1)[0]
+                       if urldata.parm.get('subdir') != None:
+                          destdir = urldata.parm.get('subdir') + "/" + destdir
                     else:
                        if urldata.parm.get('subdir') != None:
                           destdir = urldata.parm.get('subdir')
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 0476541..8db7575 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -445,6 +445,13 @@ class FetcherLocalTest(FetcherTest):
         tree = self.fetchUnpack(['file://dir/subdir/e'])
         self.assertEqual(tree, ['dir/subdir/e'])
 
+    def test_local_subdirparam(self):
+        tree = self.fetchUnpack(['file://a;subdir=bar'])
+        self.assertEqual(tree, ['bar/a'])
+
+    def test_local_deepsubdirparam(self):
+        tree = self.fetchUnpack(['file://dir/subdir/e;subdir=bar'])
+        self.assertEqual(tree, ['bar/dir/subdir/e'])
 
 class FetcherNetworkTest(FetcherTest):
 



