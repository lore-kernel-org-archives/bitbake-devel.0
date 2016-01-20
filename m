Return-Path: <olof.johansson@axis.com>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
	by mail.openembedded.org (Postfix) with ESMTP id 012E86E668
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jan 2016 13:58:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bes.se.axis.com (Postfix) with ESMTP id B50A12E15A
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jan 2016 14:58:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
Received: from bes.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bes.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 8fMQFn8t8O+4 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jan 2016 14:57:59 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by bes.se.axis.com (Postfix) with ESMTP id A28712E0CA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jan 2016 14:57:59 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 873E9157E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jan 2016 14:57:59 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 79850A5E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jan 2016 14:57:59 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 768BD3426B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jan 2016 14:57:59 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.3.342.0; Wed, 20 Jan 2016
	14:57:59 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 2FDB99C724; 
	Wed, 20 Jan 2016 14:57:59 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 20 Jan 2016 14:57:59 +0100
Message-ID: <1453298279-12141-1-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Subject: [PATCH] tests/fetch.py: add simple git fetcher specific tests
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
X-List-Received-Date: Wed, 20 Jan 2016 13:58:01 -0000
Content-Type: text/plain

Currently, only Git._get_repo_url is tested to make sure that the URLs
used in the git fetcher isn't mangled in a non-compatible way.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 bitbake/lib/bb/tests/fetch.py | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index b175a43..c9d9e9f 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -23,8 +23,10 @@ import unittest
 import tempfile
 import subprocess
 import os
+from urlparse import urlparse
 from bb.fetch2 import URI
 from bb.fetch2 import FetchMethod
+from bb.fetch2.git import Git
 import bb
 
 class URITest(unittest.TestCase):
@@ -640,6 +642,34 @@ class URLHandle(unittest.TestCase):
             result = bb.fetch.encodeurl(v)
             self.assertEqual(result, k)
 
+class GitFetchTests(unittest.TestCase):
+    class TestFetchData(object):
+        """
+        Ad-Hoc mocked FetchData for the purpose of testing Git()
+        """
+        def __init__(self, url):
+            urlp = urlparse(url)
+            if '@' in urlp.netloc:
+                self.user, self.host = urlp.netloc.split('@', 1) + [None,]
+            else:
+                self.user, self.host = None, urlp.netloc
+            self.proto = urlp.scheme
+            self.path = urlp.path
+
+    tests = [
+       'http://git.example.com/repo.git',
+       'https://git.example.com:1234/repo.git',
+       'git://git.example.com/repo',
+    ]
+
+    def setUp(self):
+        self.git = Git(None)
+        pass
+
+    def test_get_repo_url(self):
+        for url in self.tests:
+            self.assertEqual(self.git._get_repo_url(self.TestFetchData(url)), url)
+
 class FetchLatestVersionTest(FetcherTest):
 
     test_git_uris = {
-- 
2.1.4


