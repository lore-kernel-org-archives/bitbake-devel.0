Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S108j-00085F-6W
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Feb 2012 19:45:09 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 24 Feb 2012 10:36:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="70019967"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.71])
	by AZSMGA002.ch.intel.com with ESMTP; 24 Feb 2012 10:36:44 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Feb 2012 18:36:41 +0000
Message-Id: <cover.1330108168.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/1] terminate when errors found in layer configuration
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
X-List-Received-Date: Fri, 24 Feb 2012 18:45:09 -0000

A single patch to ensure we stop parsing when errors are found in
the layer configuration.
 
The patch (against poky, but applies cleanly with -p2 against bitbake
master)  is available in the git repository at:
  git://git.yoctoproject.org/poky-contrib paule/bitbake-errors3
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-errors3

Paul Eggleton (1):
  bitbake/cooker: terminate when errors found in layer configuration

 bitbake/lib/bb/cooker.py |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

-- 
1.7.5.4



