Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id C96E3747F6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Apr 2018 14:45:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 4E1FD18460
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Apr 2018 16:45:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id TnoTAiQERFeq for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Apr 2018 16:44:58 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id BEB86184C9
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Apr 2018 16:44:58 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6A431A072
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Apr 2018 16:44:58 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B6F41A069
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Apr 2018 16:44:58 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder02.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Apr 2018 16:44:58 +0200 (CEST)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id 900972D6B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Apr 2018 16:44:58 +0200 (CEST)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id w3AEiroY008644
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Apr 2018 16:44:53 +0200
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id w3AEirwi008643
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Apr 2018 16:44:53 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Apr 2018 16:44:51 +0200
Message-Id: <20180410144451.8539-1-pkj@axis.com>
X-Mailer: git-send-email 2.12.0
X-TM-AS-GCONF: 00
Subject: [PATCH] lib/bb/utils: prevent movefile from changing dest dir permissions
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
X-List-Received-Date: Tue, 10 Apr 2018 14:45:01 -0000

From: Mattias Hansson <mattias.hansson@axis.com>

Prevent movefile from falsely setting the source file's owner and
permissions on the destination directory instead of the destination
file when moving between devices.

This bug caused the last file moved into a directory to dictate the
directory's owner and permissions.

Signed-off-by: Mattias Hansson <mattias.hansson@axis.com>
Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/utils.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 8b739d7849..378e699e0c 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -807,8 +807,8 @@ def movefile(src, dest, newmtime = None, sstat = None):
                 return None # failure
         try:
             if didcopy:
-                os.lchown(dest, sstat[stat.ST_UID], sstat[stat.ST_GID])
-                os.chmod(dest, stat.S_IMODE(sstat[stat.ST_MODE])) # Sticky is reset on chown
+                os.lchown(destpath, sstat[stat.ST_UID], sstat[stat.ST_GID])
+                os.chmod(destpath, stat.S_IMODE(sstat[stat.ST_MODE])) # Sticky is reset on chown
                 os.unlink(src)
         except Exception as e:
             print("movefile: Failed to chown/chmod/unlink", dest, e)
-- 
2.12.0


