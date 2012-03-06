Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S545I-0003YO-7O
	for bitbake-devel@lists.openembedded.org;
	Wed, 07 Mar 2012 00:46:24 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 06 Mar 2012 15:37:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="118399651"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.109])
	by orsmga002.jf.intel.com with ESMTP; 06 Mar 2012 15:37:44 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Mar 2012 23:37:34 +0000
Message-Id: <cover.1331076902.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/1] bitbake error fix
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
X-List-Received-Date: Tue, 06 Mar 2012 23:46:24 -0000

A patch to report recipes that cause errors during finalise().

The patch (against Poky, but applies cleanly with -p2 against bitbake
master) is available in the git repository at:
  git://git.yoctoproject.org/poky-contrib paule/bitbake-errors5
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-errors5

Paul Eggleton (1):
  bitbake/siggen: output filename on error in finalise

 bitbake/lib/bb/siggen.py |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

-- 
1.7.5.4



