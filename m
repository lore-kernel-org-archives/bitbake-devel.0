Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TFppG-00034A-HR
	for bitbake-devel@lists.openembedded.org;
	Sun, 23 Sep 2012 19:18:38 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 23 Sep 2012 10:05:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,470,1344236400"; d="scan'208";a="148102840"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.252])
	by AZSMGA002.ch.intel.com with ESMTP; 23 Sep 2012 10:05:48 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 23 Sep 2012 18:05:36 +0100
Message-Id: <1348419936-13985-2-git-send-email-paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1348419936-13985-1-git-send-email-paul.eggleton@linux.intel.com>
References: <1348419936-13985-1-git-send-email-paul.eggleton@linux.intel.com>
Subject: [PATCH 2/2] fetch2: improve error output for checksum failures
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
X-List-Received-Date: Sun, 23 Sep 2012 17:18:38 -0000

* Don't print the full exception in the initial warning - if we later
  succeed in fetching the file from a mirror, we won't usually need the
  details (which are in the fetch log if they are needed); otherwise the
  full error will be printed when the fetch operation fails. Also adjust
  the conditional block so that we don't print another warning just
  mentioning we're going to try mirrors.
* Call logger.error() so that with knotty the full log is not printed
* Provide an explanation around the lines we print for easily updating
  the checksums in the recipe. We don't want users to be just blindly
  updating the recipe in case of a transient failure or deliberately
  altered remote file.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/lib/bb/fetch2/__init__.py |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 1acb0a4..a713418 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -358,7 +358,7 @@ def verify_checksum(u, ud, d):
         mismatch = True;
 
     if mismatch:
-        msg = msg + '\nYour checksums:\nSRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"' % (ud.md5_name, md5data, ud.sha256_name, sha256data)
+        msg = msg + '\nIf this change is expected (e.g. you have upgraded to a new version without updating the checksums) then you can use these lines within the recipe:\nSRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"\nOtherwise you should retry the download and/or check with upstream to determine if the file has become corrupted or otherwise unexpectedly modified.\n' % (ud.md5_name, md5data, ud.sha256_name, sha256data)
 
     if len(msg):
         raise ChecksumError('Checksum mismatch!%s' % msg, u)
@@ -1204,8 +1204,9 @@ class Fetch(object):
 
                     except BBFetchException as e:
                         if isinstance(e, ChecksumError):
-                            logger.warn("Checksum error encountered with download (will attempt other sources): %s" % str(e))
-                        if isinstance(e, NoChecksumError):
+                            logger.warn("Checksum failure encountered with download of %s - will attempt other sources if available" % u)
+                            logger.debug(1, str(e))
+                        elif isinstance(e, NoChecksumError):
                             raise
                         else:
                             logger.warn('Failed to fetch URL %s, attempting MIRRORS if available' % u)
@@ -1227,6 +1228,8 @@ class Fetch(object):
             except BBFetchException as e:
                 if isinstance(e, NoChecksumError):
                     logger.error("%s" % str(e))
+                elif isinstance(e, ChecksumError):
+                    logger.error("Checksum failure fetching %s" % u)
                 raise
 
             finally:
-- 
1.7.9.5



