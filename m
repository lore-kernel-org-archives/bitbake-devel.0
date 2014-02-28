Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id 214AF6D8E9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:25:36 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s1SHPW77004754 for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:25:32 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 7sB0pbhuWXhw for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:25:32 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s1SHPSXJ004744
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:25:30 GMT
Message-ID: <1393608321.31769.202.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Feb 2014 17:25:21 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] fetch/wget: Start to clean up command construction
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
X-List-Received-Date: Fri, 28 Feb 2014 17:25:37 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Start to clean up wget fetcher command construction to allow clearer
and more extensible code structure. Drops support for ${URI} and
${FILE} directly in the commands.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index e2f99ce..bb686b5 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -58,28 +58,27 @@ class Wget(FetchMethod):
 
         ud.localfile = data.expand(urllib.unquote(ud.basename), d)
 
+        self.basecmd = d.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -t 2 -T 30 -nv --passive-ftp --no-check-certificate"
+
     def download(self, ud, d, checkonly = False):
         """Fetch urls"""
 
-        basecmd = d.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -t 2 -T 30 -nv --passive-ftp --no-check-certificate"
+        fetchcmd = self.basecmd
 
         if not checkonly and 'downloadfilename' in ud.parm:
             dldir = d.getVar("DL_DIR", True)
             bb.utils.mkdirhier(os.path.dirname(dldir + os.sep + ud.localfile))
-            basecmd += " -O " + dldir + os.sep + ud.localfile
+            fetchcmd += " -O " + dldir + os.sep + ud.localfile
 
+        uri = ud.url.split(";")[0]
         if checkonly:
-            fetchcmd = d.expand(basecmd + " --spider '${URI}'")
+            fetchcmd = self.basecmd + " --spider '%s'" % uri
         elif os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again..
-            fetchcmd = d.expand(basecmd + " -c -P ${DL_DIR} '${URI}'")
+            fetchcmd = self.basecmd + d.expand(" -c -P ${DL_DIR} '%s'" % uri)
         else:
-            fetchcmd = d.expand(basecmd + " -P ${DL_DIR} '${URI}'")
-
-        uri = ud.url.split(";")[0]
+            fetchcmd = self.basecmd + d.expand(" -P ${DL_DIR} '%s'" % uri)
 
-        fetchcmd = fetchcmd.replace("${URI}", uri.split(";")[0])
-        fetchcmd = fetchcmd.replace("${FILE}", ud.basename)
         if not checkonly:
             logger.info("fetch " + uri)
             logger.debug(2, "executing " + fetchcmd)



