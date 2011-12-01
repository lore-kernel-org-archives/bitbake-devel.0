Received: from opal.openembedded.org ([140.211.169.152] helo=opal)
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <git@git.openembedded.org>) id 1RWFvL-0004sm-TE
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Dec 2011 00:20:16 +0100
Received: by opal (Postfix, from userid 111)
	id 4A4AC1032F; Thu,  1 Dec 2011 23:16:54 +0000 (UTC)
To: bitbake-devel@lists.openembedded.org
Message-Id: <20111201231654.4A4AC1032F@opal>
Date: Thu,  1 Dec 2011 23:16:54 +0000 (UTC)
From: git@git.openembedded.org
Subject: Richard Purdie : cooker.py: Allow the -e option to work with virtual classes and -b
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
X-List-Received-Date: Thu, 01 Dec 2011 23:20:16 -0000
Content-Type: text/plain; charset=UTF-8

Module: bitbake.git
Branch: master
Commit: bd5a727c8447bcb747c1d2463b7de2ab6d21a7de
URL:    http://git.openembedded.org/?p=bitbake.git&a=commit;h=bd5a727c8447bcb747c1d2463b7de2ab6d21a7de

Author: Richard Purdie <richard.purdie@linuxfoundation.org>
Date:   Thu Dec  1 23:11:24 2011 +0000

cooker.py: Allow the -e option to work with virtual classes and -b

Using bitbake -e -b virtual:xxxx:/path/to/the.bb would result in
zero matches since the virtual:xxxx piece wasn't being processed.

This adds in the necessary functionality to handle it correctly.

[YOCTO #1793]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

---

 lib/bb/cooker.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/lib/bb/cooker.py b/lib/bb/cooker.py
index f484b68..cbe0d71 100644
--- a/lib/bb/cooker.py
+++ b/lib/bb/cooker.py
@@ -289,7 +289,9 @@ class BBCooker:
             self.status = bb.cache.CacheData(self.caches_array)
             self.handleCollections( self.configuration.data.getVar("BBFILE_COLLECTIONS", 1) )
 
-            fn = self.matchFile(buildfile)
+            fn, cls = bb.cache.Cache.virtualfn2realfn(buildfile)
+            fn = self.matchFile(fn)
+            fn = bb.cache.Cache.realfn2virtual(fn, cls)
         elif len(pkgs_to_build) == 1:
             self.updateCache()
 



