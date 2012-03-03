Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S3d8g-00064Q-Aw
	for bitbake-devel@lists.openembedded.org;
	Sat, 03 Mar 2012 01:47:58 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 02 Mar 2012 16:39:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113997891"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.15.107])
	by orsmga001.jf.intel.com with ESMTP; 02 Mar 2012 16:39:25 -0800
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Mar 2012 16:39:16 -0800
Message-Id: <cover.1330734444.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 0/6] Hob GUI add persistent tooltips and use custom info icon consistently
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
X-List-Received-Date: Sat, 03 Mar 2012 00:47:58 -0000

asldlasjd

The following changes since commit 4a480a052f450c4ee061ab0e60a495a45f140cf9:

  stderr would previously be appended to stdout, corrupting the result when something was outputed to stderr but exit code was still 0 (non-fatal warning messages). This commit makes the code parse only stdout, but output stderr if an error happened. (2012-03-02 16:17:43 +0000)

are available in the git repository at:
  git://github.com/incandescant/bitbake josh/hob
  https://github.com/incandescant/bitbake/tree/josh/hob

and as a poky repository at:
  git://git.yoctoproject.org/poky-contrib josh/hob
  http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=josh/hob

Joshua Lock (6):
  crumbs/persistenttooltip: a new Gtk+ widget for use in Hob
  ui/icons: crop the info icons
  ui/crumbs/hobwidget: implement HobInfoButton per Hob interaction
    design
  ui/crumbs/imageconfigurationpage: make use of the HobInfoButton
  ui/crumbs/hig: use HobInfoButton in place of gtk.Image with tooltip
  ui/crumbs/hig: special case stock info icons in CrumbsMesssageDialog

 lib/bb/ui/crumbs/hig.py                    |   52 +++++-------
 lib/bb/ui/crumbs/hobwidget.py              |   49 +++++++++++
 lib/bb/ui/crumbs/imageconfigurationpage.py |   12 +--
 lib/bb/ui/crumbs/persistenttooltip.py      |  127 ++++++++++++++++++++++++++++
 lib/bb/ui/icons/info/info_display.png      |  Bin 4760 -> 4558 bytes
 lib/bb/ui/icons/info/info_hover.png        |  Bin 4847 -> 4650 bytes
 6 files changed, 200 insertions(+), 40 deletions(-)
 create mode 100644 lib/bb/ui/crumbs/persistenttooltip.py

-- 
1.7.7.6



