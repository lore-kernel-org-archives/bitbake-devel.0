Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SALFI-0003SV-5b
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Mar 2012 14:06:32 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 21 Mar 2012 05:57:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="123374935"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by orsmga002.jf.intel.com with ESMTP; 21 Mar 2012 05:57:28 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 21 Mar 2012 20:55:04 +0800
Message-Id: <cover.1332334068.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 00/17][PULL] Hob: Bunch of bug fixes
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
X-List-Received-Date: Wed, 21 Mar 2012 13:06:32 -0000

Hi Richard,

This pull request is Hob related bug fixes. Please help to review and pull.

Thanks,
Dongxiao

The following changes since commit d595960fea0988df9004d927bc2ec3439540dd9c:

  Hob: save CONF_VERSION and LCONF_VERSION into template (2012-03-20 14:39:45 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (14):
  Hob: Still use initcmd != None as the if judgement
  Hob: Remove split model in GTK Hob
  cooker: terminate each process when quitting recipe parsing
  Hob: change package classes selection GUI
  Hob: Change template button name from "Template" to "Templates"
  command.py: Change parseConfigurationFiles API from async to sync
  process.py: Increase the timeout value for polling commands
  Hob: Change parseConfigurationFiles API usage
  Hob: Fix the workaround to get image types
  Hob: Change recipe selection tab order
  Hob: Change package selection tab order
  Hob: Move "Create your own image" to the bottom of image list
  cooker: add inherit information when generating package tree
  Hob: Use inherit information to judge if a recipe is image type

Shane Wang (3):
  Hob: Change window title from HOB to Hob
  Hob: Change "View Packages" description
  Hob: Change the titles for recipe view and package view

 lib/bb/command.py                          |   17 +-
 lib/bb/cooker.py                           |    3 +
 lib/bb/server/process.py                   |    2 +-
 lib/bb/ui/crumbs/builder.py                |   15 +--
 lib/bb/ui/crumbs/hig.py                    |  284 ++++++++--------------------
 lib/bb/ui/crumbs/hobeventhandler.py        |   48 ++---
 lib/bb/ui/crumbs/hoblistmodel.py           |   11 +-
 lib/bb/ui/crumbs/imageconfigurationpage.py |   13 +-
 lib/bb/ui/crumbs/packageselectionpage.py   |   42 ++--
 lib/bb/ui/crumbs/recipeselectionpage.py    |   50 +++---
 lib/bb/ui/hob.py                           |   14 +-
 11 files changed, 177 insertions(+), 322 deletions(-)

-- 
1.7.4.1



