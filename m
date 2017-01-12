Return-Path: <ola.redell@retotech.se>
X-Greylist: delayed 964 seconds by postgrey-1.34 at layers.openembedded.org;
	Thu, 12 Jan 2017 10:49:57 UTC
Received: from mailrelay11.public.one.com (mailrelay11.public.one.com
	[195.47.247.189])
	by mail.openembedded.org (Postfix) with ESMTP id B02C871AEB
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jan 2017 10:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=retotech.se; s=20140924;
	h=from:subject:date:message-id:to:cc;
	bh=colmvmQ/Kv4CKNnJ5esn0RrVLiqZxsRD83+gBxPwa58=;
	b=gKlh0GBeSEDR00T8EzfS68lSb2Ns/8t8UvP8hQbx9J3+sh8H9xi2sQHby1rKfwZsAMWN53gAF5dwz
	d5d9H96PuTInCL4///tWLW2249GMcz1d2zweobTDpJSUhPiS7q6IfKYWf8fOuvae3t+MpXy2RgFxC4
	YemndQlzwvq6OqMo=
X-HalOne-Cookie: 4434b19f8c236ca15cf7b2fc530a48072170afd7
X-HalOne-ID: 97a99a8e-d8b2-11e6-ba0f-b82a72d06996
Received: from localhost.localdomain (unknown [109.228.128.54])
	by smtpfilter3.public.one.com (Halon) with ESMTPSA
	id 97a99a8e-d8b2-11e6-ba0f-b82a72d06996;
	Thu, 12 Jan 2017 10:33:51 +0000 (UTC)
From: Ola Redell <ola.redell@retotech.se>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Jan 2017 11:33:27 +0100
Message-Id: <1484217207-1889-1-git-send-email-ola.redell@retotech.se>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH] gitsm.py: Add force flag to git checkout command in update_submodules
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
X-List-Received-Date: Thu, 12 Jan 2017 10:49:59 -0000

When the gitsm fetcher is used with a repo that includes a .gitattributes
file that makes git modify files on cloning (e.g. line break characters),
the subsequent checkout performed in the update_submodules function fails.
This is fixed by adding the force flag (-f) to the checkout command.

Signed-off-by: Ola Redell <ola.redell@retotech.se>
---
 lib/bb/fetch2/gitsm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index 6613762..939fb3f 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -108,7 +108,7 @@ class GitSM(Git):
         os.rename(ud.clonedir, gitdir)
         runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*true/bare = false/'", d)
         runfetchcmd(ud.basecmd + " reset --hard", d, workdir=tmpclonedir)
-        runfetchcmd(ud.basecmd + " checkout " + ud.revisions[ud.names[0]], d, workdir=tmpclonedir)
+        runfetchcmd(ud.basecmd + " checkout -f " + ud.revisions[ud.names[0]], d, workdir=tmpclonedir)
         runfetchcmd(ud.basecmd + " submodule update --init --recursive", d, workdir=tmpclonedir)
         self._set_relative_paths(tmpclonedir)
         runfetchcmd("sed " + gitdir + "/config -i -e 's/bare.*=.*false/bare = true/'", d, workdir=tmpclonedir)
-- 
2.7.4


