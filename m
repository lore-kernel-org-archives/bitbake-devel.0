Return-Path: <peter.kjellerstedt@axis.com>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
	by mail.openembedded.org (Postfix) with ESMTP id 535E37822A
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 14:44:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by bastet.se.axis.com (Postfix) with ESMTP id 1C07618462
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:34 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
	by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new,
	port 10024)
	with LMTP id BBne0gQKJgD9 for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:33 +0100 (CET)
Received: from boulder03.se.axis.com (boulder03.se.axis.com [10.0.8.17])
	by bastet.se.axis.com (Postfix) with ESMTPS id 8B0661845C
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:33 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 773ED1E08F
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:33 +0100 (CET)
Received: from boulder03.se.axis.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C52B1E089
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:33 +0100 (CET)
Received: from seth.se.axis.com (unknown [10.0.2.172])
	by boulder03.se.axis.com (Postfix) with ESMTP
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:33 +0100 (CET)
Received: from saur-2.se.axis.com (saur-2.se.axis.com [10.92.3.2])
	by seth.se.axis.com (Postfix) with ESMTP id 607AF2E4
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  7 Dec 2017 15:38:33 +0100 (CET)
Received: from saur-2.se.axis.com (localhost [127.0.0.1])
	by saur-2.se.axis.com (8.14.5/8.14.5) with ESMTP id vB7EcXSU020908
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 7 Dec 2017 15:38:33 +0100
Received: (from pkj@localhost)
	by saur-2.se.axis.com (8.14.5/8.14.5/Submit) id vB7EcXKi020907
	for bitbake-devel@lists.openembedded.org; Thu, 7 Dec 2017 15:38:33 +0100
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  7 Dec 2017 15:38:30 +0100
Message-Id: <20171207143832.20865-1-pkj@axis.com>
X-Mailer: git-send-email 2.12.0
X-TM-AS-GCONF: 00
Subject: [PATCH 1/2] gstreamer1.0.inc: Define a PACKAGECONFIG for examples
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
 meta/recipes-multimedia/gstreamer/gstreamer1.0.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/meta/recipes-multimedia/gstreamer/gstreamer1.0.inc b/meta/recipes-multimedia/gstreamer/gstreamer1.0.inc
index 329193486d..a3a8207229 100644
--- a/meta/recipes-multimedia/gstreamer/gstreamer1.0.inc
+++ b/meta/recipes-multimedia/gstreamer/gstreamer1.0.inc
@@ -21,6 +21,7 @@ SRC_URI_append = " \
 PACKAGECONFIG ??= ""
 
 PACKAGECONFIG[debug] = "--enable-debug,--disable-debug"
+PACKAGECONFIG[examples] = "--enable-examples,--disable-examples"
 PACKAGECONFIG[tests] = "--enable-tests,--disable-tests"
 PACKAGECONFIG[valgrind] = "--enable-valgrind,--disable-valgrind,valgrind,"
 PACKAGECONFIG[gst-tracer-hooks] = "--enable-gst-tracer-hooks,--disable-gst-tracer-hooks,"
@@ -29,7 +30,6 @@ PACKAGECONFIG[dw] = "--with-dw,--without-dw,elfutils"
 
 EXTRA_OECONF = " \
     --disable-dependency-tracking \
-    --disable-examples \
 "
 
 CACHED_CONFIGUREVARS += "ac_cv_header_valgrind_valgrind_h=no"
-- 
2.12.0


