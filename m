Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SQMRX-0004KS-PT for bitbake-devel@lists.openembedded.org;
	Fri, 04 May 2012 19:37:23 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q44HRaL0016042
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 May 2012 18:27:36 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 15276-08 for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 May 2012 18:27:32 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q44HRRpI016036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 4 May 2012 18:27:28 +0100
Message-ID: <1336152451.23777.30.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 04 May 2012 18:27:31 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake/fetch2/wget: Add fallback/default wget commands
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
X-List-Received-Date: Fri, 04 May 2012 17:37:24 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 9d36115..98900ac 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -54,12 +54,12 @@ class Wget(FetchMethod):
         """Fetch urls"""
 
         if checkonly:
-            fetchcmd = data.getVar("CHECKCOMMAND_wget", d, True)
+            fetchcmd = data.getVar("CHECKCOMMAND_wget", d, True) or d.expand("/usr/bin/env wget --spider -t 5 --passive-ftp --no-check-certificate -P ${DL_DIR} '${URI}'")
         elif os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again..
-            fetchcmd = data.getVar("RESUMECOMMAND_wget", d, True)
+            fetchcmd = data.getVar("RESUMECOMMAND_wget", d, True) or d.expand("/usr/bin/env wget -c -t 5 -nv --passive-ftp --no-check-certificate -P ${DL_DIR} '${URI}'")
         else:
-            fetchcmd = data.getVar("FETCHCOMMAND_wget", d, True)
+            fetchcmd = data.getVar("FETCHCOMMAND_wget", d, True) or d.expand("/usr/bin/env wget -t 5 -nv --passive-ftp --no-check-certificate -P ${DL_DIR} '${URI}'")
 
         uri = uri.split(";")[0]
         uri_decoded = list(decodeurl(uri))
@@ -78,7 +78,7 @@ class Wget(FetchMethod):
         # Also, this used to happen if sourceforge sent us to the mirror page
         if not os.path.exists(ud.localpath) and not checkonly:
             raise FetchError("The fetch command returned success for url %s but %s doesn't exist?!" % (uri, ud.localpath), uri)
-       
+
         return True
 
     def checkstatus(self, uri, ud, d):




