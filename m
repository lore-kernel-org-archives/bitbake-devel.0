Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SWmtf-0006J8-7x
	for bitbake-devel@lists.openembedded.org;
	Tue, 22 May 2012 13:04:59 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 22 May 2012 03:54:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="146196487"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by azsmga001.ch.intel.com with ESMTP; 22 May 2012 03:54:48 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 22 May 2012 19:33:18 +0800
Message-Id: <cover.1337686256.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/1] Reimplment proxy settings for Hob
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
X-List-Received-Date: Tue, 22 May 2012 11:04:59 -0000

This patch is to reimplement the proxy tab in the advanced settings dialog
according to the new design by the design team to make it more like Gnome style.
Please review and check in. Thanks.

The following changes since commit 2219caa312822cf756b88b07dd70a014404e9cb0:

  tune-mips64.inc: Add new tune file for mips64 big-endian (2012-05-21 09:59:04 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/newproxy
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/newproxy

Shane Wang (1):
  Hob: reimplement the proxy page

 bitbake/lib/bb/ui/crumbs/builder.py         |  143 +++++++++++----
 bitbake/lib/bb/ui/crumbs/hig.py             |  273 ++++++++++++++++++++-------
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    4 -
 3 files changed, 309 insertions(+), 111 deletions(-)

-- 
1.7.6



