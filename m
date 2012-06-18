Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SgeKv-0000gd-IR
	for bitbake-devel@lists.openembedded.org;
	Mon, 18 Jun 2012 17:57:53 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 18 Jun 2012 08:45:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="167049108"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.122])
	by fmsmga001.fm.intel.com with ESMTP; 18 Jun 2012 08:45:43 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 Jun 2012 16:45:34 +0100
Message-Id: <cover.1340034255.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 0/2] Signature-based rebuild improvements
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
X-List-Received-Date: Mon, 18 Jun 2012 15:57:53 -0000

The following changes (against poky, but apply cleanly with -p2 against
bitbake master) are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-forcebuild
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-forcebuild

Paul Eggleton (2):
  bitbake: ensure -f causes dependent tasks to be re-run
  bitbake: add -C option to invalidate a task and rebuild the target

 bitbake/bin/bitbake        |    3 +++
 bitbake/lib/bb/build.py    |   18 ++++++++++++++++++
 bitbake/lib/bb/cooker.py   |    6 +++---
 bitbake/lib/bb/runqueue.py |   28 ++++++++++++++++++++++------
 bitbake/lib/bb/siggen.py   |   35 +++++++++++++++++++++++++++++++++++
 5 files changed, 81 insertions(+), 9 deletions(-)

-- 
1.7.9.5



