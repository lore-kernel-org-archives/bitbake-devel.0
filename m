Return-Path: <Yi.Zhao@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0E8BF6CCEF
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Nov 2013 09:41:00 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id rAR9ewlr021648
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 27 Nov 2013 01:40:58 -0800 (PST)
Received: from localhost (128.224.158.249) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.2.347.0;
	Wed, 27 Nov 2013 01:40:58 -0800
From: Yi Zhao <yi.zhao@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 27 Nov 2013 17:40:56 +0800
Message-ID: <1385545256-11483-1-git-send-email-yi.zhao@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-Originating-IP: [128.224.158.249]
Subject: [PATCH] crumbs/builder.py: Fix typo for indefinite article
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
X-List-Received-Date: Wed, 27 Nov 2013 09:41:00 -0000
Content-Type: text/plain

Signed-off-by: Yi Zhao <yi.zhao@windriver.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index de002b9..1ace5cf 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -1352,7 +1352,7 @@ class Builder(gtk.Window):
 
     def runqemu_image(self, image_name, kernel_name):
         if not image_name or not kernel_name:
-            lbl = "<b>Please select an %s to launch in QEMU.</b>" % ("kernel" if image_name else "image")
+            lbl = "<b>Please select %s to launch in QEMU.</b>" % ("a kernel" if image_name else "an image")
             dialog = CrumbsMessageDialog(self, lbl, gtk.MESSAGE_INFO)
             button = dialog.add_button("Close", gtk.RESPONSE_OK)
             HobButton.style_button(button)
-- 
1.7.9.5


