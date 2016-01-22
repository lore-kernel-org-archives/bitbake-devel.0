Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 3F841731D2
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Jan 2016 11:52:49 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 22 Jan 2016 03:52:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,330,1449561600"; d="scan'208";a="896028980"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.181.236])
	by orsmga002.jf.intel.com with ESMTP; 22 Jan 2016 03:52:47 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 23 Jan 2016 00:52:20 +1300
Message-Id: <cover.1453463510.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.0
Subject: [PATCH 0/1] BitBake support for accessing world targets list
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
X-List-Received-Date: Fri, 22 Jan 2016 11:52:53 -0000

The following changes since commit 4eb15605a1436631b3673bdba39af14bcb3a0e6d:

  tests/codeparser.py: Add filename/lineno flags to test variable (2016-01-19 17:42:20 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-taskdata-world
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-taskdata-world

Paul Eggleton (1):
  taskdata: add the ability to access world targets list

 lib/bb/cache.py     |  5 ++++-
 lib/bb/cooker.py    | 24 +-----------------------
 lib/bb/providers.py | 26 ++++++++++++++++++++++++++
 lib/bb/taskdata.py  | 17 +++++++++++++++++
 4 files changed, 48 insertions(+), 24 deletions(-)

-- 
2.5.0


