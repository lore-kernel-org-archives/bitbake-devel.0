Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 1F27C723FE
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Dec 2014 11:14:53 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 29 Dec 2014 03:14:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,659,1413270000"; d="scan'208";a="630312985"
Received: from brvijay-mobl.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.0.132])
	by orsmga001.jf.intel.com with ESMTP; 29 Dec 2014 03:14:31 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Dec 2014 11:14:25 +0000
Message-Id: <cover.1419851448.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/2] Fixes for devtool QA issues on the YP autobuilder
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
X-List-Received-Date: Mon, 29 Dec 2014 11:14:57 -0000

These fix the code in bitbake-layers and lib/bb/utils.py that OE's
devtool and its QA tests use so that the tests should now pass.


The following changes since commit 10a47b1ec7470c9e8c4ffe0bb35cdf6d1bb2ee2e:

  fetch2/wget: Fix horrible temp file handling (2014-12-23 12:35:06 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bblayers-fixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bblayers-fixes

Paul Eggleton (2):
  bitbake-layers: fix error handling in add-layer / remove-layer
  utils: make edit_metadata_file() handle VARIABLE +=

 bin/bitbake-layers |  2 +-
 lib/bb/utils.py    | 10 +++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
1.9.3


