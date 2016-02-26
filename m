Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5D28B77477
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 17:49:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1QHncd7008973 for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 17:49:38 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id WcX6Mk7_rTTm for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 17:49:38 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1QHnXME008969
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 17:49:34 GMT
Message-ID: <1456508973.11498.98.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 26 Feb 2016 17:49:33 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] fetch2/__init__: Fix decodeurl to better handle urls without paths
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
X-List-Received-Date: Fri, 26 Feb 2016 17:49:38 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

If we specify urls such as npm://somehost;someparams the fetcher currently
does a poor job of handling mirrors of these urls due to deficiencies in the
way decodeurl works. This is because "somehost" is returned as a path, not
a host.

This tweaks the code so that unless its a file url, the host is returned
correctly.

This patch also adds test cases for these urls to the exist set of test
urls.

We need to tweak the URI() class since this thinks this is a relative url
which is clearly isn't. We also need to handle the fact that encodeurl will
error if passed a url of this form (it would want the path to be '/'.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 6d00703..058adf2 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -327,7 +327,7 @@ class URI(object):
     def path(self, path):
         self._path = path
 
-        if re.compile("^/").match(path):
+        if not path or re.compile("^/").match(path):
             self.relative = False
         else:
             self.relative = True
@@ -375,9 +375,12 @@ def decodeurl(url):
     if locidx != -1 and type.lower() != 'file':
         host = location[:locidx]
         path = location[locidx:]
-    else:
+    elif type.lower() == 'file':
         host = ""
         path = location
+    else:
+        host = location
+        path = ""
     if user:
         m = re.compile('(?P<user>[^:]+)(:?(?P<pswd>.*))').match(user)
         if m:
diff --git a/bitbake/lib/bb/tests/fetch.py b/bitbake/lib/bb/tests/fetch.py
index 850e2ba..f6b11d5 100644
--- a/bitbake/lib/bb/tests/fetch.py
+++ b/bitbake/lib/bb/tests/fetch.py
@@ -228,7 +228,38 @@ class URITest(unittest.TestCase):
             'params': {},
             'query': {},
             'relative': False
+        },
+        "http://somesite.net;someparam=1": {
+            'uri': 'http://somesite.net;someparam=1',
+            'scheme': 'http',
+            'hostname': 'somesite.net',
+            'port': None,
+            'hostport': 'somesite.net',
+            'path': '',
+            'userinfo': '',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {"someparam" : "1"},
+            'query': {},
+            'relative': False
+        },
+        "file://somelocation;someparam=1": {
+            'uri': 'file:somelocation;someparam=1',
+            'scheme': 'file',
+            'hostname': '',
+            'port': None,
+            'hostport': '',
+            'path': 'somelocation',
+            'userinfo': '',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {"someparam" : "1"},
+            'query': {},
+            'relative': True
         }
+
     }
 
     def test_uri(self):
@@ -623,11 +654,18 @@ class URLHandle(unittest.TestCase):
        "http://www.google.com/index.html" : ('http', 'www.google.com', '/index.html', '', '', {}),
        "cvs://anoncvs@cvs.handhelds.org/cvs;module=familiar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', '', {'module': 'familiar/dist/ipkg'}),
        "cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=V0-99-81;module=familiar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', 'anonymous', {'tag': 'V0-99-81', 'module': 'familiar/dist/ipkg'}),
-       "git://git.openembedded.org/bitbake;branch=@foo" : ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo'})
+       "git://git.openembedded.org/bitbake;branch=@foo" : ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo'}),
+       "file://somelocation;someparam=1": ('file', '', 'somelocation', '', '', {'someparam': '1'}),
     }
+    # we require a pathname to encodeurl but users can still pass such urls to 
+    # decodeurl and we need to handle them
+    decodedata = datatable.copy()
+    decodedata.update({
+       "http://somesite.net;someparam=1": ('http', 'somesite.net', '', '', '', {'someparam': '1'}),
+    })
 
     def test_decodeurl(self):
-        for k, v in self.datatable.items():
+        for k, v in self.decodedata.items():
             result = bb.fetch.decodeurl(k)
             self.assertEqual(result, v)
 



