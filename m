Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1STe1h-00070w-Tv for bitbake-devel@lists.openembedded.org;
	Sun, 13 May 2012 21:00:18 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4DIoKQM019741;
	Sun, 13 May 2012 19:50:20 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12124-04; Sun, 13 May 2012 19:50:15 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4DInTSh019704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 13 May 2012 19:50:13 +0100
Message-ID: <1336912527.2711.10.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 13 May 2012 13:35:27 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.2.2- 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake/fetch2: Improve visibility of checksum warnings when fetching from mirrors
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
X-List-Received-Date: Sun, 13 May 2012 19:00:18 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When fetching from mirrors, checksum errors would get buried in the
logs. This raises their profile so a warning is logged on the console
when fetcher checksum issues are encountered, even if other attempts
are made to get the file (which may or may not have the same issue).
    
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index e7571ab..6b31621 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -63,6 +63,9 @@ class FetchError(BBFetchException):
          BBFetchException.__init__(self, msg)
          self.args = (message, url)
 
+class ChecksumError(FetchError):
+    """Exception when mismatched checksum encountered"""
+
 class UnpackError(BBFetchException):
     """General fetcher exception when something happens incorrectly when unpacking"""
     def __init__(self, message, url):
@@ -312,7 +315,7 @@ def verify_checksum(u, ud, d):
         msg = msg + "\nFile: '%s' has %s checksum %s when %s was expected" % (ud.localpath, 'sha256', sha256data, ud.sha256_expected)
 
     if len(msg):
-        raise FetchError('Checksum mismatch!%s' % msg, u)
+        raise ChecksumError('Checksum mismatch!%s' % msg, u)
 
 
 def update_stamp(u, ud, d):
@@ -504,8 +507,12 @@ def try_mirrors(d, origud, mirrors, check = False):
             raise
 
         except bb.fetch2.BBFetchException as e:
-            logger.debug(1, "Mirror fetch failure for url %s (original url: %s)" % (newuri, origud.url))
-            logger.debug(1, str(e))
+            if isinstance(e, ChecksumError):
+                logger.warn("Mirror checksum failure for url %s (original url: %s)\nCleaning and trying again." % (newuri, origud.url))
+                logger.warn(str(e))
+            else:
+                logger.debug(1, "Mirror fetch failure for url %s (original url: %s)" % (newuri, origud.url))
+                logger.debug(1, str(e))
             try:
                 ud.method.clean(ud, ld)
             except UnboundLocalError:
@@ -977,8 +984,11 @@ class Fetch(object):
                         raise
 
                     except BBFetchException as e:
-                        logger.warn('Failed to fetch URL %s' % u)
-                        logger.debug(1, str(e))
+                        if isinstance(e, ChecksumError):
+                            logger.warn("Checksum error encountered with download (will attempt other sources): %s" % str(e))
+                        else:
+                            logger.warn('Failed to fetch URL %s, attempting MIRRORS if available' % u)
+                            logger.debug(1, str(e))
                         firsterr = e
                         # Remove any incomplete fetch
                         m.clean(ud, self.d)



