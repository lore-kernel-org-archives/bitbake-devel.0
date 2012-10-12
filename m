Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei.adrianx.dinu@intel.com>) id 1TMgnL-0002iL-QV
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Oct 2012 17:05:00 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 12 Oct 2012 07:50:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,576,1344236400"; d="scan'208";a="204845475"
Received: from adinu-vostro-460 (HELO localhost.localdomain) ([10.237.105.39])
	by orsmga001.jf.intel.com with ESMTP; 12 Oct 2012 07:50:40 -0700
From: Andrei Dinu <andrei.adrianx.dinu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 12 Oct 2012 17:51:30 +0300
Message-Id: <1350053490-5977-1-git-send-email-andrei.adrianx.dinu@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH] hob: stop build without percentage shown
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
X-List-Received-Date: Fri, 12 Oct 2012 15:05:00 -0000

added a method in progressbar.py that doesn't update the
percentage in the progress bar shown in hob.

the call of the method is done in builder.py.

Signed-off-by: Andrei Dinu <andrei.adrianx.dinu@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py     |    2 +-
 bitbake/lib/bb/ui/crumbs/progressbar.py |    5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 6ddc5b6..2a41657 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -1480,7 +1480,7 @@ class Builder(gtk.Window):
         if response != gtk.RESPONSE_CANCEL:
             self.stopping = True
         if response == gtk.RESPONSE_OK:
-            self.build_details_page.progress_bar.set_title("Stopping the build...")
+            self.build_details_page.progress_bar.set_stop_title("Stopping the build....")
             self.build_details_page.progress_bar.set_rcstyle("stop")
             self.cancel_build_sync()
         elif response == gtk.RESPONSE_YES:
diff --git a/bitbake/lib/bb/ui/crumbs/progressbar.py b/bitbake/lib/bb/ui/crumbs/progressbar.py
index f75818a..3e2c660 100644
--- a/bitbake/lib/bb/ui/crumbs/progressbar.py
+++ b/bitbake/lib/bb/ui/crumbs/progressbar.py
@@ -43,6 +43,11 @@ class HobProgressBar (gtk.ProgressBar):
         text += " %.0f%%" % self.percentage
         self.set_text(text)
 
+    def set_stop_title(self, text=None):
+	if not text:
+	    text = ""
+	self.set_text(text)
+
     def reset(self):
         self.set_fraction(0)
         self.set_text("")
-- 
1.7.9.5



