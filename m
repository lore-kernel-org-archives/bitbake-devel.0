Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1Rspeg-0002rV-EN
	for bitbake-devel@lists.openembedded.org;
	Thu, 02 Feb 2012 06:56:22 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 01 Feb 2012 21:48:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="102974704"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.2])
	by orsmga001.jf.intel.com with ESMTP; 01 Feb 2012 21:48:12 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  2 Feb 2012 14:05:26 +0800
Message-Id: <cover.1328162622.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/1][V2] bitbake: add description cache into cache_extra
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
X-List-Received-Date: Thu, 02 Feb 2012 05:56:22 -0000

Enable bitbake to cache description into the extra cache file and Hob2 will get its value for core-image-foo.

The following changes since commit 8d4d9a15c4947e55ed217c6035e76fcff724e544:

  package bbclass: allow per package PRIVATE_LIBS (2012-02-01 15:15:15 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/desc-bitbake-change
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/desc-bitbake-change

Shane Wang (1):
  [V2] bitbake: add description cache into cache_extra

 bitbake/lib/bb/cache.py       |    9 ---------
 bitbake/lib/bb/cache_extra.py |    3 +++
 bitbake/lib/bb/cooker.py      |    2 ++
 3 files changed, 5 insertions(+), 9 deletions(-)

-- 
1.7.6



