Return-Path: <peter.kjellerstedt@axis.com>
X-Greylist: delayed 353 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 29 Aug 2017 20:38:57 UTC
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 807ED78304
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Aug 2017 20:38:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 5D3801843C
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Aug 2017 22:33:05 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 43JGcFyPlbuV for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Aug 2017 22:33:04 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 8FA0D1842D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Aug 2017 22:33:04 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D2091E094
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Aug 2017 22:33:04 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70C391E096
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Aug 2017 22:33:04 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder03.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Aug 2017 22:33:04 +0200 (CEST)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id 6508731F5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Aug 2017 22:33:04 +0200 (CEST)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id v7TKX34D021353
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 29 Aug 2017 22:33:03 +0200
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id v7TKX3wf021351
	for bitbake-devel@lists.openembedded.org;
	Tue, 29 Aug 2017 22:33:03 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 29 Aug 2017 22:33:01 +0200
Message-Id: <4a22ea6326cc4d5bd7ecc119fa8230f262ccbdc4.1504038736.git.pkj@axis.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <cover.1504038736.git.pkj@axis.com>
References: <cover.1504038736.git.pkj@axis.com>
X-TM-AS-GCONF: 00
Subject: [PATCH 1/1] fetch2: Allow Fetch.download() to warn instead of error
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
X-List-Received-Date: Tue, 29 Aug 2017 20:38:58 -0000

Under some situations it can be allowed for Fetch.download() to fail
to fetch a file without causing bitbake to fail. By adding
only_warn=True as argument to Fetch.download(), it will call
logger.warning() instead of logger.error() and thus not cause build
failures.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 3eb0e4d211..58f65ada84 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -1608,9 +1608,10 @@ class Fetch(object):
 
         return local
 
-    def download(self, urls=None):
+    def download(self, urls=None, only_warn=False):
         """
-        Fetch all urls
+        Fetch all urls. In case only_warn is True, a failure to fetch a url
+        will only result in a warning message, rather than an error message.
         """
         if not urls:
             urls = self.urls
@@ -1688,19 +1689,28 @@ class Fetch(object):
 
                 if not localpath or ((not os.path.exists(localpath)) and localpath.find("*") == -1):
                     if firsterr:
-                        logger.error(str(firsterr))
+                        if only_warn:
+                            logger.warning(str(firsterr))
+                        else:
+                            logger.error(str(firsterr))
                     raise FetchError("Unable to fetch URL from any source.", u)
 
                 update_stamp(ud, self.d)
 
             except IOError as e:
                 if e.errno in [os.errno.ESTALE]:
-                    logger.error("Stale Error Observed %s." % u)
+                    if only_warn:
+                        logger.warning("Stale Error Observed %s." % u)
+                    else:
+                        logger.error("Stale Error Observed %s." % u)
                     raise ChecksumError("Stale Error Detected")
 
             except BBFetchException as e:
                 if isinstance(e, ChecksumError):
-                    logger.error("Checksum failure fetching %s" % u)
+                    if only_warn:
+                        logger.warning("Checksum failure fetching %s" % u)
+                    else:
+                        logger.error("Checksum failure fetching %s" % u)
                 raise
 
             finally:
-- 
2.12.0


