Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 5EA4973C71
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 21:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t2VLZgpO014020 for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 22:35:42 +0100
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pzwZGT21Lt4K for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 22:35:42 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	t2VLZRde014005
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 31 Mar 2015 22:35:39 +0100
Message-ID: <1427837727.14020.367.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Tue, 31 Mar 2015 22:35:27 +0100
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Mime-Version: 1.0
Subject: [PATCH] bin/image-writer: Add ext4 as a deployable image type
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
X-List-Received-Date: Tue, 31 Mar 2015 21:35:41 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

This is particularly problematic since qemu images switched to ext4 by 
default and now cannot work properly with UIs like hob.

This patch adds in ext4 to the appropriate variable fixing this.

[YOCTO #7426]

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>

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



