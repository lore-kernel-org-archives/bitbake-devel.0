Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id BDB3F6FEE0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Mar 2016 19:50:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u2UJo0Pp023208 for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Mar 2016 20:50:00 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id w0tk0Sq2b6gw for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Mar 2016 20:50:00 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u2UJnx92023205
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Mar 2016 20:50:00 +0100
Message-ID: <1459367399.21672.54.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 30 Mar 2016 20:49:59 +0100
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] fetch2: Ensure that incorrect checksumed files are always renamed
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
X-List-Received-Date: Wed, 30 Mar 2016 19:50:01 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

There are some codepaths where the file checksum is verified and can
be found to mismatch but the 'rename' logic doesn't kick in. If code
relies on the presence of a file for the checksum having been checked
(e.g. uninative.bbclass) then it can be used when the checksum hasn't
matched.

Therefore rename the file whenever an invalid checksum is encountered.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index e8cea7f..dc074d5 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -677,7 +677,8 @@ def verify_donestamp(ud, d, origud=None):
         # incorrect stamp file.
         logger.warn("Checksum mismatch for local file %s\n"
                     "Cleaning and trying again." % ud.localpath)
-        rename_bad_checksum(ud, e.checksum)
+        if os.path.exists(ud.localpath):
+            rename_bad_checksum(ud, e.checksum)
         bb.utils.remove(ud.donestamp)
     return False
 
@@ -698,11 +699,21 @@ def update_stamp(ud, d):
             # Errors aren't fatal here
             pass
     else:
-        checksums = verify_checksum(ud, d)
-        # Store the checksums for later re-verification against the recipe
-        with open(ud.donestamp, "wb") as cachefile:
-            p = pickle.Pickler(cachefile, pickle.HIGHEST_PROTOCOL)
-            p.dump(checksums)
+        try:
+            checksums = verify_checksum(ud, d)
+            # Store the checksums for later re-verification against the recipe
+            with open(ud.donestamp, "wb") as cachefile:
+                p = pickle.Pickler(cachefile, pickle.HIGHEST_PROTOCOL)
+                p.dump(checksums)
+        except ChecksumError as e:
+            # Checksums failed to verify, trigger re-download and remove the
+            # incorrect stamp file.
+            logger.warn("Checksum mismatch for local file %s\n"
+                        "Cleaning and trying again." % ud.localpath)
+            if os.path.exists(ud.localpath):
+                rename_bad_checksum(ud, e.checksum)
+            bb.utils.remove(ud.donestamp)
+            raise
 
 def subprocess_setup():
     # Python installs a SIGPIPE handler by default. This is usually not what
@@ -973,7 +984,8 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
         if isinstance(e, ChecksumError):
             logger.warn("Mirror checksum failure for url %s (original url: %s)\nCleaning and trying again." % (ud.url, origud.url))
             logger.warn(str(e))
-            rename_bad_checksum(ud, e.checksum)
+            if os.path.exists(ud.localpath):
+                rename_bad_checksum(ud, e.checksum)
         elif isinstance(e, NoChecksumError):
             raise
         else:
@@ -1583,7 +1595,8 @@ class Fetch(object):
                         if isinstance(e, ChecksumError):
                             logger.warn("Checksum failure encountered with download of %s - will attempt other sources if available" % u)
                             logger.debug(1, str(e))
-                            rename_bad_checksum(ud, e.checksum)
+                            if os.path.exists(ud.localpath):
+                                rename_bad_checksum(ud, e.checksum)
                         elif isinstance(e, NoChecksumError):
                             raise
                         else:



