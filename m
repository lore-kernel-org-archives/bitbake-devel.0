Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Qbzhd-0000gm-Ll
	for bitbake-devel@lists.openembedded.org;
	Wed, 29 Jun 2011 20:41:33 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 29 Jun 2011 11:37:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,444,1304319600"; d="scan'208";a="24396400"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.126])
	by fmsmga001.fm.intel.com with ESMTP; 29 Jun 2011 11:37:43 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Jun 2011 19:37:36 +0100
Message-Id: <cover.1309372176.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [RFC PATCH 0/5] Layer tooling improvements v2
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
X-List-Received-Date: Wed, 29 Jun 2011 18:41:33 -0000

The following patches add dependencies between layers, and add the ability
to query "overlayed" recipes.

Since v1, two more patches were added: the first to add the ability to
flatten multi-layer configurations into a single layer, and the second is
a fix for the way that bitbake-layers' show_appends action sorts its
output. The other patches are unchanged aside from renaming "overlayedlist"
to "overlayed" within the first two patches.

The changes are available (against Poky, but apply cleanly against bitbake
master with -p2) at:
  git://git.pokylinux.org/poky-contrib paule/layertooling-2
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/layertooling-2

Paul Eggleton (5):
  bitbake: track 'overlayed' recipes
  bitbake-layers: add show_overlayed action
  bitbake/cooker: implement layer dependencies, make priority optional
  bitbake-layers: add command to flatten layers into one
  bitbake-layers: fix sorting of show_appends output

 bitbake/bin/bitbake-layers |   79 +++++++++++++++++++++++++++++++++++--
 bitbake/lib/bb/cooker.py   |   92 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 158 insertions(+), 13 deletions(-)

-- 
1.7.4.1



