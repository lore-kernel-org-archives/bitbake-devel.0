Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1ScD4p-0002oA-Nb
	for bitbake-devel@lists.openembedded.org;
	Wed, 06 Jun 2012 12:02:56 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.3/8.14.3) with ESMTP id q569qRdI002836
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 6 Jun 2012 02:52:27 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Wed, 6 Jun 2012 02:52:27 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <dvhart@linux.intel.com>
Date: Wed, 6 Jun 2012 17:52:26 +0800
Message-ID: <bda43415c8822a6a47f955a7df6b382db29f7b33.1338976258.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1338976258.git.kai.kang@windriver.com>
References: <cover.1338976258.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: bitbake-devel@lists.openembedded.org, zhenfeng.zhao@windriver.com
Subject: [PATCH 4/6] ui/crumbs/hig.py: check deploy process return value
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
X-List-Received-Date: Wed, 06 Jun 2012 10:02:56 -0000
Content-Type: text/plain

Update function response_cb of DeployImageDialog to get deploy process
return value. According the return value tell user that deploy image
successfully or not.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   32 +++++++++++++++++++++++++++++---
 1 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index cf73145..97a3b22 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -827,12 +827,38 @@ class DeployImageDialog (CrumbsDialog):
 
     def response_cb(self, dialog, response_id):
         if response_id == gtk.RESPONSE_YES:
+            lbl = ''
             combo_item = self.usb_combo.get_active_text()
-            if combo_item and combo_item != self.__dummy_usb__:
+            if combo_item and combo_item != self.__dummy_usb__ and self.image_path:
                 cmdline = bb.ui.crumbs.utils.which_terminal()
                 if cmdline:
-                    cmdline += "\"sudo dd if=" + self.image_path + " of=" + combo_item + "\""
-                    bb.process.Popen(shlex.split(cmdline))
+                    tmpname = os.tmpnam()
+                    cmdline += "\"sudo dd if=" + self.image_path + \
+                                " of=" + combo_item + "; echo $? > " + tmpname + "\""
+                    deploy_process = bb.process.Popen(shlex.split(cmdline))
+                    deploy_process.wait()
+
+                    # if file tmpname not exists, that means there is something wrong with xterm
+                    # user can get the error message from xterm so no more warning need.
+                    if os.path.exists(tmpname):
+                        tmpfile = open(tmpname)
+                        if int(tmpfile.readline().strip()) == 0:
+                            lbl = "<b>Deploy image successfully</b>"
+                        else:
+                            lbl = "<b>Deploy image failed</b>\nPlease try again."
+                        tmpfile.close()
+                        os.remove(tmpname)
+            else:
+                if not self.image_path:
+                    lbl = "<b>No selection made</b>\nYou have not selected an image to deploy"
+                else:
+                    lbl = "<b>No selection made</b>\nYou have not selected USB device"
+            if len(lbl):
+                crumbs_dialog = CrumbsMessageDialog(self, lbl, gtk.STOCK_DIALOG_INFO)
+                button = crumbs_dialog.add_button("Close", gtk.RESPONSE_OK)
+                HobButton.style_button(button)
+                crumbs_dialog.run()
+                crumbs_dialog.destroy()
 
     def update_progress_bar(self, title, fraction, status=None):
         self.progress_bar.update(fraction)
-- 
1.7.5.4



