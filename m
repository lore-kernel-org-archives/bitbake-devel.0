Return-Path: <peter.kjellerstedt@axis.com>
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
	by mail.openembedded.org (Postfix) with ESMTP id 04DA77D6B4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 13 Nov 2019 05:17:17 +0000 (UTC)
IronPort-SDR: +fBli98ydEyTKwLYliclCGpAApglGLh4OUSTigiTEqtHB1lq1tY4V8JnpExDQI4OQoYs/CSA3C
	nkNQKT7rNGgAkHZB3Sfxcmktb+mqHnWQyGQ6iNkWTPQ+TfNCVnop6E8lPuBg2sC63HhD3L8YSQ
	QBSfTkyFenv3fScwtxJ2bB47c+S7XyAq2SKUEpFJaPIKhpke/kibwT+CTiw2E85u6FoMoVOZbw
	QYS0FYVdmzaHnmwgR/smw/XQr3ZaXPtzvvmGV5L4S09zlkYN8w3uduglXUBxeS+4VcksgD80Ls
	XwE=
X-IronPort-AV: E=Sophos;i="5.68,299,1569276000"; 
   d="scan'208";a="2366816"
X-Axis-User: NO
X-Axis-NonUser: YES
X-Virus-Scanned: Debian amavisd-new at bes.se.axis.com
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 13 Nov 2019 06:17:16 +0100
Message-Id: <20191113051716.19050-1-pkj@axis.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Subject: [PATCH] cooker: Remove a left-over comment about expanded_data
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
X-List-Received-Date: Wed, 13 Nov 2019 05:17:18 -0000
Content-Transfer-Encoding: 8bit

This should have been removed together with expanded_data in commit
e3694e73 (cooker/command: Drop expanded_data).

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 bitbake/lib/bb/cooker.py | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
index 20ef04d3ff..e6442bff93 100644
--- a/bitbake/lib/bb/cooker.py
+++ b/bitbake/lib/bb/cooker.py
@@ -371,10 +371,6 @@ class BBCooker:
 
         self.data.setVar('BB_CMDLINE', self.ui_cmdline)
 
-        #
-        # Copy of the data store which has been expanded.
-        # Used for firing events and accessing variables where expansion needs to be accounted for
-        #
         if CookerFeatures.BASEDATASTORE_TRACKING in self.featureset:
             self.disableDataTracking()
 
-- 
2.21.0


