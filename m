Return-Path: <kergoth@gmail.com>
Received: from mail-pd0-f171.google.com (mail-pd0-f171.google.com
	[209.85.192.171])
	by mail.openembedded.org (Postfix) with ESMTP id 4BF0173CC7
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  3 Apr 2015 22:03:52 +0000 (UTC)
Received: by pdbnk13 with SMTP id nk13so53578934pdb.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 03 Apr 2015 15:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=t6PkOn8JfsGNaJA+iNQjBBl3f8PSeal5t3mttrm60Fk=;
	b=fpw28kqcWii6leWyPx0xXv+Lq9j1xb8B4uxaQlVQrgr0bXflGcyTmgVC7QbqKREByE
	Hnl7o9EsdnahAYQAfrnlBqUXJmCWNOz8o+rsKg9a4CmWXjpse3aEyrc2Gdws0ZlbsLdi
	nbp+lXbeqmQlVnHSIyWLYCjFbi95YVQPE1C0bqRIioADm62FMMehxkchpizYhMXwIxB4
	BQ3ygMn/4x+css/Hia4z6PtJzwHiFsR4UFySE7T+5KaBa9U7kChNCUSit+yA3WXZQOyt
	YHBL+U3nRkTitEBQDkPk6Ktcazg9+fbQHfHNws//PTpvdPprlvOqOiFX/nmaf43kZ1N2
	0gDg==
X-Received: by 10.68.139.103 with SMTP id qx7mr7403859pbb.133.1428098634115;
	Fri, 03 Apr 2015 15:03:54 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by mx.google.com with ESMTPSA id jh2sm9021130pbb.25.2015.04.03.15.03.52
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 03 Apr 2015 15:03:52 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  3 Apr 2015 15:03:45 -0700
Message-Id: <1428098626-1947-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
Subject: [PATCH] bitbake: bin/image-writer: Add ext4 as a deployable image type
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
X-List-Received-Date: Fri, 03 Apr 2015 22:03:53 -0000

From: Richard Purdie <richard.purdie@linuxfoundation.org>

This is particularly problematic since qemu images switched to ext4 by
default and now cannot work properly with UIs like hob.

This patch adds in ext4 to the appropriate variable fixing this.

[YOCTO #7426]

(Bitbake rev: a1431b1b85bf90ed5f771552d0ce91de288047d4)

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
 bitbake/bin/image-writer | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/bin/image-writer b/bitbake/bin/image-writer
index 86c38b5..7d71167 100755
--- a/bitbake/bin/image-writer
+++ b/bitbake/bin/image-writer
@@ -34,7 +34,7 @@ from bb.ui.crumbs.hig.deployimagedialog import DeployImageDialog
 from bb.ui.crumbs.hig.imageselectiondialog import ImageSelectionDialog
 
 # I put all the fs bitbake supported here. Need more test.
-DEPLOYABLE_IMAGE_TYPES = ["jffs2", "cramfs", "ext2", "ext3", "btrfs", "squashfs", "ubi", "vmdk"]
+DEPLOYABLE_IMAGE_TYPES = ["jffs2", "cramfs", "ext2", "ext3", "ext4", "btrfs", "squashfs", "ubi", "vmdk"]
 Title = "USB Image Writer"
 
 class DeployWindow(gtk.Window):
-- 
2.2.1


