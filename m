Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 3ADAC73DA5
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 May 2015 15:08:43 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 18 May 2015 08:08:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,453,1427785200"; d="scan'208";a="696616653"
Received: from jmcmill1-mobl3.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.0.158])
	by orsmga001.jf.intel.com with ESMTP; 18 May 2015 08:08:43 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 May 2015 16:08:33 +0100
Message-Id: <cover.1431961693.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH 0/3] Improvements for utility functions
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
X-List-Received-Date: Mon, 18 May 2015 15:08:49 -0000

A patch adding a utility function for getting the layer a file is
contained in, plus a couple of patches extending and improving the
behaviour of edit_metadata_file() (in support of some devtool/recipetool
enhancements in OE that are about to be posted). I kept the two patches
separate as the first one may be backportable to previous branches.


The following changes since commit 76f095107a0eaf987a5a6a48eed7b98f87aea121:

  tests/parse: Add file missing from previous commit (2015-05-16 22:40:30 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-edit-metadata-fixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-edit-metadata-fixes

Paul Eggleton (3):
  lib/bb/utils: add function to get layer containing a file
  lib/bb/utils: fix several bugs in edit_metadata_file()
  lib/bb/utils: fix and extend edit_metadata_file()

 lib/bb/tests/utils.py | 271 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/bb/utils.py       | 256 +++++++++++++++++++++++++++++++++++++----------
 2 files changed, 472 insertions(+), 55 deletions(-)

-- 
2.1.0


