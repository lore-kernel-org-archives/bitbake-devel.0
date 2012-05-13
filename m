Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1STe1H-0006c2-U0 for bitbake-devel@lists.openembedded.org;
	Sun, 13 May 2012 20:59:52 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4DIns8G019718;
	Sun, 13 May 2012 19:49:54 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12067-04; Sun, 13 May 2012 19:49:49 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4DInTSg019704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 13 May 2012 19:49:48 +0100
Message-ID: <1336909489.2711.4.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 13 May 2012 12:44:49 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.2.2- 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake/fetch2: Remove hardcoded file removal and use clean method
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
X-List-Received-Date: Sun, 13 May 2012 18:59:52 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Under certain circumstances, bitbake could remove files which were
outside its control since it unconditionally removes ud.localpath.
In the file:// case this can point at external paths.
    
This patch converts it to use the clean() method which will remove
files when its safe to do so but not in the file:// case since the
file:// handler has an empty clean method. This means bitbake no
longer removes files outside its control and is generally much safer.
    
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index e5c4b34..8ae8caa 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -506,8 +506,7 @@ def try_mirrors(d, origud, mirrors, check = False):
             logger.debug(1, "Mirror fetch failure for url %s (original url: %s)" % (newuri, origud.url))
             logger.debug(1, str(e))
             try:
-                if os.path.isfile(ud.localpath):
-                    bb.utils.remove(ud.localpath)
+                ud.method.clean(ud, ld)
             except UnboundLocalError:
                 pass
             continue
@@ -981,8 +980,7 @@ class Fetch(object):
                         logger.debug(1, str(e))
                         firsterr = e
                         # Remove any incomplete fetch
-                        if os.path.isfile(ud.localpath):
-                            bb.utils.remove(ud.localpath)
+                        m.clean(ud, self.d)
                         logger.debug(1, "Trying MIRRORS")
                         mirrors = mirror_from_string(self.d.getVar('MIRRORS', True))
                         localpath = try_mirrors (self.d, ud, mirrors)



