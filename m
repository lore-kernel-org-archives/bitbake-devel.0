Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qlmio-0003hd-1f
	for bitbake-devel@lists.openembedded.org;
	Tue, 26 Jul 2011 20:51:14 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 26 Jul 2011 11:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,270,1309762800"; d="scan'208";a="30353979"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.155])
	by orsmga002.jf.intel.com with ESMTP; 26 Jul 2011 11:46:53 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jul 2011 11:46:40 -0700
Message-Id: <65819447ccc96ae2af8d42cf3a31769ef3d2d26e.1311705833.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311705833.git.josh@linux.intel.com>
References: <cover.1311705833.git.josh@linux.intel.com>
In-Reply-To: <cover.1311705833.git.josh@linux.intel.com>
References: <cover.1311705833.git.josh@linux.intel.com>
Subject: [PATCH 06/10] ui/hob: Force the 'Base image combo' to be drawn correctly
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
X-List-Received-Date: Tue, 26 Jul 2011 18:51:14 -0000

As the combo is created before its backing model it's common for the combo to
be drawn at its minimum size and then grow the first time the user activates
it. This slight ugly patch forces the combo to be resized as soon as the
model is associated so that by the time the user interacts with the widget it
is less likely to change size.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index df0ebe2..865933c 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -155,6 +155,10 @@ class MainWindow (gtk.Window):
     def data_generated(self, handler):
         self.generating = False
         self.image_combo.set_model(self.model.images_model())
+        # Without this the image combo is incorrectly sized on first load of the GUI
+        self.image_combo.set_active(0)
+        self.image_combo.set_active(-1)
+
         if not self.image_combo_id:
             self.image_combo_id = self.image_combo.connect("changed", self.image_changed_cb)
         self.enable_widgets()
-- 
1.7.6



