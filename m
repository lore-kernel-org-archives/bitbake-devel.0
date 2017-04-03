Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id EF0FD77D0E
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Apr 2017 12:59:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 27E9418292
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Apr 2017 14:59:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id ipIoQO4AhtOq for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Apr 2017 14:59:57 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id 2EC98180FF
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Apr 2017 14:59:57 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D7C71A09A
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Apr 2017 14:59:57 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 124E91A097
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Apr 2017 14:59:57 +0200 (CEST)
Received: from thoth.se.axis.com (unknown [10.0.2.173])
	by boulder02.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Apr 2017 14:59:57 +0200 (CEST)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by thoth.se.axis.com (Postfix) with ESMTP id 062772773
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Apr 2017 14:59:57 +0200 (CEST)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id v33CxuBv027777
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 3 Apr 2017 14:59:56 +0200
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id v33CxuWO027776
	for bitbake-devel@lists.openembedded.org; Mon, 3 Apr 2017 14:59:56 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Apr 2017 14:59:35 +0200
Message-Id: <20170403125935.27692-1-pkj@axis.com>
X-Mailer: git-send-email 2.12.0
X-TM-AS-GCONF: 00
Subject: [morty][PATCH] fetch2: Do not fail to create symbolic links if they already exist
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
X-List-Received-Date: Mon, 03 Apr 2017 12:59:57 -0000

From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>

When the fetcher retrieves file:// URLs, there is no lock file being
used. This means that in case two separate tasks (typically from two
concurrent invocations of bitbake) want to download the same file://
URL at the same time, there is a very small chance that they also end
up wanting to create a symbolic link to the file at the same time.
This would previously lead to one of the tasks failing as the other
task would have created the link.

Signed-off-by: Peter Kjellerstedt <pkj@axis.com>
Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---

This is a backport of 58a03531c8183b165bb7dcad86d8559c92bc150d on
master.

 bitbake/lib/bb/fetch2/__init__.py | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index cd7362c44a..f36f01a707 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -967,7 +967,14 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
                 open(ud.donestamp, 'w').close()
             dest = os.path.join(dldir, os.path.basename(ud.localpath))
             if not os.path.exists(dest):
-                os.symlink(ud.localpath, dest)
+                # In case this is executing without any file locks held (as is
+                # the case for file:// URLs), two tasks may end up here at the
+                # same time, in which case we do not want the second task to
+                # fail when the link has already been created by the first task.
+                try:
+                    os.symlink(ud.localpath, dest)
+                except FileExistsError:
+                    pass
             if not verify_donestamp(origud, ld) or origud.method.need_update(origud, ld):
                 origud.method.download(origud, ld)
                 if hasattr(origud.method,"build_mirror_data"):
@@ -979,7 +986,11 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
                 # Broken symbolic link
                 os.unlink(origud.localpath)
 
-            os.symlink(ud.localpath, origud.localpath)
+            # As per above, in case two tasks end up here simultaneously.
+            try:
+                os.symlink(ud.localpath, origud.localpath)
+            except FileExistsError:
+                pass
         update_stamp(origud, ld)
         return ud.localpath
 
-- 
2.12.0


