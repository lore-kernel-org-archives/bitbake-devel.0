Return-Path: <richard@rpsys.net>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 0913F773C2
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  1 Jun 2016 12:37:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cb48J007485; Wed, 1 Jun 2016 13:37:05 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id UiCySDPyFp4m; Wed,  1 Jun 2016 13:37:05 +0100 (BST)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u51Cax7l007466
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 1 Jun 2016 13:37:00 +0100
Received: from richard by hex with local (Exim 4.86)
	(envelope-from <richard@rpsys.net>)
	id 1b85ON-0000pF-II; Wed, 01 Jun 2016 13:36:59 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2016 13:36:43 +0100
Message-Id: <1464784607-2985-24-git-send-email-richard.purdie@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
References: <1464784607-2985-1-git-send-email-richard.purdie@linuxfoundation.org>
Subject: [PATCH 24/28] Revert "buildinfohelper: work around unicode exceptions"
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
X-List-Received-Date: Wed, 01 Jun 2016 12:37:13 -0000

From: Ed Bartosh <ed.bartosh@linux.intel.com>

This commit causes buildinfohelper to crash when run on python 3
as python 3 doesn't have unicode builtin function.

This reverts commit 7a309d964a86f3474eaab7df6d438ed797f935c0.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 lib/bb/ui/buildinfohelper.py | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index cea53e0..d59d6a5 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -494,7 +494,7 @@ class ORMWrapper(object):
             parent_obj = self._cached_get(Target_File, target = target_obj, path = parent_path, inodetype = Target_File.ITYPE_DIRECTORY)
             tf_obj = Target_File.objects.create(
                         target = target_obj,
-                        path = unicode(path, 'utf-8'),
+                        path = path,
                         size = size,
                         inodetype = Target_File.ITYPE_DIRECTORY,
                         permission = permission,
@@ -519,7 +519,7 @@ class ORMWrapper(object):
 
             tf_obj = Target_File.objects.create(
                         target = target_obj,
-                        path = unicode(path, 'utf-8'),
+                        path = path,
                         size = size,
                         inodetype = inodetype,
                         permission = permission,
@@ -550,9 +550,7 @@ class ORMWrapper(object):
                 filetarget_path = "/".join(fcpl)
 
             try:
-                filetarget_obj = Target_File.objects.get(
-                                     target = target_obj,
-                                     path = unicode(filetarget_path, 'utf-8'))
+                filetarget_obj = Target_File.objects.get(target = target_obj, path = filetarget_path)
             except Target_File.DoesNotExist:
                 # we might have an invalid link; no way to detect this. just set it to None
                 filetarget_obj = None
@@ -561,7 +559,7 @@ class ORMWrapper(object):
 
             tf_obj = Target_File.objects.create(
                         target = target_obj,
-                        path = unicode(path, 'utf-8'),
+                        path = path,
                         size = size,
                         inodetype = Target_File.ITYPE_SYMLINK,
                         permission = permission,
-- 
2.5.0


