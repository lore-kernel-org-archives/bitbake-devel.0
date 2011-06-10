Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dexuan.cui@intel.com>) id 1QUwyE-0003bZ-Rs
	for bitbake-devel@lists.openembedded.org;
	Fri, 10 Jun 2011 10:21:35 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 10 Jun 2011 01:18:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,345,1304319600"; d="scan'208";a="14682864"
Received: from dcui-desktop.sh.intel.com (HELO localhost) ([10.239.13.51])
	by fmsmga002.fm.intel.com with ESMTP; 10 Jun 2011 01:18:13 -0700
From: Dexuan Cui <dexuan.cui@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Jun 2011 16:18:09 +0800
Message-Id: <cover.1307693771.git.dexuan.cui@intel.com>
X-Mailer: git-send-email 1.7.2
Subject: [PATCH 0/1] bitbake-layers: stop the warning 'not been run using the bitbake wrapper...'
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
X-List-Received-Date: Fri, 10 Jun 2011 08:21:35 -0000

Please review the patch.

The following changes since commit 1b53eef2769d1b5e4ff527ccabf9b700afc02220:

  native/nativesdk: Clean up the depends ordering after bitbake override handling updates (2011-06-09 22:49:10 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dcui/bb
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dcui/bb

Dexuan Cui (1):
  bitbake-layers: stop the warning "not been run using the bitbake
    wrapper..."

 bitbake/bin/bitbake-layers |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

-- 
1.7.2



