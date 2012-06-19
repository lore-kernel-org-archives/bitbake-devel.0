Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Kai.Kang@windriver.com>) id 1Sgv47-0007Ji-Kr
	for bitbake-devel@lists.openembedded.org;
	Tue, 19 Jun 2012 11:49:40 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q5J9ctrp001930
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jun 2012 02:38:55 -0700 (PDT)
Received: from localhost.localdomain (128.224.162.164) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.1.255.0; Tue, 19 Jun 2012 02:38:54 -0700
From: Kang Kai <kai.kang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 19 Jun 2012 17:39:18 +0800
Message-ID: <8a6196c93278c9272e44420f190eff1cb2357e73.1340098628.git.kai.kang@windriver.com>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <cover.1340098628.git.kai.kang@windriver.com>
References: <cover.1340098628.git.kai.kang@windriver.com>
MIME-Version: 1.0
X-Originating-IP: [128.224.162.164]
Cc: Zhenfeng.Zhao@windriver.com
Subject: [PATCH 1/1] ui/depexp.py: use the new progressbar in Hob
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
X-List-Received-Date: Tue, 19 Jun 2012 09:49:40 -0000
Content-Type: text/plain

[Yocto 2149]

Use the new progressbar in Hob, so that we can reduce the maintenance
burden of the multiple GUIs.

Signed-off-by: Kang Kai <kai.kang@windriver.com>
---
 bitbake/lib/bb/ui/depexp.py |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/bitbake/lib/bb/ui/depexp.py b/bitbake/lib/bb/ui/depexp.py
index b62adbf..425302e 100644
--- a/bitbake/lib/bb/ui/depexp.py
+++ b/bitbake/lib/bb/ui/depexp.py
@@ -24,7 +24,7 @@ import threading
 import xmlrpclib
 import bb
 import bb.event
-from bb.ui.crumbs.progress import ProgressBar
+from bb.ui.crumbs.progressbar import HobProgressBar
 
 # Package Model
 (COL_PKG_NAME) = (0)
@@ -220,8 +220,12 @@ def main(server, eventHandler):
 
     gtk.gdk.threads_enter()
     dep = DepExplorer()
-    pbar = ProgressBar(dep)
-    pbar.connect("delete-event", gtk.main_quit)
+    bardialog = gtk.Dialog(parent=dep)
+    bardialog.set_default_size(400, 50)
+    pbar = HobProgressBar()
+    bardialog.vbox.pack_start(pbar)
+    bardialog.show_all()
+    bardialog.connect("delete-event", gtk.main_quit)
     gtk.gdk.threads_leave()
 
     progress_total = 0
@@ -238,19 +242,20 @@ def main(server, eventHandler):
             if isinstance(event, bb.event.CacheLoadStarted):
                 progress_total = event.total
                 gtk.gdk.threads_enter()
-                pbar.set_title("Loading Cache")
-                pbar.update(0, progress_total)
+                bardialog.set_title("Loading Cache")
+                pbar.update(0)
                 gtk.gdk.threads_leave()
 
             if isinstance(event, bb.event.CacheLoadProgress):
                 x = event.current
                 gtk.gdk.threads_enter()
-                pbar.update(x, progress_total)
+                pbar.update(x * 1.0 / progress_total)
+                pbar.set_title('')
                 gtk.gdk.threads_leave()
                 continue
 
             if isinstance(event, bb.event.CacheLoadCompleted):
-                pbar.hide()
+                bardialog.hide()
                 continue
 
             if isinstance(event, bb.event.ParseStarted):
@@ -258,19 +263,21 @@ def main(server, eventHandler):
                 if progress_total == 0:
                     continue
                 gtk.gdk.threads_enter()
-                pbar.set_title("Processing recipes")
-                pbar.update(0, progress_total)
+                pbar.update(0)
+                bardialog.set_title("Processing recipes")
+
                 gtk.gdk.threads_leave()
 
             if isinstance(event, bb.event.ParseProgress):
                 x = event.current
                 gtk.gdk.threads_enter()
-                pbar.update(x, progress_total)
+                pbar.update(x * 1.0 / progress_total)
+                pbar.set_title('')
                 gtk.gdk.threads_leave()
                 continue
 
             if isinstance(event, bb.event.ParseCompleted):
-                pbar.hide()
+                bardialog.hide()
                 continue
 
             if isinstance(event, bb.event.DepTreeGenerated):
-- 
1.7.5.4



