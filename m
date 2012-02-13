Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1RwuQl-0003dN-Ua
	for bitbake-devel@lists.openembedded.org;
	Mon, 13 Feb 2012 12:50:52 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 13 Feb 2012 03:41:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="116995915"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.241])
	by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2012 03:41:36 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 13 Feb 2012 11:41:30 +0000
Message-Id: <cover.1329133148.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/3] bitbake error fixes
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
X-List-Received-Date: Mon, 13 Feb 2012 11:50:52 -0000

The following changes (against Poky, but apply cleanly with -p2 against
bitbake master) are available in the git repository at:
  git://git.yoctoproject.org/poky-contrib paule/bberrors1
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bberrors1

Paul Eggleton (3):
  bitbake: show appropriate warnings for universe target
  bitbake/knotty: ensure we return non-zero exit code on Ctrl+C
  bitbake/knotty: ensure CommandFailed increases error count

 bitbake/lib/bb/cooker.py    |    4 ++++
 bitbake/lib/bb/runqueue.py  |   10 +++++++---
 bitbake/lib/bb/ui/knotty.py |    6 ++++++
 3 files changed, 17 insertions(+), 3 deletions(-)

-- 
1.7.5.4



