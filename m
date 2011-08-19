Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QuDeG-0005Br-A5
	for bitbake-devel@lists.openembedded.org;
	Fri, 19 Aug 2011 03:13:24 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 18 Aug 2011 18:08:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,248,1312182000"; d="scan'208";a="40058944"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.250])
	by azsmga001.ch.intel.com with ESMTP; 18 Aug 2011 18:08:40 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2011 18:08:23 -0700
Message-Id: <b520e9569d1a18db2bb161ce04ee3f772fd0ebc6.1313715804.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1313715804.git.josh@linux.intel.com>
References: <cover.1313715804.git.josh@linux.intel.com>
In-Reply-To: <cover.1313715804.git.josh@linux.intel.com>
References: <cover.1313715804.git.josh@linux.intel.com>
Subject: [PATCH 09/11] bb/ui/crumbs/hobeventhandler: fix return values of *_image_output_type
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
X-List-Received-Date: Fri, 19 Aug 2011 01:13:24 -0000

These methods are expected to return lists.

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 1a4c7b5..fca4401 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -310,17 +310,17 @@ class HobHandler(gobject.GObject):
     def add_image_output_type(self, output_type):
         if output_type not in self.image_output_types:
             self.image_output_types.append(output_type)
-            fstypes = " ".join(self.image_output_types)
+            fstypes = " ".join(self.image_output_types).lstrip(" ")
             self.set_fstypes(fstypes)
-        return fstypes
+        return self.image_output_types
 
     def remove_image_output_type(self, output_type):
         if output_type in self.image_output_types:
             ind = self.image_output_types.index(output_type)
             self.image_output_types.pop(ind)
-            fstypes = " ".join(self.image_output_types)
+            fstypes = " ".join(self.image_output_types).lstrip(" ")
             self.set_fstypes(fstypes)
-        return fstypes
+        return self.image_output_types
 
     def get_image_deploy_dir(self):
         return self.server.runCommand(["getVariable", "DEPLOY_DIR_IMAGE"])
-- 
1.7.6



