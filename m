Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QreBl-0004ve-OD
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 00:57:21 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 11 Aug 2011 15:52:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="36965242"
Received: from vorpal.jf.intel.com ([10.7.199.53])
	by orsmga002.jf.intel.com with ESMTP; 11 Aug 2011 15:52:43 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 11 Aug 2011 15:57:31 -0700
Message-Id: <1f6aa344671494faa60843fa5b96834e6f8d503d.1313103368.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313103368.git.josh@linux.intel.com>
References: <cover.1313103368.git.josh@linux.intel.com>
In-Reply-To: <cover.1313103368.git.josh@linux.intel.com>
References: <cover.1313103368.git.josh@linux.intel.com>
Subject: [PATCH 8/8] lib/bb/ui/crumbs/hobprefs: fix erroneous save/reparse
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
X-List-Received-Date: Thu, 11 Aug 2011 22:57:22 -0000

We need to unset the reload_required variable once we've triggered a reload
so that we don't cause a reload each time the preferences dialog is shown and
dismissed, regardless of whether anything has changed.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobprefs.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobprefs.py b/lib/bb/ui/crumbs/hobprefs.py
index 8ebfba2..014087b 100644
--- a/lib/bb/ui/crumbs/hobprefs.py
+++ b/lib/bb/ui/crumbs/hobprefs.py
@@ -163,6 +163,7 @@ class HobPrefs(gtk.Dialog):
     def prefs_response_cb(self, dialog, response):
         if self.reload_required:
             glib.idle_add(self.handler.reload_data)
+            self.reload_required = False
 
     def __init__(self, configurator, handler, curr_sdk_mach, curr_distro, pclass,
                  cpu_cnt, pmake, bbthread, selected_image_types, all_image_types,
-- 
1.7.6



