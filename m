Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TA0ag-0001en-LP
	for bitbake-devel@lists.openembedded.org;
	Fri, 07 Sep 2012 17:35:30 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 07 Sep 2012 08:23:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,387,1344236400"; d="scan'208";a="142631243"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.175])
	by AZSMGA002.ch.intel.com with ESMTP; 07 Sep 2012 08:22:59 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  7 Sep 2012 16:22:52 +0100
Message-Id: <cover.1347031196.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 0/2] Exception handling fixes
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
X-List-Received-Date: Fri, 07 Sep 2012 15:35:30 -0000

The following changes (against Poky, but apply cleanly with -p2 against
bitbake master) are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-brokenexcept
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-brokenexcept

Paul Eggleton (2):
  fetch2: fix malformed URL causing a useless traceback
  cooker: fix handling of exceptions during exception handling

 bitbake/lib/bb/cooker.py          |    9 +++++++--
 bitbake/lib/bb/fetch2/__init__.py |    4 ++--
 2 files changed, 9 insertions(+), 4 deletions(-)

-- 
1.7.9.5



