Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1Sf7B3-0000ut-E2
	for bitbake-devel@lists.openembedded.org;
	Thu, 14 Jun 2012 12:21:21 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q5EAAdJ8016097
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 Jun 2012 03:10:42 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Thu, 14 Jun 2012 03:10:38 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 14 Jun 2012 18:10:56 +0800
Message-ID: <cf49b94af8bfa7186d31620af742503ed4cd9605.1339653356.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1339653356.git.kai.kang@windriver.com>
References: <cover.1339653356.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/3] ui/crumbs/hig.py: tweak strings
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
X-List-Received-Date: Thu, 14 Jun 2012 10:21:21 -0000
Content-Type: text/plain

Add comments for DeployImageDialog 'standalone' part of codes to make it
easy to read.
And tweak some strings.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 3b50f68..0c3f56c 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -784,6 +784,11 @@ class DeployImageDialog (CrumbsDialog):
         scroll.add(tv)
         table.attach(scroll, 0, 10, 0, 1)
 
+        # There are 2 ways to use DeployImageDialog
+        # One way is that called by HOB when the 'Deploy Image' button is clicked
+        # The other way is that called by a standalone script.
+        # Following block of codes handles the latter way. It adds a 'Select Image' button and
+        # emit a signal when the button is clicked.
         if self.standalone:
                 gobject.signal_new("select_image_clicked", self, gobject.SIGNAL_RUN_FIRST,
                                    gobject.TYPE_NONE, ())
@@ -874,16 +879,16 @@ class DeployImageDialog (CrumbsDialog):
                     if os.path.exists(tmpname):
                         tmpfile = open(tmpname)
                         if int(tmpfile.readline().strip()) == 0:
-                            lbl = "<b>Deploy image successfully</b>"
+                            lbl = "<b>Deploy image successfully.</b>"
                         else:
-                            lbl = "<b>Deploy image failed</b>\nPlease try again."
+                            lbl = "<b>Failed to deploy image.</b>\nPlease check image <b>%s</b> exists and USB device <b>%s</b> is writable." % (self.image_path, combo_item)
                         tmpfile.close()
                         os.remove(tmpname)
             else:
                 if not self.image_path:
-                    lbl = "<b>No selection made</b>\nYou have not selected an image to deploy"
+                    lbl = "<b>No selection made.</b>\nYou have not selected an image to deploy."
                 else:
-                    lbl = "<b>No selection made</b>\nYou have not selected USB device"
+                    lbl = "<b>No selection made.</b>\nYou have not selected a USB device."
             if len(lbl):
                 crumbs_dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
                 button = crumbs_dialog.add_button("Close", gtk.RESPONSE_OK)
-- 
1.7.5.4



