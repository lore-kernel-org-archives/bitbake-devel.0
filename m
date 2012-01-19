Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dvhart@linux.intel.com>) id 1Rnzy1-0004U4-6o
	for bitbake-devel@lists.openembedded.org;
	Thu, 19 Jan 2012 22:56:21 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 19 Jan 2012 13:47:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="100564186"
Received: from unknown (HELO localhost) ([10.7.199.147])
	by orsmga002.jf.intel.com with ESMTP; 19 Jan 2012 13:47:35 -0800
From: Darren Hart <dvhart@linux.intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
	bitbake-devel@lists.openembedded.org
Date: Thu, 19 Jan 2012 13:46:37 -0800
Message-Id: <cover.1327009447.git.dvhart@linux.intel.com>
X-Mailer: git-send-email 1.7.6.5
Subject: [PATCH 0/1] metadata: Correct "inherit" search to bbclass from oeclass
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
X-List-Received-Date: Thu, 19 Jan 2012 21:56:21 -0000

The following changes since commit 967de59f35acef7fb258524973473f3d154e4a37:

  buildhistory_analysis: include related fields in output (2012-01-19 14:59:23 +0000)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dvhart/bitbake
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dvhart/bitbake

Darren Hart (1):
  metadata: Correct "inherit" search to bbclass from oeclass

 bitbake/doc/manual/usermanual.xml |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
1.7.6.5



