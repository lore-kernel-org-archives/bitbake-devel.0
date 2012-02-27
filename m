Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S21R9-0002ad-40
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Feb 2012 15:20:23 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 27 Feb 2012 06:11:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="112237820"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.30])
	by orsmga001.jf.intel.com with ESMTP; 27 Feb 2012 06:11:55 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Feb 2012 14:11:52 +0000
Message-Id: <cover.1330351817.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/1] Allow set +x for shell functions to be configured
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
X-List-Received-Date: Mon, 27 Feb 2012 14:20:23 -0000

A patch to allow the addition of "set +x" to be controlled via
configuration.

The patch (against Poky, but applies cleanly with -p2 against bitbake
master) is available in the git repository at:
  git://git.yoctoproject.org/poky-contrib paule/bbverboselogs
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bbverboselogs

Paul Eggleton (1):
  bitbake: implement BB_VERBOSE_LOGS

 bitbake/lib/bb/build.py  |    3 ++-
 bitbake/lib/bb/cooker.py |    4 ++++
 bitbake/lib/bb/msg.py    |    3 +++
 3 files changed, 9 insertions(+), 1 deletions(-)

-- 
1.7.5.4



