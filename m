Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SWyaH-0005N9-El
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 01:33:45 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 22 May 2012 16:23:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="103080364"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.180])
	by AZSMGA002.ch.intel.com with ESMTP; 22 May 2012 16:23:34 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 May 2012 00:23:30 +0100
Message-Id: <cover.1337728949.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 0/2] Implement file checksums
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
X-List-Received-Date: Tue, 22 May 2012 23:33:45 -0000

This is 2/3 of the changes required to implement local file checksums;
the other third is a patch to base.bbclass which will be sent to the
OE-Core list.


The following changes (against Poky, but apply cleanly against BitBake
master with -p2) are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/file-checksum-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/file-checksum-bb

Paul Eggleton (2):
  bitbake: refactor out codeparser cache into a separate class
  bitbake: implement checksums for local files in SRC_URI

 bitbake/lib/bb/cache.py           |  129 ++++++++++++++++++++++++-
 bitbake/lib/bb/checksum.py        |   90 +++++++++++++++++
 bitbake/lib/bb/codeparser.py      |  191 +++++++++++--------------------------
 bitbake/lib/bb/cooker.py          |    2 +
 bitbake/lib/bb/fetch2/__init__.py |   85 +++++++++++++++++
 bitbake/lib/bb/siggen.py          |   24 +++++
 6 files changed, 382 insertions(+), 139 deletions(-)
 create mode 100644 bitbake/lib/bb/checksum.py

-- 
1.7.9.5



