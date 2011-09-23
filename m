Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1R75B6-0006DY-E9
	for bitbake-devel@lists.openembedded.org;
	Fri, 23 Sep 2011 14:48:28 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 23 Sep 2011 05:43:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.68,430,1312182000"; d="scan'208";a="19954424"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.136])
	by AZSMGA002.ch.intel.com with ESMTP; 23 Sep 2011 05:43:05 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 Sep 2011 13:43:01 +0100
Message-Id: <cover.1316781566.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/1] bitbake: fix -D and -v options
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
X-List-Received-Date: Fri, 23 Sep 2011 12:48:28 -0000

A single patch to fix a regression in setting the debug/verbosity levels
(-D and -v command line options).

The patch (against Poky, but applies cleanly against bitbake master with 
-p2) is available in the git repository at:
  git://git.pokylinux.org/poky-contrib paule/bb-debug
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/bb-debug

Paul Eggleton (1):
  bitbake/lib/bb/msg.py: fix setting debug and verbosity levels

 bitbake/lib/bb/msg.py |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

-- 
1.7.4.1



