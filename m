Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1TF4iE-0004KT-DL
	for bitbake-devel@lists.openembedded.org;
	Fri, 21 Sep 2012 17:00:14 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 21 Sep 2012 07:47:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,463,1344236400"; d="scan'208";a="209599660"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.241])
	by orsmga002.jf.intel.com with ESMTP; 21 Sep 2012 07:47:28 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 21 Sep 2012 15:47:22 +0100
Message-Id: <cover.1348238757.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH v2 0/4] More Hob fixes
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
X-List-Received-Date: Fri, 21 Sep 2012 15:00:14 -0000

The following changes (against Poky, but apply cleanly with -p2 against
bitbake master) are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/hob-fixes-2
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/hob-fixes-2

Paul Eggleton (4):
  hob: don't show error dialog for errors during building
  hob: allow configuring default machine using HOB_MACHINE
  hob: remove confirmation dialog on close
  hob: fix Gtk-WARNINGs due to invalid markup on Back button

 bitbake/lib/bb/ui/crumbs/builddetailspage.py |    2 +-
 bitbake/lib/bb/ui/crumbs/builder.py          |   19 ++++++-------------
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py  |    9 +++++----
 3 files changed, 12 insertions(+), 18 deletions(-)

-- 
1.7.9.5



