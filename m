Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R7CXU-0007fl-F7
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Sep 2011 22:40:04 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 23 Sep 2011 13:34:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,432,1312182000"; d="scan'208";a="66944253"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.15.15])
	by fmsmga001.fm.intel.com with ESMTP; 23 Sep 2011 13:34:40 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Sep 2011 13:34:33 -0700
Message-Id: <656eafe0f2c9ec7730d33e15705b8c720f787c49.1316809959.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6.2
In-Reply-To: <cover.1316809959.git.josh@linux.intel.com>
References: <cover.1316809959.git.josh@linux.intel.com>
In-Reply-To: <cover.1316809959.git.josh@linux.intel.com>
References: <cover.1316809959.git.josh@linux.intel.com>
Subject: [PATCH 3/3] hob: fix building with current selections after reparse
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
X-List-Received-Date: Fri, 23 Sep 2011 20:40:04 -0000

After the reparse we were setting the model to reflect the values before
the reparse was triggered but clearing the internal variables used to test
whether these values are set, leading to the UI erroneously reporting that
selections had not been made.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index e696314..c016e44 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -304,13 +304,11 @@ class MainWindow (gtk.Window):
                 self.image_combo.disconnect(self.image_combo_id)
                 self.image_combo_id = None
             self.model.set_selected_image(self.selected_image)
-            self.selected_image = None
             if not self.image_combo_id:
                 self.image_combo_id = self.image_combo.connect("changed", self.image_changed_cb)
 
         if self.selected_packages:
             self.model.set_selected_packages(self.selected_packages)
-            self.selected_packages = None
 
     def reset_clicked_cb(self, button):
         lbl = "<b>Reset your selections?</b>\n\nAny new changes you have made will be lost"
-- 
1.7.6.2



