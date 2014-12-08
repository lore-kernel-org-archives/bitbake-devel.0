Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 66583724B3
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Dec 2014 21:38:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sB8Lc25r018261
	for <bitbake-devel@lists.openembedded.org>; Mon, 8 Dec 2014 21:38:02 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uM3MNDoOM7RG for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Dec 2014 21:38:02 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sB8LbnAC018239
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 8 Dec 2014 21:38:01 GMT
Message-ID: <1418074706.22903.29.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 08 Dec 2014 21:38:26 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] cache/fetch2/siggen: Ensure we track include history for file checksums
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
X-List-Received-Date: Mon, 08 Dec 2014 21:38:40 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently, if you reference a file url, its checksum is included in the
task hash, however if you change to a different file at a different
location, perhaps taking advantage of the FILESPATH functionality, the
system will not reparse the file in question and change its checksum to
match the new file.

To correctly handle this, the system not only needs to know if the
existing file still exists or not, but also check the existence
of every file it would have looked at when computing the original file.

We already do this in the bitbake parsing code for class inclusion. This
change uses the same technique to log the file list we looked at and
if files in these locations exist when they previously did not, to
invalidate and reparse the file.

Since data stored in the cache is flattened text, we have to use a string
form of the data and split on the ":" character which is ugly, but is
an internal detail we can improve later if a better method is found.

The cache version changes to trigger a reparse since the previous
cache data is now incompatible.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/cache.py b/bitbake/lib/bb/cache.py
index ac0c27f..715da07 100644
--- a/bitbake/lib/bb/cache.py
+++ b/bitbake/lib/bb/cache.py
@@ -43,7 +43,7 @@ except ImportError:
     logger.info("Importing cPickle failed. "
                 "Falling back to a very slow implementation.")
 
-__cache_version__ = "147"
+__cache_version__ = "148"
 
 def getCacheFile(path, filename, data_hash):
     return os.path.join(path, filename + "." + data_hash)
@@ -529,8 +529,11 @@ class Cache(object):
         if hasattr(info_array[0], 'file_checksums'):
             for _, fl in info_array[0].file_checksums.items():
                 for f in fl.split():
-                    if not ('*' in f or os.path.exists(f)):
-                        logger.debug(2, "Cache: %s's file checksum list file %s was removed",
+                    if "*" in f:
+                        continue
+                    f, exist = f.split(":")
+                    if (exist == "True" and not os.path.exists(f)) or (exist == "False" and os.path.exists(f)):
+                        logger.debug(2, "Cache: %s's file checksum list file %s changed",
                                         fn, f)
                         self.remove(fn)
                         return False
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 9a9b895..1de118c 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -964,22 +964,21 @@ def get_checksum_file_list(d):
         ud = fetch.ud[u]
 
         if ud and isinstance(ud.method, local.Local):
-            ud.setup_localpath(d)
-            f = ud.localpath
-            pth = ud.decodedurl
-            if '*' in pth:
-                f = os.path.join(os.path.abspath(f), pth)
-            if f.startswith(dl_dir):
-                # The local fetcher's behaviour is to return a path under DL_DIR if it couldn't find the file anywhere else
-                if os.path.exists(f):
-                    bb.warn("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR" % (d.getVar('PN', True), os.path.basename(f)))
-                else:
-                    bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN', True), os.path.basename(f)))
-            filelist.append(f)
+            paths = ud.method.localpaths(ud, d)
+            for f in paths:
+                pth = ud.decodedurl
+                if '*' in pth:
+                    f = os.path.join(os.path.abspath(f), pth)
+                if f.startswith(dl_dir):
+                    # The local fetcher's behaviour is to return a path under DL_DIR if it couldn't find the file anywhere else
+                    if os.path.exists(f):
+                        bb.warn("Getting checksum for %s SRC_URI entry %s: file not found except in DL_DIR" % (d.getVar('PN', True), os.path.basename(f)))
+                    else:
+                        bb.warn("Unable to get checksum for %s SRC_URI entry %s: file could not be found" % (d.getVar('PN', True), os.path.basename(f)))
+                filelist.append(f + ":" + str(os.path.exists(f)))
 
     return " ".join(filelist)
 
-
 def get_file_checksums(filelist, pn):
     """Get a list of the checksums for a list of local files
 
@@ -1009,6 +1008,10 @@ def get_file_checksums(filelist, pn):
 
     checksums = []
     for pth in filelist.split():
+        exist = pth.split(":")[1]
+        if exist == "False":
+            continue
+        pth = pth.split(":")[0]
         if '*' in pth:
             # Handle globs
             for f in glob.glob(pth):
@@ -1016,14 +1019,12 @@ def get_file_checksums(filelist, pn):
                     checksums.extend(checksum_dir(f))
                 else:
                     checksum = checksum_file(f)
-                    if checksum:
-                        checksums.append((f, checksum))
+                    checksums.append((f, checksum))
         elif os.path.isdir(pth):
             checksums.extend(checksum_dir(pth))
         else:
             checksum = checksum_file(pth)
-            if checksum:
-                checksums.append((pth, checksum))
+            checksums.append((pth, checksum))
 
     checksums.sort(key=operator.itemgetter(1))
     return checksums
diff --git a/bitbake/lib/bb/siggen.py b/bitbake/lib/bb/siggen.py
index 5103073..17836a3 100644
--- a/bitbake/lib/bb/siggen.py
+++ b/bitbake/lib/bb/siggen.py
@@ -185,7 +185,8 @@ class SignatureGeneratorBasic(SignatureGenerator):
             checksums = bb.fetch2.get_file_checksums(dataCache.file_checksums[fn][task], recipename)
             for (f,cs) in checksums:
                 self.file_checksum_values[k][f] = cs
-                data = data + cs
+                if cs:
+                    data = data + cs
 
         taint = self.read_taint(fn, task, dataCache.stamp[fn])
         if taint:



