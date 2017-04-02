Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 97D5470031
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  2 Apr 2017 23:19:21 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga105.jf.intel.com with ESMTP; 02 Apr 2017 16:19:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,266,1486454400"; d="scan'208";a="243247991"
Received: from rbek-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.164.56])
	by fmsmga004.fm.intel.com with ESMTP; 02 Apr 2017 16:19:21 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Apr 2017 11:19:02 +1200
Message-Id: <cover.1491175014.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
Subject: [PATCH 0/4] Fixes for variable dependency handling with contains functions
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
X-List-Received-Date: Sun, 02 Apr 2017 23:19:24 -0000

Fixes for a few issues I discovered while working on bitbake-diffsigs.

The following changes since commit 58a03531c8183b165bb7dcad86d8559c92bc150d:

  fetch2: Do not fail to create symbolic links if they already exist (2017-04-01 08:23:29 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-contains
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-contains

Paul Eggleton (4):
  lib/bb/data: fix dependency handling for contains and multiple values
  codeparser: improve handling of contains_any() and filter()
  bitbake-selftest: add contains tests
  codeparser: add some comments

 lib/bb/cache.py            |  2 +-
 lib/bb/codeparser.py       | 34 +++++++++++++++++++++++++++++---
 lib/bb/data.py             | 10 ++++++----
 lib/bb/tests/codeparser.py | 48 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 8 deletions(-)

-- 
2.9.3


