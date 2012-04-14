Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SJ7rD-0008V4-Te
	for bitbake-devel@lists.openembedded.org;
	Sat, 14 Apr 2012 20:38:00 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 14 Apr 2012 11:28:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="130934694"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 14 Apr 2012 11:28:35 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 15 Apr 2012 02:58:53 +0800
Message-Id: <cover.1334429179.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/2] Hob fixes
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
X-List-Received-Date: Sat, 14 Apr 2012 18:38:00 -0000

The fixes include:
 - remember settings and layers between Hob sessions.
 - continue to fix another case to forget user selection when settings are changed.

The following changes since commit 276b86509ba29046828d283f15ae44ae0850d1d0:

  Hob: Use BB_DEFAULT_TASK as build task instead of hardcoded "build" (2012-04-14 14:43:24 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/hob_0413
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob_0413

Shane Wang (2):
  Hob: remember layers and settings between Hob sessions
  Hob: reset user recipe selection and package selection after settings
    are changed

 bitbake/lib/bb/ui/crumbs/builddetailspage.py       |   16 +-
 bitbake/lib/bb/ui/crumbs/builder.py                |  170 ++++++++++++-------
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |    1 -
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    4 +-
 bitbake/lib/bb/ui/crumbs/template.py               |   24 +++-
 5 files changed, 136 insertions(+), 79 deletions(-)

-- 
1.7.6



