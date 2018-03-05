Return-Path: <amanda.r.brindle@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 78E6C78A8B
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Mar 2018 19:16:25 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	05 Mar 2018 11:16:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800"; d="scan'208";a="205674788"
Received: from arbrindl-dev.jf.intel.com ([10.7.199.57])
	by orsmga005.jf.intel.com with ESMTP; 05 Mar 2018 11:16:27 -0800
From: Amanda Brindle <amanda.r.brindle@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Mar 2018 11:11:42 -0800
Message-Id: <cover.1520274722.git.amanda.r.brindle@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: stephano.cetola@intel.com
Subject: [PATCH V3 0/1] utils.py: Add option for explode_dep_versions2 to return unsorted
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
X-List-Received-Date: Mon, 05 Mar 2018 19:16:26 -0000

Changes since V2:

Changed variable name in explode_dep_versions2 from unsorted to sort in order to avoid double negative logic.

Also made the variable a keyword-only argument for readability.

The following changes since commit 44ea6ded0e8e73f5258ce55bd1b851e24243b76a:

  bitbake: bitbake-user-manual: Commented out Placeholder Paragraph (2018-02-06 18:10:35 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib abrindle/buildhistory-diff4
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=abrindle/buildhistory-diff4

Amanda Brindle (1):
  utils.py: Add option for explode_dep_versions2 to return unsorted

 lib/bb/utils.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.7.4


