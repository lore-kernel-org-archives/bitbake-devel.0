Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1RoCgd-0003s2-39
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jan 2012 12:31:15 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 20 Jan 2012 03:22:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="97916393"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.2])
	by azsmga001.ch.intel.com with ESMTP; 20 Jan 2012 03:22:27 -0800
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Jan 2012 19:39:02 +0800
Message-Id: <cover.1327059385.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/1] bitbake: add description cache into cache_extra
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
X-List-Received-Date: Fri, 20 Jan 2012 11:31:15 -0000

enable bitbake to cache description into the extra cache file and Hob2 will get its value for core-image-foo.

The following changes since commit 522c6b376d067243bff20c64a1f6f8700be8e586:

  gnutls: Fix configure issue wrt to rm (2012-01-19 11:34:13 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/desc-bitbake-change
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/desc-bitbake-change

Shane Wang (1):
  bitbake: add description cache into cache_extra

 bitbake/lib/bb/cache_extra.py |   13 +++----------
 bitbake/lib/bb/cooker.py      |    2 ++
 2 files changed, 5 insertions(+), 10 deletions(-)

-- 
1.7.6



