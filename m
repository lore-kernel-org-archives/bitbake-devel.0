Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id EF51062137
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 09:55:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4C9txIc031189 for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 10:55:59 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id P6tVIPigSzoa for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 10:55:59 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u4C9tv61031177
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 May 2016 10:55:58 +0100
Message-ID: <1463046957.9746.5.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 12 May 2016 10:55:57 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] fetch: Use OrderedDict for url parameters
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
X-List-Received-Date: Thu, 12 May 2016 09:55:59 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Without this, the dict can reorder causing sanity test failures.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 3082b19..af7162b 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -292,7 +292,7 @@ class URI(object):
             if self.query else '')
 
     def _param_str_split(self, string, elmdelim, kvdelim="="):
-        ret = {}
+        ret = collections.OrderedDict()
         for k, v in [x.split(kvdelim, 1) for x in string.split(elmdelim)]:
             ret[k] = v
         return ret
@@ -385,7 +385,7 @@ def decodeurl(url):
         user = ''
         pswd = ''
 
-    p = {}
+    p = collections.OrderedDict()
     if parm:
         for s in parm.split(';'):
             if s:
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 659f97d..49a6c65 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -22,6 +22,7 @@
 import unittest
 import tempfile
 import subprocess
+import collections
 import os
 from bb.fetch2 import URI
 from bb.fetch2 import FetchMethod
@@ -133,10 +134,10 @@ class URITest(unittest.TestCase):
             'userinfo': 'anoncvs:anonymous',
             'username': 'anoncvs',
             'password': 'anonymous',
-            'params': {
-                'tag': 'V0-99-81',
-                'module': 'familiar/dist/ipkg'
-            },
+            'params': collections.OrderedDict([
+                ('tag', 'V0-99-81'),
+                ('module', 'familiar/dist/ipkg')
+            ]),
             'query': {},
             'relative': False
         },
@@ -660,7 +661,7 @@ class URLHandle(unittest.TestCase):
     datatable = {
        "http://www.google.com/index.html" : ('http', 'www.google.com', '/index.html', '', '', {}),
        "cvs://anoncvs@cvs.handhelds.org/cvs;module=familiar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', '', {'module': 'familiar/dist/ipkg'}),
-       "cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=V0-99-81;module=familiar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', 'anonymous', {'tag': 'V0-99-81', 'module': 'familiar/dist/ipkg'}),
+       "cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=V0-99-81;module=familiar/dist/ipkg" : ('cvs', 'cvs.handhelds.org', '/cvs', 'anoncvs', 'anonymous', collections.OrderedDict([('tag', 'V0-99-81'), ('module', 'familiar/dist/ipkg')])),
        "git://git.openembedded.org/bitbake;branch=@foo" : ('git', 'git.openembedded.org', '/bitbake', '', '', {'branch': '@foo'}),
        "file://somelocation;someparam=1": ('file', '', 'somelocation', '', '', {'someparam': '1'}),
     }


