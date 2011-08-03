Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QoQA2-0006Dn-5U
	for bitbake-devel@lists.openembedded.org;
	Wed, 03 Aug 2011 03:22:14 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 02 Aug 2011 18:17:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,307,1309762800"; d="scan'208";a="33627964"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.13.215])
	by orsmga002.jf.intel.com with ESMTP; 02 Aug 2011 18:17:47 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  2 Aug 2011 18:17:38 -0700
Message-Id: <d790386112b0beb444713a12d766bd4bd3441f56.1312334047.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <cover.1312334047.git.josh@linux.intel.com>
References: <cover.1312334047.git.josh@linux.intel.com>
In-Reply-To: <cover.1312334047.git.josh@linux.intel.com>
References: <cover.1312334047.git.josh@linux.intel.com>
Subject: [PATCH 5/6] bb/ui/hob: disable editing in the build messages tree view
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
X-List-Received-Date: Wed, 03 Aug 2011 01:22:15 -0000

Addresses the second part of [YOCTO #1311]

Signed-off-by: Joshua Lock <josh@linux.intel.com>
---
 lib/bb/ui/hob.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lib/bb/ui/hob.py b/lib/bb/ui/hob.py
index 9debbca..a770fc2 100644
--- a/lib/bb/ui/hob.py
+++ b/lib/bb/ui/hob.py
@@ -731,7 +731,7 @@ class MainWindow (gtk.Window):
         vbox = gtk.VBox(False, 12)
         vbox.set_border_width(6)
         vbox.show()
-        build_tv = RunningBuildTreeView()
+        build_tv = RunningBuildTreeView(readonly=True)
         build_tv.show()
         build_tv.set_model(self.build.model)
         self.build.model.connect("row-inserted", self.scroll_tv_cb, build_tv)
-- 
1.7.6



