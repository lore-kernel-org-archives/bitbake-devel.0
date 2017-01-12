Return-Path: <juro.bystricky@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 6A7C471AC8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Jan 2017 23:44:09 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga103.fm.intel.com with ESMTP; 12 Jan 2017 15:44:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,220,1477983600"; d="scan'208";a="29749361"
Received: from juro-precision-t5610.jf.intel.com ([10.7.198.149])
	by orsmga002.jf.intel.com with ESMTP; 12 Jan 2017 15:44:09 -0800
From: Juro Bystricky <juro.bystricky@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Jan 2017 15:40:31 -0800
Message-Id: <1484264431-28529-1-git-send-email-juro.bystricky@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: jurobystricky@hotmail.com
Subject: [PATCH] cookerdata.py: check for existence of configuration files
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
X-List-Received-Date: Thu, 12 Jan 2017 23:44:13 -0000

Presently there is no check to verify the existence of configuration
files as listed in BBMULTICONFIG. For example, BBMULTICONFIG = "foobar" in local.conf
does not trigger an error when there is no conf/multiconfig/foobar.conf.
The missing file is silently ignored.

This patch verifies the existence of config files and errors-out with the message:

ERROR: BBMULTICONFIG="foobar" but the configuration file './conf/multiconfig/foobar.conf' does not exist!

when the file does not exist.

[YOCTO#10917]

Signed-off-by: Juro Bystricky <juro.bystricky@intel.com>
---
 bitbake/lib/bb/cookerdata.py | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/bitbake/lib/bb/cookerdata.py b/bitbake/lib/bb/cookerdata.py
index d9eab56..bb1e2c3 100644
--- a/bitbake/lib/bb/cookerdata.py
+++ b/bitbake/lib/bb/cookerdata.py
@@ -289,6 +289,12 @@ class CookerDataBuilder(object):
 
             multiconfig = (self.data.getVar("BBMULTICONFIG") or "").split()
             for config in multiconfig:
+                if config != "":
+                    src = "./conf/multiconfig/" + config + ".conf"
+                    if not os.access(src, os.R_OK):
+                        parselog.critical("BBMULTICONFIG=\"%s\" but the configuration file '%s' does not exist! " % (self.data.getVar("BBMULTICONFIG"),src))
+                        sys.exit(1)
+
                 mcdata = self.parseConfigurationFiles(self.prefiles, self.postfiles, config)
                 bb.event.fire(bb.event.ConfigParsed(), mcdata)
                 self.mcdata[config] = mcdata
-- 
2.7.4


