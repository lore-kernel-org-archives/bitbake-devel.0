Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Sx2Qf-0006Ii-7L for bitbake-devel@lists.openembedded.org;
	Thu, 02 Aug 2012 22:55:34 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q72Khs1L011091
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 2 Aug 2012 21:43:54 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 09592-02 for <bitbake-devel@lists.openembedded.org>;
	Thu,  2 Aug 2012 21:43:49 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q72Khl3j011085
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 2 Aug 2012 21:43:47 +0100
Message-ID: <1343940228.9756.99.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 02 Aug 2012 21:43:48 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] fetch2/local.py: Provide better debug output when fetch of a local file fails
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
X-List-Received-Date: Thu, 02 Aug 2012 20:55:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

When a fetch failure occurs for a local file, this patch ensures we print the
locations searched making it easier for the user to debug the problem.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/.gitignore b/.gitignore
index bd0acdc..0405bab 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,4 +1,3 @@
-bitbake
 *.pyc
 *.pyo
 /*.patch
diff --git a/bitbake/lib/bb/fetch2/local.py b/bitbake/lib/bb/fetch2/local.py
index bfef079..3a34f2a 100644
--- a/bitbake/lib/bb/fetch2/local.py
+++ b/bitbake/lib/bb/fetch2/local.py
@@ -30,7 +30,8 @@ import urllib
 import bb
 import bb.utils
 from   bb import data
-from   bb.fetch2 import FetchMethod
+from   bb.fetch2 import FetchMethod, FetchError
+from   bb.fetch2 import logger
 
 class Local(FetchMethod):
     def supports(self, url, urldata, d):
@@ -41,16 +42,15 @@ class Local(FetchMethod):
 
     def urldata_init(self, ud, d):
         # We don't set localfile as for this fetcher the file is already local!
-        ud.basename = os.path.basename(urllib.unquote(ud.url.split("://")[1].split(";")[0]))
+        ud.decodedurl = urllib.unquote(ud.url.split("://")[1].split(";")[0])
+        ud.basename = os.path.basename(ud.decodedurl)
         return
 
     def localpath(self, url, urldata, d):
         """
         Return the local filename of a given url assuming a successful fetch.
         """
-        path = url.split("://")[1]
-        path = path.split(";")[0]
-        path = urllib.unquote(path)
+        path = urldata.decodedurl
         newpath = path
         if path[0] != "/":
             filespath = data.getVar('FILESPATH', d, True)
@@ -76,7 +76,20 @@ class Local(FetchMethod):
     def download(self, url, urldata, d):
         """Fetch urls (no-op for Local method)"""
         # no need to fetch local files, we'll deal with them in place.
-        return 1
+        if self.supports_checksum(urldata) and not os.path.exists(urldata.localpath):
+            locations = []
+            filespath = data.getVar('FILESPATH', d, True)
+            if filespath:
+                locations = filespath.split(":")
+            filesdir = data.getVar('FILESDIR', d, True)
+            if filesdir:
+                locations.append(filesdir)
+            locations.append(d.getVar("DL_DIR", True))
+
+            msg = "Unable to find file " + url + " anywhere. The paths that were searched were:\n    " + "\n    ".join(locations)
+            raise FetchError(msg)
+
+        return True
 
     def checkstatus(self, url, urldata, d):
         """




