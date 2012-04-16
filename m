Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <elizabeth.flanagan@intel.com>) id 1SJvBZ-0000Gm-RA
	for bitbake-devel@lists.openembedded.org;
	Tue, 17 Apr 2012 01:18:18 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 16 Apr 2012 16:07:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="130377297"
Received: from envy.jf.intel.com ([10.7.201.175])
	by orsmga001.jf.intel.com with ESMTP; 16 Apr 2012 16:07:46 -0700
From: Beth Flanagan <elizabeth.flanagan@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Apr 2012 16:12:59 -0700
Message-Id: <cover.1334617726.git.elizabeth.flanagan@intel.com>
X-Mailer: git-send-email 1.7.1
Subject: [PATCH 0/1] Hob: Add a description for creating own image
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
X-List-Received-Date: Mon, 16 Apr 2012 23:18:18 -0000

Hob's dummy_image ("Create your own image") has an empty desc. This patch
adds that description.

The following changes since commit a2280512b8a1f72be340799b4846a527f0c1892f:

  libzypp: add libproxy to DEPENDS (2012-04-16 23:30:49 +0100)

are available in the git repository at:
  git://git.yoctoproject.org/poky-contrib eflanagan/bb_default_image
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=eflanagan/bb_default_image

Beth Flanagan (1):
  hoblistmodel.py: description for selfcreated image

 bitbake/lib/bb/ui/crumbs/hoblistmodel.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)



