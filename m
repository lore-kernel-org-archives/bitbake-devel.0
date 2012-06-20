Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard@rpsys.net>) id 1ShLqR-0007wt-E4
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 16:25:19 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id
	q5KEHMKU007999 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:22 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id z9mum2P+xGC3 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:22 +0100 (BST)
Received: from ted (ted.config [192.168.1.66]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.2/Debian-2build1) with ESMTP id
	q5KEHKZ0007994
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 15:17:21 +0100
Received: from richard by ted with local (Exim 4.76)
	(envelope-from <richard@dan.rpsys.net>) id 1ShLf4-0002Sa-8z
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 15:13:34 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 20 Jun 2012 15:12:56 +0100
Message-Id: <d222ebb7c75d74fde4fd04ea6feb27e10a862bae.1340200207.git.richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
In-Reply-To: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
References: <cover.1340200207.git.richard.purdie@linuxfoundation.org>
Subject: [PATCH 05/14] fetch2: Split try_mirrors into two parts
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
X-List-Received-Date: Wed, 20 Jun 2012 14:27:14 -0000

There are no functionality changes in this change

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/lib/bb/fetch2/__init__.py |  111 +++++++++++++++++++-----------------
 1 files changed, 59 insertions(+), 52 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index b09753f..e4af951 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -464,6 +464,60 @@ def check_network_access(d, info = "", url = None):
     else:
         logger.debug(1, "Fetcher accessed the network with the command %s" % info)
 
+def try_mirror_url(newuri, origud, ud, ld, check = False):
+    # Return of None or a value means we're finished
+    # False means try another url
+    try:
+        if check:
+            found = ud.method.checkstatus(newuri, ud, ld)
+            if found:
+                return found
+            return False
+
+        os.chdir(ld.getVar("DL_DIR", True))
+
+        if not os.path.exists(ud.donestamp) or ud.method.need_update(newuri, ud, ld):
+            ud.method.download(newuri, ud, ld)
+            if hasattr(ud.method,"build_mirror_data"):
+                ud.method.build_mirror_data(newuri, ud, ld)
+
+        if not ud.localpath or not os.path.exists(ud.localpath):
+            return False
+
+        if ud.localpath == origud.localpath:
+            return ud.localpath
+
+        # We may be obtaining a mirror tarball which needs further processing by the real fetcher
+        # If that tarball is a local file:// we need to provide a symlink to it
+        dldir = ld.getVar("DL_DIR", True)
+        if os.path.basename(ud.localpath) != os.path.basename(origud.localpath):
+            open(ud.donestamp, 'w').close()
+            dest = os.path.join(dldir, os.path.basename(ud.localpath))
+            if not os.path.exists(dest):
+                os.symlink(ud.localpath, dest)
+            return None
+        # Otherwise the result is a local file:// and we symlink to it
+        if not os.path.exists(origud.localpath):
+             os.symlink(ud.localpath, origud.localpath)
+        update_stamp(newuri, origud, ld)
+        return ud.localpath
+
+    except bb.fetch2.NetworkAccess:
+        raise
+
+    except bb.fetch2.BBFetchException as e:
+        if isinstance(e, ChecksumError):
+            logger.warn("Mirror checksum failure for url %s (original url: %s)\nCleaning and trying again." % (newuri, origud.url))
+            logger.warn(str(e))
+        else:
+            logger.debug(1, "Mirror fetch failure for url %s (original url: %s)" % (newuri, origud.url))
+            logger.debug(1, str(e))
+        try:
+            ud.method.clean(ud, ld)
+        except UnboundLocalError:
+            pass
+        return False
+
 def try_mirrors(d, origud, mirrors, check = False):
     """
     Try to use a mirrored version of the sources.
@@ -482,59 +536,12 @@ def try_mirrors(d, origud, mirrors, check = False):
         newuri = uri_replace(origud, find, replace, ld)
         if not newuri:
             continue
-        try:
-            ud = FetchData(newuri, ld)
-            ud.setup_localpath(ld)
-
-            os.chdir(ld.getVar("DL_DIR", True))
-
-            if check:
-                found = ud.method.checkstatus(newuri, ud, ld)
-                if found:
-                    return found
-                continue
+        ud = FetchData(newuri, ld)
+        ud.setup_localpath(ld)
 
-            if not os.path.exists(ud.donestamp) or ud.method.need_update(newuri, ud, ld):
-                ud.method.download(newuri, ud, ld)
-                if hasattr(ud.method,"build_mirror_data"):
-                    ud.method.build_mirror_data(newuri, ud, ld)
-
-            if not ud.localpath or not os.path.exists(ud.localpath):
-                continue
-
-            if ud.localpath == origud.localpath:
-                return ud.localpath
-
-            # We may be obtaining a mirror tarball which needs further processing by the real fetcher
-            # If that tarball is a local file:// we need to provide a symlink to it
-            dldir = ld.getVar("DL_DIR", True)
-            if os.path.basename(ud.localpath) != os.path.basename(origud.localpath):
-                open(ud.donestamp, 'w').close()
-                dest = os.path.join(dldir, os.path.basename(ud.localpath))
-                if not os.path.exists(dest):
-                    os.symlink(ud.localpath, dest)
-                return None
-            # Otherwise the result is a local file:// and we symlink to it
-            if not os.path.exists(origud.localpath):
-                 os.symlink(ud.localpath, origud.localpath)
-            update_stamp(newuri, origud, ld)
-            return ud.localpath
-
-        except bb.fetch2.NetworkAccess:
-            raise
-
-        except bb.fetch2.BBFetchException as e:
-            if isinstance(e, ChecksumError):
-                logger.warn("Mirror checksum failure for url %s (original url: %s)\nCleaning and trying again." % (newuri, origud.url))
-                logger.warn(str(e))
-            else:
-                logger.debug(1, "Mirror fetch failure for url %s (original url: %s)" % (newuri, origud.url))
-                logger.debug(1, str(e))
-            try:
-                ud.method.clean(ud, ld)
-            except UnboundLocalError:
-                pass
-            continue
+        ret = try_mirror_url(newuri, origud, ud, ld, check)
+        if ret != False:
+            return ret
     return None
 
 def srcrev_internal_helper(ud, d, name):
-- 
1.7.5.4



