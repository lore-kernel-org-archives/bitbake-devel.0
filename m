Return-Path: <pascal.bach@siemens.com>
X-Greylist: delayed 2094 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 16 Sep 2016 09:33:13 UTC
Received: from goliath.siemens.de (goliath.siemens.de [192.35.17.28])
	by mail.openembedded.org (Postfix) with ESMTP id 0D02D73191
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 09:33:13 +0000 (UTC)
Received: from mail3.siemens.de (mail3.siemens.de [139.25.208.14])
	by goliath.siemens.de (8.15.2/8.15.2) with ESMTPS id u8G8wJsH014582
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 10:58:19 +0200
Received: from dev.sbt.siemens.com (MD1FZU9C.ww002.siemens.net [139.16.76.169])
	by mail3.siemens.de (8.15.2/8.15.2) with ESMTP id u8G8wJdj016195;
	Fri, 16 Sep 2016 10:58:19 +0200
From: Pascal Bach <pascal.bach@siemens.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2016 10:58:13 +0200
Message-Id: <1474016293-26538-1-git-send-email-pascal.bach@siemens.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] fetch2/git: always use premirror first if update is required
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
X-List-Received-Date: Fri, 16 Sep 2016 09:33:14 -0000

When an update of the local copy is required always try to fetch the update
from a premirror first.
The premirror should always have precedence over the upstream repository
as updating from there might not work if BB_FETCH_PREMIRRORONLY,
BB_NO_NBB_ALLOWED_NETWORKS or BB_NO_NETWORK is set.

This also gets rid of the special case for BB_FETCH_PREMIRRORONLY.

Signed-off-by: Pascal Bach <pascal.bach@siemens.com>
---
 lib/bb/fetch2/git.py | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/lib/bb/fetch2/git.py b/lib/bb/fetch2/git.py
index 1bec60a..cac2a87 100644
--- a/lib/bb/fetch2/git.py
+++ b/lib/bb/fetch2/git.py
@@ -227,13 +227,8 @@ class Git(FetchMethod):
         return False
 
     def try_premirror(self, ud, d):
-        # If we don't do this, updating an existing checkout with only premirrors
-        # is not possible
-        if d.getVar("BB_FETCH_PREMIRRORONLY", True) is not None:
-            return True
-        if os.path.exists(ud.clonedir):
-            return False
-        return True
+        # Always try premirror if an update is required
+        return self.need_update(ud, d)
 
     def download(self, ud, d):
         """Fetch url"""
-- 
2.1.4


