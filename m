Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SbUw0-0005B2-Ap
	for bitbake-devel@lists.openembedded.org;
	Mon, 04 Jun 2012 12:54:52 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 04 Jun 2012 03:44:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="147757735"
Received: from hp.sh.intel.com ([10.239.47.6])
	by orsmga001.jf.intel.com with ESMTP; 04 Jun 2012 03:44:26 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  4 Jun 2012 18:47:22 +0800
Message-Id: <cover.1338806537.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/5] Hob: bug-fixes (2)
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
X-List-Received-Date: Mon, 04 Jun 2012 10:54:52 -0000

Added two commits compared with the last mail sent to public:
Hob: clear the repeated function get_kernel_file_name
Hob: fix entry of recipe page can't be edited in case after clicked
    clear button

The following changes since commit de4cdfd6bc1280ac7ac0559b87734d26294ef773:

  documentation/kernel-manual/kernel-how-to.xml: Updated to kernel 3.4 (2012-05-31 21:16:55 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib limx/hob-bug-fixes-continue
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=limx/hob-bug-fixes-continue

Liming An (5):
  Hob: clear the repeated function get_kernel_file_name
  Hob: fix entry of recipe page can't be edited in case after clicked
    clear button
  Hob: fixed a definition not match issue when click choose directflb
    in package page
  Hob: Change 'run image' work flow and image detail screen as ui
    design
  Hob: fixed the index issue when set actived item for base image combo

 bitbake/lib/bb/ui/crumbs/builder.py                |  117 +++++------
 bitbake/lib/bb/ui/crumbs/hig.py                    |    2 +-
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |    3 +-
 bitbake/lib/bb/ui/crumbs/hobwidget.py              |   10 +-
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    3 +-
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |  216 ++++++++++++++------
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |    2 +-
 7 files changed, 214 insertions(+), 139 deletions(-)

-- 
1.7.5.4



