Return-Path: <olof.johansson@axis.com>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by mail.openembedded.org (Postfix) with ESMTP id 3ECCB6E71D
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 11:03:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 1720219E6F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id hLSuuKyZSzKU for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:45 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id 5481919DD0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 3DCD0BB0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 330B170A
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 3047034055
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.255.0; Mon, 20 Jan 2014
	12:03:25 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 14B969C075; 
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Jan 2014 12:03:23 +0100
Message-ID: <1390215804-20578-5-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390215804-20578-1-git-send-email-olof.johansson@axis.com>
References: <1390215804-20578-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [PATCH 4/5] fetch2.URI: Support URIs with both query strings and params
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

There is a case in meta-intel where a SRC_URI contains both a query string and
URI parameter:

 https://edc.intel.com/Download.aspx?id=6190;downloadfilename=LIN_IEMGD_1_14_GOLD_2443.tgz

Python's urlparse thought the URI parameters were part of the query parameter
value, but in the bitbake context this is obviously not the case. As bitbake's
usage isn't really RFC compliant, we have to extract and remove the URI parameters
*before* urlparse sees the URI.

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/fetch2/__init__.py | 16 +++++-----------
 lib/bb/tests/fetch.py     | 18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 2ebdafa..abff9e2 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -208,6 +208,10 @@ class URI(object):
         if not uri:
             return
 
+        # We hijack the URL parameters, since the way bitbake uses
+        # them are not quite RFC compliant.
+        uri, param_str = (uri.split(";", 1) + [None])[:2]
+
         urlp = urlparse.urlparse(uri)
         self.scheme = urlp.scheme
 
@@ -242,17 +246,7 @@ class URI(object):
             if urlp.password:
                 self.userinfo += ':%s' % urlp.password
 
-        # Do support params even for URI schemes that Python's
-        # urlparse doesn't support params for.
-        path = ''
-        param_str = ''
-        if not urlp.params:
-            path, param_str = (list(urlp.path.split(";", 1)) + [None])[:2]
-        else:
-            path = urlp.path
-            param_str = urlp.params
-
-        self.path = urllib.unquote(path)
+        self.path = urllib.unquote(urlp.path)
 
         if param_str:
             self.params = self._param_str_split(param_str, ";")
diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
index 5169496..6ffe296 100644
--- a/lib/bb/tests/fetch.py
+++ b/lib/bb/tests/fetch.py
@@ -74,6 +74,24 @@ class URITest(unittest.TestCase):
             },
             'relative': False
         },
+        "http://www.example.org/index.html?qparam1=qvalue1;param2=value2" : {
+            'uri': 'http://www.example.org/index.html?qparam1=qvalue1;param2=value2',
+            'scheme': 'http',
+            'hostname': 'www.example.org',
+            'port': None,
+            'hostport': 'www.example.org',
+            'path': '/index.html',
+            'userinfo': '',
+            'username': '',
+            'password': '',
+            'params': {
+                'param2': 'value2'
+            },
+            'query': {
+                'qparam1': 'qvalue1'
+            },
+            'relative': False
+        },
         "http://www.example.com:8080/index.html" : {
             'uri': 'http://www.example.com:8080/index.html',
             'scheme': 'http',
-- 
1.8.5.2


