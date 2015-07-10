Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id CB5306017E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jul 2015 13:51:53 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga103.jf.intel.com with ESMTP; 10 Jul 2015 06:51:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,446,1432623600"; d="scan'208";a="759832533"
Received: from dawalker-mobl3.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.7.62])
	by fmsmga002.fm.intel.com with ESMTP; 10 Jul 2015 06:51:52 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Jul 2015 14:51:39 +0100
Message-Id: <cover.1436536203.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH 0/1] BitBake side of shell message function support
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
X-List-Received-Date: Fri, 10 Jul 2015 13:51:53 -0000

I'm finally sending out the patches to support the output of bbwarn,
bberror etc. output actually going to the console. This is the BitBake
side of the changes to implement it.


The following changes since commit fbb9c6f5538084e125b58118a86968908e6f895b:

  fetch2: Add fetch parameter to checkstatus (2015-07-09 17:59:29 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-shell-logging
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-shell-logging

Paul Eggleton (1):
  lib/bb: set up infrastructure for shell message functions

 lib/bb/build.py   | 50 +++++++++++++++++++++++++++++++++++++++++++-------
 lib/bb/process.py | 25 ++++++++++++++++++++++---
 2 files changed, 65 insertions(+), 10 deletions(-)

-- 
2.1.0


