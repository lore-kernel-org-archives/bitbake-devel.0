Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SJK31-0002Nd-NN
	for bitbake-devel@lists.openembedded.org;
	Sun, 15 Apr 2012 09:39:01 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 15 Apr 2012 00:29:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="141868402"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 15 Apr 2012 00:29:31 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 15 Apr 2012 15:26:36 +0800
Message-Id: <cover.1334474635.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/2 v2][PULL] Hob: Fix bug 2249
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
X-List-Received-Date: Sun, 15 Apr 2012 07:39:01 -0000

Hi Richard,

This is the second pull request that fixes bug 2249.
Besides, this adds another commit to simplify the Hob init process.

Please help to review and pull.

Changes from v1:
1) Add a new commit to simplify the Hob init process.

Thanks,
Dongxiao


The following changes since commit 95f4e9dc351f67442844ff52f90fc154fa95ba95:

  Hob: reset user recipe selection and package selection after settings are changed (2012-04-14 23:48:36 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (2):
  Hob: Handle NoProvider event in runningbuild module
  Hob: Simplify the init process

 lib/bb/ui/crumbs/builder.py         |   31 +++++++++++++++++--------------
 lib/bb/ui/crumbs/hobeventhandler.py |   32 ++------------------------------
 lib/bb/ui/crumbs/runningbuild.py    |   17 +++++++++++++++++
 3 files changed, 36 insertions(+), 44 deletions(-)

-- 
1.7.4.1



