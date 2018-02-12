Return-Path: <amanda.r.brindle@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id AC26F78260
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Feb 2018 20:35:45 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	12 Feb 2018 12:35:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,503,1511856000"; d="scan'208";a="34136859"
Received: from arbrindl-dev.jf.intel.com ([10.7.199.57])
	by orsmga002.jf.intel.com with ESMTP; 12 Feb 2018 12:35:46 -0800
From: Amanda Brindle <amanda.r.brindle@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Feb 2018 12:31:49 -0800
Message-Id: <cover.1518466860.git.amanda.r.brindle@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: stephano.cetola@intel.com
Subject: [PATCH 0/1] bitbake: Add option for explode_dep_versions2 to return unsorted
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
X-List-Received-Date: Mon, 12 Feb 2018 20:35:45 -0000

The following changes since commit 44ea6ded0e8e73f5258ce55bd1b851e24243b76a:

  bitbake: bitbake-user-manual: Commented out Placeholder Paragraph (2018-02-06 18:10:35 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib abrindle/buildhistory-diff4
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=abrindle/buildhistory-diff4

Amanda Brindle (1):
  bitbake: Add option for explode_dep_versions2 to return unsorted

 bitbake/lib/bb/utils.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.7.4


