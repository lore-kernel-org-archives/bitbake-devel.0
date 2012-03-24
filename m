Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SBPeG-0003RD-PK
	for bitbake-devel@lists.openembedded.org;
	Sat, 24 Mar 2012 13:00:45 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 24 Mar 2012 04:51:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="124600682"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 24 Mar 2012 04:51:47 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 24 Mar 2012 19:49:24 +0800
Message-Id: <2f61109406a174b9d059abb369da42c5246d1c61.1332589589.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332589589.git.dongxiao.xu@intel.com>
References: <cover.1332589589.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332589589.git.dongxiao.xu@intel.com>
References: <cover.1332589589.git.dongxiao.xu@intel.com>
Subject: [PATCH 6/9] Hob: Add a supported image type "vmdk"
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
X-List-Received-Date: Sat, 24 Mar 2012 12:00:45 -0000

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hobwidget.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index 020c5e2..1213b11 100644
--- a/lib/bb/ui/crumbs/hobwidget.py
+++ b/lib/bb/ui/crumbs/hobwidget.py
@@ -82,6 +82,7 @@ class hcc:
         "cpio"          : ["cpio"],
         "cpio.gz"       : ["cpio.gz"],
         "cpio.xz"       : ["cpio.xz"],
+        "vmdk"          : ["vmdk"],
         "cpio.lzma"     : ["cpio.lzma"],
     }
 
-- 
1.7.4.1



