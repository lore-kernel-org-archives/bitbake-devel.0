Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1R7CXT-0007fl-Q2
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Sep 2011 22:40:03 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 23 Sep 2011 13:34:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,432,1312182000"; d="scan'208";a="66944251"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.15.15])
	by fmsmga001.fm.intel.com with ESMTP; 23 Sep 2011 13:34:40 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Sep 2011 13:34:32 -0700
Message-Id: <f7d0560307707fe10bf80820f1e6ae300864f915.1316809959.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6.2
In-Reply-To: <cover.1316809959.git.josh@linux.intel.com>
References: <cover.1316809959.git.josh@linux.intel.com>
In-Reply-To: <cover.1316809959.git.josh@linux.intel.com>
References: <cover.1316809959.git.josh@linux.intel.com>
Subject: [PATCH 2/3] ui/crumbs/hobeventhandler: fix variable name typo
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

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/crumbs/hobeventhandler.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobeventhandler.py b/lib/bb/ui/crumbs/hobeventhandler.py
index 44dc4ac..ddab987 100644
--- a/lib/bb/ui/crumbs/hobeventhandler.py
+++ b/lib/bb/ui/crumbs/hobeventhandler.py
@@ -328,7 +328,7 @@ class HobHandler(gobject.GObject):
         return self.image_output_types
 
     def get_image_deploy_dir(self):
-        return self.img_out_dir
+        return self.image_out_dir
 
     def make_temp_dir(self):
         bb.utils.mkdirhier(self.image_dir)
-- 
1.7.6.2



