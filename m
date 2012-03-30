Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SDXbc-0007ah-IH
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Mar 2012 10:54:48 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 30 Mar 2012 01:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="135629477"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga001.fm.intel.com with ESMTP; 30 Mar 2012 01:45:45 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 30 Mar 2012 17:12:42 +0800
Message-Id: <f342b5c8dd757153a834361277fa92f4e6cf130d.1333098599.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <7bb76a68926bc36bc6f8a27180916e13c5c304a3.1333098599.git.shane.wang@intel.com>
References: <7bb76a68926bc36bc6f8a27180916e13c5c304a3.1333098599.git.shane.wang@intel.com>
In-Reply-To: <cover.1333098599.git.shane.wang@intel.com>
References: <cover.1333098599.git.shane.wang@intel.com>
Subject: [PATCH 2/2] Hob: In building log page, fixed the issue about 'endpath' not clear when next to start build
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
X-List-Received-Date: Fri, 30 Mar 2012 08:54:48 -0000

From: Liming An <limingx.l.an@intel.com>

Fixed the issue about the building log scrollbar can not auto scroll to page end sometimes

[YOCTO #2098]

Signed-off-by: Liming An <limingx.l.an@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builddetailspage.py b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
index 1440039..aee258a 100755
--- a/bitbake/lib/bb/ui/crumbs/builddetailspage.py
+++ b/bitbake/lib/bb/ui/crumbs/builddetailspage.py
@@ -172,6 +172,7 @@ class BuildDetailsPage (HobPage):
 
     def reset_build_status(self):
         self.task_status.set_markup("\n") # to ensure layout is correct
+        self.endpath = (0,)
 
     def show_issues(self):
         self.num_of_issues += 1
@@ -234,7 +235,8 @@ class BuildDetailsPage (HobPage):
         if treeview and v_adj:
             if path[0] > self.endpath[0]: # check the event is a new row append or not
                 self.endpath = path
-                if v_adj.value == (v_adj.upper - v_adj.page_size): # check the gtk.adjustment position is at end boundary or not
+                # check the gtk.adjustment position is at end boundary or not
+                if (v_adj.upper <= v_adj.page_size) or (v_adj.value == v_adj.upper - v_adj.page_size):
                     treeview.scroll_to_cell(path)
 
     def show_configurations(self, configurations, params):
-- 
1.7.6



