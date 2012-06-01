Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <limingx.l.an@intel.com>) id 1SaPL7-0005xW-Po
	for bitbake-devel@lists.openembedded.org;
	Fri, 01 Jun 2012 12:44:18 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 01 Jun 2012 03:33:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="150344427"
Received: from hp.sh.intel.com ([10.239.47.6])
	by azsmga001.ch.intel.com with ESMTP; 01 Jun 2012 03:33:47 -0700
From: Liming An <limingx.l.an@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Jun 2012 18:36:39 +0800
Message-Id: <cover.1338546445.git.limingx.l.an@intel.com>
X-Mailer: git-send-email 1.7.5.4
Subject: [PATCH 0/3] Hob: bug fixes
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
X-List-Received-Date: Fri, 01 Jun 2012 10:44:18 -0000

The following changes since commit de4cdfd6bc1280ac7ac0559b87734d26294ef773:

  documentation/kernel-manual/kernel-how-to.xml: Updated to kernel 3.4 (2012-05-31 21:16:55 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib limx/hob-bug-fixes-continue
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=limx/hob-bug-fixes-continue

Liming An (3):
  Hob: clear the repeated function get_kernel_file_name
  Hob: fix entry of recipe page can't be edited in case after clicked
    clear button
  Hob: fixed a definition not match issue when click choose directflb
    in package page

 bitbake/lib/bb/ui/crumbs/builder.py              |    5 +++--
 bitbake/lib/bb/ui/crumbs/hobwidget.py            |   10 ++--------
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py     |   19 +------------------
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py |    2 +-
 4 files changed, 7 insertions(+), 29 deletions(-)

-- 
1.7.5.4



