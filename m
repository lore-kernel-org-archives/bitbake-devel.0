Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SAjpf-0003Kk-2R
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Mar 2012 16:21:43 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 22 Mar 2012 08:12:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="143280830"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 22 Mar 2012 08:12:46 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 22 Mar 2012 23:37:58 +0800
Message-Id: <cover.1332430442.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/8] More fixes for Hob
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
X-List-Received-Date: Thu, 22 Mar 2012 15:21:43 -0000

These patches are to:
  - change parse_config API from async to sync for image types and remembering layers
  - fix the image types
  - add proxy support
  - remember settings and layers between Hob runs with template
  - fix two UI bugs in the build log screen
  - extend the timeout for piping.
  - etc.

The following changes since commit 8dda137c12d284304a5b3e6693732b00f2b5553f:

  Hob: Revert interfaces of callbacks for layer_button, view_recipes_button, and view_packages_button. (2012-03-22 14:43:51 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/hob-fixes-continue
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob-fixes-continue

Dongxiao Xu (4):
  command.py: Change parseConfigurationFiles API from async to sync
  process.py: Increase the timeout value for polling commands
  Hob: Change parseConfigurationFiles API usage
  Hob: Fix the workaround to get image types

Liming An (2):
  Hob: reset the policy to forbid the horizontal scrolling for building
    log
  Hob: add auto scroll to rows which be new appended in hob building
    log page

Shane Wang (2):
  Hob: allow users to setup the proxies
  Hob: remember the settings between Hob sessions

 bitbake/lib/bb/command.py                    |   17 ++--
 bitbake/lib/bb/server/process.py             |    2 +-
 bitbake/lib/bb/ui/crumbs/builddetailspage.py |   17 +++-
 bitbake/lib/bb/ui/crumbs/builder.py          |  139 +++++++++++++++++++++++--
 bitbake/lib/bb/ui/crumbs/hig.py              |   94 +++++++++++++++--
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py  |   28 ++++--
 bitbake/lib/bb/ui/crumbs/hobwidget.py        |   24 +++++
 bitbake/lib/bb/ui/crumbs/runningbuild.py     |    7 +-
 bitbake/lib/bb/ui/crumbs/template.py         |   55 +++++++---
 bitbake/lib/bb/ui/hob.py                     |    3 +-
 10 files changed, 319 insertions(+), 67 deletions(-)

-- 
1.7.6



