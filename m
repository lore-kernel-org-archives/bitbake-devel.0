Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S2NNc-0000SB-DG
	for bitbake-devel@lists.openembedded.org;
	Tue, 28 Feb 2012 14:46:12 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 28 Feb 2012 05:37:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="130368925"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.68])
	by fmsmga002.fm.intel.com with ESMTP; 28 Feb 2012 05:37:43 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Feb 2012 13:37:40 +0000
Message-Id: <cover.1330435914.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/1] Allow set +x for shell functions to be configured v2
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
X-List-Received-Date: Tue, 28 Feb 2012 13:46:12 -0000

A patch to allow the addition of "set +x" to be controlled via
configuration.

Since v1, move the set +x call after emit_func() so that we only log
the commands executed rather than all of the definitions as well.

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



