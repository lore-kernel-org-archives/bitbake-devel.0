Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1SZ3eu-0004Yb-TY
	for bitbake-devel@lists.openembedded.org;
	Mon, 28 May 2012 19:23:09 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 28 May 2012 10:11:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="172031874"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.120.22])
	by fmsmga002.fm.intel.com with ESMTP; 28 May 2012 10:10:46 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 28 May 2012 18:10:38 +0100
Message-Id: <cover.1338224913.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 0/1] hob: handle sanity check failures as a separate event
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
X-List-Received-Date: Mon, 28 May 2012 17:23:09 -0000

The following change (against Poky, but applies cleanly with -p2 against
BitBake master) is available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/hob-sanity
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/hob-sanity

Paul Eggleton (1):
  hob: handle sanity check failures as a separate event

 bitbake/lib/bb/event.py                     |    8 ++++++++
 bitbake/lib/bb/ui/crumbs/builder.py         |    7 ++++++-
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |    6 ++++++
 3 files changed, 20 insertions(+), 1 deletion(-)

-- 
1.7.9.5



