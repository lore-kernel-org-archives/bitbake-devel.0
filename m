Received: from ra.se.axis.com ([195.60.68.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1U06Cr-00030m-Eh
	for bitbake-devel@lists.openembedded.org;
	Tue, 29 Jan 2013 09:06:16 +0100
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id 2AD2011FE4
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Jan 2013 08:50:33 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id AP37Gv7bHJcL for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Jan 2013 08:50:31 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by ra.se.axis.com (Postfix) with ESMTP id C524F11DF1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Jan 2013 08:50:12 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 856C83415F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Jan 2013 08:50:12 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.176.0; Tue, 29 Jan 2013
	08:50:12 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 36E3F9C079; 
	Tue, 29 Jan 2013 08:50:11 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 29 Jan 2013 08:50:08 +0100
Message-ID: <1359445811-6394-4-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
References: <1358759883-7566-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [PATCH v2 3/6] fetch2: unittests for bb.fetch2.URI class
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 29 Jan 2013 08:06:28 -0000
Content-Type: text/plain

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/tests/fetch.py |  226 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 226 insertions(+)

diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 67eda59..e765ca7 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -21,8 +21,234 @@ import unittest
 import tempfile
 import subprocess
 import os
+from bb.fetch2 import URI
 import bb
 
+class URITest(unittest.TestCase):
+    test_uris = {
+        "http://www.google.com/index.html" : {
+            'uri': 'http://www.google.com/index.html',
+            'scheme': 'http',
+            'hostname': 'www.google.com',
+            'port': None,
+            'hostport': 'www.google.com',
+            'path': '/index.html',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {},
+            'relative': False
+        },
+        "http://www.google.com/index.html;param1=value1" : {
+            'uri': 'http://www.google.com/index.html;param1=value1',
+            'scheme': 'http',
+            'hostname': 'www.google.com',
+            'port': None,
+            'hostport': 'www.google.com',
+            'path': '/index.html',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {
+                'param1': 'value1'
+            },
+            'relative': False
+        },
+        "http://www.example.com:8080/index.html" : {
+            'uri': 'http://www.example.com:8080/index.html',
+            'scheme': 'http',
+            'hostname': 'www.example.com',
+            'port': 8080,
+            'hostport': 'www.example.com:8080',
+            'path': '/index.html',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {},
+            'relative': False
+        },
+        "cvs://anoncvs@cvs.handhelds.org/cvs;module=familiar/dist/ipkg" : {
+            'uri': 'cvs://anoncvs@cvs.handhelds.org/cvs;module=familiar/dist/ipkg',
+            'scheme': 'cvs',
+            'hostname': 'cvs.handhelds.org',
+            'port': None,
+            'hostport': 'cvs.handhelds.org',
+            'path': '/cvs',
+            'userinfo': 'anoncvs',
+            'username': 'anoncvs',
+            'password': '',
+            'params': {
+                'module': 'familiar/dist/ipkg'
+            },
+            'relative': False
+        },
+        "cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=V0-99-81;module=familiar/dist/ipkg": {
+            'uri': 'cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=V0-99-81;module=familiar/dist/ipkg',
+            'scheme': 'cvs',
+            'hostname': 'cvs.handhelds.org',
+            'port': None,
+            'hostport': 'cvs.handhelds.org',
+            'path': '/cvs',
+            'userinfo': 'anoncvs:anonymous',
+            'username': 'anoncvs',
+            'password': 'anonymous',
+            'params': {
+                'tag': 'V0-99-81',
+                'module': 'familiar/dist/ipkg'
+            },
+            'relative': False
+        },
+        "file://example.diff": { # NOTE: Not RFC compliant!
+            'uri': 'file:example.diff',
+            'scheme': 'file',
+            'hostname': '',
+            'port': None,
+            'hostport': '',
+            'path': 'example.diff',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {},
+            'relative': True
+        },
+        "file:example.diff": { # NOTE: RFC compliant version of the former
+            'uri': 'file:example.diff',
+            'scheme': 'file',
+            'hostname': '',
+            'port': None,
+            'hostport': '',
+            'path': 'example.diff',
+            'userinfo': '',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {},
+            'relative': True
+        },
+        "file:///tmp/example.diff": {
+            'uri': 'file:///tmp/example.diff',
+            'scheme': 'file',
+            'hostname': '',
+            'port': None,
+            'hostport': '',
+            'path': '/tmp/example.diff',
+            'userinfo': '',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {},
+            'relative': False
+        },
+        "git:///path/example.git": {
+            'uri': 'git:///path/example.git',
+            'scheme': 'git',
+            'hostname': '',
+            'port': None,
+            'hostport': '',
+            'path': '/path/example.git',
+            'userinfo': '',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {},
+            'relative': False
+        },
+        "git:path/example.git": {
+            'uri': 'git:path/example.git',
+            'scheme': 'git',
+            'hostname': '',
+            'port': None,
+            'hostport': '',
+            'path': 'path/example.git',
+            'userinfo': '',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {},
+            'relative': True
+        },
+        "git://example.net/path/example.git": {
+            'uri': 'git://example.net/path/example.git',
+            'scheme': 'git',
+            'hostname': 'example.net',
+            'port': None,
+            'hostport': 'example.net',
+            'path': '/path/example.git',
+            'userinfo': '',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {},
+            'relative': False
+        }
+    }
+
+    def test_uri(self):
+        for test_uri, ref in self.test_uris.items():
+            uri = URI(test_uri)
+
+            self.assertEqual(str(uri), ref['uri'])
+
+            # expected attributes
+            self.assertEqual(uri.scheme, ref['scheme'])
+
+            self.assertEqual(uri.userinfo, ref['userinfo'])
+            self.assertEqual(uri.username, ref['username'])
+            self.assertEqual(uri.password, ref['password'])
+
+            self.assertEqual(uri.hostname, ref['hostname'])
+            self.assertEqual(uri.port, ref['port'])
+            self.assertEqual(uri.hostport, ref['hostport'])
+
+            self.assertEqual(uri.path, ref['path'])
+            self.assertEqual(uri.params, ref['params'])
+
+            self.assertEqual(uri.relative, ref['relative'])
+
+    def test_dict(self):
+        for test in self.test_uris.values():
+            uri = URI()
+
+            self.assertEqual(uri.scheme, '')
+            self.assertEqual(uri.userinfo, '')
+            self.assertEqual(uri.username, '')
+            self.assertEqual(uri.password, '')
+            self.assertEqual(uri.hostname, '')
+            self.assertEqual(uri.port, None)
+            self.assertEqual(uri.path, '')
+            self.assertEqual(uri.params, {})
+
+
+            uri.scheme = test['scheme']
+            self.assertEqual(uri.scheme, test['scheme'])
+
+            uri.userinfo = test['userinfo']
+            self.assertEqual(uri.userinfo, test['userinfo'])
+            self.assertEqual(uri.username, test['username'])
+            self.assertEqual(uri.password, test['password'])
+
+            uri.hostname = test['hostname']
+            self.assertEqual(uri.hostname, test['hostname'])
+            self.assertEqual(uri.hostport, test['hostname'])
+
+            uri.port = test['port']
+            self.assertEqual(uri.port, test['port'])
+            self.assertEqual(uri.hostport, test['hostport'])
+
+            uri.path = test['path']
+            self.assertEqual(uri.path, test['path'])
+
+            uri.params = test['params']
+            self.assertEqual(uri.params, test['params'])
+
+            self.assertEqual(str(uri)+str(uri.relative), str(test['uri'])+str(test['relative']))
+
+            self.assertEqual(str(uri), test['uri'])
+
+            uri.params = {}
+            self.assertEqual(uri.params, {})
+            self.assertEqual(str(uri), (str(uri).split(";"))[0])
+
 
 class FetcherTest(unittest.TestCase):
 
-- 
1.7.10.4



