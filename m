Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id C562F606BF
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2016 04:37:06 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by fmsmga102.fm.intel.com with ESMTP; 29 Aug 2016 21:37:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,254,1470726000"; d="scan'208";a="872441149"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.182.37])
	by orsmga003.jf.intel.com with ESMTP; 29 Aug 2016 21:37:05 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 30 Aug 2016 16:36:35 +1200
Message-Id: <cover.1472531645.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH 0/3] Tinfoil fixes
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
X-List-Received-Date: Tue, 30 Aug 2016 04:37:08 -0000

Add context management and a parsing function, and ensure tinfoil using
utilities within the bitbake repo shut down tinfoil properly at the end.
The parsing function in particular is going to be needed to properly
fix the layer index update script that has been broken since the
multiconfig changes.

(This series borrows a few things from my tinfoil2 branch.)


The following changes since commit 0ed8975c42718342a104a9764a58816f964ec4ea:

  fetch2: clean up remaining cwd saves/changes (2016-08-24 13:55:36 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/tinfoil-fixes-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/tinfoil-fixes-bb

Paul Eggleton (3):
  tinfoil: add context manager functions
  Ensure tinfoil is shut down correctly in utilities that use it
  tinfoil: add a parse_recipe_file function

 bin/bitbake-diffsigs |  6 +++---
 bin/bitbake-layers   | 53 +++++++++++++++++++++++++++-------------------------
 lib/bb/tinfoil.py    | 27 ++++++++++++++++++++++++++
 3 files changed, 58 insertions(+), 28 deletions(-)

-- 
2.5.5


