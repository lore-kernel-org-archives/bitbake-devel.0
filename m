Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Qbzhl-0000hX-DK
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Jun 2011 20:41:41 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 29 Jun 2011 11:37:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,444,1304319600"; d="scan'208";a="24396452"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.126])
	by fmsmga001.fm.intel.com with ESMTP; 29 Jun 2011 11:37:50 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Jun 2011 19:37:41 +0100
Message-Id: <4b3dc305f975d7156edeecb8c274b890f80f1167.1309372176.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1309372176.git.paul.eggleton@linux.intel.com>
References: <cover.1309372176.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1309372176.git.paul.eggleton@linux.intel.com>
References: <cover.1309372176.git.paul.eggleton@linux.intel.com>
Subject: [RFC PATCH 5/5] bitbake-layers: fix sorting of show_appends output
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
X-List-Received-Date: Wed, 29 Jun 2011 18:41:41 -0000

Sort packages alphabetically but ensure appends are left in their
original order (layer priority).

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bitbake/bin/bitbake-layers |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/bitbake/bin/bitbake-layers b/bitbake/bin/bitbake-layers
index 110e3c8..dfbdb70 100755
--- a/bitbake/bin/bitbake-layers
+++ b/bitbake/bin/bitbake-layers
@@ -149,7 +149,9 @@ class Commands(cmd.Cmd):
 
         logger.info('State of append files:')
 
-        for pn in self.cooker_data.pkg_pn:
+        pnlist = list(self.cooker_data.pkg_pn.keys())
+        pnlist.sort( key=lambda item: item.pn )
+        for pn in pnlist:
             self.show_appends_for_pn(pn)
 
         self.show_appends_for_skipped()
@@ -188,7 +190,7 @@ class Commands(cmd.Cmd):
 
 
     def get_appends_for_files(self, filenames):
-        appended, notappended = set(), set()
+        appended, notappended = [], []
         for filename in filenames:
             _, cls = bb.cache.Cache.virtualfn2realfn(filename)
             if cls:
@@ -197,9 +199,9 @@ class Commands(cmd.Cmd):
             basename = os.path.basename(filename)
             appends = self.cooker_data.appends.get(basename)
             if appends:
-                appended.add((basename, frozenset(appends)))
+                appended.append((basename, list(appends)))
             else:
-                notappended.add(basename)
+                notappended.append(basename)
         return appended, notappended
 
     def show_appends_with_no_recipes(self):
-- 
1.7.4.1



