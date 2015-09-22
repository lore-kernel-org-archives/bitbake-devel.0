Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 64361766EB
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Sep 2015 02:41:09 +0000 (UTC)
Received: by padbj2 with SMTP id bj2so8637013pad.3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Sep 2015 19:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=S2iXy7iXZgNspoU4y4cBt2gcK/LuuBFK2h8sQjgZ2nI=;
	b=sukPCR/Y5vn9VJqbyaH3TVgaXF50sJjioUZxWdGsIXArsdwSEFbqsaEB6fNSeLULeV
	cmORvdfZ5Vzwgb3Fmri0OAnMtZ6pCjtrtp7eVWJe48IlXedg67a75VFaR73dMIhNwPWe
	zyk/Q626ykLjfbqbM3zF6HszUoi3DwdHcxCF1ub+Ho1jODbtLVJxLTCMC5wwTHjK1/ha
	ZRxEHN8vkUI0Azs+JUsMDuIkMeA8r7+Zfh/dnQoXKLGufKxwveU1xpLOTm3+kRN+Brlw
	DuZ5wQboGA4Gb6UJ7gvgApJD1IKnfhwtyUk0Y5dG0cz1WkveQ40bt3C5YEpP4oOuxiTo
	GJZQ==
X-Received: by 10.66.154.201 with SMTP id vq9mr29258198pab.105.1442889670320; 
	Mon, 21 Sep 2015 19:41:10 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	si1sm27136231pbc.72.2015.09.21.19.41.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 21 Sep 2015 19:41:09 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 Sep 2015 19:42:35 -0700
Message-Id: <bd29b02f5a169f2e6daebe9f29c6c0095e606c4d.1442889648.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1442889648.git.avery.brian@gmail.com>
References: <cover.1442889648.git.avery.brian@gmail.com>
Subject: [PATCH 1/1] toaster: Add fake entry to Target_File for filesystem root
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
X-List-Received-Date: Tue, 22 Sep 2015 02:41:10 -0000

From: Elliot Smith <elliot.smith@intel.com>

The files-in-image.txt file is produced by bitbake after an
image is created, listing all the files in the image.
However, this list doesn't include the root directory ('/').

buildinfohelper.py then tries to construct the filesystem
tree from this file, assuming that every directory apart from
the root directory (which is special-cased) can be assigned
a parent. But because the root directory isn't listed in
files-in-image.txt, an object for the root directory is never
created.

The direct subdirectories of the root ('./bin', './usr' etc.)
then can't be assigned a parent directory, as the object
representing the root directory doesn't exist. This
results in a Target_File lookup error and causes the
directory listing page to fail.

Fix this by creating a fake entry for the root directory
in the Target_File table, so that the direct subdirectories
of / can be assigned a parent. Note that it doesn't matter
that the root is faked, as its properties are never shown
in the directory structure tree.

[YOCTO #8280]

Signed-off-by: Elliot Smith <elliot.smith@intel.com>
Signed-off-by: brian avery <avery.brian@gmail.com>
---
 lib/bb/ui/buildinfohelper.py | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 6e313fe..b2201f6 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -353,26 +353,29 @@ class ORMWrapper(object):
         files = filedata['files']
         syms = filedata['syms']
 
-        # we insert directories, ordered by name depth
+        # always create the root directory as a special case;
+        # note that this is never displayed, so the owner, group,
+        # size, permission are irrelevant
+        tf_obj = Target_File.objects.create(target = target_obj,
+                                            path = '/',
+                                            size = 0,
+                                            owner = '',
+                                            group = '',
+                                            permission = '',
+                                            inodetype = Target_File.ITYPE_DIRECTORY)
+        tf_obj.save()
+
+        # insert directories, ordered by name depth
         for d in sorted(dirs, key=lambda x:len(x[-1].split("/"))):
             (user, group, size) = d[1:4]
             permission = d[0][1:]
             path = d[4].lstrip(".")
+
+            # we already created the root directory, so ignore any
+            # entry for it
             if len(path) == 0:
-                # we create the root directory as a special case
-                path = "/"
-                tf_obj = Target_File.objects.create(
-                        target = target_obj,
-                        path = path,
-                        size = size,
-                        inodetype = Target_File.ITYPE_DIRECTORY,
-                        permission = permission,
-                        owner = user,
-                        group = group,
-                        )
-                tf_obj.directory = tf_obj
-                tf_obj.save()
                 continue
+
             parent_path = "/".join(path.split("/")[:len(path.split("/")) - 1])
             if len(parent_path) == 0:
                 parent_path = "/"
-- 
1.9.1


