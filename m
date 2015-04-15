Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id B8B8673D2B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Apr 2015 14:43:27 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP; 15 Apr 2015 07:43:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,582,1422950400"; d="scan'208";a="714092248"
Received: from linux.intel.com ([10.23.219.25])
	by orsmga002.jf.intel.com with ESMTP; 15 Apr 2015 07:43:29 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id 43FCD6A408F;
	Wed, 15 Apr 2015 07:43:04 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 15 Apr 2015 17:43:22 +0300
Message-Id: <1429109002-25246-1-git-send-email-ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <CABcZANnTuVDDisxj3W1EjE_RN3MAaLnk2-9Wm_rcnq4E1jR=ew@mail.gmail.com>
References: <CABcZANnTuVDDisxj3W1EjE_RN3MAaLnk2-9Wm_rcnq4E1jR=ew@mail.gmail.com>
Subject: [PATCH] bitbake: Allow environment variables and ~ in bblayers
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
X-List-Received-Date: Wed, 15 Apr 2015 14:43:28 -0000

Enabled processing of environment variables in bblayers paths using
bitbake apporved_variables API.

Enabled processing of ~ if HOME environment variable is approved.

Signed-off-by: Ed Bartosh <ed.bartosh@linux.intel.com>
---
 bitbake/lib/bb/cookerdata.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 6c11a60..05b3986 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -25,6 +25,7 @@
 import os, sys
 from functools import wraps
 import logging
+import string
 import bb
 from bb import data
 import bb.parse
@@ -269,8 +270,13 @@ class CookerDataBuilder(object):
             layers = (data.getVar('BBLAYERS', True) or "").split()
 
             data = bb.data.createCopy(data)
+            approved = dict((var, data.getVar(var, True)) \
+                                  for var in bb.utils.approved_variables())
             for layer in layers:
                 parselog.debug(2, "Adding layer %s", layer)
+                layer = string.Template(layer).safe_substitute(approved)
+                if 'HOME' in approved:
+                    layer = os.path.expanduser(layer)
                 data.setVar('LAYERDIR', layer)
                 data = parse_config_file(os.path.join(layer, "conf", "layer.conf"), data)
                 data.expandVarref('LAYERDIR')
-- 
2.1.4


