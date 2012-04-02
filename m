Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SEinh-0005fz-IQ
	for bitbake-devel@lists.openembedded.org;
	Mon, 02 Apr 2012 17:04:09 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 02 Apr 2012 07:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="148714247"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 02 Apr 2012 07:54:59 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Apr 2012 23:22:37 +0800
Message-Id: <7ef65b5d1a00fe42d39be41ddd93fc75ade17308.1333379931.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1333379931.git.shane.wang@intel.com>
References: <cover.1333379931.git.shane.wang@intel.com>
Subject: [PATCH 1/4] Hob: add the "info" indication icon for "information" in the dialogs.
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
X-List-Received-Date: Mon, 02 Apr 2012 15:04:09 -0000

Previously we reused the info display file which is for indication of tooltips.
But it is too small, when it is shown on the dialog as the dialog indication icon,
it becomes unclear after being stretched out. So, we replace it with a larger
icon.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hobwidget.py       |    3 ++-
 bitbake/lib/bb/ui/icons/indicators/info.png |  Bin 0 -> 3311 bytes
 2 files changed, 2 insertions(+), 1 deletions(-)
 create mode 100644 bitbake/lib/bb/ui/icons/indicators/info.png

diff --git a/bitbake/lib/bb/ui/crumbs/hobwidget.py b/bitbake/lib/bb/ui/crumbs/hobwidget.py
index 9625c6d..edb85db 100644
--- a/bitbake/lib/bb/ui/crumbs/hobwidget.py
+++ b/bitbake/lib/bb/ui/crumbs/hobwidget.py
@@ -60,6 +60,7 @@ class hic:
     ICON_INDI_REFRESH_FILE        = os.path.join(HOB_ICON_BASE_DIR, ('indicators/refresh.png'))
     ICON_INDI_ALERT_FILE          = os.path.join(HOB_ICON_BASE_DIR, ('indicators/alert.png'))
     ICON_INDI_TICK_FILE           = os.path.join(HOB_ICON_BASE_DIR, ('indicators/tick.png'))
+    ICON_INDI_INFO_FILE           = os.path.join(HOB_ICON_BASE_DIR, ('indicators/info.png'))
 
 class hcc:
 
@@ -826,7 +827,7 @@ class HobIconChecker(hic):
     """
     def check_stock_icon(self, stock_name=""):
         HOB_CHECK_STOCK_NAME = {
-            ('hic-dialog-info', 'gtk-dialog-info', 'dialog-info')           : self.ICON_INFO_DISPLAY_FILE,
+            ('hic-dialog-info', 'gtk-dialog-info', 'dialog-info')           : self.ICON_INDI_INFO_FILE,
             ('hic-ok',          'gtk-ok',           'ok')                   : self.ICON_INDI_TICK_FILE,
             ('hic-dialog-error', 'gtk-dialog-error', 'dialog-error')        : self.ICON_INDI_ERROR_FILE,
             ('hic-dialog-warning', 'gtk-dialog-warning', 'dialog-warning')  : self.ICON_INDI_ALERT_FILE,
diff --git a/bitbake/lib/bb/ui/icons/indicators/info.png b/bitbake/lib/bb/ui/icons/indicators/info.png
new file mode 100644
index 0000000000000000000000000000000000000000..ee8e8d846251ab1a937902d7eb517da24ecb30f5
GIT binary patch
literal 3311
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

literal 0
HcmV?d00001

-- 
1.7.6



