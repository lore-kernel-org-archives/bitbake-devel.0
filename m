Received: from anubis.se.axis.com ([195.60.68.12])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1UEjGv-0006qu-Ct
	for bitbake-devel@lists.openembedded.org;
	Sun, 10 Mar 2013 17:38:53 +0100
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id C5A6519DC9
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id TaR+xOftfszj for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:15 +0100 (CET)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by anubis.se.axis.com (Postfix) with ESMTP id 388E719DC5
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:14 +0100 (CET)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id EDF7C3E2AA
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 10 Mar 2013 17:22:14 +0100 (CET)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.176.0; Sun, 10 Mar 2013
	17:22:14 +0100
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id 1ED719C076; 
	Sun, 10 Mar 2013 17:22:23 +0100 (CET)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Sun, 10 Mar 2013 17:22:18 +0100
Message-ID: <1362932543-3737-2-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1362932543-3737-1-git-send-email-olof.johansson@axis.com>
References: <1362932543-3737-1-git-send-email-olof.johansson@axis.com>
MIME-Version: 1.0
Subject: [PATCH 1/5] fetch2.URI: Coerce urlparse to use netloc for all schemes
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
X-List-Received-Date: Sun, 10 Mar 2013 16:38:55 -0000
Content-Type: text/plain

With this change, we don't have to think about what urlparse
supports and not, and can treat all URIs the same in this regard.
This should also make a previous, git specific, fix for this
problem redundant (and thus removed).

Signed-off-by: Olof Johansson <olof.johansson@axis.com>
---
 lib/bb/fetch2/__init__.py |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index 4cfe089..455ab6a 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -31,9 +31,6 @@ import os, re
 import logging
 import urllib
 import urlparse
-if 'git' not in urlparse.uses_netloc:
-    urlparse.uses_netloc.append('git')
-from urlparse import urlparse
 import operator
 import bb.persist_data, bb.utils
 import bb.checksum
@@ -202,13 +199,25 @@ class URI(object):
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
1.7.10.4



