Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QZNYF-0000KN-Fr
	for bitbake-devel@lists.openembedded.org;
	Wed, 22 Jun 2011 15:33:03 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 22 Jun 2011 06:28:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,406,1304319600"; d="scan'208";a="16815072"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.16])
	by azsmga001.ch.intel.com with ESMTP; 22 Jun 2011 06:28:22 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 22 Jun 2011 14:28:15 +0100
Message-Id: <cover.1308749155.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [RFC PATCH 0/3] Layer tooling improvements
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
X-List-Received-Date: Wed, 22 Jun 2011 13:33:03 -0000

The following patches add dependencies between layers, and add the ability
to query "overlayed" recipes. The latter functionality will hopefully be
utilised by future changes for "flattening" multi-layer setups also. Please
review.

The changes are available (against Poky, but apply cleanly against bitbake
master with -p2) at:
  git://git.pokylinux.org/poky-contrib paule/layertooling-1
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/layertooling-1

Paul Eggleton (3):
  bitbake: track 'overlayed' recipes
  bitbake-layers: add show_overlayed action
  bitbake/cooker: implement layer dependencies, make priority optional

 bitbake/bin/bitbake-layers |   10 +++++
 bitbake/lib/bb/cooker.py   |   92 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 93 insertions(+), 9 deletions(-)

-- 
1.7.4.1



