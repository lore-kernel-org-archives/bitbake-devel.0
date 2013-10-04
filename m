Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 620D960FA4
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Oct 2013 16:44:37 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 04 Oct 2013 09:44:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,1034,1371106800"; d="scan'208";a="414098026"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.164])
	by orsmga002.jf.intel.com with ESMTP; 04 Oct 2013 09:44:34 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Oct 2013 17:44:24 +0100
Message-Id: <cover.1380904913.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH 0/4] BitBake signature tool improvements
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
X-List-Received-Date: Fri, 04 Oct 2013 16:44:37 -0000

Make bitbake-diffsigs and bitbake-dumpsig a little easier to use.

The following changes (against poky, but apply cleanly against bitbake
master with -p2) are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-sig-tools
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-sig-tools

Paul Eggleton (4):
  bitbake-diffsigs: handle if task name is specified without do_ prefix
  bitbake-diffsigs: refactor argument parsing slightly
  bitbake-diffsigs: improve error handling
  bitbake-dumpsig: introduce command line and error handling

 bitbake/bin/bitbake-diffsigs | 57 ++++++++++++++++++++++++++++-------------
 bitbake/bin/bitbake-dumpsig  | 60 +++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 96 insertions(+), 21 deletions(-)

-- 
1.8.1.2


