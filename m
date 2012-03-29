Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SDEDp-0007QK-3H
	for bitbake-devel@lists.openembedded.org;
	Thu, 29 Mar 2012 14:12:57 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 29 Mar 2012 05:03:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="124772089"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by azsmga001.ch.intel.com with ESMTP; 29 Mar 2012 05:03:52 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 29 Mar 2012 20:01:14 +0800
Message-Id: <3c033c05a429d07fbad0e65e126c56b5fd4ae2b6.1333022081.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
In-Reply-To: <cover.1333022081.git.dongxiao.xu@intel.com>
References: <cover.1333022081.git.dongxiao.xu@intel.com>
Subject: [PATCH 08/14] Hob: Inherit image_types.bbclass in set_user_config()
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
X-List-Received-Date: Thu, 29 Mar 2012 12:12:57 -0000

Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
---
 lib/bb/ui/crumbs/builder.py |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
index b651643..0621600 100755
--- a/lib/bb/ui/crumbs/builder.py
+++ b/lib/bb/ui/crumbs/builder.py
@@ -404,6 +404,7 @@ class Builder(gtk.Window):
         self.handler.set_image_fstypes(self.configuration.image_fstypes)
         self.handler.set_extra_config(self.configuration.extra_setting)
         self.handler.set_extra_inherit("packageinfo")
+        self.handler.set_extra_inherit("image_types")
         # set proxies
         if self.parameters.enable_proxy:
             self.handler.set_http_proxy(self.configuration.http_proxy)
-- 
1.7.4.1



