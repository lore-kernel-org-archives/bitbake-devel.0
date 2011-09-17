Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1R4sli-0008GP-Eg
	for bitbake-devel@lists.openembedded.org;
	Sat, 17 Sep 2011 13:09:10 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 17 Sep 2011 04:03:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,398,1312182000"; d="scan'208";a="54766889"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.34])
	by fmsmga002.fm.intel.com with ESMTP; 17 Sep 2011 04:03:52 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 17 Sep 2011 12:03:46 +0100
Message-Id: <cover.1316257305.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/1] Fix git fetcher subpath option v2
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
X-List-Received-Date: Sat, 17 Sep 2011 11:09:10 -0000

This patch makes the git fetcher (fetch2) subpath option work the way
the Opie git recipes (the main user of the option) expect.

Since v1, handle subpath with depth > 1 correctly.

The patch (against poky, but applies cleanly to bitbake master with
 -p2) is available at:
  git://git.pokylinux.org/poky-contrib paule/subpath
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/subpath

Paul Eggleton (1):
  fetch2/git: fix subpath destination directory

 bitbake/lib/bb/fetch2/git.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

-- 
1.7.4.1



