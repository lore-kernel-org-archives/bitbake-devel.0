Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1SZeBz-00008U-Gn
	for bitbake-devel@lists.openembedded.org;
	Wed, 30 May 2012 10:23:43 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q4U8DOid008739
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 May 2012 01:13:24 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Wed, 30 May 2012 01:13:23 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 30 May 2012 16:13:47 +0800
Message-ID: <1338365627-20706-1-git-send-email-kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Subject: [PATCH] hob2: set beginning folders for FileChooserDialog
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
X-List-Received-Date: Wed, 30 May 2012 08:23:43 -0000
Content-Type: text/plain

Set begining folders FileChooserDialog for the select images and
some local directory configurations. That may make user feel more
convenient.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index 4baf960..38db466 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -137,6 +137,8 @@ class AdvancedSettingDialog (CrumbsDialog):
     def entry_widget_select_path_cb(self, action, parent, entry):
         dialog = gtk.FileChooserDialog("", parent,
                                        gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER)
+        text = entry.get_text()
+        dialog.set_current_folder(text if len(text) > 0 else os.getcwd())
         button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
         HobAltButton.style_button(button)
         button = dialog.add_button("Open", gtk.RESPONSE_YES)
@@ -1092,6 +1094,8 @@ class ImageSelectionDialog (CrumbsDialog):
     def select_path_cb(self, action, parent, entry):
         dialog = gtk.FileChooserDialog("", parent,
                                        gtk.FILE_CHOOSER_ACTION_SELECT_FOLDER)
+        text = entry.get_text()
+        dialog.set_current_folder(text if len(text) > 0 else os.getcwd())
         button = dialog.add_button("Cancel", gtk.RESPONSE_NO)
         HobAltButton.style_button(button)
         button = dialog.add_button("Open", gtk.RESPONSE_YES)
-- 
1.7.5.4



