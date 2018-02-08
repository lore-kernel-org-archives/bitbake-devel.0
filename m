Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 9BD8D77BD2
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 Feb 2018 04:28:53 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w184StJE009929
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 7 Feb 2018 20:28:55 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Wed, 7 Feb 2018 20:28:48 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 8 Feb 2018 12:29:38 +0800
Message-ID: <b77413545becde32ba578928a2054abaee06e20e.1518064148.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1518064148.git.liezhi.yang@windriver.com>
References: <cover.1518064148.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/1] bitbake: toaster: don't use git fetch --all
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
X-List-Received-Date: Thu, 08 Feb 2018 04:28:53 -0000
Content-Type: text/plain

The '--all'' fetches all remotes, including the ones in $HOME/.gitconfig, which
causes the fetching very slow, so don't use "--all", git fetch should be
enough.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/toaster/bldcontrol/localhostbecontroller.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
index 4c17562..16c7c80 100644
--- a/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/bitbake/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -192,7 +192,7 @@ class LocalhostBEController(BuildEnvironmentController):
             if commit != "HEAD":
                 logger.debug("localhostbecontroller: checking out commit %s to %s " % (commit, localdirname))
                 ref = commit if re.match('^[a-fA-F0-9]+$', commit) else 'origin/%s' % commit
-                self._shellcmd('git fetch --all && git reset --hard "%s"' % ref, localdirname,env=git_env)
+                self._shellcmd('git fetch && git reset --hard "%s"' % ref, localdirname,env=git_env)
 
             # take the localdirname as poky dir if we can find the oe-init-build-env
             if self.pokydirname is None and os.path.exists(os.path.join(localdirname, "oe-init-build-env")):
-- 
2.7.4


