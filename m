Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 37C876DA97
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2013 14:51:53 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAKEpn2h022749 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2013 14:51:49 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id LGJhBLXMBwC6 for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2013 14:51:49 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	rAKEpgHY022742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256
	verify=NOT) for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Nov 2013 14:51:44 GMT
Message-ID: <1384959099.16887.60.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 20 Nov 2013 14:51:39 +0000
X-Mailer: Evolution 3.6.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] fetch2: Clean up some url parameters to functions
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
X-List-Received-Date: Wed, 20 Nov 2013 14:51:54 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

urldata contains the url so we might as well stop passing around
pointless function parameters. This was done for legacy reasons but
its time to clean this mess up.

This is a first step in cleanup and is a standalone patch but there is
more to be done in a second patch.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index b9f673c..ae99b72 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -507,7 +507,7 @@ def fetcher_compare_revisions(d):
 def mirror_from_string(data):
     return [ i.split() for i in (data or "").replace('\\n','\n').split('\n') if i ]
 
-def verify_checksum(u, ud, d):
+def verify_checksum(ud, d):
     """
     verify the MD5 and SHA256 checksum for downloaded src
 
@@ -530,7 +530,7 @@ def verify_checksum(u, ud, d):
             raise NoChecksumError('No checksum specified for %s, please add at least one to the recipe:\n'
                              'SRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"' %
                              (ud.localpath, ud.md5_name, md5data,
-                              ud.sha256_name, sha256data), u)
+                              ud.sha256_name, sha256data), ud.url)
 
         # Log missing sums so user can more easily add them
         if ud.md5_expected == None:
@@ -568,10 +568,10 @@ def verify_checksum(u, ud, d):
         msg = msg + '\nIf this change is expected (e.g. you have upgraded to a new version without updating the checksums) then you can use these lines within the recipe:\nSRC_URI[%s] = "%s"\nSRC_URI[%s] = "%s"\nOtherwise you should retry the download and/or check with upstream to determine if the file has become corrupted or otherwise unexpectedly modified.\n' % (ud.md5_name, md5data, ud.sha256_name, sha256data)
 
     if len(msg):
-        raise ChecksumError('Checksum mismatch!%s' % msg, u, md5data)
+        raise ChecksumError('Checksum mismatch!%s' % msg, ud.url, md5data)
 
 
-def update_stamp(u, ud, d):
+def update_stamp(ud, d):
     """
         donestamp is file stamp indicating the whole fetching is done
         this function update the stamp after verifying the checksum
@@ -584,7 +584,7 @@ def update_stamp(u, ud, d):
             # Errors aren't fatal here
             pass
     else:
-        verify_checksum(u, ud, d)
+        verify_checksum(ud, d)
         open(ud.donestamp, 'w').close()
 
 def subprocess_setup():
@@ -730,7 +730,7 @@ def build_mirroruris(origud, mirrors, ld):
     replacements["BASENAME"] = origud.path.split("/")[-1]
     replacements["MIRRORNAME"] = origud.host.replace(':','.') + origud.path.replace('/', '.').replace('*', '.')
 
-    def adduri(uri, ud, uris, uds):
+    def adduri(ud, uris, uds):
         for line in mirrors:
             try:
                 (find, replace) = line
@@ -753,9 +753,9 @@ def build_mirroruris(origud, mirrors, ld):
             uris.append(newuri)
             uds.append(newud)
 
-            adduri(newuri, newud, uris, uds)
+            adduri(newud, uris, uds)
 
-    adduri(None, origud, uris, uds)
+    adduri(origud, uris, uds)
 
     return uris, uds
 
@@ -772,22 +772,22 @@ def rename_bad_checksum(ud, suffix):
     bb.utils.movefile(ud.localpath, new_localpath)
 
 
-def try_mirror_url(newuri, origud, ud, ld, check = False):
+def try_mirror_url(origud, ud, ld, check = False):
     # Return of None or a value means we're finished
     # False means try another url
     try:
         if check:
-            found = ud.method.checkstatus(newuri, ud, ld)
+            found = ud.method.checkstatus(ud.url, ud, ld)
             if found:
                 return found
             return False
 
         os.chdir(ld.getVar("DL_DIR", True))
 
-        if not os.path.exists(ud.donestamp) or ud.method.need_update(newuri, ud, ld):
-            ud.method.download(newuri, ud, ld)
+        if not os.path.exists(ud.donestamp) or ud.method.need_update(ud.url, ud, ld):
+            ud.method.download(ud.url, ud, ld)
             if hasattr(ud.method,"build_mirror_data"):
-                ud.method.build_mirror_data(newuri, ud, ld)
+                ud.method.build_mirror_data(ud.url, ud, ld)
 
         if not ud.localpath or not os.path.exists(ud.localpath):
             return False
@@ -817,7 +817,7 @@ def try_mirror_url(newuri, origud, ud, ld, check = False):
                 os.unlink(origud.localpath)
 
             os.symlink(ud.localpath, origud.localpath)
-        update_stamp(newuri, origud, ld)
+        update_stamp(origud, ld)
         return ud.localpath
 
     except bb.fetch2.NetworkAccess:
@@ -825,13 +825,13 @@ def try_mirror_url(newuri, origud, ud, ld, check = False):
 
     except bb.fetch2.BBFetchException as e:
         if isinstance(e, ChecksumError):
-            logger.warn("Mirror checksum failure for url %s (original url: %s)\nCleaning and trying again." % (newuri, origud.url))
+            logger.warn("Mirror checksum failure for url %s (original url: %s)\nCleaning and trying again." % (ud.url, origud.url))
             logger.warn(str(e))
             rename_bad_checksum(ud, e.checksum)
         elif isinstance(e, NoChecksumError):
             raise
         else:
-            logger.debug(1, "Mirror fetch failure for url %s (original url: %s)" % (newuri, origud.url))
+            logger.debug(1, "Mirror fetch failure for url %s (original url: %s)" % (ud.url, origud.url))
             logger.debug(1, str(e))
         try:
             ud.method.clean(ud, ld)
@@ -853,7 +853,7 @@ def try_mirrors(d, origud, mirrors, check = False):
     uris, uds = build_mirroruris(origud, mirrors, ld)
 
     for index, uri in enumerate(uris):
-        ret = try_mirror_url(uri, origud, uds[index], ld, check)
+        ret = try_mirror_url(origud, uds[index], ld, check)
         if ret != False:
             return ret
     return None
@@ -1394,7 +1394,7 @@ class Fetch(object):
                         localpath = ud.localpath
                         # early checksum verify, so that if checksum mismatched,
                         # fetcher still have chance to fetch from mirror
-                        update_stamp(u, ud, self.d)
+                        update_stamp(ud, self.d)
 
                     except bb.fetch2.NetworkAccess:
                         raise
@@ -1421,7 +1421,7 @@ class Fetch(object):
                         logger.error(str(firsterr))
                     raise FetchError("Unable to fetch URL from any source.", u)
 
-                update_stamp(u, ud, self.d)
+                update_stamp(ud, self.d)
 
             except BBFetchException as e:
                 if isinstance(e, NoChecksumError):



