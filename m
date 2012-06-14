Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1Sf7B4-0000v2-7e
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 12:21:22 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q5EAAj5W016102
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Jun 2012 03:10:45 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Thu, 14 Jun 2012 03:10:44 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Jun 2012 18:10:58 +0800
Message-ID: <36062e7eb3dcac9799c5b7b0b7f54d7c06e1a48f.1339653356.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1339653356.git.kai.kang@windriver.com>
References: <cover.1339653356.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 3/3] image-writer: tweak some strings
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 14 Jun 2012 10:21:23 -0000
Content-Type: text/plain

Tweak some strings in accord with the script name 'image writer', and
remove extra noun 'button'.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/bin/image-writer |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/bitbake/bin/image-writer b/bitbake/bin/image-writer
index 3f9f5c1..0b9e450 100755
--- a/bitbake/bin/image-writer
+++ b/bitbake/bin/image-writer
@@ -33,7 +33,7 @@ from bb.ui.crumbs.hobwidget import HobAltButton, HobButton
 
 # I put all the fs bitbake supported here. Need more test.
 DEPLOYABLE_IMAGE_TYPES = ["jffs2", "cramfs", "ext2", "ext3", "btrfs", "squashfs", "ubi", "vmdk"]
-Title = "USB Image Maker"
+Title = "USB Image Writer"
 
 class DeployWindow(gtk.Window):
     def __init__(self, image_path=''):
@@ -43,13 +43,13 @@ class DeployWindow(gtk.Window):
             valid = True
             if not os.path.exists(image_path):
                 valid = False
-                lbl = "<b>Invalid image file path: %s.</b>\nPress <b>Select Image</b> button to select an image." % image_path
+                lbl = "<b>Invalid image file path: %s.</b>\nPress <b>Select Image</b> to select an image." % image_path
             else:
                 image_path = os.path.abspath(image_path)
                 extend_name = os.path.splitext(image_path)[1][1:]
                 if extend_name not in DEPLOYABLE_IMAGE_TYPES:
                     valid = False
-                    lbl = "<b>Undeployable imge type: %s</b>\nPress <b>Select Image</b> button to select an image." % extend_name
+                    lbl = "<b>Undeployable imge type: %s</b>\nPress <b>Select Image</b> to select an image." % extend_name
 
             if not valid:
                 image_path = ''
@@ -66,8 +66,8 @@ class DeployWindow(gtk.Window):
         HobAltButton.style_button(close_button)
         close_button.connect('clicked', gtk.main_quit)
 
-        make_button = self.deploy_dialog.add_button("Make USB image", gtk.RESPONSE_YES)
-        HobAltButton.style_button(make_button)
+        write_button = self.deploy_dialog.add_button("Write USB image", gtk.RESPONSE_YES)
+        HobAltButton.style_button(write_button)
 
         self.deploy_dialog.connect('select_image_clicked', self.select_image_clicked_cb)
         self.deploy_dialog.connect('destroy', gtk.main_quit)
-- 
1.7.5.4



