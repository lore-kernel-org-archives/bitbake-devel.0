Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S16g8-0007uP-Sq
	for bitbake-devel@lists.openembedded.org;
	Sat, 25 Feb 2012 02:44:05 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 24 Feb 2012 17:34:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="110607533"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.27])
	by azsmga001.ch.intel.com with ESMTP; 24 Feb 2012 17:34:35 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 24 Feb 2012 17:34:25 -0800
Message-Id: <cover.1330133412.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 0/6] Hob tweaks
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
X-List-Received-Date: Sat, 25 Feb 2012 01:44:05 -0000

Here's a first pass of tweaks for the Hob GUI based on a brief interaction with the
landing page of the GUI. It's by no means a perfect set of changes, my HIG related
tweaks are based on memory and examples in the code that remains from Hob v1.

If nothing else the button ordering will need fixing fairly soonish as regular Linux
Gtk+ desktop users like myself will soon start clicking the wrong buttons due to the
inverted order.

Cheers,
Joshua

CC: Dongxiao Xu <dongxiao.xu@intel.com>

The following changes since commit c7486a09310fe63b1aa1b7b0bb9450f306b6093b:

  bitbake/cooker: terminate when errors found in layer configuration (2012-02-24 23:30:16 +0000)

are available in the git repository at:
  git://github.com/incandescant/bitbake josh/hob
  https://github.com/incandescant/bitbake/tree/josh/hob

Joshua Lock (6):
  crumbs: Factor common dialogue configuration out
  crumbs/builder: use the name Hob consistently
  crumbs: move towards more standard dialogue spacing
  crumbs: fix button order in several dialogues
  hig: try to avoid setting explicit dialogue sizes
  crumbs/hig: tweak UI and layout of LayerSelectionDialog

 lib/bb/ui/crumbs/builder.py   |   56 +++++++++++-----------
 lib/bb/ui/crumbs/hig.py       |  102 +++++++++++++++++++---------------------
 lib/bb/ui/crumbs/hobwidget.py |   12 ++--
 3 files changed, 82 insertions(+), 88 deletions(-)

-- 
1.7.7.6



