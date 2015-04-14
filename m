Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 7359173CC5
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Apr 2015 20:46:05 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP; 14 Apr 2015 13:46:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,577,1422950400"; d="scan'208";a="556022791"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga003.jf.intel.com with ESMTP; 14 Apr 2015 13:46:01 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id AEAFC6A408D;
	Tue, 14 Apr 2015 13:45:33 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 14 Apr 2015 23:45:50 +0300
Message-Id: <1429044350-19766-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH] Allow environment variables and ~ in bbconf paths
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
X-List-Received-Date: Tue, 14 Apr 2015 20:46:08 -0000

This should allow to use ~, $HOME and other environment
variables in bbconf paths.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/cookerdata.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 6c11a60..ec5c9ea 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -271,6 +271,7 @@ class CookerDataBuilder(object):
             data = bb.data.createCopy(data)
             for layer in layers:
                 parselog.debug(2, "Adding layer %s", layer)
+                layer = os.path.expanduser(os.path.expandvars(layer))
                 data.setVar('LAYERDIR', layer)
                 data = parse_config_file(os.path.join(layer, "conf", "layer.conf"), data)
                 data.expandVarref('LAYERDIR')
-- 
2.1.4


