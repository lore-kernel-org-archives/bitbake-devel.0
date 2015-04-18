Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 8962A7226D
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 18 Apr 2015 15:10:08 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP; 18 Apr 2015 08:09:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,599,1422950400"; d="scan'208";a="715672799"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 18 Apr 2015 08:09:54 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id E9C7B6A408D;
	Sat, 18 Apr 2015 08:09:27 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 18 Apr 2015 18:09:46 +0300
Message-Id: <1429369786-12896-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1429267317.6976.196.camel@linuxfoundation.org>
References: <1429267317.6976.196.camel@linuxfoundation.org>
Subject: [PATCH] bitbake: Allow ~ in bblayers
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
X-List-Received-Date: Sat, 18 Apr 2015 15:10:10 -0000

Implemented processing of ~ in bblayer's paths if HOME
environment variable is approved.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/cookerdata.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 6c11a60..630ee27 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -269,8 +269,11 @@ class CookerDataBuilder(object):
             layers = (data.getVar('BBLAYERS', True) or "").split()
 
             data = bb.data.createCopy(data)
+            approved = bb.utils.approved_variables()
             for layer in layers:
                 parselog.debug(2, "Adding layer %s", layer)
+                if 'HOME' in approved and '~' in layer:
+                    layer = os.path.expanduser(layer)
                 data.setVar('LAYERDIR', layer)
                 data = parse_config_file(os.path.join(layer, "conf", "layer.conf"), data)
                 data.expandVarref('LAYERDIR')
-- 
2.1.4


