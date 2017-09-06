Return-Path: <mcfrisk@kapsi.fi>
Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
	by mail.openembedded.org (Postfix) with ESMTP id 33846606B2
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Sep 2017 12:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; h=Message-Id:Date:Subject:Cc:To:From;
	bh=z1klrcUdFJCpvZhq2pPjKt9MYKlsEhRYRHMDhEaMyoE=; 
	b=z3Xbs0c8iChZEitDzRnzVgdv/JDXB4pnlTUXylXXWle2lvNcFGGwIw5vtqPJF423ffnyfA3Zl10GOWDKob4xK6s7UphkTw9T+O3vr9VPuAdJXdtZ6Cnd+PD9eErKkG324AVgy3LTlpYt4Mw7pqkA4aCeWbO89bQHmtmCgvLqJnpmIbDyrMH/SD+yORUIwnjBpA9p0GfY29qvRGi1zwqwfy39j0xjmywKdphxHFE30BHh2Wmt7cM4IPaFnxNjs0WlqEwUHHVF6AT1U3smTonEm+RIJ4IlzvgPXylYzY+4ERtIyLBw1TNPnr5lkckj0aJHSKykMZfF7JKP9p5IJWQPDQ==;
Received: from lakka.kapsi.fi ([2001:1bc8:1004::1] ident=Debian-exim)
	by mail.kapsi.fi with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.84_2) (envelope-from <mcfrisk@kapsi.fi>)
	id 1dpZWP-0003UG-2a; Wed, 06 Sep 2017 15:33:33 +0300
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.84_2)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1dpZWP-0002nv-0Y; Wed, 06 Sep 2017 15:33:33 +0300
From: Mikko Rapeli <mikko.rapeli@bmw.de>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Sep 2017 15:33:29 +0300
Message-Id: <1504701210-10424-1-git-send-email-mikko.rapeli@bmw.de>
X-Mailer: git-send-email 2.1.4
X-SA-Exim-Connect-IP: 2001:1bc8:1004::1
X-SA-Exim-Mail-From: mcfrisk@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Subject: [PATCH v2 1/2] gitsm.py: use download cache for git submodules too
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
X-List-Received-Date: Wed, 06 Sep 2017 12:33:32 -0000

Currently download caches for recipes using gitsm are filled also with
the submodule repositories but when the git submodule tree is reused from
cache, only the base repository is cloned. After a source URL rewrite,
'git submodule update --init --recursive' is called in the tree
which downloads the needed submodules from upstream URL's.
This wastes bandwidth since download cache already had the needed
commits for the submodule repositories.

With this change, also the submodule repositories are copied to the
work space from download cache and the download from upstream can
be avoided. Using plain 'cp -a' since git cloning doesn't work for the
submodule directories.

Note that using BB_NO_NETWORK does not stop the submodule downloads
from 'git submodule update --init --recursive'. Thus tested by
breaking access to remote repository via /etc/hosts line like:

127.0.0.1       localhost github.com

Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
---
 bitbake/lib/bb/fetch2/gitsm.py | 8 ++++++++
 1 file changed, 8 insertions(+)

v2: send to bitbake-devel

v1: was sent to oe-core

diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.py
index 0aff100..20a9c40 100644
--- a/bitbake/lib/bb/fetch2/gitsm.py
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -131,5 +131,13 @@ class GitSM(Git):
         Git.unpack(self, ud, destdir, d)
 
         if self.uses_submodules(ud, d, ud.destdir):
+            # Copy also submodule trees from download cache instead of
+            # downloading again from the upstream repository.
+            # For some reason git does not clone them.
+            clone_modules = os.path.join(ud.clonedir, "modules")
+            if os.path.exists(clone_modules):
+                dest_modules = os.path.join(ud.destdir, ".git")
+                runfetchcmd("cp -a " + clone_modules + " " + dest_modules, d)
+
             runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d, workdir=ud.destdir)
             runfetchcmd(ud.basecmd + " submodule update --init --recursive", d, workdir=ud.destdir)
-- 
1.9.1


