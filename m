Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1TbejC-0000v1-Kz for bitbake-devel@lists.openembedded.org;
	Thu, 22 Nov 2012 22:54:35 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAMLeRJC029704
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Nov 2012 21:40:27 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 27637-06 for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Nov 2012 21:40:21 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id qAMLeILC029698
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Nov 2012 21:40:20 GMT
Message-ID: <1353620418.10459.63.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 22 Nov 2012 21:40:18 +0000
X-Mailer: Evolution 3.2.3-0ubuntu6 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] fetch2/local: Improve handling of wildcard matches
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
X-List-Received-Date: Thu, 22 Nov 2012 21:54:35 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Currently wildcard matches end up working by FILESDIR being defined
in the metadata to a default of "." in FILESPATH which is hacky at best.

This patch adds the behaviour into the fetcher so its at least slightly
more explicit.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/local.py b/bitbake/lib/bb/fetch2/local.py
index 690532d..7ea2f3b 100644
--- a/bitbake/lib/bb/fetch2/local.py
+++ b/bitbake/lib/bb/fetch2/local.py
@@ -62,7 +62,12 @@ class Local(FetchMethod):
                 if filesdir:
                     logger.debug(2, "Searching for %s in path: %s" % (path, filesdir))
                     newpath = os.path.join(filesdir, path)
-            if not os.path.exists(newpath) and path.find("*") == -1:
+            if not newpath or not os.path.exists(newpath) and path.find("*") != -1:
+                # For expressions using '*', best we can do is take the first directory in FILESPATH that exists
+                newpath = bb.utils.which(filespath, ".")
+                logger.debug(2, "Searching for %s in path: %s" % (path, newpath))
+                return newpath
+            if not os.path.exists(newpath):
                 dldirfile = os.path.join(d.getVar("DL_DIR", True), path)
                 logger.debug(2, "Defaulting to %s for %s" % (dldirfile, path))
                 bb.utils.mkdirhier(os.path.dirname(dldirfile))




