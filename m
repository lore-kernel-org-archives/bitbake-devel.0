Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id D2EC96F190
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:56:19 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s1SHuCag006117 for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:56:15 GMT
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id qe7WsVIMKQG5 for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:56:15 +0000 (GMT)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s1SHuCeS006107
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Feb 2014 17:56:13 GMT
Message-ID: <1393610164.31769.206.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Feb 2014 17:56:04 +0000
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] wget: Drop usage of old style *COMMAND variables
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
X-List-Received-Date: Fri, 28 Feb 2014 17:56:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

These variables were dropped from OE-Core some time ago, drop their
usage from the fetcher as well.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/wget.py b/bitbake/lib/bb/fetch2/wget.py
index 7cd25a5..e2f99ce 100644
--- a/bitbake/lib/bb/fetch2/wget.py
+++ b/bitbake/lib/bb/fetch2/wget.py
@@ -69,12 +69,12 @@ class Wget(FetchMethod):
             basecmd += " -O " + dldir + os.sep + ud.localfile
 
         if checkonly:
-            fetchcmd = d.getVar("CHECKCOMMAND_wget", True) or d.expand(basecmd + " --spider '${URI}'")
+            fetchcmd = d.expand(basecmd + " --spider '${URI}'")
         elif os.path.exists(ud.localpath):
             # file exists, but we didnt complete it.. trying again..
-            fetchcmd = d.getVar("RESUMECOMMAND_wget", True) or d.expand(basecmd + " -c -P ${DL_DIR} '${URI}'")
+            fetchcmd = d.expand(basecmd + " -c -P ${DL_DIR} '${URI}'")
         else:
-            fetchcmd = d.getVar("FETCHCOMMAND_wget", True) or d.expand(basecmd + " -P ${DL_DIR} '${URI}'")
+            fetchcmd = d.expand(basecmd + " -P ${DL_DIR} '${URI}'")
 
         uri = ud.url.split(";")[0]
 



