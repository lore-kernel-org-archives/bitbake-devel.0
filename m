Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1STe27-00071v-EK for bitbake-devel@lists.openembedded.org;
	Sun, 13 May 2012 21:00:44 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4DIokBJ019749;
	Sun, 13 May 2012 19:50:46 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12067-05; Sun, 13 May 2012 19:50:41 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4DInTSi019704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 13 May 2012 19:50:38 +0100
Message-ID: <1336912600.2711.12.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 13 May 2012 13:36:40 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.2.2- 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake/fetch: If checksums are available, check them for any file, local or remote
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
X-List-Received-Date: Sun, 13 May 2012 19:00:44 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently, checksums are only checked for remote files. This changes
the check to apply to any file we have checksum data for. A mismatch
against a file is fatal but in the local case, no warnings are shown
about missing checksums.
    
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 6b31621..56bb8fc 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -271,30 +271,28 @@ def verify_checksum(u, ud, d):
     matched
     """
 
-    if not ud.type in ["http", "https", "ftp", "ftps"]:
-        return
-
     md5data = bb.utils.md5_file(ud.localpath)
     sha256data = bb.utils.sha256_file(ud.localpath)
 
-    # If strict checking enabled and neither sum defined, raise error
-    strict = d.getVar("BB_STRICT_CHECKSUM", True) or None
-    if (strict and ud.md5_expected == None and ud.sha256_expected == None):
-        raise FetchError('No checksum specified for %s, please add at least one to the recipe:\n'
-                         'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"' %
-                         (ud.localpath, ud.md5_name, md5data,
-                         ud.sha256_name, sha256data), u)
-
-    # Log missing sums so user can more easily add them
-    if ud.md5_expected == None:
-        logger.warn('Missing md5 SRC_URI checksum for %s, consider adding to the recipe:\n'
-                    'SRC_URI[%s] = "%s"',
-                    ud.localpath, ud.md5_name, md5data)
-
-    if ud.sha256_expected == None:
-        logger.warn('Missing sha256 SRC_URI checksum for %s, consider adding to the recipe:\n'
-                    'SRC_URI[%s] = "%s"',
-                    ud.localpath, ud.sha256_name, sha256data)
+    if ud.type in ["http", "https", "ftp", "ftps"]:
+        # If strict checking enabled and neither sum defined, raise error
+        strict = d.getVar("BB_STRICT_CHECKSUM", True) or None
+        if (strict and ud.md5_expected == None and ud.sha256_expected == None):
+            raise FetchError('No checksum specified for %s, please add at least one to the recipe:\n'
+                             'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"' %
+                             (ud.localpath, ud.md5_name, md5data,
+                              ud.sha256_name, sha256data), u)
+
+        # Log missing sums so user can more easily add them
+        if ud.md5_expected == None:
+            logger.warn('Missing md5 SRC_URI checksum for %s, consider adding to the recipe:\n'
+                        'SRC_URI[%s] = "%s"',
+                        ud.localpath, ud.md5_name, md5data)
+
+        if ud.sha256_expected == None:
+            logger.warn('Missing sha256 SRC_URI checksum for %s, consider adding to the recipe:\n'
+                        'SRC_URI[%s] = "%s"',
+                        ud.localpath, ud.sha256_name, sha256data)
 
     md5mismatch = False
     sha256mismatch = False



