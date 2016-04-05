Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id B3A4477140
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  5 Apr 2016 10:35:52 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id u35AZqNb012367
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 5 Apr 2016 03:35:52 -0700
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.248.2;
	Tue, 5 Apr 2016 03:35:52 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 5 Apr 2016 03:35:51 -0700
Message-ID: <422c156e028c615327a780b83db657ba68259549.1459852436.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <cover.1459852436.git.liezhi.yang@windriver.com>
References: <cover.1459852436.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] fetch2/git.py: remove .indirectiondir workaround
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
X-List-Received-Date: Tue, 05 Apr 2016 10:35:54 -0000
Content-Type: text/plain

It was used for workaround git 1.7.9.2 which was released in 2012 which
should not be existed on nowadays host, so remove it to avoid
confusions.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 0513348..526668b 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -262,23 +262,7 @@ class Git(FetchMethod):
         if ud.bareclone:
             cloneflags += " --mirror"
 
-        # Versions of git prior to 1.7.9.2 have issues where foo.git and foo get confused
-        # and you end up with some horrible union of the two when you attempt to clone it
-        # The least invasive workaround seems to be a symlink to the real directory to
-        # fool git into ignoring any .git version that may also be present.
-        #
-        # The issue is fixed in more recent versions of git so we can drop this hack in future
-        # when that version becomes common enough.
-        clonedir = ud.clonedir
-        if not ud.path.endswith(".git"):
-            indirectiondir = destdir[:-1] + ".indirectionsymlink"
-            if os.path.exists(indirectiondir):
-                os.remove(indirectiondir)
-            bb.utils.mkdirhier(os.path.dirname(indirectiondir))
-            os.symlink(ud.clonedir, indirectiondir)
-            clonedir = indirectiondir
-
-        runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, cloneflags, clonedir, destdir), d)
+        runfetchcmd("%s clone %s %s/ %s" % (ud.basecmd, cloneflags, ud.clonedir, destdir), d)
         os.chdir(destdir)
         repourl = self._get_repo_url(ud)
         runfetchcmd("%s remote set-url origin %s" % (ud.basecmd, repourl), d)
-- 
2.8.0


