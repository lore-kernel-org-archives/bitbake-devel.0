Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id B2D597742C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 17:52:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1QHpLo5009037 for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 17:52:18 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uO2suxpN1C4H for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 17:52:18 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u1QHqEpL009059
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 26 Feb 2016 17:52:15 GMT
Message-ID: <1456509134.11498.101.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 26 Feb 2016 17:52:14 +0000
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Subject: [PATCH] fetch2: Skip lockfiles and donestamps for local files
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
X-List-Received-Date: Fri, 26 Feb 2016 17:52:19 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

For local files, there are no races with downloads, we don't need ".done" 
stamps and we don't need lockfiles.

This considerably cleans up DL_DIR and all the pointless ".done" files
as well as removes stalls over local files with the same name.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 058adf2..ea816ba 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -626,6 +626,9 @@ def verify_donestamp(ud, d, origud=None):
     Returns True, if the donestamp exists and is valid, False otherwise. When
     returning False, any existing done stamps are removed.
     """
+    if not ud.needdonestamp:
+        return True
+
     if not os.path.exists(ud.donestamp):
         return False
 
@@ -684,6 +687,9 @@ def update_stamp(ud, d):
         donestamp is file stamp indicating the whole fetching is done
         this function update the stamp after verifying the checksum
     """
+    if not ud.needdonestamp:
+        return
+
     if os.path.exists(ud.donestamp):
         # Touch the done stamp file to show active use of the download
         try:
@@ -1119,6 +1125,7 @@ class FetchData(object):
     def __init__(self, url, d, localonly = False):
         # localpath is the location of a downloaded result. If not set, the file is local.
         self.donestamp = None
+        self.needdonestamp = True
         self.localfile = ""
         self.localpath = None
         self.lockfile = None
@@ -1183,6 +1190,10 @@ class FetchData(object):
             self.localpath = self.method.localpath(self, d)
 
         dldir = d.getVar("DL_DIR", True)
+
+        if not self.needdonestamp:
+            return
+
         # Note: .done and .lock files should always be in DL_DIR whereas localpath may not be.
         if self.localpath and self.localpath.startswith(dldir):
             basepath = self.localpath
@@ -1520,7 +1531,8 @@ class Fetch(object):
             m = ud.method
             localpath = ""
 
-            lf = bb.utils.lockfile(ud.lockfile)
+            if ud.lockfile:
+                lf = bb.utils.lockfile(ud.lockfile)
 
             try:
                 self.d.setVar("BB_NO_NETWORK", network)
@@ -1586,7 +1598,8 @@ class Fetch(object):
                 raise
 
             finally:
-                bb.utils.unlockfile(lf)
+                if ud.lockfile:
+                    bb.utils.unlockfile(lf)
 
     def checkstatus(self, urls=None):
         """
diff --git a/bitbake/lib/bb/fetch2/local.py b/bitbake/lib/bb/fetch2/local.py
index 2d921f7..303a52b 100644
--- a/bitbake/lib/bb/fetch2/local.py
+++ b/bitbake/lib/bb/fetch2/local.py
@@ -45,6 +45,7 @@ class Local(FetchMethod):
         ud.decodedurl = urllib.unquote(ud.url.split("://")[1].split(";")[0])
         ud.basename = os.path.basename(ud.decodedurl)
         ud.basepath = ud.decodedurl
+        ud.needdonestamp = False
         return
 
     def localpath(self, urldata, d):



