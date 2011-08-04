Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qomj4-0000xE-MF
	for bitbake-devel@lists.openembedded.org;
	Thu, 04 Aug 2011 03:27:56 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 03 Aug 2011 18:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,313,1309762800"; d="scan'208";a="34155893"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.173])
	by orsmga002.jf.intel.com with ESMTP; 03 Aug 2011 18:23:29 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  3 Aug 2011 18:23:19 -0700
Message-Id: <2cb561de9b34d0c23939a492c475230f21d87d99.1312420894.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312420894.git.josh@linux.intel.com>
References: <cover.1312420894.git.josh@linux.intel.com>
In-Reply-To: <cover.1312420894.git.josh@linux.intel.com>
References: <cover.1312420894.git.josh@linux.intel.com>
Subject: [PATCH 3/6] bb/ui/hob: prevent label on progress bar from changing rapidly when loading
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
X-List-Received-Date: Thu, 04 Aug 2011 01:27:56 -0000

Fixes [YOCTO #1240]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 5998e6b..b8842a9 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -240,7 +240,6 @@ class MainWindow (gtk.Window):
 
     def busy_idle_func(self):
         if self.generating:
-            self.progress.set_text("Loading...")
             self.progress.pulse()
             return True
         else:
@@ -253,12 +252,13 @@ class MainWindow (gtk.Window):
 
     def busy(self, handler):
         self.generating = True
+        self.progress.set_text("Loading...")
         self.set_busy_cursor()
         if self.image_combo_id:
             self.image_combo.disconnect(self.image_combo_id)
             self.image_combo_id = None
         self.progress.pulse()
-        gobject.timeout_add (200, self.busy_idle_func)
+        gobject.timeout_add (100, self.busy_idle_func)
         self.disable_widgets()
 
     def enable_widgets(self):
-- 
1.7.6



