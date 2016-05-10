Return-Path: <humberto.ibarra.lopez@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id A3A1660088
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 May 2016 17:53:58 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga104.fm.intel.com with ESMTP; 10 May 2016 10:54:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,605,1455004800"; d="scan'208";a="972827060"
Received: from jhibarra-desk.zpn.intel.com ([10.219.16.19])
	by orsmga002.jf.intel.com with ESMTP; 10 May 2016 10:53:58 -0700
From: Humberto Ibarra <humberto.ibarra.lopez@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 May 2016 12:54:09 -0500
Message-Id: <1462902849-6940-1-git-send-email-humberto.ibarra.lopez@intel.com>
X-Mailer: git-send-email 2.4.11
Subject: [PATCH] bitbake/lib/bb/cookerdata.py: Check if layer conf files exist before parsing them
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
X-List-Received-Date: Tue, 10 May 2016 17:54:01 -0000

If an invalid layer is added to bblayers.conf, the parsing of said file
ends with a trace and an "Unable to parse" exception. This is not the
ideal output, especially considering that we know exactly why this is failing.

This patch checks if a layer conf file exists before trying to parse it.
If it does not, a clear and more concise message is send to the user.
Otherwise, the parsing continues.

[Yocto #9506]

Signed-off-by: Humberto Ibarra <humberto.ibarra.lopez@intel.com>
---
 bitbake/lib/bb/cookerdata.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index 50259a9..28f652e 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -295,7 +295,11 @@ class CookerDataBuilder(object):
                 if layer.endswith('/'):
                     layer = layer.rstrip('/')
                 data.setVar('LAYERDIR', layer)
-                data = parse_config_file(os.path.join(layer, "conf", "layer.conf"), data)
+                layer_config_file = os.path.join(layer, "conf", "layer.conf")
+                if not os.path.exists(layer_config_file):
+                    parselog.critical("Unable to find layer configuration file: %s" % layer_config_file)
+                    sys.exit(1)
+                data = parse_config_file(layer_config_file, data)
                 data.expandVarref('LAYERDIR')
 
             data.delVar('LAYERDIR')
-- 
2.4.11


