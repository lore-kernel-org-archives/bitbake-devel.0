Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1S8Szz-0005pz-PV
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Mar 2012 09:59:00 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 16 Mar 2012 01:50:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="78286425"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by AZSMGA002.ch.intel.com with ESMTP; 16 Mar 2012 01:50:10 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Mar 2012 16:48:10 +0800
Message-Id: <cover.1331887394.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/3][PULL] Hob: Bug fix
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
X-List-Received-Date: Fri, 16 Mar 2012 08:59:00 -0000

Hi Richard,

This pull request fixes some bugs related with new Hob, please help to review and pull.

Thanks,
Dongxiao

The following changes since commit a17473d51f54a9dfb4eeaa5ad516c4851d5ac142:

  bitbake/fetch: Fix uri_replace (2012-03-15 22:51:20 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix-bitbake
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix-bitbake

Dongxiao Xu (3):
  Hob: reset the selection if switch to a new base image
  Hob: Fix advanced setting reparse mechanism
  Hob: save CONF_VERSION and LCONF_VERSION into template

 lib/bb/ui/crumbs/builder.py         |    6 ++++++
 lib/bb/ui/crumbs/hig.py             |    2 ++
 lib/bb/ui/crumbs/hobeventhandler.py |    3 +++
 lib/bb/ui/crumbs/hoblistmodel.py    |    1 +
 lib/bb/ui/crumbs/template.py        |   10 +++++-----
 5 files changed, 17 insertions(+), 5 deletions(-)

-- 
1.7.4.1



