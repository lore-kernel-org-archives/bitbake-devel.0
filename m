Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SoHOC-0005XU-DE for bitbake-devel@lists.openembedded.org;
	Mon, 09 Jul 2012 19:04:48 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q69Grdxl009059
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 9 Jul 2012 17:53:39 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 08021-10 for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Jul 2012 17:53:34 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q69GrVCu009053
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 9 Jul 2012 17:53:32 +0100
Message-ID: <1341852811.8066.28.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 09 Jul 2012 17:53:31 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] fetch2/wget: Use FETCHCMD_wget to provide the commandline and options
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
X-List-Received-Date: Mon, 09 Jul 2012 17:04:48 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This also changes to use  -t 2 -T 30 as the defaults which are more sane for
a modern fetcher and already specified in OpenEmbedded metadata.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index e223b21..9881c8c 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -56,13 +56,15 @@ class Wget(FetchMethod):
     def download(self, uri, ud, d, checkonly = False):
         """Fetch urls"""
 
+        basecmd = data.getVar("FETCHCMD_wget", True) or "/usr/bin/env wget -t 2 -T 30 -nv --passive-ftp --no-check-certificate"
+
         if checkonly:
-            fetchcmd = data.getVar("CHECKCOMMAND_wget", d, True) or d.expand("/usr/bin/env wget --spider -t 5 --passive-ftp --no-check-certificate -P ${DL_DIR} '${URI}'")
+            fetchcmd = data.getVar("CHECKCOMMAND_wget", d, True) or d.expand(basecmd + " -c -P ${DL_DIR} '${URI}'")
         elif os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again..
-            fetchcmd = data.getVar("RESUMECOMMAND_wget", d, True) or d.expand("/usr/bin/env wget -c -t 5 -nv --passive-ftp --no-check-certificate -P ${DL_DIR} '${URI}'")
+            fetchcmd = data.getVar("RESUMECOMMAND_wget", d, True) or d.expand(basecmd + " --spider -P ${DL_DIR} '${URI}'")
         else:
-            fetchcmd = data.getVar("FETCHCOMMAND_wget", d, True) or d.expand("/usr/bin/env wget -t 5 -nv --passive-ftp --no-check-certificate -P ${DL_DIR} '${URI}'")
+            fetchcmd = data.getVar("FETCHCOMMAND_wget", d, True) or d.expand(basecmd + " -P ${DL_DIR} '${URI}'")
 
         uri = uri.split(";")[0]
         uri_decoded = list(decodeurl(uri))




