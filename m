Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TEjB2-0003ue-Ci
	for bitbake-devel@lists.openembedded.org;
	Thu, 20 Sep 2012 18:00:32 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 20 Sep 2012 08:47:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,454,1344236400"; d="scan'208";a="195074983"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.248])
	by azsmga001.ch.intel.com with ESMTP; 20 Sep 2012 08:47:44 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Sep 2012 16:47:36 +0100
Message-Id: <cover.1348155869.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 0/2] A couple more Hob fixes
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
X-List-Received-Date: Thu, 20 Sep 2012 16:00:32 -0000

The following changes (against Poky, but apply cleanly with -p2 against
bitbake master) are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/hob-fixes-2
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/hob-fixes-2

Paul Eggleton (2):
  hob: remove confirmation dialog on close
  hob: allow configuring default machine using HOB_MACHINE

 bitbake/lib/bb/ui/crumbs/builder.py |   17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

-- 
1.7.9.5



