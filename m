Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1SXV18-0004AE-DX for bitbake-devel@lists.openembedded.org;
	Thu, 24 May 2012 12:11:39 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4OA1RjU022311
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 May 2012 11:01:27 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 21227-08 for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 May 2012 11:01:22 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4OA1GqN022301
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 May 2012 11:01:17 +0100
Message-ID: <1337853676.8248.104.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 24 May 2012 11:01:16 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake/cooker: Ensure matchFile returns full pathnames
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
X-List-Received-Date: Thu, 24 May 2012 10:11:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

We should always be passing full pathnames around within bitbake. If
a file was referenced as a relative path to the current working
directory, it might not get passed through the abspath call and
hence the cwd would not get added as a prefix.

This change attempts to put everything through abspath and ignores
failures. Any failure cases would mean the file simply wouldn't exist
and then would get covered by the catchall code below.

[YOCTO #1465]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 8ad4922..e036efb 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -985,9 +985,10 @@ class BBCooker:
         """
         Find the .bb files which match the expression in 'buildfile'.
         """
-
-        if bf.startswith("/") or bf.startswith("../"):
+        try:
             bf = os.path.abspath(bf)
+        except:
+            pass
         filelist, masked = self.collect_bbfiles()
         try:
             os.stat(bf)




