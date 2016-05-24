Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id BAA2C65C8A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 May 2016 07:25:31 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga103.fm.intel.com with ESMTP; 24 May 2016 00:25:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,359,1459839600"; d="scan'208";a="813506657"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by orsmga003.jf.intel.com with ESMTP; 24 May 2016 00:25:31 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 May 2016 10:25:30 +0300
Message-Id: <1464074730-23187-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
Subject: [PATCH] cookerdata: print an error if layer dir does not exist
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
X-List-Received-Date: Tue, 24 May 2016 07:25:31 -0000

Makes it easier for user to identify problems, e.g. typos, in BBLAYERS.

[YOCTO #9507]

Signed-off-by: Markus Lehtonen <markus.lehtonen@linux.intel.com>
---
 lib/bb/cookerdata.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 1615db5..7dfe7b5 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -292,6 +292,10 @@ class CookerDataBuilder(object):
             data = bb.data.createCopy(data)
             approved = bb.utils.approved_variables()
             for layer in layers:
+                if not os.path.isdir(layer):
+                    parselog.critical("Layer directory '%s' does not to exist! "
+                                      "Please check BBLAYERS in %s" % (layer, layerconf))
+                    sys.exit(1)
                 parselog.debug(2, "Adding layer %s", layer)
                 if 'HOME' in approved and '~' in layer:
                     layer = os.path.expanduser(layer)
-- 
2.6.6


