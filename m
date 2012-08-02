Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Sx2W9-0006n2-Q3 for bitbake-devel@lists.openembedded.org;
	Thu, 02 Aug 2012 23:01:14 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q72KnYEY011145
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 2 Aug 2012 21:49:34 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 09311-06 for <bitbake-devel@lists.openembedded.org>;
	Thu,  2 Aug 2012 21:49:30 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q72KnOBI011139
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 2 Aug 2012 21:49:25 +0100
Message-ID: <1343940565.9756.100.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 02 Aug 2012 21:49:25 +0100
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] fetch2/local: Add search paths to the debug log to improve log usefullness
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
X-List-Received-Date: Thu, 02 Aug 2012 21:01:14 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/local.py b/bitbake/lib/bb/fetch2/local.py
index 3a34f2a..690532d 100644
--- a/bitbake/lib/bb/fetch2/local.py
+++ b/bitbake/lib/bb/fetch2/local.py
@@ -55,13 +55,16 @@ class Local(FetchMethod):
         if path[0] != "/":
             filespath = data.getVar('FILESPATH', d, True)
             if filespath:
+                logger.debug(2, "Searching for %s in paths:    \n%s" % (path, "\n    ".join(filespath.split(":"))))
                 newpath = bb.utils.which(filespath, path)
             if not newpath:
                 filesdir = data.getVar('FILESDIR', d, True)
                 if filesdir:
+                    logger.debug(2, "Searching for %s in path: %s" % (path, filesdir))
                     newpath = os.path.join(filesdir, path)
             if not os.path.exists(newpath) and path.find("*") == -1:
                 dldirfile = os.path.join(d.getVar("DL_DIR", True), path)
+                logger.debug(2, "Defaulting to %s for %s" % (dldirfile, path))
                 bb.utils.mkdirhier(os.path.dirname(dldirfile))
                 return dldirfile
         return newpath




