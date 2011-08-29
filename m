Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1QxwPC-00019s-1b
	for bitbake-devel@lists.openembedded.org;
	Mon, 29 Aug 2011 09:37:14 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 29 Aug 2011 00:31:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="43176192"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.52])
	by orsmga001.jf.intel.com with ESMTP; 29 Aug 2011 00:31:15 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Aug 2011 15:33:57 +0800
Message-Id: <cover.1314603042.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.1
Subject: [PATCH 0/1][PULL] bitbake: parsing time improvement
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
X-List-Received-Date: Mon, 29 Aug 2011 07:37:14 -0000

Hi Richard,

This pull request is to improve parsing time by getting use of the
expand cache, please help to review and pull.

Thanks,
Dongxiao

The following changes since commit 0423587db09f6f28cf9d801f5657a84157f42dbe:

  hob: disable some menu entries whilst build is in progress (2011-08-24 19:32:42 -0700)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/parse
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/parse

Dongxiao Xu (1):
  data_smart.py: make use of expand cache in getVar()

 lib/bb/data_smart.py |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)



