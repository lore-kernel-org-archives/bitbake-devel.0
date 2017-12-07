Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 5499E784DB
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 14:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 4C60318454
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:36 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id p-4-Xwp44ADA for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:33 +0100 (CET)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
	by bastet.se.axis.com (Postfix) with ESMTPS id A04A818460
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:33 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 903E41A072
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:33 +0100 (CET)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8543B1A069
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:33 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder02.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:33 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id 797832A9E
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:33 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id vB7EcXrq020916
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 7 Dec 2017 15:38:33 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id vB7EcXnL020915
	for bitbake-devel@lists.openembedded.org; Thu, 7 Dec 2017 15:38:33 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  7 Dec 2017 15:38:32 +0100
Message-Id: <20171207143832.20865-3-pkj@axis.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20171207143832.20865-1-pkj@axis.com>
References: <20171207143832.20865-1-pkj@axis.com>
X-TM-AS-GCONF: 00
Subject: [PATCH 2/2] gstreamer1.0-plugins.inc: Define a PACKAGECONFIG for examples
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
X-List-Received-Date: Thu, 07 Dec 2017 14:44:01 -0000

This makes it consistent with, e.g., debug, that can be
enabled/disabled using a PACKAGECONFIG.

Signed-off-by: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
---
 meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins.inc | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins.inc b/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins.inc
index c40d398911..32846165c1 100644
--- a/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins.inc
+++ b/meta/recipes-multimedia/gstreamer/gstreamer1.0-plugins.inc
@@ -19,15 +19,12 @@ require gst-plugins-package.inc
 GSTREAMER_ORC ?= "orc"
 
 PACKAGECONFIG[debug] = "--enable-debug,--disable-debug"
+PACKAGECONFIG[examples] = "--enable-examples,--disable-examples"
 PACKAGECONFIG[orc] = "--enable-orc,--disable-orc,orc orc-native"
 PACKAGECONFIG[valgrind] = "--enable-valgrind,--disable-valgrind,valgrind"
 
 export ORCC = "${STAGING_DIR_NATIVE}${bindir}/orcc"
 
-EXTRA_OECONF = " \
-    --disable-examples \
-"
-
 delete_pkg_m4_file() {
 	# This m4 file is out of date and is missing PKG_CONFIG_SYSROOT_PATH tweaks which we need for introspection
 	rm "${S}/common/m4/pkg.m4" || true
-- 
2.12.0


