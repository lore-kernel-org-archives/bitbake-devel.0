Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S21Mh-0002VB-Qq
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Feb 2012 15:15:48 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 27 Feb 2012 06:07:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="115262237"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.123.30])
	by orsmga002.jf.intel.com with ESMTP; 27 Feb 2012 06:06:20 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Feb 2012 14:06:17 +0000
Message-Id: <cover.1330351287.git.paul.eggleton@linux.intel.com>
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
X-List-Received-Date: Mon, 27 Feb 2012 14:15:48 -0000

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
 bitbake/lib/bb/msg.py    |    5 ++++-
 3 files changed, 10 insertions(+), 2 deletions(-)

-- 
1.7.5.4



