Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 171BB724B3
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Dec 2014 21:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sB8LbKTZ018218
	for <bitbake-devel@lists.openembedded.org>; Mon, 8 Dec 2014 21:37:20 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id n4rfVZGnX8JQ for <bitbake-devel@lists.openembedded.org>;
	Mon,  8 Dec 2014 21:37:19 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	sB8Lb7cL018206
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 8 Dec 2014 21:37:18 GMT
Message-ID: <1418074664.22903.28.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 08 Dec 2014 21:37:44 +0000
X-Mailer: Evolution 3.12.7-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] fetch2/local: Add localpaths method which gives localpath with history
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
X-List-Received-Date: Mon, 08 Dec 2014 21:38:06 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

In some cases for cache purpose we not only need to know which file
is going to be used but also which paths were considered. Add a
localpaths method which includes the history.

The core which() function already supports this, this just extends
the function to preserve the extra data we need. localpath becomes
just a special case of the case with history.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/local.py b/bitbake/lib/bb/fetch2/local.py
index 6fa188f..0785236 100644
--- a/bitbake/lib/bb/fetch2/local.py
+++ b/bitbake/lib/bb/fetch2/local.py
@@ -51,29 +51,41 @@ class Local(FetchMethod):
         """
         Return the local filename of a given url assuming a successful fetch.
         """
+        return self.localpaths(urldata, d)[-1]
+
+    def localpaths(self, urldata, d):
+        """
+        Return the local filename of a given url assuming a successful fetch.
+        """
+        searched = []
         path = urldata.decodedurl
         newpath = path
-        if path[0] != "/":
-            filespath = data.getVar('FILESPATH', d, True)
-            if filespath:
-                logger.debug(2, "Searching for %s in paths:\n    %s" % (path, "\n    ".join(filespath.split(":"))))
-                newpath = bb.utils.which(filespath, path)
-            if not newpath:
-                filesdir = data.getVar('FILESDIR', d, True)
-                if filesdir:
-                    logger.debug(2, "Searching for %s in path: %s" % (path, filesdir))
-                    newpath = os.path.join(filesdir, path)
-            if (not newpath or not os.path.exists(newpath)) and path.find("*") != -1:
-                # For expressions using '*', best we can do is take the first directory in FILESPATH that exists
-                newpath = bb.utils.which(filespath, ".")
-                logger.debug(2, "Searching for %s in path: %s" % (path, newpath))
-                return newpath
-            if not os.path.exists(newpath):
-                dldirfile = os.path.join(d.getVar("DL_DIR", True), path)
-                logger.debug(2, "Defaulting to %s for %s" % (dldirfile, path))
-                bb.utils.mkdirhier(os.path.dirname(dldirfile))
-                return dldirfile
-        return newpath
+        if path[0] == "/":
+            return [path]
+        filespath = data.getVar('FILESPATH', d, True)
+        if filespath:
+            logger.debug(2, "Searching for %s in paths:\n    %s" % (path, "\n    ".join(filespath.split(":"))))
+            newpath, hist = bb.utils.which(filespath, path, history=True)
+            searched.extend(hist)
+        if not newpath:
+            filesdir = data.getVar('FILESDIR', d, True)
+            if filesdir:
+                logger.debug(2, "Searching for %s in path: %s" % (path, filesdir))
+                newpath = os.path.join(filesdir, path)
+                searched.append(newpath)
+        if (not newpath or not os.path.exists(newpath)) and path.find("*") != -1:
+            # For expressions using '*', best we can do is take the first directory in FILESPATH that exists
+            newpath, hist = bb.utils.which(filespath, ".", history=True)
+            searched.extend(hist)
+            logger.debug(2, "Searching for %s in path: %s" % (path, newpath))
+            return searched
+        if not os.path.exists(newpath):
+            dldirfile = os.path.join(d.getVar("DL_DIR", True), path)
+            logger.debug(2, "Defaulting to %s for %s" % (dldirfile, path))
+            bb.utils.mkdirhier(os.path.dirname(dldirfile))
+            searched.append(dldirfile)
+            return searched
+        return searched
 
     def need_update(self, ud, d):
         if ud.url.find("*") != -1:



