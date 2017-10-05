Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 21A03719B7
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  5 Oct 2017 23:07:33 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 Oct 2017 16:07:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,482,1500966000"; d="scan'208";a="157294810"
Received: from pnaidu-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.147.41])
	by orsmga005.jf.intel.com with ESMTP; 05 Oct 2017 16:07:32 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  6 Oct 2017 12:06:54 +1300
Message-Id: <68417f805b782bb5e35ce413542b85898149fdbc.1507244747.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <cover.1507244747.git.paul.eggleton@linux.intel.com>
References: <cover.1507244747.git.paul.eggleton@linux.intel.com>
Subject: [PATCH 1/1] toaster: build missing toaster.conf settings
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
X-List-Received-Date: Thu, 05 Oct 2017 23:07:34 -0000

From: David Reyna <David.Reyna@windriver.com>

The bitbake server changed such that the Toaster custom settings from
'toaster.conf' and 'toaster-bblayers.conf' that were set when
the '--server-only' mode was started were lost when the subsequent build
request happened, resulting in builds missing all custom changes.

This patch asserts those environment settings in both server calls.

[YOCTO #12194]

Signed-off-by: David Reyna <David.Reyna@windriver.com>
Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
---
 lib/toaster/bldcontrol/localhostbecontroller.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/toaster/bldcontrol/localhostbecontroller.py b/lib/toaster/bldcontrol/localhostbecontroller.py
index a2ca95b..83cb703 100644
--- a/lib/toaster/bldcontrol/localhostbecontroller.py
+++ b/lib/toaster/bldcontrol/localhostbecontroller.py
@@ -381,9 +381,10 @@ class LocalhostBEController(BuildEnvironmentController):
         local_bitbake = os.path.join(os.path.dirname(os.getenv('BBBASEDIR')),
                                      'bitbake')
         self._shellcmd(['bash -c \"(TOASTER_BRBE="%s" BBSERVER="0.0.0.0:%s" '
-                        '%s %s -u toasterui --token="" >>%s 2>&1;'
+                        '%s %s -u toasterui  --read %s --read %s --token="" >>%s 2>&1;'
                         'BITBAKE_UI="knotty" BBSERVER=0.0.0.0:%s %s -m)&\"' \
-                        % (brbe, self.be.bbport, local_bitbake, bbtargets, log, self.be.bbport, bitbake)],
+                        % (brbe, self.be.bbport, local_bitbake, bbtargets, confpath, toasterlayers, log,
+                        self.be.bbport, bitbake,)],
                         builddir, nowait=True)
 
         logger.debug('localhostbecontroller: Build launched, exiting. '
-- 
2.9.5


