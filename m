Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SJReJ-0007Dt-7O
	for bitbake-devel@lists.openembedded.org;
	Sun, 15 Apr 2012 17:45:59 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 15 Apr 2012 08:36:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="153877398"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga002.fm.intel.com with ESMTP; 15 Apr 2012 08:36:33 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Apr 2012 00:07:02 +0800
Message-Id: <cover.1334505890.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/1] Add exception handling into Hob
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
X-List-Received-Date: Sun, 15 Apr 2012 15:45:59 -0000

This patch is to add try-except-finally exception handling to Hob. Please review.

The following changes since commit a5210e47b08e0ee42e9e188d83953203147a994d:

  guile: Fix binary relocation issue for precompiled guile objects (2012-04-15 12:06:41 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/hob_0415
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob_0415

Shane Wang (1):
  Hob: add exception handling

 bitbake/lib/bb/ui/crumbs/builder.py         |   56 ++++++---
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py |  175 ++++++++++++++-------------
 2 files changed, 128 insertions(+), 103 deletions(-)

-- 
1.7.6



