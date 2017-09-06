Return-Path: <mcfrisk@kapsi.fi>
Received: from mail.kapsi.fi (mail.kapsi.fi [91.232.154.25])
	by mail.openembedded.org (Postfix) with ESMTP id 10258606B2
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Sep 2017 12:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
	s=20161220; 
	h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
	bh=Aiok8Cfwe0Kov0LlQgp1Fj+K1SYt8NmdwDZgJCUXq8k=; 
	b=nG8oXJGLD+g05/sJxidZp1ZupRnOr2jCrkqUW/aglVjhfaJu9iI0n+ix2WNRgPGdOMxiY5s80BOchy1Pmn9hLz5QsoSzQhQpbRXDstrI/JafPQJOjhwWwGkx50DKoXZ+OpzjYtCxjPaKxbJBDw2rDQ8Fo20OEj9xDavCeDGngrRvhtwnFekks7n7evuSUvzqzxbj9/gmFikBNNGlirEOssMNV+IRHotIa8TXjk5sG0fs+fabIP9KZOIA47JC5WEmYC19HqNudT3kqceci5/iKNME+Y0+wWN+UgnA/33sdoce+BJqOSGERJk5td1mswli3x0MG+hg64QL0mCOFrlD6g==;
Received: from lakka.kapsi.fi ([2001:1bc8:1004::1] ident=Debian-exim)
	by mail.kapsi.fi with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.84_2) (envelope-from <mcfrisk@kapsi.fi>)
	id 1dpZWQ-0003Up-5s; Wed, 06 Sep 2017 15:33:34 +0300
Received: from mcfrisk by lakka.kapsi.fi with local (Exim 4.84_2)
	(envelope-from <mcfrisk@lakka.kapsi.fi>)
	id 1dpZWQ-0002p9-2t; Wed, 06 Sep 2017 15:33:34 +0300
From: Mikko Rapeli <mikko.rapeli@bmw.de>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Sep 2017 15:33:30 +0300
Message-Id: <1504701210-10424-2-git-send-email-mikko.rapeli@bmw.de>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1504701210-10424-1-git-send-email-mikko.rapeli@bmw.de>
References: <1504701210-10424-1-git-send-email-mikko.rapeli@bmw.de>
X-SA-Exim-Connect-IP: 2001:1bc8:1004::1
X-SA-Exim-Mail-From: mcfrisk@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Subject: [PATCH v2 2/2] gitsm.py: support BB_NO_NETWORK during do_unpack
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
X-List-Received-Date: Wed, 06 Sep 2017 12:33:33 -0000

'git submodule update --init -recursive' will clone remote repositories
if local tree does not have the referenced commits. Add --no-fetch
to git submodule update if BB_NO_NETWORK is defined and only local
download caches should be used.

Signed-off-by: Mikko Rapeli <mikko.rapeli@bmw.de>
---
 bitbake/lib/bb/fetch2/gitsm.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

v2: send to bitbake-devel

v1: was sent to oe-core

diff --git a/bitbake/lib/bb/fetch2/gitsm.py b/bitbake/lib/bb/fetch2/gitsm.py
index 20a9c40..007d06e 100644
--- a/bitbake/lib/bb/fetch2/gitsm.py
+++ b/bitbake/lib/bb/fetch2/gitsm.py
@@ -140,4 +140,7 @@ class GitSM(Git):
                 runfetchcmd("cp -a " + clone_modules + " " + dest_modules, d)
 
             runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d, workdir=ud.destdir)
-            runfetchcmd(ud.basecmd + " submodule update --init --recursive", d, workdir=ud.destdir)
+            if d.getVar("BB_NO_NETWORK", True) == "1":
+                runfetchcmd(ud.basecmd + " submodule update --no-fetch --init --recursive", d, workdir=ud.destdir)
+            else:
+                runfetchcmd(ud.basecmd + " submodule update --init --recursive", d, workdir=ud.destdir)
-- 
1.9.1


