Return-Path: <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id BE45472F4F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Feb 2017 16:34:21 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	21 Feb 2017 08:34:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.35,190,1484035200"; d="scan'208";a="60815218"
Received: from jairdeje-mobl1.zpn.intel.com ([10.219.4.48])
	by orsmga004.jf.intel.com with ESMTP; 21 Feb 2017 08:34:22 -0800
From: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Feb 2017 10:33:56 -0600
Message-Id: <32a254a644a8b2fe9bbc58fcfaef15cc77b04740.1487693987.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1487693987.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
References: <cover.1487693987.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Subject: [selftest][PATCH V2 2/3] bitbake: selftest: add bb.tests.event to bitbake-selftest
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
X-List-Received-Date: Tue, 21 Feb 2017 16:34:21 -0000

Tests for bitbake event module were created on bb.tests.event.
This change is to include them on the default test list in
bitbake-selftest script.

[YOCTO #10368]

Signed-off-by: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
---
 bitbake/bin/bitbake-selftest | 1 +
 1 file changed, 1 insertion(+)

diff --git a/bitbake/bin/bitbake-selftest b/bitbake/bin/bitbake-selftest
index 380e003..afe1603 100755
--- a/bitbake/bin/bitbake-selftest
+++ b/bitbake/bin/bitbake-selftest
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


