Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1R78KY-0001sZ-2o
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Sep 2011 18:10:26 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 23 Sep 2011 09:05:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,431,1312182000"; d="scan'208";a="66634526"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.136])
	by fmsmga001.fm.intel.com with ESMTP; 23 Sep 2011 09:05:02 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Sep 2011 17:04:59 +0100
Message-Id: <cover.1316793495.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/1] bitbake: fix -D and -v options v2
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
X-List-Received-Date: Fri, 23 Sep 2011 16:10:26 -0000

A single patch to fix a regression in setting the debug/verbosity levels
(-D and -v command line options).

Since v1, fix some references to the loggerVerbose variable in build.py.

The patch (against Poky, but applies cleanly against bitbake master with 
-p2) is available in the git repository at: 
  git://git.pokylinux.org/poky-contrib paule/bb-debug
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/bb-debug

Paul Eggleton (1):
  bitbake/lib/bb/msg.py: fix setting debug and verbosity levels

 bitbake/lib/bb/build.py |    4 ++--
 bitbake/lib/bb/msg.py   |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
1.7.4.1



