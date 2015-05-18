Return-Path: <randy.e.witt@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id C71BB60054
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 May 2015 22:06:17 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 18 May 2015 15:06:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,455,1427785200"; d="scan'208";a="573314993"
Received: from bitbang.jf.intel.com ([10.7.201.37])
	by orsmga003.jf.intel.com with ESMTP; 18 May 2015 15:06:18 -0700
From: Randy Witt <randy.e.witt@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 May 2015 15:06:10 -0700
Message-Id: <1431986772-17395-1-git-send-email-randy.e.witt@linux.intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/2] Remove Toaster dependency on daemon
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
X-List-Received-Date: Mon, 18 May 2015 22:06:17 -0000

The following changes since commit bc162d21dd148252efcf3ed771e04c791ef4d869:

  bitbake: tests/parse: Add file missing from previous commit (2015-05-16 22:40:44 +0100)

are available in the git repository at:

  git@git.yoctoproject.org:poky-contrib rewitt/toaster

for you to fetch changes up to e5e8d341edd28007eac22381e336f8362d784530:

  toaster: Remove dependency on daemon application (2015-05-18 15:01:42 -0700)

----------------------------------------------------------------
Randy Witt (2):
      localhostbecontroller: Fix server search debug message
      toaster: Remove dependency on daemon application

 bitbake/bin/toaster                                 |  5 -----
 .../lib/toaster/bldcontrol/localhostbecontroller.py | 21 ++++++++++++++-------
 2 files changed, 14 insertions(+), 12 deletions(-)


