Return-Path: <clemens.lang@bmw-carit.de>
X-Greylist: delayed 330 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 27 Feb 2015 12:05:59 UTC
Received: from mail.bmw-carit.de (mail.bmw-carit.de [62.245.222.98])
	by mail.openembedded.org (Postfix) with ESMTP id 83117737A3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Feb 2015 12:05:59 +0000 (UTC)
Received: from exchange2010.bmw-carit.intra ([192.168.100.28]:42644
	helo=mail.bmw-carit.de)
	by mail.bmw-carit.de with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.82_1-5b7a7c0-XX) (envelope-from <Clemens.Lang@bmw-carit.de>)
	id 1YRJam-0005D7-1W; Fri, 27 Feb 2015 13:00:28 +0100
Received: from localhost (10.242.6.42) by Exchange2010.bmw-carit.intra
	(192.168.100.28) with Microsoft SMTP Server (TLS) id 14.1.218.12;
	Fri, 27 Feb 2015 13:00:27 +0100
Date: Fri, 27 Feb 2015 13:00:26 +0100
From: Clemens Lang <clemens.lang@bmw-carit.de>
To: <bitbake-devel@lists.openembedded.org>
Message-ID: <20150227120026.GA13973@ulm-bmuc496424.bmw-carit.de>
MIME-Version: 1.0
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.242.6.42]
Subject: [PATCH] bitbake: fetch2: Revalidate checksums, YOCTO #5571
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
X-List-Received-Date: Fri, 27 Feb 2015 12:06:00 -0000
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,

I wrote a patch to implement checksum verification after the initial
download to catch the case of modified checksums in the recipe while the
cached download and done stamp are unmodified.

The change imports cPickle, but I don't think that's an issue, because
it is already used in other parts of bitbake. The use of cPickle avoids
recomputing the checksums each time do_fetch runs, which could take a
while for large downloads.

Here's the patch, please review and consider applying:

From 30a168607be0b66a6310b1104738b839bc119898 Mon Sep 17 00:00:00 2001
From: Clemens Lang <clemens.lang@bmw-carit.de>
Date: Fri, 6 Feb 2015 16:23:01 +0100
Subject: [PATCH] bitbake: fetch2: Revalidate checksums, YOCTO #5571

[YOCTO #5571] -- https://bugzilla.yoctoproject.org/show_bug.cgi?id=5571

The following workflow (whether accidentally or deliberately) would
previously not result in a checksum error, but would be helpful to do
so:
 - Write a recipe with correct checksums
 - Fetch the sources for this recipe using bitbake
 - Change the checksums
Since the bitbake fetcher writes a done stamp after the initial download
and does not verify the checksums again (even if they are changed in the
recipe afterwards), the change of checksums is silently ignored.

Fix this without the overhead of computing the checksums from scratch on
every do_fetch by storing them in pickled format in the done stamp and
verifying that they still match those in the recipe.

Signed-off-by: Clemens Lang <clemens.lang@bmw-carit.de>
---
 bitbake/lib/bb/fetch2/__init__.py | 106 ++++++++++++++++++++++++++++++++++----
 1 file changed, 96 insertions(+), 10 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 599ea8c..c0c8312 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -45,6 +45,13 @@ _checksum_cache = bb.checksum.FileChecksumCache()
 
 logger = logging.getLogger("BitBake.Fetcher")
 
+try:
+    import cPickle as pickle
+except ImportError:
+    import pickle
+    logger.info("Importing cPickle failed. "
+                "Falling back to a very slow implementation.")
+
 class BBFetchException(Exception):
     """Class all fetch exceptions inherit from"""
     def __init__(self, message):
@@ -525,7 +532,7 @@ def fetcher_compare_revisions(d):
 def mirror_from_string(data):
     return [ i.split() for i in (data or "").replace('\\n','\n').split('\n') if i ]
 
-def verify_checksum(ud, d):
+def verify_checksum(ud, d, precomputed={}):
     """
     verify the MD5 and SHA256 checksum for downloaded src
 
@@ -533,13 +540,28 @@ def verify_checksum(ud, d):
     the downloaded file, or if BB_STRICT_CHECKSUM is set and there are no
     checksums specified.
 
+    Returns a dict of checksums that can be stored in a done stamp file and
+    passed in as precomputed parameter in a later call to avoid re-computing
+    the checksums from the file. This allows verifying the checksums of the
+    file against those in the recipe each time, rather than only after
+    downloading. See https://bugzilla.yoctoproject.org/show_bug.cgi?id=5571.
     """
 
+    _MD5_KEY = "md5"
+    _SHA256_KEY = "sha256"
+
     if ud.ignore_checksums or not ud.method.supports_checksum(ud):
-        return
+        return {}
 
-    md5data = bb.utils.md5_file(ud.localpath)
-    sha256data = bb.utils.sha256_file(ud.localpath)
+    if _MD5_KEY in precomputed:
+        md5data = precomputed[_MD5_KEY]
+    else:
+        md5data = bb.utils.md5_file(ud.localpath)
+
+    if _SHA256_KEY in precomputed:
+        sha256data = precomputed[_SHA256_KEY]
+    else:
+        sha256data = bb.utils.sha256_file(ud.localpath)
 
     if ud.method.recommends_checksum(ud):
         # If strict checking enabled and neither sum defined, raise error
@@ -589,6 +611,66 @@ def verify_checksum(ud, d):
     if len(msg):
         raise ChecksumError('Checksum mismatch!%s' % msg, ud.url, md5data)
 
+    return {
+        _MD5_KEY: md5data,
+        _SHA256_KEY: sha256data
+    }
+
+
+def verify_donestamp(ud, d):
+    """
+    Check whether the done stamp file has the right checksums (if the fetch
+    method supports them). If it doesn't, delete the done stamp and force
+    a re-download.
+
+    Returns True, if the donestamp exists and is valid, False otherwise. When
+    returning False, any existing done stamps are removed.
+    """
+    if not os.path.exists(ud.donestamp):
+        return False
+
+    if not ud.method.supports_checksum(ud):
+        # done stamp exists, checksums not supported; assume the local file is
+        # current
+        return True
+
+    if not os.path.exists(ud.localpath):
+        # done stamp exists, but the downloaded file does not; the done stamp
+        # must be incorrect, re-trigger the download
+        bb.utils.remove(ud.donestamp)
+        return False
+
+    precomputed_checksums = {}
+    try:
+        with open(ud.donestamp, "rb") as cachefile:
+            pickled = pickle.Unpickler(cachefile)
+            precomputed_checksums.update(pickled.load())
+    except Exception as e:
+        # Avoid the warnings on the upgrade path from emtpy done stamp files to
+        # those containing the checksums.
+        if not isinstance(e, EOFError):
+            # Ignore errors, they aren't fatal
+            logger.warn("Couldn't load checksums from donestamp %s: %s "
+                        "(msg: %s)" % (ud.donestamp, type(e).__name__, str(e)))
+
+    try:
+        checksums = verify_checksum(ud, d, precomputed_checksums)
+        # If the cache file did not have the checksums, compute and store them
+        # as an upgrade path from the previous done stamp file format.
+        if checksums != precomputed_checksums:
+            with open(ud.donestamp, "wb") as cachefile:
+                p = pickle.Pickler(cachefile, pickle.HIGHEST_PROTOCOL)
+                p.dump(checksums)
+        return True
+    except ChecksumError as e:
+        # Checksums failed to verify, trigger re-download and remove the
+        # incorrect stamp file.
+        logger.warn("Checksum mismatch for local file %s\n"
+                    "Cleaning and trying again." % ud.localpath)
+        rename_bad_checksum(ud, e.checksum)
+        bb.utils.remove(ud.donestamp)
+    return False
+
 
 def update_stamp(ud, d):
     """
@@ -603,8 +685,11 @@ def update_stamp(ud, d):
             # Errors aren't fatal here
             pass
     else:
-        verify_checksum(ud, d)
-        open(ud.donestamp, 'w').close()
+        checksums = verify_checksum(ud, d)
+        # Store the checksums for later re-verification against the recipe
+        with open(ud.donestamp, "wb") as cachefile:
+            p = pickle.Pickler(cachefile, pickle.HIGHEST_PROTOCOL)
+            p.dump(checksums)
 
 def subprocess_setup():
     # Python installs a SIGPIPE handler by default. This is usually not what
@@ -805,7 +890,7 @@ def try_mirror_url(origud, ud, ld, check = False):
 
         os.chdir(ld.getVar("DL_DIR", True))
 
-        if not os.path.exists(ud.donestamp) or ud.method.need_update(ud, ld):
+        if not verify_donestamp(ud, ld) or ud.method.need_update(ud, ld):
             ud.method.download(ud, ld)
             if hasattr(ud.method,"build_mirror_data"):
                 ud.method.build_mirror_data(ud, ld)
@@ -821,12 +906,13 @@ def try_mirror_url(origud, ud, ld, check = False):
         dldir = ld.getVar("DL_DIR", True)
         if origud.mirrortarball and os.path.basename(ud.localpath) == os.path.basename(origud.mirrortarball) \
                 and os.path.basename(ud.localpath) != os.path.basename(origud.localpath):
+            # Create donestamp in old format to avoid triggering a re-download
             bb.utils.mkdirhier(os.path.dirname(ud.donestamp))
             open(ud.donestamp, 'w').close()
             dest = os.path.join(dldir, os.path.basename(ud.localpath))
             if not os.path.exists(dest):
                 os.symlink(ud.localpath, dest)
-            if not os.path.exists(origud.donestamp) or origud.method.need_update(origud, ld):
+            if not verify_donestamp(origud, ld) or origud.method.need_update(origud, ld):
                 origud.method.download(origud, ld)
                 if hasattr(origud.method,"build_mirror_data"):
                     origud.method.build_mirror_data(origud, ld)
@@ -1422,7 +1508,7 @@ class Fetch(object):
             try:
                 self.d.setVar("BB_NO_NETWORK", network)
  
-                if os.path.exists(ud.donestamp) and not m.need_update(ud, self.d):
+                if verify_donestamp(ud, self.d) and not m.need_update(ud, self.d):
                     localpath = ud.localpath
                 elif m.try_premirror(ud, self.d):
                     logger.debug(1, "Trying PREMIRRORS")
@@ -1435,7 +1521,7 @@ class Fetch(object):
                 os.chdir(self.d.getVar("DL_DIR", True))
 
                 firsterr = None
-                if not localpath and ((not os.path.exists(ud.donestamp)) or m.need_update(ud, self.d)):
+                if not localpath and ((not verify_donestamp(ud, self.d)) or m.need_update(ud, self.d)):
                     try:
                         logger.debug(1, "Trying Upstream")
                         m.download(ud, self.d)
-- 
2.1.0

-- 
Clemens Lang • Development Specialist
BMW Car IT GmbH • Lise-Meitner-Str. 14 • 89081 Ulm • http://bmw-carit.com
-------------------------------------------------------------------------
BMW Car IT GmbH
Geschäftsführer: Michael Würtenberger und Reinhard Stolle
Sitz und Registergericht: München HRB 134810
-------------------------------------------------------------------------

