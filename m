Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1QRiUd-0008Nq-TG
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Jun 2011 12:17:59 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 01 Jun 2011 03:09:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,302,1304319600"; 
   d="scan'208";a="5112939"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.13.133])
	by azsmga001.ch.intel.com with ESMTP; 01 Jun 2011 03:09:35 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  1 Jun 2011 11:09:33 +0100
Message-Id: <cover.1306922503.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/1] bitbake: use layer priority when applying bbappends v2
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
X-List-Received-Date: Wed, 01 Jun 2011 10:17:59 -0000

Since v1, fixed missing "self." on one reference to calc_bbfile_priorities.

---------

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



