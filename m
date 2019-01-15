Return-Path: <mark.hatle@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 806197C0AA
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Jan 2019 21:32:52 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x0FLWcs4026543
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 15 Jan 2019 13:32:38 -0800 (PST)
Received: from msp-lpggp1.wrs.com (172.25.34.110) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.3.408.0;
	Tue, 15 Jan 2019 13:32:37 -0800
From: Mark Hatle <mark.hatle@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 15 Jan 2019 16:31:34 -0500
Message-ID: <20190115213137.113956-5-mark.hatle@windriver.com>
X-Mailer: git-send-email 2.16.0.rc2
In-Reply-To: <20190115213137.113956-1-mark.hatle@windriver.com>
References: <20190115213137.113956-1-mark.hatle@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 4/7] gitsm.py: Optimize code and attempt to resolve locking issue
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
X-List-Received-Date: Tue, 15 Jan 2019 21:32:52 -0000
Content-Type: text/plain

It was reported that a race condition on a shared download directory could
occur with the gitsm fetcher, the result happened with a call to

  git config

that occured within the update_submodules.  Since the fetch is locked by the
upper level, it was probably the prior need_update(...) function causing this
because of some old code.

The gitsm class inherits the git class.  The need_update was overridding the
version in gitsm, so that it forceably checked the submodules.

It's clear we can optimize the code by only updating if the primary repository
needs updating.  Since we don't care if the submodule repository has changed
because if the primary hasn't, references to the submodule won't change.

Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
---
 lib/bb/fetch2/gitsm.py | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/lib/bb/fetch2/gitsm.py b/lib/bb/fetch2/gitsm.py
index dd94186..11bfa66 100644
--- a/lib/bb/fetch2/gitsm.py
+++ b/lib/bb/fetch2/gitsm.py
@@ -148,20 +148,6 @@ class GitSM(Git):
 
         return True
 
-    def need_update(self, ud, d):
-        main_repo_needs_update = Git.need_update(self, ud, d)
-
-        # First check that the main repository has enough history fetched. If it doesn't, then we don't
-        # even have the .gitmodules and gitlinks for the submodules to attempt asking whether the
-        # submodules' histories are recent enough.
-        if main_repo_needs_update:
-            return True
-
-        # Now check that the submodule histories are new enough. The git-submodule command doesn't have
-        # any clean interface for doing this aside from just attempting the checkout (with network
-        # fetched disabled).
-        return not self.update_submodules(ud, d)
-
     def download(self, ud, d):
         Git.download(self, ud, d)
 
-- 
1.8.3.1


