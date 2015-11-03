Return-Path: <joel.esponde@gmail.com>
Received: from mail-wm0-f51.google.com (mail-wm0-f51.google.com [74.125.82.51])
	by mail.openembedded.org (Postfix) with ESMTP id 4B21071633
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  3 Nov 2015 22:09:55 +0000 (UTC)
Received: by wmll128 with SMTP id l128so99284730wml.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 03 Nov 2015 14:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding;
	bh=TTP/rc8q6ZeGTE5hFKgNDm7UcGZd8twW/0/NQ/AnsY8=;
	b=j5FBEhDagwAb3rJMFRs28wCmLqespHN2O+BLRolBr0CxLqbG8CjXdYFK1UNfqXedU9
	P4Ncmx014r09oJBp8knkyuaXQeAU0rqoZQauagB9XpMNvG/pSLLGP/IzCmFpXlIdS5Wf
	u6q/OglmzsGRn7xioe80Ub3qXdKoknrIZqwpknhyuhu7ujIIx4PshZY9Bkqp3YXQgflt
	7U+bi/BgSStDbdWfCBlCgq+YCNSuRCF7hPYxunbqUMvH23XUsg7JqxSOj8M067n4bAFS
	3U+cEYKehUhHrmdyiNCcRafyXqPX4tjP/HSsKONKLFstp7uqsiemosxAfTSXhQ3MwUKp
	fT7A==
X-Received: by 10.28.6.206 with SMTP id 197mr23814782wmg.102.1446588595206;
	Tue, 03 Nov 2015 14:09:55 -0800 (PST)
Received: from localhost.localdomain ([78.245.105.188])
	by smtp.gmail.com with ESMTPSA id
	kr10sm29656059wjc.25.2015.11.03.14.09.53
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 03 Nov 2015 14:09:54 -0800 (PST)
From: =?UTF-8?q?Jo=C3=ABl=20Esponde?= <joel.esponde@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  3 Nov 2015 23:08:31 +0100
Message-Id: <1446588511-16158-1-git-send-email-joel.esponde@gmail.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH] Bitbake hob's image detail page should be able to display big logs with display resolution like 1600x900. Freescale yocto project is producing big logs for example.
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
X-List-Received-Date: Tue, 03 Nov 2015 22:09:56 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Moved log boxes into ScrolledWindows to keep them with a small size while being able to display big logs.
Changed buttons alignment from y centered to top for them to be visible directly on first show.

Signed-off-by: Joël Esponde <joel.esponde@gmail.com>
---
 lib/bb/ui/crumbs/imagedetailspage.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/bb/ui/crumbs/imagedetailspage.py b/lib/bb/ui/crumbs/imagedetailspage.py
index 352e948..0d8ae81 100755
--- a/lib/bb/ui/crumbs/imagedetailspage.py
+++ b/lib/bb/ui/crumbs/imagedetailspage.py
@@ -75,11 +75,11 @@ class ImageDetailsPage (HobPage):
             # pack the button on the right
             if button:
                 self.bbox = gtk.VBox()
-                self.bbox.pack_start(button, expand=True, fill=False)
+                self.bbox.pack_start(button, expand=False, fill=False)
                 if button2:
-                    self.bbox.pack_start(button2, expand=True, fill=False)
+                    self.bbox.pack_start(button2, expand=False, fill=False)
                 self.bbox.set_size_request(150,-1)
-                self.row.attach(self.bbox, 1, 2, 0, 1, xoptions=gtk.FILL, yoptions=gtk.EXPAND)
+                self.row.attach(self.bbox, 1, 2, 0, 1, xoptions=0, yoptions=gtk.EXPAND|gtk.FILL)
                 
         def update_line_widgets(self, variable, value):
             if len(self.line_widgets) == 0:
@@ -374,7 +374,9 @@ class ImageDetailsPage (HobPage):
             edit_config_button.set_tooltip_text("Edit machine and image recipe")
             edit_config_button.connect("clicked", self.edit_config_button_clicked_cb)
             self.setting_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=edit_config_button)
-            self.box_group_area.pack_start(self.setting_detail, expand=True, fill=True)
+            self.setting_detail_swin = gtk.ScrolledWindow()
+            self.setting_detail_swin.add_with_viewport(self.setting_detail)
+            self.box_group_area.pack_start(self.setting_detail_swin, expand=True, fill=True)
 
         # Packages included, and Total image size
         varlist = ["Packages included: ", "Total image size: "]
@@ -390,7 +392,9 @@ class ImageDetailsPage (HobPage):
         else: # get to this page from "My images"
             edit_packages_button = None
         self.package_detail = self.DetailBox(varlist=varlist, vallist=vallist, button=edit_packages_button)
-        self.box_group_area.pack_start(self.package_detail, expand=True, fill=True)
+        self.package_detail_swin = gtk.ScrolledWindow()
+        self.package_detail_swin.add_with_viewport(self.package_detail)
+        self.box_group_area.pack_start(self.package_detail_swin, expand=True, fill=True)
 
         # pack the buttons at the bottom, at this time they are already created.
         if self.build_succeeded:
-- 
1.9.1


