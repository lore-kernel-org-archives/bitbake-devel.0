Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1Sj57R-0007Ks-EM
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Jun 2012 10:58:06 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q5P8l8B3007152
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 25 Jun 2012 01:47:08 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Mon, 25 Jun 2012 01:47:08 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 25 Jun 2012 16:47:36 +0800
Message-ID: <f5d87b1a31aa712ff0e7715e68a734dd3856d666.1340609180.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1340609180.git.kai.kang@windriver.com>
References: <cover.1340609180.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/1] hig.py: use module tempfile to create temp file
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
X-List-Received-Date: Mon, 25 Jun 2012 08:58:06 -0000
Content-Type: text/plain

I am sorry that use os.tmpname which casue a security warning.
Follow Darren's suggestion to use tempfile.NamedTemporaryFile instead.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/ui/crumbs/hig.py |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hig.py b/bitbake/lib/bb/ui/crumbs/hig.py
index b586b6c..2001ff4 100644
--- a/bitbake/lib/bb/ui/crumbs/hig.py
+++ b/bitbake/lib/bb/ui/crumbs/hig.py
@@ -28,6 +28,7 @@ import os
 import re
 import shlex
 import subprocess
+import tempfile
 from bb.ui.crumbs.hobcolor import HobColors
 from bb.ui.crumbs.hobwidget import hcc, hic, HobViewTable, HobInfoButton, HobButton, HobAltButton, HobIconChecker
 from bb.ui.crumbs.progressbar import HobProgressBar
@@ -869,21 +870,16 @@ class DeployImageDialog (CrumbsDialog):
             if combo_item and combo_item != self.__dummy_usb__ and self.image_path:
                 cmdline = bb.ui.crumbs.utils.which_terminal()
                 if cmdline:
-                    tmpname = os.tmpnam()
+                    tmpfile = tempfile.NamedTemporaryFile()
                     cmdline += "\"sudo dd if=" + self.image_path + \
-                                " of=" + combo_item + "; echo $? > " + tmpname + "\""
+                                " of=" + combo_item + "; echo $? > " + tmpfile.name + "\""
                     subprocess.call(shlex.split(cmdline))
 
-                    # if file tmpname not exists, that means there is something wrong with xterm
-                    # user can get the error message from xterm so no more warning need.
-                    if os.path.exists(tmpname):
-                        tmpfile = open(tmpname)
-                        if int(tmpfile.readline().strip()) == 0:
-                            lbl = "<b>Deploy image successfully.</b>"
-                        else:
-                            lbl = "<b>Failed to deploy image.</b>\nPlease check image <b>%s</b> exists and USB device <b>%s</b> is writable." % (self.image_path, combo_item)
-                        tmpfile.close()
-                        os.remove(tmpname)
+                    if int(tmpfile.readline().strip()) == 0:
+                        lbl = "<b>Deploy image successfully.</b>"
+                    else:
+                        lbl = "<b>Failed to deploy image.</b>\nPlease check image <b>%s</b> exists and USB device <b>%s</b> is writable." % (self.image_path, combo_item)
+                    tmpfile.close()
             else:
                 if not self.image_path:
                     lbl = "<b>No selection made.</b>\nYou have not selected an image to deploy."
-- 
1.7.5.4



