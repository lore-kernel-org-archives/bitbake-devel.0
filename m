Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 252B96E237
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Dec 2013 19:07:32 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 09 Dec 2013 11:07:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,859,1378882800"; d="scan'208";a="449359929"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.25])
	by orsmga002.jf.intel.com with ESMTP; 09 Dec 2013 11:07:31 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Dec 2013 19:07:12 +0000
Message-Id: <f6031bd753917c459ab232d88d7dcfc3f10e8184.1386615747.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1386615747.git.paul.eggleton@linux.intel.com>
References: <cover.1386615747.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 06/11] toasterui: fix version numbers for no PE specified
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
X-List-Received-Date: Mon, 09 Dec 2013 19:07:32 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

PE is an optional field in recipes specifiying the epoch
for the recipe. The canonical form for the
full recipe version string is: PE:PV-PR

If no PE is specified, we shouldn't store the initial ":"
character, as it leads to inconsistency with how the
version string is used elsewhere. This patch drops the leading ":"

    [YOCTO #5459]

Signed-off-by: Alexandru DAMIAN <alexandru.damian@intel.com>
---
 lib/bb/ui/buildinfohelper.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bb/ui/buildinfohelper.py b/lib/bb/ui/buildinfohelper.py
index 0252efd..3d5f1c8 100644
--- a/lib/bb/ui/buildinfohelper.py
+++ b/lib/bb/ui/buildinfohelper.py
@@ -531,7 +531,7 @@ class BuildInfoHelper(object):
 
             recipe_info = {}
             recipe_info['name'] = pn
-            recipe_info['version'] = event._depgraph['pn'][pn]['version']
+            recipe_info['version'] = event._depgraph['pn'][pn]['version'].lstrip(":")
             recipe_info['layer_version'] = layer_version_obj
             recipe_info['summary'] = event._depgraph['pn'][pn]['summary']
             recipe_info['license'] = event._depgraph['pn'][pn]['license']
-- 
1.8.1.2


