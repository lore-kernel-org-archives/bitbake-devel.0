Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1RZvys-0002dr-9O
	for bitbake-devel@lists.openembedded.org;
	Mon, 12 Dec 2011 03:51:06 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 11 Dec 2011 18:43:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="84619654"
Received: from dongxiao-desktop.sh.intel.com (HELO localhost) ([10.239.36.46])
	by azsmga001.ch.intel.com with ESMTP; 11 Dec 2011 18:43:06 -0800
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 12 Dec 2011 10:20:19 +0800
Message-Id: <cover.1323656120.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PATCH 00/10][PULL] Hob2 related bitbake changes
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
X-List-Received-Date: Mon, 12 Dec 2011 02:51:06 -0000

Hi Richard,

This pull request introduces several hob2 related bitbake changes.
Please help to review and pull.

Thanks,
Dongxiao

The following changes since commit 71b53a3f0766ca464560a1f6a449f9424fbdf7ae:
  Matthew McClintock (1):
        siggen.py: If both sigs have a variable in it's whitelist then don't say it's changed

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib dxu4/hob2-bitbake-change
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob2-bitbake-change

Dongxiao Xu (10):
  command.py: Modify needcache value for certain functions
  cache: Use configuration's hash value to validate cache
  cooker: user bb.configuration.data to inject events
  command.py: add initCooker API
  command.py: add parseConfigurationFiles API
  command.py: add generateTargetsTreePro API
  event.py: Add a new event PackageInfo
  xmlrpc: Change BitbakeServerInfo init function
  cooker: remove command import in cooker.py
  bitbake: add a new option "--server-only"

 bin/bitbake             |   23 ++++++---
 lib/bb/cache.py         |   32 +++++--------
 lib/bb/command.py       |   34 ++++++++++++-
 lib/bb/cooker.py        |  123 +++++++++++++++++++++++++++++++++++++++++++++--
 lib/bb/data_smart.py    |   17 +++++++
 lib/bb/event.py         |    9 ++++
 lib/bb/server/xmlrpc.py |    8 ++--
 7 files changed, 208 insertions(+), 38 deletions(-)



