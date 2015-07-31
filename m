Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 0A7C860444
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 31 Jul 2015 09:17:02 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 31 Jul 2015 02:16:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,583,1432623600"; d="scan'208";a="533594749"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.252.23.101])
	by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2015 02:16:42 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 31 Jul 2015 10:16:32 +0100
Message-Id: <cover.1438334127.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH 0/1] Fix for bitbake.lock handling
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
X-List-Received-Date: Fri, 31 Jul 2015 09:17:05 -0000

A patch from Richard and myself to try to fix bitbake.lock handling
properly this time.


The following changes since commit bef724057f1ea81571dd3ac5a9cf862f818434b5:

  build: Exit scripts with result of last shell function (2015-07-27 16:29:11 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bitbake-lock-fix
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-lock-fix

Richard Purdie (1):
  cooker: properly fix bitbake.lock handling

 lib/bb/command.py   |  6 ------
 lib/bb/cooker.py    | 30 ++++++++++++++++++++++++++++++
 lib/bb/main.py      |  1 +
 lib/bb/tinfoil.py   |  1 +
 lib/bb/ui/knotty.py | 20 --------------------
 lib/bb/utils.py     | 29 +++++++++++++++++++++++++----
 6 files changed, 57 insertions(+), 30 deletions(-)

-- 
2.1.0


