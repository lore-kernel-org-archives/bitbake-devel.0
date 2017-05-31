Return-Path: <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 7EB1177E33
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 21:26:42 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	31 May 2017 14:26:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,276,1493708400"; d="scan'208";a="94079797"
Received: from jairdeje-mobl1.zpn.intel.com ([10.219.4.146])
	by orsmga002.jf.intel.com with ESMTP; 31 May 2017 14:26:43 -0700
From: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 31 May 2017 16:26:02 -0500
Message-Id: <5a766b3ac9673c6f28c6dad5469bd6309ff9b732.1496259855.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1496259855.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
References: <cover.1496259855.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Subject: [selftest][PATCH V4 2/3] bitbake: selftest: add bb.tests.event to bitbake-selftest
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
X-List-Received-Date: Wed, 31 May 2017 21:26:42 -0000

Tests for bitbake event module were created on bb.tests.event.
This change is to include them on the default test list in
bitbake-selftest script.

[YOCTO #10368]

Signed-off-by: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
---
 bin/bitbake-selftest | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bin/bitbake-selftest b/bin/bitbake-selftest
index 380e003..afe1603 100755
--- a/bin/bitbake-selftest
+++ b/bin/bitbake-selftest
@@ -28,6 +28,7 @@ except RuntimeError as exc:
 tests = ["bb.tests.codeparser",
          "bb.tests.cow",
          "bb.tests.data",
+         "bb.tests.event",
          "bb.tests.fetch",
          "bb.tests.parse",
          "bb.tests.utils"]
-- 
2.7.4


