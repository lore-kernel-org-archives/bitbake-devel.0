Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1STe15-0006aw-NZ for bitbake-devel@lists.openembedded.org;
	Sun, 13 May 2012 20:59:39 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4DInhhc019710;
	Sun, 13 May 2012 19:49:43 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 12124-03; Sun, 13 May 2012 19:49:37 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q4DInTSf019704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 13 May 2012 19:49:32 +0100
Message-ID: <1336909411.2711.2.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 13 May 2012 12:43:31 +0100
Mime-Version: 1.0
X-Mailer: Evolution 3.2.2- 
X-Virus-Scanned: amavisd-new at rpsys.net
Subject: [PATCH] bitbake/fetch2: Improve stamp creation in mirror code
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
X-List-Received-Date: Sun, 13 May 2012 18:59:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Under certain conditions such as local file:// mirrors of all files,
bitbake might not check checksums. This is not desirable and we should
always check the checksum where possible.
    
This only exception to this is the git mirror tarball case where the
checksum is unknown but we need to create the .done stamp for other
reasons. This patch preserves thta functionality but in a more specific
section of code where this doesn't interfere in normal checksums.
    
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 8ae8caa..e7571ab 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -476,7 +476,6 @@ def try_mirrors(d, origud, mirrors, check = False):
 
             if not os.path.exists(ud.donestamp) or ud.method.need_update(newuri, ud, ld):
                 ud.method.download(newuri, ud, ld)
-                open(ud.donestamp, 'w').close()
                 if hasattr(ud.method,"build_mirror_data"):
                     ud.method.build_mirror_data(newuri, ud, ld)
 
@@ -490,6 +489,7 @@ def try_mirrors(d, origud, mirrors, check = False):
             # If that tarball is a local file:// we need to provide a symlink to it
             dldir = ld.getVar("DL_DIR", True)
             if os.path.basename(ud.localpath) != os.path.basename(origud.localpath):
+                open(ud.donestamp, 'w').close()
                 dest = os.path.join(dldir, os.path.basename(ud.localpath))
                 if not os.path.exists(dest):
                     os.symlink(ud.localpath, dest)
@@ -497,6 +497,7 @@ def try_mirrors(d, origud, mirrors, check = False):
             # Otherwise the result is a local file:// and we symlink to it
             if not os.path.exists(origud.localpath):
                  os.symlink(ud.localpath, origud.localpath)
+            update_stamp(newuri, origud, ld)
             return ud.localpath
 
         except bb.fetch2.NetworkAccess:



