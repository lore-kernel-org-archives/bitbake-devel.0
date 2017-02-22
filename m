Return-Path: <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 9B02A72FFB
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Feb 2017 00:00:42 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	21 Feb 2017 16:00:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.35,191,1484035200"; d="scan'208";a="68032514"
Received: from jairdeje-mobl1.zpn.intel.com ([10.219.4.48])
	by fmsmga005.fm.intel.com with ESMTP; 21 Feb 2017 16:00:44 -0800
From: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Feb 2017 18:00:08 -0600
Message-Id: <1487721630-3712-2-git-send-email-jair.de.jesus.gonzalez.plascencia@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [bitbake][PATCH V3 2/3] bitbake: selftest: add bb.tests.event to bitbake-selftest
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
X-List-Received-Date: Wed, 22 Feb 2017 00:00:45 -0000

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


