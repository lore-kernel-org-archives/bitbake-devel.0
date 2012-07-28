Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1Suvmg-0003NX-PN
	for bitbake-devel@lists.openembedded.org;
	Sat, 28 Jul 2012 03:25:35 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q6S1Cqcf026957
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Jul 2012 18:13:58 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.61) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.1.255.0;
	Fri, 27 Jul 2012 18:13:31 -0700
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 27 Jul 2012 20:26:38 -0500
Message-ID: <1343438798-3872-1-git-send-email-mark.hatle@windriver.com>
X-Mailer: git-send-email 1.7.3.4
MIME-Version: 1.0
X-Originating-IP: [172.25.34.61]
Subject: [PATCH] fetch2/__init__.py: Add NoChecksumError exception
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
X-List-Received-Date: Sat, 28 Jul 2012 01:25:35 -0000
Content-Type: text/plain

Without the new exception, when the system is configured to use premirrors,
but not allow network access (via BB_NO_NETWORK), when a recipe was lacking a
checksum the wrong error message(s) were being generated.

Instead of complaining about trying to perform network access, if the system
was able to find the item in the premirror, it should inform the user of the
lack of checksums, and the two SRC_URI fields they should use to update their
recipe.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/fetch2/__init__.py |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
index fa963be..a7da899 100644
--- a/lib/bb/fetch2/__init__.py
+++ b/lib/bb/fetch2/__init__.py
@@ -70,6 +70,9 @@ class FetchError(BBFetchException):
 class ChecksumError(FetchError):
     """Exception when mismatched checksum encountered"""
 
+class NoChecksumError(FetchError):
+    """Exception when no checksum is specified, but BB_STRICT_CHECKSUM is set"""
+
 class UnpackError(BBFetchException):
     """General fetcher exception when something happens incorrectly when unpacking"""
     def __init__(self, message, url):
@@ -314,7 +317,7 @@ def verify_checksum(u, ud, d):
         # If strict checking enabled and neither sum defined, raise error
         strict = d.getVar("BB_STRICT_CHECKSUM", True) or None
         if (strict and ud.md5_expected == None and ud.sha256_expected == None):
-            raise FetchError('No checksum specified for %s, please add at least one to the recipe:\n'
+            raise NoChecksumError('No checksum specified for %s, please add at least one to the recipe:\n'
                              'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"' %
                              (ud.localpath, ud.md5_name, md5data,
                               ud.sha256_name, sha256data), u)
@@ -568,6 +571,8 @@ def try_mirror_url(newuri, origud, ud, ld, check = False):
         if isinstance(e, ChecksumError):
             logger.warn("Mirror checksum failure for url %s (original url: %s)\nCleaning and trying again." % (newuri, origud.url))
             logger.warn(str(e))
+        elif isinstance(e, NoChecksumError):
+            raise
         else:
             logger.debug(1, "Mirror fetch failure for url %s (original url: %s)" % (newuri, origud.url))
             logger.debug(1, str(e))
@@ -1179,6 +1184,8 @@ class Fetch(object):
                     except BBFetchException as e:
                         if isinstance(e, ChecksumError):
                             logger.warn("Checksum error encountered with download (will attempt other sources): %s" % str(e))
+                        if isinstance(e, NoChecksumError):
+                            raise
                         else:
                             logger.warn('Failed to fetch URL %s, attempting MIRRORS if available' % u)
                             logger.debug(1, str(e))
@@ -1196,6 +1203,11 @@ class Fetch(object):
 
                 update_stamp(u, ud, self.d)
 
+            except BBFetchException as e:
+                if isinstance(e, NoChecksumError):
+                    logger.error("%s" % str(e))
+                raise
+
             finally:
                 bb.utils.unlockfile(lf)
 
-- 
1.7.3.4



