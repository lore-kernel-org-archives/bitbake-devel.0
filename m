Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QlLgX-0001bS-K8
	for bitbake-devel@lists.openembedded.org;
	Mon, 25 Jul 2011 15:59:07 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 25 Jul 2011 06:54:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,261,1309762800"; d="scan'208";a="34207811"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.255.17.240])
	by fmsmga001.fm.intel.com with ESMTP; 25 Jul 2011 06:54:51 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 25 Jul 2011 14:54:40 +0100
Message-Id: <cover.1311601628.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/3] Some error message improvements
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
X-List-Received-Date: Mon, 25 Jul 2011 13:59:07 -0000

These changes add some more information to unavailable PREFERRED_VERSION
and "nothing PROVIDES" error output for skipped recipes. I also found and
fixed one bug in taskdata.py in the process.

The changes (against poky, apply cleanly against bitbake with -p2) are
available in the git repository at:
  git://git.pokylinux.org/poky-contrib paule/error-messages
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/error-messages

Paul Eggleton (3):
  bitbake: show more information for NoProvider errors
  bitbake/taskdata: fix incorrect usage of rdependees instead of
    dependees
  bitbake/providers: list PREFERRED_VERSION candidates when unavailable

 bitbake/lib/bb/cache.py     |    3 ++-
 bitbake/lib/bb/cooker.py    |    6 ++++--
 bitbake/lib/bb/event.py     |    3 ++-
 bitbake/lib/bb/providers.py |   12 ++++++++++++
 bitbake/lib/bb/taskdata.py  |   28 +++++++++++++++++++++++-----
 bitbake/lib/bb/ui/knotty.py |    3 +++
 6 files changed, 46 insertions(+), 9 deletions(-)

-- 
1.7.4.1



