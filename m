Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 40115728F9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Dec 2014 10:20:49 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 19 Dec 2014 02:20:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.07,606,1413270000"; d="scan'208";a="640218074"
Received: from khamid-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.31.61])
	by fmsmga001.fm.intel.com with ESMTP; 19 Dec 2014 02:20:49 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 19 Dec 2014 10:20:28 +0000
Message-Id: <cover.1418984377.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/4] devtool related changes, part 2
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
X-List-Received-Date: Fri, 19 Dec 2014 10:20:53 -0000

The following changes since commit 18cd0ce6a55c9065c3f1bf223b47d817b5efcd8f:

  data: escape '$' in shell variable assignment (2014-12-18 10:24:45 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/devtool-bb2
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/devtool-bb2

Paul Eggleton (4):
  siggen: ensure nostamp tasks force dependent tasks to re-execute
  utils: add basic metadata manipulation functions
  bitbake-layers: add commands for adding and removing layers
  cooker: add ability to ignore unmatched regexes in BBFILE_PATTERN

 bin/bitbake-layers |  54 +++++++++++++++++++++++
 lib/bb/cooker.py   |   7 +--
 lib/bb/siggen.py   |   6 +++
 lib/bb/utils.py    | 127 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 191 insertions(+), 3 deletions(-)

-- 
1.9.3


