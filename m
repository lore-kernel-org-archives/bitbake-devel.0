Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SEcS5-0007jx-RG
	for bitbake-devel@lists.openembedded.org;
	Mon, 02 Apr 2012 10:17:26 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 02 Apr 2012 01:08:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="136472679"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2012 01:08:06 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Apr 2012 16:29:19 +0800
Message-Id: <0de2f23879389dfd3540dbdf9bc5f9740d3634ca.1333355236.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <0c8981e042d26a7b381f85256d918a059c866fed.1333355236.git.shane.wang@intel.com>
References: <0c8981e042d26a7b381f85256d918a059c866fed.1333355236.git.shane.wang@intel.com>
In-Reply-To: <cover.1333355236.git.shane.wang@intel.com>
References: <cover.1333355236.git.shane.wang@intel.com>
Subject: [PATCH 5/6] Hob: a minor fix on image_fstypes
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
X-List-Received-Date: Mon, 02 Apr 2012 08:17:26 -0000

image_fstypes in the configuration has been changed into a string rather than
a list. Here we correct it in __init__() of class Configuration. At other places,
image_fstypes are all strings.

Signed-off-by: Shane Wang <shane.wang@intel.com>
---
 bitbake/lib/bb/ui/crumbs/builder.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/bitbake/lib/bb/ui/crumbs/builder.py b/bitbake/lib/bb/ui/crumbs/builder.py
index 151bec4..7a786a9 100755
--- a/bitbake/lib/bb/ui/crumbs/builder.py
+++ b/bitbake/lib/bb/ui/crumbs/builder.py
@@ -60,7 +60,7 @@ class Configuration:
         self.lconf_version = params["lconf_version"]
         self.extra_setting = {}
         self.toolchain_build = False
-        self.image_fstypes = params["image_fstypes"].split()
+        self.image_fstypes = params["image_fstypes"]
         # bblayers.conf
         self.layers = params["layer"].split()
         # image/recipes/packages
-- 
1.7.6



