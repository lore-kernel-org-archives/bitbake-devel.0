Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QRSwW-0005Ww-QW
	for bitbake-devel@lists.openembedded.org;
	Tue, 31 May 2011 19:41:25 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 31 May 2011 10:37:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,298,1304319600"; 
   d="scan'208";a="7348998"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.13.104])
	by orsmga001.jf.intel.com with ESMTP; 31 May 2011 10:36:39 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 31 May 2011 18:36:28 +0100
Message-Id: <cover.1306863360.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/1] bitbake: use layer priority when applying bbappends
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
X-List-Received-Date: Tue, 31 May 2011 17:41:25 -0000

The following changes since commit 52295fa3deef3b0374b99829626d524cefae6001:

  Improve handling of 'all' architecture recipes and their interaction with sstate (2011-05-31 13:07:00 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib paule/bbfile-sort
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=paule/bbfile-sort

Paul Eggleton (1):
  bitbake: use layer priority when applying bbappends

 bitbake/lib/bb/cooker.py |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

-- 
1.7.4.1



