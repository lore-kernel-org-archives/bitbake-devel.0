Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S0JoA-0008OV-QC
	for bitbake-devel@lists.openembedded.org;
	Wed, 22 Feb 2012 22:33:07 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 22 Feb 2012 13:24:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="69228244"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.16])
	by AZSMGA002.ch.intel.com with ESMTP; 22 Feb 2012 13:24:44 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 Feb 2012 21:24:40 +0000
Message-Id: <cover.1329945681.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/1] fix incorrect exit code
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
X-List-Received-Date: Wed, 22 Feb 2012 21:33:07 -0000

Fixes a moderately serious regression caused by my recently merged
Ctrl+C patch.

The patch (against poky, but applies cleanly against bitbake master with
-p2) is available in the git repository at:
  git://git.yoctoproject.org/poky-contrib paule/bitbake-shutdown-fix
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-shutdown-fix

Paul Eggleton (1):
  bitbake/ui/knotty: fix incorrect exit code

 bitbake/lib/bb/ui/knotty.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

-- 
1.7.5.4



