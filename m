Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SB6Gk-0005yH-Mh
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Mar 2012 16:19:10 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 23 Mar 2012 08:10:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="120924063"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga001.jf.intel.com with ESMTP; 23 Mar 2012 08:10:13 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Mar 2012 23:07:54 +0800
Message-Id: <60fa39cbd860af22fc4191b729b0ff8845e3c236.1332514895.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1332514895.git.dongxiao.xu@intel.com>
References: <cover.1332514895.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1332514895.git.dongxiao.xu@intel.com>
References: <cover.1332514895.git.dongxiao.xu@intel.com>
Subject: [PATCH 6/7] Hob: Add a supported image type "vmdk"
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
X-List-Received-Date: Fri, 23 Mar 2012 15:19:10 -0000

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/hobwidget.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/hobwidget.py b/lib/bb/ui/crumbs/hobwidget.py
index 9d144c9..70644dc 100644
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



