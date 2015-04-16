Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id EF19373D52
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 18:29:03 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP; 16 Apr 2015 11:29:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,589,1422950400"; d="scan'208";a="481874278"
Received: from linux.intel.com ([10.23.219.25])
	by FMSMGA003.fm.intel.com with ESMTP; 16 Apr 2015 11:29:03 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 141406A408D;
	Thu, 16 Apr 2015 11:28:38 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 16 Apr 2015 21:28:59 +0300
Message-Id: <1429208939-10876-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <CABcZANnOghZ-ek19v0KH8L2EdC1m2vDOW2Eyv_zOV2zfFaLnWg@mail.gmail.com>
References: <CABcZANnOghZ-ek19v0KH8L2EdC1m2vDOW2Eyv_zOV2zfFaLnWg@mail.gmail.com>
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
X-List-Received-Date: Thu, 16 Apr 2015 18:29:06 -0000

Implemented processing of ~ in bblayer's paths if HOME
environment variable is approved.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/cookerdata.py | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 6c11a60..bf08c63 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -269,8 +269,11 @@ class CookerDataBuilder(object):
             layers = (data.getVar('BBLAYERS', True) or "").split()
 
             data = bb.data.createCopy(data)
+            approved = bb.utils.approved_variables()
             for layer in layers:
                 parselog.debug(2, "Adding layer %s", layer)
+                if 'HOME' in approved:
+                    layer = os.path.expanduser(layer)
                 data.setVar('LAYERDIR', layer)
                 data = parse_config_file(os.path.join(layer, "conf", "layer.conf"), data)
                 data.expandVarref('LAYERDIR')
-- 
2.1.4


