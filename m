Return-Path: <olof.johansson@axis.com>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by mail.openembedded.org (Postfix) with ESMTP id 8EA326E71B
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 11:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id E7E4D19DE4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Ln3RIzstu+nR for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:42 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id 8B1F619DD7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 70E50C6F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.se.axis.com (Postfix) with ESMTP id 64E48C6C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 6125C3E070
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.255.0; Mon, 20 Jan 2014
	12:03:25 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 274F79C07C; 
	Mon, 20 Jan 2014 12:03:24 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Jan 2014 12:03:22 +0100
Message-ID: <1390215804-20578-4-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390215804-20578-1-git-send-email-olof.johansson@axis.com>
References: <1390215804-20578-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [PATCH 3/5] fetch2.URI: add support for query parameters
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
X-List-Received-Date: Mon, 20 Jan 2014 11:03:46 -0000
Content-Type: text/plain

This change introduces the .query property of the URI class. It is a
read/write dict of the parameters supplied in the query string of the
URI. E.g.:

  http://example.com/?foo=bar => .query = {'foo': 'bar'}

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/fetch2/__init__.py | 38 +++++++++++++++++++++++---------------
 lib/bb/tests/fetch.py     | 30 ++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 15 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 9c201aa..2ebdafa 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -162,6 +162,7 @@ class URI(object):
       * path_quoted (read/write)
         A URI quoted version of path
       * params (dict) (read/write)
+      * query (dict) (read/write)
       * relative (bool) (read only)
         True if this is a "relative URI", (e.g. file:foo.diff)
 
@@ -201,6 +202,7 @@ class URI(object):
         self.port = None
         self._path = ''
         self.params = {}
+        self.query = {}
         self.relative = False
 
         if not uri:
@@ -253,36 +255,42 @@ class URI(object):
         self.path = urllib.unquote(path)
 
         if param_str:
-            self.params = self._param_dict(param_str)
+            self.params = self._param_str_split(param_str, ";")
+        if urlp.query:
+            self.query = self._param_str_split(urlp.query, "&")
 
     def __str__(self):
         userinfo = self.userinfo
         if userinfo:
             userinfo += '@'
 
-        return "%s:%s%s%s%s%s" % (
+        return "%s:%s%s%s%s%s%s" % (
             self.scheme,
             '' if self.relative else '//',
             userinfo,
             self.hostport,
             self.path_quoted,
-            self._param_str)
+            self._query_str(),
+            self._param_str())
 
-    @property
     def _param_str(self):
-        ret = ''
-        for key, val in self.params.items():
-            ret += ";%s=%s" % (key, val)
+        return (
+            ''.join([';', self._param_str_join(self.params, ";")])
+            if self.params else '')
+
+    def _query_str(self):
+        return (
+            ''.join(['?', self._param_str_join(self.query, "&")])
+            if self.query else '')
+
+    def _param_str_split(self, string, elmdelim, kvdelim="="):
+        ret = {}
+        for k, v in [x.split(kvdelim, 1) for x in string.split(elmdelim)]:
+            ret[k] = v
         return ret
 
-    def _param_dict(self, param_str):
-        parm = {}
-
-        for keyval in param_str.split(";"):
-            key, val = keyval.split("=", 1)
-            parm[key] = val
-
-        return parm
+    def _param_str_join(self, dict_, elmdelim, kvdelim="="):
+        return elmdelim.join([kvdelim.join([k, v]) for k, v in dict_.items()])
 
     @property
     def hostport(self):
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 3dbeafa..5169496 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -39,6 +39,7 @@ class URITest(unittest.TestCase):
             'username': '',
             'password': '',
             'params': {},
+            'query': {},
             'relative': False
         },
         "http://www.google.com/index.html;param1=value1" : {
@@ -54,6 +55,23 @@ class URITest(unittest.TestCase):
             'params': {
                 'param1': 'value1'
             },
+            'query': {},
+            'relative': False
+        },
+        "http://www.example.org/index.html?param1=value1" : {
+            'uri': 'http://www.example.org/index.html?param1=value1',
+            'scheme': 'http',
+            'hostname': 'www.example.org',
+            'port': None,
+            'hostport': 'www.example.org',
+            'path': '/index.html',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {},
+            'query': {
+                'param1': 'value1'
+            },
             'relative': False
         },
         "http://www.example.com:8080/index.html" : {
@@ -67,6 +85,7 @@ class URITest(unittest.TestCase):
             'username': '',
             'password': '',
             'params': {},
+            'query': {},
             'relative': False
         },
         "cvs://anoncvs@cvs.handhelds.org/cvs;module=familiar/dist/ipkg" : {
@@ -82,6 +101,7 @@ class URITest(unittest.TestCase):
             'params': {
                 'module': 'familiar/dist/ipkg'
             },
+            'query': {},
             'relative': False
         },
         "cvs://anoncvs:anonymous@cvs.handhelds.org/cvs;tag=V0-99-81;module=familiar/dist/ipkg": {
@@ -98,6 +118,7 @@ class URITest(unittest.TestCase):
                 'tag': 'V0-99-81',
                 'module': 'familiar/dist/ipkg'
             },
+            'query': {},
             'relative': False
         },
         "file://example.diff": { # NOTE: Not RFC compliant!
@@ -111,6 +132,7 @@ class URITest(unittest.TestCase):
             'username': '',
             'password': '',
             'params': {},
+            'query': {},
             'relative': True
         },
         "file:example.diff": { # NOTE: RFC compliant version of the former
@@ -125,6 +147,7 @@ class URITest(unittest.TestCase):
             'username': '',
             'password': '',
             'params': {},
+            'query': {},
             'relative': True
         },
         "file:///tmp/example.diff": {
@@ -139,6 +162,7 @@ class URITest(unittest.TestCase):
             'username': '',
             'password': '',
             'params': {},
+            'query': {},
             'relative': False
         },
         "git:///path/example.git": {
@@ -153,6 +177,7 @@ class URITest(unittest.TestCase):
             'username': '',
             'password': '',
             'params': {},
+            'query': {},
             'relative': False
         },
         "git:path/example.git": {
@@ -167,6 +192,7 @@ class URITest(unittest.TestCase):
             'username': '',
             'password': '',
             'params': {},
+            'query': {},
             'relative': True
         },
         "git://example.net/path/example.git": {
@@ -181,6 +207,7 @@ class URITest(unittest.TestCase):
             'username': '',
             'password': '',
             'params': {},
+            'query': {},
             'relative': False
         }
     }
@@ -243,6 +270,9 @@ class URITest(unittest.TestCase):
             uri.params = test['params']
             self.assertEqual(uri.params, test['params'])
 
+            uri.query = test['query']
+            self.assertEqual(uri.query, test['query'])
+
             self.assertEqual(str(uri), test['uri'])
 
             uri.params = {}
-- 
1.8.5.2


