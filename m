Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SEinp-0005gV-Ch
	for bitbake-devel@lists.openembedded.org;
	Mon, 02 Apr 2012 17:04:17 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 02 Apr 2012 07:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="126134518"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 02 Apr 2012 07:55:03 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Apr 2012 23:22:40 +0800
Message-Id: <00400e0c4c67810b7e2b501d5e4a972d5103b43d.1333379931.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <7ef65b5d1a00fe42d39be41ddd93fc75ade17308.1333379931.git.shane.wang@intel.com>
References: <7ef65b5d1a00fe42d39be41ddd93fc75ade17308.1333379931.git.shane.wang@intel.com>
In-Reply-To: <cover.1333379931.git.shane.wang@intel.com>
References: <cover.1333379931.git.shane.wang@intel.com>
Subject: [PATCH 4/4] Hob: reset issue indication and build status before build starts on build details screen
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
X-List-Received-Date: Mon, 02 Apr 2012 15:04:17 -0000

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    3 +++
 bitbake/lib/bb/ui/crumbs/builder.py          |    2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index aee258a..86d0515 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -214,6 +214,9 @@ class BuildDetailsPage (HobPage):
         self.show_all()
         self.back_button.hide()
 
+        self.reset_build_status()
+        self.reset_issues()
+
     def update_progress_bar(self, title, fraction, status=None):
         self.progress_bar.update(fraction)
         self.progress_bar.set_title(title)
diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index de4fb29..89e5b9e 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -639,8 +639,6 @@ class Builder(gtk.Window):
         elif self.current_step == self.PACKAGE_GENERATING:
             fraction = 0
         self.build_details_page.update_progress_bar("Build Started: ", fraction)
-        self.build_details_page.reset_build_status()
-        self.build_details_page.reset_issues()
         self.build_details_page.show_configurations(self.configuration, self.parameters)
 
     def build_succeeded(self):
-- 
1.7.6



