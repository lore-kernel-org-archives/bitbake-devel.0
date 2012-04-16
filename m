Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <elizabeth.flanagan@intel.com>) id 1SJvBi-0000Hi-6n
	for bitbake-devel@lists.openembedded.org;
	Tue, 17 Apr 2012 01:18:26 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 16 Apr 2012 16:07:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="130377356"
Received: from envy.jf.intel.com ([10.7.201.175])
	by orsmga001.jf.intel.com with ESMTP; 16 Apr 2012 16:07:55 -0700
From: Beth Flanagan <elizabeth.flanagan@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Apr 2012 16:13:08 -0700
Message-Id: <fe7a121b7f5dad8feb55c0365c503d435839383e.1334617726.git.elizabeth.flanagan@intel.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <cover.1334617726.git.elizabeth.flanagan@intel.com>
References: <cover.1334617726.git.elizabeth.flanagan@intel.com>
Subject: [PATCH 1/1] hoblistmodel.py: description for selfcreated image
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
X-List-Received-Date: Mon, 16 Apr 2012 23:18:26 -0000

The current description is empty. This adds a default
description for hob's dummy_image.

Signed-off-by: Beth Flanagan <elizabeth.flanagan@intel.com>
---
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
index e7836c5..3f53432 100644
--- a/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
+++ b/bitbake/lib/bb/ui/crumbs/hoblistmodel.py
@@ -565,7 +565,9 @@ class RecipeListModel(gtk.ListStore):
 
         # dummy image for prompt
         self.set(self.append(), self.COL_NAME, self.__dummy_image__,
-                 self.COL_DESC, "",
+                 self.COL_DESC, "Use the 'View recipes' and 'View packages' " \
+                                "options to select what you want to include " \
+                                "in your image.",
                  self.COL_LIC, "", self.COL_GROUP, "",
                  self.COL_DEPS, "", self.COL_BINB, "",
                  self.COL_TYPE, "image", self.COL_INC, False,
-- 
1.7.1



