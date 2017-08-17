Return-Path: <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 105E978581
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Aug 2017 20:41:24 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	17 Aug 2017 13:41:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,389,1498546800"; d="scan'208";a="891183046"
Received: from jairdeje-mobl1.zpn.intel.com ([10.219.4.45])
	by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2017 13:41:25 -0700
From: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Aug 2017 15:40:53 -0500
Message-Id: <c0ef65aad173bf004facfbb52b42fb8b16848768.1503000752.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1503000752.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
References: <cover.1503000752.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Subject: [selftest][PATCH V1 4/5] bitbake: tests: Initialize data attribute on BuildBase event
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
X-List-Received-Date: Thu, 17 Aug 2017 20:41:24 -0000

The BuildBase event class contains a cfg property for which the
corresponding data attribute was not being initialized on the
constructor. This caused that trying to access the property
without setting it first threw an AttributeError exception.

This change adds an initialization to None to the data attribute.

Signed-off-by: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
---
 lib/bb/event.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/bb/event.py b/lib/bb/event.py
index 526c41f..76b09ec 100644
--- a/lib/bb/event.py
+++ b/lib/bb/event.py
@@ -432,6 +432,7 @@ class BuildBase(Event):
         self._pkgs = p
         Event.__init__(self)
         self._failures = failures
+        self.data = None
 
     def getPkgs(self):
         return self._pkgs
-- 
2.7.4


