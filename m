Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id C34386E3C1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:26:38 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s1SHQYLS004762 for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:26:34 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id of4YfxKJOD9W for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:26:34 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s1SHQSj1004758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:26:29 GMT
Message-ID: <1393608380.31769.203.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Feb 2014 17:26:20 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] fetch/wget: Separate out download and checkstatus functions
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
X-List-Received-Date: Fri, 28 Feb 2014 17:26:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

These two functions have little in common, separate them out.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index bb686b5..03d7e12 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -60,41 +60,47 @@ class Wget(FetchMethod):
 
         self.basecmd = d.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -t 2 -T 30 -nv --passive-ftp --no-check-certificate"
 
-    def download(self, ud, d, checkonly = False):
+    def __runwget(self, ud, d, command, quiet):
+
+        logger.debug(2, "Fetching %s using command '%s'" % (ud.url, command))
+        bb.fetch2.check_network_access(d, command)
+        runfetchcmd(command, d, quiet)
+
+    def download(self, ud, d):
         """Fetch urls"""
 
         fetchcmd = self.basecmd
 
-        if not checkonly and 'downloadfilename' in ud.parm:
+        if 'downloadfilename' in ud.parm:
             dldir = d.getVar("DL_DIR", True)
             bb.utils.mkdirhier(os.path.dirname(dldir + os.sep + ud.localfile))
             fetchcmd += " -O " + dldir + os.sep + ud.localfile
 
         uri = ud.url.split(";")[0]
-        if checkonly:
-            fetchcmd = self.basecmd + " --spider '%s'" % uri
-        elif os.path.exists(ud.localpath):
+        if os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again..
             fetchcmd = self.basecmd + d.expand(" -c -P ${DL_DIR} '%s'" % uri)
         else:
             fetchcmd = self.basecmd + d.expand(" -P ${DL_DIR} '%s'" % uri)
 
-        if not checkonly:
-            logger.info("fetch " + uri)
-            logger.debug(2, "executing " + fetchcmd)
-        bb.fetch2.check_network_access(d, fetchcmd)
-        runfetchcmd(fetchcmd, d, quiet=checkonly)
+        self.__runwget(ud, d, fetchcmd, False)
 
         # Sanity check since wget can pretend it succeed when it didn't
         # Also, this used to happen if sourceforge sent us to the mirror page
-        if not os.path.exists(ud.localpath) and not checkonly:
+        if not os.path.exists(ud.localpath):
             raise FetchError("The fetch command returned success for url %s but %s doesn't exist?!" % (uri, ud.localpath), uri)
 
-        if not checkonly and os.path.getsize(ud.localpath) == 0:
+        if os.path.getsize(ud.localpath) == 0:
             os.remove(ud.localpath)
             raise FetchError("The fetch of %s resulted in a zero size file?! Deleting and failing since this isn't right." % (uri), uri)
 
         return True
 
     def checkstatus(self, ud, d):
-        return self.download(ud, d, True)
+
+        uri = ud.url.split(";")[0]
+        fetchcmd = self.basecmd + " --spider '%s'" % uri
+
+        self.__runwget(ud, d, fetchcmd, True)
+
+        return True



