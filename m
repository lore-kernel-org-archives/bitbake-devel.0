Return-Path: <brian.avery@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 9B319719F4
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Oct 2016 23:54:58 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by orsmga103.jf.intel.com with ESMTP; 03 Oct 2016 16:54:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,292,1473145200"; d="scan'208";a="15932504"
Received: from bavery-ws-desk.jf.intel.com ([10.7.198.85])
	by orsmga005.jf.intel.com with ESMTP; 03 Oct 2016 16:54:58 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Oct 2016 16:56:26 -0700
Message-Id: <6e40ff809e0ae60795bd8f561bef9466ad1de517.1475538792.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1475538792.git.brian.avery@intel.com>
References: <cover.1475538792.git.brian.avery@intel.com>
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 1/1] toaster: add Font Awesome license
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
X-List-Received-Date: Mon, 03 Oct 2016 23:55:02 -0000

Font Awesome fonts are bundled with the Toaster UI and are released
under the SIL Open Font License 1.1.  This patch adds that information
to the LICENSE file.

Signed-off-by: bavery <brian.avery@intel.com>
---
 LICENSE | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/LICENSE b/LICENSE
index 4a09b0f..5d4a4c2 100644
--- a/LICENSE
+++ b/LICENSE
@@ -13,3 +13,5 @@ Foundation and individual contributors.
 * jsrender is redistributed under the MIT license.
 
 * QUnit is redistributed under the MIT license.
+
+* Font Awesome fonts redistributed under the SIL Open Font License 1.1
-- 
1.9.1


