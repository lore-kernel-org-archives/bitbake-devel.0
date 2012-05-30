Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SZlkL-00054z-BE
	for bitbake-devel@lists.openembedded.org;
	Wed, 30 May 2012 18:27:41 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 30 May 2012 09:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="105914729"
Received: from unknown (HELO helios.amr.corp.intel.com) ([10.255.12.128])
	by AZSMGA002.ch.intel.com with ESMTP; 30 May 2012 09:17:20 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 30 May 2012 17:17:13 +0100
Message-Id: <cover.1338394341.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 0/5] Checksum / error reporting improvements
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
X-List-Received-Date: Wed, 30 May 2012 16:27:41 -0000

Some checksum improvements and a few error reporting fixes that I made
in the process. Note that the varflags change won't do anything without
the list of exclusions; an appropriate list has been set in a patch
which will shortly be set to the OE-Core list.


The following changes (against Poky, but which apply cleanly with -p2
against BitBake master) are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-checksum-fixes-2
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-checksum-fixes-2

Paul Eggleton (5):
  lib/bb/data_smart.py: don't report variable in ExpansionError if not
    set
  cooker: fix UnboundLocalError when exception occurs during parsing
  cooker: report recipe being parsed when ExpansionError occurs
  lib/bb/fetch2: ignore remote URIs when doing file checksums
  bitbake: include varflags in checksums

 bitbake/lib/bb/cooker.py          |    8 +++++++-
 bitbake/lib/bb/data.py            |   20 +++++++++++++++++++-
 bitbake/lib/bb/data_smart.py      |    5 ++++-
 bitbake/lib/bb/fetch2/__init__.py |   26 ++++++++++++++++++++------
 bitbake/lib/bb/siggen.py          |    4 ++++
 5 files changed, 54 insertions(+), 9 deletions(-)

-- 
1.7.9.5



