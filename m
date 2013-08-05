Return-Path: <ross.burton@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id 9D1B760958
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Aug 2013 16:12:29 +0000 (UTC)
Received: by mail-wi0-f177.google.com with SMTP id hq12so1721278wib.16
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Aug 2013 09:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:in-reply-to:references
	:in-reply-to:references:x-gm-message-state;
	bh=vz6W0GW+VMeDV88zu08pQ2jXR19dU4YRPFA9wwFZmk0=;
	b=L6mfaLRowhTTe8JshRddIvqtsMusNsfYhu37DPciAojk7Efke/aZUQ9eHyqVqY+rHc
	nJoU5kG1wcCdmFob4TJtSqOSsTpeHWkVb8hK/IEgB8xGh1JG8iStXunuhbi2uJj/JudV
	ySibbLeGEruVGk547EDaPU85RNCRFR7lrymR1vPp25Rip4phFSqjmhzYFqpQ2Nl/V6VG
	d6ovcXI7Hh60Wyu6jPEMZYdJbEEB+X2qhUXxwLu4/19GprNq0oAB0Wm4674ji4Z/vWZC
	msShdD8TkroYiLx9pNeHTxXUePDrLV6pDQ3Tb7xD7o3Z+XVwDcJjZc2ph/cMNbqeoKWp
	i6eg==
X-Received: by 10.194.80.69 with SMTP id p5mr1705639wjx.33.1375719149739;
	Mon, 05 Aug 2013 09:12:29 -0700 (PDT)
Received: from melchett.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
	by mx.google.com with ESMTPSA id
	fd3sm22434156wic.10.2013.08.05.09.12.28
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 05 Aug 2013 09:12:28 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Aug 2013 17:12:21 +0100
Message-Id: <b23b666db43ca87f8648dece7b44ac4d2633b63c.1375718812.git.ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <cover.1375718812.git.ross.burton@intel.com>
References: <cover.1375718812.git.ross.burton@intel.com>
In-Reply-To: <cover.1375718812.git.ross.burton@intel.com>
References: <cover.1375718812.git.ross.burton@intel.com>
X-Gm-Message-State: ALoCoQmadWFA1mnFzCkiw5Jrhj4Zo/GZoQhnUcBMoTa/ioemUF4vM539pbjAVv5JZQbYnTboLq0d
Subject: [PATCH 1/3] depexp: make parse() a member function
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
X-List-Received-Date: Mon, 05 Aug 2013 16:12:30 -0000

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/ui/depexp.py |   32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/bitbake/lib/bb/ui/depexp.py b/bitbake/lib/bb/ui/depexp.py
index 885c31a..b7e6f8f 100644
--- a/bitbake/lib/bb/ui/depexp.py
+++ b/bitbake/lib/bb/ui/depexp.py
@@ -163,23 +163,23 @@ class DepExplorer(gtk.Window):
         self.revdep_treeview.set_current_package(current_package)
 
 
-def parse(depgraph, pkg_model, depends_model):
-    for package in depgraph["pn"]:
-        pkg_model.set(pkg_model.append(), COL_PKG_NAME, package)
+    def parse(self, depgraph):
+        for package in depgraph["pn"]:
+            self.pkg_model.set(self.pkg_model.append(), COL_PKG_NAME, package)
 
-    for package in depgraph["depends"]:
-        for depend in depgraph["depends"][package]:
-            depends_model.set (depends_model.append(),
-                              COL_DEP_TYPE, TYPE_DEP,
-                              COL_DEP_PARENT, package,
-                              COL_DEP_PACKAGE, depend)
+        for package in depgraph["depends"]:
+            for depend in depgraph["depends"][package]:
+                self.depends_model.set (self.depends_model.append(),
+                                        COL_DEP_TYPE, TYPE_DEP,
+                                        COL_DEP_PARENT, package,
+                                        COL_DEP_PACKAGE, depend)
 
-    for package in depgraph["rdepends-pn"]:
-        for rdepend in depgraph["rdepends-pn"][package]:
-            depends_model.set (depends_model.append(),
-                              COL_DEP_TYPE, TYPE_RDEP,
-                              COL_DEP_PARENT, package,
-                              COL_DEP_PACKAGE, rdepend)
+        for package in depgraph["rdepends-pn"]:
+            for rdepend in depgraph["rdepends-pn"][package]:
+                self.depends_model.set (self.depends_model.append(),
+                                        COL_DEP_TYPE, TYPE_RDEP,
+                                        COL_DEP_PARENT, package,
+                                        COL_DEP_PACKAGE, rdepend)
 
 
 class gtkthread(threading.Thread):
@@ -293,7 +293,7 @@ def main(server, eventHandler, params):
 
             if isinstance(event, bb.event.DepTreeGenerated):
                 gtk.gdk.threads_enter()
-                parse(event._depgraph, dep.pkg_model, dep.depends_model)
+                dep.parse(event._depgraph)
                 gtk.gdk.threads_leave()
 
             if isinstance(event, bb.command.CommandCompleted):
-- 
1.7.10.4


