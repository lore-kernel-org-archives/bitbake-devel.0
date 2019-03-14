Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0E0DC6B50B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Mar 2019 09:09:09 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x2E99A6A016259
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Mar 2019 02:09:10 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.439.0; Thu, 14 Mar 2019 02:09:08 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Mar 2019 17:28:17 +0800
Message-ID: <bb7358f27955d4b020dd9a7dfce2d49e457a2faa.1552555629.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1552555629.git.liezhi.yang@windriver.com>
References: <cover.1552555629.git.liezhi.yang@windriver.com>
MIME-Version: 1.0
Subject: [PATCH 1/5] fetch2/git: Fix clean to remove clonedir
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
X-List-Received-Date: Thu, 14 Mar 2019 09:09:12 -0000
Content-Type: text/plain

The localpath is a symlink to clonedir when it is cloned from a mirror, for
example:
$ bitbake systemtap-native -cfetch
$ ls downloads/git2
sourceware.org.git.systemtap.git -> /path/to/downloads/git2/mirror.path.git.sourceware.org.git.systemtap.git
mirror.path.git.sourceware.org.git.systemtap.git

There are both sourceware.org.git.systemtap.git and
mirror.path.git.sourceware.org.git.systemtap.git in DL_DIR/git2, the symlink
sourceware.org.git.systemtap.git is created by try_mirror_url(), but
do_cleanall" only removed the symlink, didn't remove the real dir
mirror.path.git.sourceware.org.git.systemtap.git, this may cause confusions,
for example, I assumed that do_cleanall removed everything, but it didn't, and
it would the re-used next time when do_fetch. This patch fixes the problem.

Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
---
 bitbake/lib/bb/fetch2/git.py | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 1a8ebe3..cf8bee7 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -522,9 +522,17 @@ class Git(FetchMethod):
     def clean(self, ud, d):
         """ clean the git directory """
 
-        bb.utils.remove(ud.localpath, True)
-        bb.utils.remove(ud.fullmirror)
-        bb.utils.remove(ud.fullmirror + ".done")
+        to_remove = [ud.localpath, ud.fullmirror, ud.fullmirror + ".done"]
+        # The localpath is a symlink to clonedir when it is cloned from a
+        # mirror, so remove both of them.
+        if os.path.islink(ud.localpath):
+            clonedir = os.path.realpath(ud.localpath)
+            to_remove.append(clonedir)
+
+        for r in to_remove:
+            if os.path.exists(r):
+                bb.note('Removing %s' % r)
+                bb.utils.remove(r, True)
 
     def supports_srcrev(self):
         return True
-- 
2.7.4


