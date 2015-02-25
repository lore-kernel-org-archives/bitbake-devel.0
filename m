Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 159D2736E7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Feb 2015 15:30:12 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 25 Feb 2015 07:30:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,645,1418112000"; d="scan'208";a="683267077"
Received: from gcattani-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.20.5])
	by fmsmga002.fm.intel.com with ESMTP; 25 Feb 2015 07:30:02 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 25 Feb 2015 15:29:58 +0000
Message-Id: <84e8e8c2bfba2e7ce5200be7c7a78e543d601a68.1424878172.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
In-Reply-To: <cover.1424878172.git.paul.eggleton@linux.intel.com>
References: <cover.1424878172.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1424878172.git.paul.eggleton@linux.intel.com>
References: <cover.1424878172.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] bitbake-layers: fix wildcard support in remove-layer
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 25 Feb 2015 15:30:12 -0000

The recent refactoring caused use of wildcards to trigger a traceback
because the old variable name was being used.

Fixes [YOCTO #7367].

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index a86ad1c..89662c7 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -119,7 +119,7 @@ Removes the specified layer from bblayers.conf
             return 1
 
         if args.layerdir.startswith('*'):
-            layerdir = dirname
+            layerdir = args.layerdir
         else:
             layerdir = os.path.abspath(args.layerdir)
         (_, notremoved) = bb.utils.edit_bblayers_conf(bblayers_conf, None, layerdir)
-- 
1.9.3


