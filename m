Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1Qqb2U-0003xC-BA
	for bitbake-devel@lists.openembedded.org;
	Tue, 09 Aug 2011 03:23:26 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 08 Aug 2011 18:18:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,340,1309762800"; d="scan'208";a="36498547"
Received: from unknown (HELO scimitar.amr.corp.intel.com) ([10.255.14.247])
	by azsmga001.ch.intel.com with ESMTP; 08 Aug 2011 18:18:39 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  8 Aug 2011 18:18:27 -0700
Message-Id: <cover.1312852599.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/4] Bug fixes for hob
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
X-List-Received-Date: Tue, 09 Aug 2011 01:23:26 -0000

Hi,

Here are some more bug fixes (and more on the way).

Thanks,
Joshua

The following changes since commit 5cacdc4f1641eda1b5707c96f7c40924a9db6174:

  bb/cooker: mark parsed conf files as potential cache invalidators (2011-08-04 15:40:51 -0700)

are available in the git repository at:
  git://github.com/incandescant/bitbake hob
  https://github.com/incandescant/bitbake/tree/hob

Jessica Zhang (1):
  bb/ui/hob: Restore toolchain relevant preference settings for build

Joshua Lock (3):
  bb/ui/crumbs/tasklistmodel: prevent hang when removing item
  bb/ui/hob: move some code around to avert a race
  bb/cooker: only emit ConfigFilePathFound for files which were parsed

 lib/bb/cooker.py                  |   32 ++++++++++++++++++++++++++++++--
 lib/bb/ui/crumbs/tasklistmodel.py |    4 +++-
 lib/bb/ui/hob.py                  |   17 ++++++++++-------
 3 files changed, 43 insertions(+), 10 deletions(-)

-- 
1.7.6



