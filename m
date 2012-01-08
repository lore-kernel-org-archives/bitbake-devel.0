Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1Rjrdn-0005Vf-1o
	for bitbake-devel@lists.openembedded.org;
	Sun, 08 Jan 2012 13:14:23 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 08 Jan 2012 04:06:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="95755838"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.80])
	by orsmga002.jf.intel.com with ESMTP; 08 Jan 2012 04:06:54 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sun,  8 Jan 2012 12:06:48 +0000
Message-Id: <cover.1326023910.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/3] bitbake-layers: flatten improvements
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
X-List-Received-Date: Sun, 08 Jan 2012 12:14:23 -0000

A few patches improving the "flatten" subcommand in bitbake-layers,
prompted by Yocto bug #1654, to allow only flattening some of the
configured layers as well as warn when recipes/bbappends are outside
the new flattened layer's paths. I'm hoping to be able to improve it
further in future to be able to automatically put files in the
correct place but this will have to wait until the next development
cycle.

The patches (against Poky, but which apply cleanly against bitbake
master with -p2) are available in the git repository at:
  git://git.yoctoproject.org/poky-contrib paule/bitbake-layers-fix4
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-layers-fix4

Paul Eggleton (3):
  bitbake-layers: flatten: allow specifying layers to flatten
  bitbake-layers: flatten: warn the user if output structure is
    incorrect
  bitbake-layers: close files in apply_append()

 bitbake/bin/bitbake-layers |  115 ++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 107 insertions(+), 8 deletions(-)

-- 
1.7.5.4



