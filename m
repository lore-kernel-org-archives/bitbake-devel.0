Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id D24EC77DB7
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Mar 2017 15:00:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id A02CE1843A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Mar 2017 17:00:04 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id 7bk75t5QdJjY for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Mar 2017 17:00:01 +0200 (CEST)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id A5A70183CC
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Mar 2017 17:00:01 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 923471E05C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Mar 2017 17:00:01 +0200 (CEST)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 86D011E056
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Mar 2017 17:00:01 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder03.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Mar 2017 17:00:01 +0200 (CEST)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id 7AC1F23D1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Mar 2017 17:00:01 +0200 (CEST)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id v2VF01V1008266
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Mar 2017 17:00:01 +0200
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id v2VF01Ap008265
	for bitbake-devel@lists.openembedded.org;
	Fri, 31 Mar 2017 17:00:01 +0200
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Mar 2017 16:59:56 +0200
Message-Id: <938bb5a85f8bbb61946504f1ac477ade83441d81.1490972335.git.pkj@axis.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <cover.1490972335.git.pkj@axis.com>
References: <cover.1490972335.git.pkj@axis.com>
X-TM-AS-GCONF: 00
Subject: [PATCH 1/1] fetch2: Do not fail to create symbolic links if they already exist
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
X-List-Received-Date: Fri, 31 Mar 2017 15:00:05 -0000

When the fetcher retrieves file:// URLs, there is no lock file being
used. This means that in case two separate tasks (typically from two
concurrent invocations of bitbake) want to download the same file://
URL at the same time, there is a very small chance that they also end
up wanting to create a symbolic link to the file at the same time.
This would previously lead to one of the tasks failing as the other
task would have created the link.

Signed-off-by: Peter Kjellerstedt <pkj@axis.com>
---
 bitbake/lib/bb/fetch2/__init__.py | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index ea72025c22..136fc29c16 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -983,7 +983,14 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
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
@@ -995,7 +1002,11 @@ def try_mirror_url(fetch, origud, ud, ld, check = False):
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


