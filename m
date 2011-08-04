Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qp6fh-0007D4-3Y
	for bitbake-devel@lists.openembedded.org;
	Fri, 05 Aug 2011 00:45:49 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 04 Aug 2011 15:41:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,320,1309762800"; d="scan'208";a="34615627"
Received: from vorpal.jf.intel.com ([10.7.199.75])
	by orsmga002.jf.intel.com with ESMTP; 04 Aug 2011 15:41:20 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  4 Aug 2011 15:45:59 -0700
Message-Id: <cover.1312497858.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/2] More hob bug fixes
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 04 Aug 2011 22:45:49 -0000

The first patch is a glaring omission in my code, apologies for that. The
second, aiui, should fix cache invalidation to work as expected.

Please review.

Thanks,
Joshua

The following changes since commit 5f079f11ca626a4a11ad728c56bde21009ddd7c8:

  bb/ui/hob: be clear that the image contents are an estimate (2011-08-03 18:19:54 -0700)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Joshua Lock (2):
  bb/ui/hob: reset event handler once build complete
  bb/cooker: mark parsed conf files as potential cache invalidators

 lib/bb/cooker.py |    2 +-
 lib/bb/ui/hob.py |    2 ++
 2 files changed, 3 insertions(+), 1 deletions(-)

-- 
1.7.6



