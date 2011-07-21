Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qjy4U-00053G-35
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jul 2011 20:34:06 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 21 Jul 2011 11:29:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,242,1309762800"; d="scan'208";a="28648889"
Received: from vorpal.jf.intel.com ([10.7.199.57])
	by orsmga002.jf.intel.com with ESMTP; 21 Jul 2011 11:29:55 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2011 11:34:20 -0700
Message-Id: <afb87a809962b756f8282c9e9fdf9b15cdb9192b.1311273097.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1311273097.git.josh@linux.intel.com>
References: <cover.1311273097.git.josh@linux.intel.com>
In-Reply-To: <cover.1311273097.git.josh@linux.intel.com>
References: <cover.1311273097.git.josh@linux.intel.com>
Subject: [PATCH 3/6] ui/hob: add more guidance to the stop dialog
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
X-List-Received-Date: Thu, 21 Jul 2011 18:34:06 -0000

This patch adds explanation of the different options when asking the user
to choose between Stop and Force Stop so they can make an informed choice.

Fixes [YOCTO #1223]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 06d936e..aed7eac 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -650,7 +650,14 @@ class MainWindow (gtk.Window):
         return vbox
 
     def cancel_build(self, button):
-        lbl = "<b>Stop build?</b>\n\nAre you sure you want to stop this build?"
+        lbl = "<b>Stop build?</b>\n\nAre you sure you want to stop this build?\n"
+        lbl = lbl + "'Force Stop' will stop the build as quickly as"
+        lbl = lbl + " possible but may well leave your build directory in an"
+        lbl = lbl + " unusable state that requires manual steps to fix.\n"
+        lbl = lbl + "'Stop' will stop the build as soon as all in"
+        lbl = lbl + " progress build tasks are finished. However if a"
+        lbl = lbl + " lengthy compilation phase is in progress this may take"
+        lbl = lbl + " some time."
         dialog = CrumbsDialog(self, lbl, gtk.STOCK_DIALOG_WARNING)
         dialog.add_button(gtk.STOCK_CANCEL, gtk.RESPONSE_CANCEL)
         dialog.add_button("Stop", gtk.RESPONSE_OK)
-- 
1.7.6



