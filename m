Return-Path: <olof.johansson@axis.com>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by mail.openembedded.org (Postfix) with ESMTP id 8CD746CBD7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 11:03:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 1804C19DB2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:42 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id xXWmYEkoWpY5 for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:41 +0100 (CET)
Received: from boulder.se.axis.com (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id 548A719DD2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from boulder.se.axis.com (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id 3DD74C6E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from thoth.se.axis.com (thoth.se.axis.com [10.0.2.173])
	by boulder.se.axis.com (Postfix) with ESMTP id 31E65C6C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by thoth.se.axis.com (Postfix) with ESMTP id 2F9373404E
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 12:03:25 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.255.0; Mon, 20 Jan 2014
	12:03:25 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 0046C9C083; 
	Mon, 20 Jan 2014 12:03:24 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Jan 2014 12:03:20 +0100
Message-ID: <1390215804-20578-2-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.8.5.2
In-Reply-To: <1390215804-20578-1-git-send-email-olof.johansson@axis.com>
References: <1390215804-20578-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [PATCH 1/5] fetch2.URI: Coerce urlparse to use netloc for all schemes
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
X-List-Received-Date: Mon, 20 Jan 2014 11:03:45 -0000
Content-Type: text/plain

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/fetch2/__init__.py | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 9499a91..9c201aa 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -33,9 +33,6 @@ import glob
 import logging
 import urllib
 import urlparse
-if 'git' not in urlparse.uses_netloc:
-    urlparse.uses_netloc.append('git')
-from urlparse import urlparse
 import operator
 import bb.persist_data, bb.utils
 import bb.checksum
@@ -209,13 +206,25 @@ class URI(object):
         if not uri:
             return
 
-        urlp = urlparse(uri)
+        urlp = urlparse.urlparse(uri)
         self.scheme = urlp.scheme
 
-        # Convert URI to be relative
+        reparse = 0
+
+        # Coerce urlparse to make URI scheme use netloc
+        if not self.scheme in urlparse.uses_netloc:
+            urlparse.uses_params.append(self.scheme)
+            reparse = 1
+
+        # Make urlparse happy(/ier) by converting local resources
+        # to RFC compliant URL format. E.g.:
+        #   file://foo.diff -> file:foo.diff
         if urlp.scheme in self._netloc_forbidden:
             uri = re.sub("(?<=:)//(?!/)", "", uri, 1)
-            urlp = urlparse(uri)
+            reparse = 1
+
+        if reparse:
+            urlp = urlparse.urlparse(uri)
 
         # Identify if the URI is relative or not
         if urlp.scheme in self._relative_schemes and \
-- 
1.8.5.2


