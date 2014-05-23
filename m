Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (unknown [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 353186B49F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 May 2014 15:22:37 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 23 May 2014 08:22:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.98,894,1392192000"; d="scan'208";a="545581382"
Received: from bidesilv-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.123.159])
	by orsmga002.jf.intel.com with ESMTP; 23 May 2014 08:22:34 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 May 2014 16:22:17 +0100
Message-Id: <95f35e6212702496490f1a4c442379cb53ed680e.1400858501.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <cover.1400858501.git.paul.eggleton@linux.intel.com>
References: <cover.1400858501.git.paul.eggleton@linux.intel.com>
In-Reply-To: <cover.1400858501.git.paul.eggleton@linux.intel.com>
References: <cover.1400858501.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 4/4] bitbake-layers: show-cross-depends: add support for RRECOMMENDS
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
X-List-Received-Date: Fri, 23 May 2014 15:22:37 -0000

RRECOMMENDS must be satisfied at build time, and these could cross layer
boundaries, so report these if they exist.

Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 bin/bitbake-layers | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/bin/bitbake-layers b/bin/bitbake-layers
index 135096b..302f020 100755
--- a/bin/bitbake-layers
+++ b/bin/bitbake-layers
@@ -634,6 +634,26 @@ The .bbappend file can impact the dependency.
                                     self.bbhandler.cooker_data)[0][0]
                     self.check_cross_depends("RDEPENDS", layername, f, best, options.show_filenames, ignore_layers)
 
+            # The RRECOMMENDS
+            all_rrecs = self.bbhandler.cooker_data.runrecs[f].values()
+            # Remove the duplicated or null one.
+            sorted_rrecs = {}
+            # The all_rrecs is the list in list, so we need two for loops
+            for k1 in all_rrecs:
+                for k2 in k1:
+                    sorted_rrecs[k2] = 1
+            all_rrecs = sorted_rrecs.keys()
+            for rrec in all_rrecs:
+                all_p = bb.providers.getRuntimeProviders(self.bbhandler.cooker_data, rrec)
+                if all_p:
+                    if f in all_p:
+                        # The recipe provides this one itself, ignore
+                        continue
+                    best = bb.providers.filterProvidersRunTime(all_p, rrec,
+                                    self.bbhandler.config_data,
+                                    self.bbhandler.cooker_data)[0][0]
+                    self.check_cross_depends("RRECOMMENDS", layername, f, best, options.show_filenames, ignore_layers)
+
             # The inherit class
             cls_re = re.compile('classes/')
             if f in self.bbhandler.cooker_data.inherits:
-- 
1.9.0


