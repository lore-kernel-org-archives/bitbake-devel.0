Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1QkIeU-0007hj-Bq
	for bitbake-devel@lists.openembedded.org;
	Fri, 22 Jul 2011 18:32:38 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 22 Jul 2011 09:27:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,248,1309762800"; d="scan'208";a="30389111"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.51])
	by azsmga001.ch.intel.com with ESMTP; 22 Jul 2011 09:27:17 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Jul 2011 09:27:10 -0700
Message-Id: <cover.1311351396.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/1] Store a data object containing the initial environment
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
X-List-Received-Date: Fri, 22 Jul 2011 16:32:38 -0000

As discussed, take a copy of the environment in the bitbake entry point and
pass it to the cooker for saving in a data store.

Tested with bitbake and bitbake-layers.

The following changes since commit abc67ed6921c98ed581f101ec1acc589fd9ce7e9:

  bitbake/utils: Add contains helper function from lib.oe.utils (2011-07-22 12:11:01 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake initialenv
  https://github.com/incandescant/bitbake/tree/initialenv

Joshua Lock (1):
  bitbake|cooker: save a copy of the environment when BitBake is
    started

 bin/bitbake      |    5 ++++-
 lib/bb/cooker.py |   11 ++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
1.7.6



