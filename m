Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SJF8W-0007Ar-Az
	for bitbake-devel@lists.openembedded.org;
	Sun, 15 Apr 2012 04:24:20 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 14 Apr 2012 19:14:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="89143489"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 14 Apr 2012 19:14:55 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun, 15 Apr 2012 10:12:00 +0800
Message-Id: <cover.1334455811.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/1][PULL] Hob: Fix bug 2249
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
X-List-Received-Date: Sun, 15 Apr 2012 02:24:20 -0000

Hi Richard,

This pull request is to fix bug 2249, please help to review and pull.

Thanks,
Dongxiao

The following changes since commit 95f4e9dc351f67442844ff52f90fc154fa95ba95:

  Hob: reset user recipe selection and package selection after settings are changed (2012-04-14 23:48:36 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (1):
  Hob: Handle NoProvider event in runningbuild module

 lib/bb/ui/crumbs/builder.py         |   18 ++++++++++++++----
 lib/bb/ui/crumbs/hobeventhandler.py |   21 ---------------------
 lib/bb/ui/crumbs/runningbuild.py    |   17 +++++++++++++++++
 3 files changed, 31 insertions(+), 25 deletions(-)

-- 
1.7.4.1



