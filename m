Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S9mvl-000820-BD
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 01:28:05 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 19 Mar 2012 17:18:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="141535435"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.181])
	by fmsmga002.fm.intel.com with ESMTP; 19 Mar 2012 17:18:08 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 19 Mar 2012 17:18:00 -0700
Message-Id: <cover.1332202341.git.josh@linux.intel.com>
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
X-List-Received-Date: Tue, 20 Mar 2012 00:28:05 -0000

Here's a series of patches to polish the Hob GUI: some minor tweaks to remove
redundant calls and API, a couple of HIG related tweaks to buttons, a change to
the persistenttooltip to try and match the close position of the window manager
(i.e. running under Unity on Ubuntu the close button on the persistent tooltip
will appear on the left) and finally a change to the layer dialogue implementation
so that it more closely matches the interaction design (this is still pending
some designer feedback on visuals and whether to remove some labels but they can
easily be implemented as iterative patches on top of these).

Cheers,

Joshua

The following changes since commit 5a1e62a8cdd4f0253b0dc59046b3b4c3186af461:

  bitbake/fetch2: Fix typo which broke use of tarballs (2012-03-16 23:44:08 +0000)

are available in the git repository at:
  git://github.com/incandescant/bitbake josh/hob
  https://github.com/incandescant/bitbake/tree/josh/hob
  git://git.yoctoproject.org/poky-contrib josh/hob
  http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=josh/hob

Joshua Lock (6):
  ui/crumbs/hig: use close rather than OK for dismis button
  ui/crumbs: remove unused return value from append_toolbar_button
  ui/crumbs/hobpage: no need to force a Toolbar button type
  ui/crumbs/persistenttooltip: try to reflect WM close button position
  ui/crumbs/builder: remove OK/Cancel buttons on Layer dialog. Use
    Close.
  ui/crumbs/hig: make the layer selection dialogue more closely match
    design

 lib/bb/ui/crumbs/builder.py                |    3 +-
 lib/bb/ui/crumbs/hig.py                    |   98 +++++++++++++++++++++-------
 lib/bb/ui/crumbs/hobpages.py               |    6 +-
 lib/bb/ui/crumbs/imageconfigurationpage.py |    6 +-
 lib/bb/ui/crumbs/imagedetailspage.py       |    2 +-
 lib/bb/ui/crumbs/persistenttooltip.py      |   24 +++++++-
 6 files changed, 105 insertions(+), 34 deletions(-)

-- 
1.7.7.6



