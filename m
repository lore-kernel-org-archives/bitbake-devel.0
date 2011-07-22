Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QkJTR-0000iv-MN
	for bitbake-devel@lists.openembedded.org;
	Fri, 22 Jul 2011 19:25:17 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 22 Jul 2011 10:21:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,248,1309762800"; d="scan'208";a="30859603"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.51])
	by orsmga001.jf.intel.com with ESMTP; 22 Jul 2011 10:21:07 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Jul 2011 10:20:59 -0700
Message-Id: <cover.1311355172.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/1] Store a data object containing the initial environment v2
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
X-List-Received-Date: Fri, 22 Jul 2011 17:25:17 -0000

Take a copy of the environment in the bitbake entry point and pass it to the
cooker for saving in a data store.

Tested with bitbake and bitbake-layers.

Sanity prevails thanks to diligent code review.

The following changes since commit abc67ed6921c98ed581f101ec1acc589fd9ce7e9:

  bitbake/utils: Add contains helper function from lib.oe.utils (2011-07-22 12:11:01 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake initialenv
  https://github.com/incandescant/bitbake/tree/initialenv

Joshua Lock (1):
  bitbake|cooker: save a copy of the environment when BitBake is
    started

 bin/bitbake      |    5 ++++-
 lib/bb/cooker.py |   10 +++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

-- 
1.7.6



