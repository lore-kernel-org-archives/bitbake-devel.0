Received: from ra.se.axis.com ([195.60.68.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1UEjGx-0006r5-9y
	for bitbake-devel@lists.openembedded.org;
	Sun, 10 Mar 2013 17:39:03 +0100
Received: from localhost (localhost [127.0.0.1])
	by ra.se.axis.com (Postfix) with ESMTP id DC79311DF8
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:18 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at ra.se.axis.com
Received: from ra.se.axis.com ([127.0.0.1])
	by localhost (ra.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id XTqrI-FGu+E7 for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:16 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by ra.se.axis.com (Postfix) with ESMTP id 69FE411EFD
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:15 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id 2BF853E2AD
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:15 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.176.0; Sun, 10 Mar 2013
	17:22:15 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 562A69C07C; 
	Sun, 10 Mar 2013 17:22:23 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 10 Mar 2013 17:22:21 +0100
Message-ID: <1362932543-3737-5-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1362932543-3737-1-git-send-email-olof.johansson@axis.com>
References: <1362932543-3737-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [PATCH 4/5] fetch2.URI: Support URIs with both query strings and params
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
X-List-Received-Date: Sun, 10 Mar 2013 16:40:06 -0000
X-List-Received-Date: Sun, 10 Mar 2013 16:40:06 -0000
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
 lib/bb/fetch2/__init__.py |   16 +++++-----------
 lib/bb/tests/fetch.py     |   18 ++++++++++++++++++
 2 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 09e8be2..f890181 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -201,6 +201,10 @@ class URI(object):
         if not uri:
             return
 
+        # We hijack the URL parameters, since the way bitbake uses
+        # them are not quite RFC compliant.
+        uri, param_str = (uri.split(";", 1) + [None])[:2]
+
         urlp = urlparse.urlparse(uri)
         self.scheme = urlp.scheme
 
@@ -235,17 +239,7 @@ class URI(object):
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
index 755ec3f..be21623 100644
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
1.7.10.4



