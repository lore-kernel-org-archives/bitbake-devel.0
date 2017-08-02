Return-Path: <mcfrisk@kapsi.fi>
X-Greylist: delayed 1156 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 02 Aug 2017 10:07:17 UTC
Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
	by mail.openembedded.org (Postfix) with ESMTP id 42B2B780B4
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Aug 2017 10:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Message-Id:Date:Subject:Cc:To:From;
	bh=O8z2WvQjux1uCFX8l40RGR34MT89GJzlz+Uzdxg5REs=; 
	b=0/m3gYWzaqFbzdmqZSi62f4xYPYZzgpB/qKkKwiy/tZfeNW7XJQl66UGa9ebYUpFq/VSaLa/L2vcxC/Vzq2QH8ZV7M94WGx6Q7Q8VqmymjmfGsc6i7D6mka0fpt9c/34IydpIjmvsV5Cs1641DdtcUhnDKWq8dL2y818iKgfSHMud7a9Wo0f5XCGydjasgFUUMPf/+AhryUsY2hw4VgrNz6i0zvdHjvlM90pzZwI22Q9l/c2x6xTG1JsPELil2QsbSQ1VwjJs0CnHWkezvtTl7X/7ZN2bovrLP8eFnqiDSCLHsYNYfspjYTekfPXW5riGvHpMi/U9+Kj80utvHULpA==;
Received: from lakka.kapsi.fi ([2001:1bc8:1004::1] ident=Debian-exim)
	by mail.kapsi.fi with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.84_2) (envelope-from <mcfrisk@kapsi.fi>)
	id 1dcqFz-0003Gy-HB; Wed, 02 Aug 2017 12:47:59 +0300
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.84_2)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1dcqFz-0000Iu-F4; Wed, 02 Aug 2017 12:47:59 +0300
From: Mikko Rapeli <mikko.rapeli@bmw.de>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Aug 2017 12:47:44 +0300
Message-Id: <1501667264-32012-1-git-send-email-mikko.rapeli@bmw.de>
X-Mailer: git-send-email 2.1.4
X-SA-Exim-Connect-IP: 2001:1bc8:1004::1
X-SA-Exim-Mail-From: mcfrisk@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Subject: [PATCH] fetch2/git.py: try to handle local clone failures by pruning branches
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
X-List-Received-Date: Wed, 02 Aug 2017 10:07:18 -0000

Switching bitbake build environment from Ubuntu 14.04 to 16.04 brought
up this incompatibility between download cache data generated with
git 1.9.x.

In git 1.9.x from Ubuntu 14.04 local cloning succeeds even if source tree
has non-existing remote branches, which have been deleted in upstream git
tree.

In git 2.7.x from Ubuntu 16.04 cloning fails with an error:

downloads/git2$ git clone sourceware.org.git.glibc.git/ /tmp/
Cloning into '/tmp'...
done.
fatal: cannot process 'refs/remotes/origin/hjl/memcpy' and 'refs/remotes/origin/hjl/memcpy/dpdk/master' at the same time
fatal: The remote end hung up unexpectedly

Work around this by pruning non-existing remote branches from the git
tree in download cache if cloning failed, and then try the local clone
again.

Another workaround is to do those steps manually for every download cache,
but that does not scale in large distributed build environments.

Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
---
 lib/bb/fetch2/git.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 534c93d..d25c16e 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -472,7 +472,17 @@ class Git(FetchMethod):
             bb.utils.mkdirhier(destdir)
             runfetchcmd("tar -xzf %s" % ud.fullshallow, d, workdir=destdir)
         else:
-            runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, ud.cloneflags, ud.clonedir, destdir), d)
+            try:
+                runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, ud.cloneflags, ud.clonedir, destdir), d)
+            except bb.fetch2.FetchError:
+                # try to recover by pruning deleted remote branches which
+                # make cloning local git tree fail in git 2.7.x but not in
+                # git 1.9.x
+                try:
+                    runfetchcmd("%s -C %s remote prune origin" % (ud.basecmd, ud.clonedir), d)
+                except bb.fetch2.FetchError:
+                    pass
+                runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, ud.cloneflags, ud.clonedir, destdir), d)
 
         repourl = self._get_repo_url(ud)
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, repourl), d, workdir=destdir)
-- 
1.9.1


