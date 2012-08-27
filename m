Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1T66Mm-0000sM-Eh
	for bitbake-devel@lists.openembedded.org;
	Mon, 27 Aug 2012 22:57:00 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 27 Aug 2012 13:44:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,322,1344236400"; d="scan'208";a="191985297"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.136])
	by orsmga002.jf.intel.com with ESMTP; 27 Aug 2012 13:44:46 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 27 Aug 2012 21:44:30 +0100
Message-Id: <cover.1346099795.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 0/5] Refactoring + improve bitbake-diffsigs
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
X-List-Received-Date: Mon, 27 Aug 2012 20:57:00 -0000

Refactor out a class which can be used as the basis for bitbake-based
utilities, and use it to improve bitbake-diffsigs to enable easily
specifying a recipe and task and determine what the difference was in
the signature data between the last two executions.

This change requires some support code within the metadata (since
BitBake itself knows nothing about the implementation of shared state);
a patch to implement this in OE-Core has been sent to the OE-Core
mailing list.

Note that this is similar in spirit but does not directly overlap with
Robert's bitbake-whatchanged script - that allows you to determine what
will be done before it happens, whereas this tool is useful for
determining why a rebuild occurred afterwards.


The following changes (against poky, but apply cleanly with -p2 against 
bitbake master) are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bbdiffsigs
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bbdiffsigs

Paul Eggleton (5):
  tinfoil: create simple interface for bitbake-based utilities
  lib/bb/siggen: replace tabs with spaces
  lib/bb/siggen.py: insert a colon between class and recipe name
  lib/bb/siggen.py: make signature dump/compare functions return a list
  bitbake-diffsigs: allow specifying task & follow deps recursively

 bitbake/bin/bitbake-diffsigs |   96 ++++++++++++++++++++++++++-
 bitbake/bin/bitbake-dumpsig  |    4 +-
 bitbake/bin/bitbake-layers   |  146 ++++++++++++++----------------------------
 bitbake/lib/bb/siggen.py     |  109 +++++++++++++++++--------------
 bitbake/lib/bb/tinfoil.py    |   98 ++++++++++++++++++++++++++++
 5 files changed, 301 insertions(+), 152 deletions(-)
 create mode 100644 bitbake/lib/bb/tinfoil.py

-- 
1.7.9.5



