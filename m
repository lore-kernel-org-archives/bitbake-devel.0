Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1Safsl-0001wz-HH
	for bitbake-devel@lists.openembedded.org;
	Sat, 02 Jun 2012 06:24:07 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 01 Jun 2012 21:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="159771851"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga001.fm.intel.com with ESMTP; 01 Jun 2012 21:13:44 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat,  2 Jun 2012 12:54:32 +0800
Message-Id: <cover.1338612620.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/3] Hob: some fixes
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
X-List-Received-Date: Sat, 02 Jun 2012 04:24:07 -0000

Here are some fixes for Hob:
 - lower the limitation of PyGTK so Ubuntu 10.04 can still use Hob
 - we will continue to change Hob, add versions for compatibility check
 - some special chars can be shown as markup, replace them with escape chars
    & -> &amp;
    < -> &lt;
    > -> &gt;
    and so on

The following changes since commit de4cdfd6bc1280ac7ac0559b87734d26294ef773:

  documentation/kernel-manual/kernel-how-to.xml: Updated to kernel 3.4 (2012-05-31 21:16:55 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/newproxy
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/newproxy

Shane Wang (3):
  Hob: lower the limitation for PyGTK
  Hob: add versions for compatibility check between Hob and templates
  Hob: Interpret some special characters for label markup

 bitbake/lib/bb/ui/crumbs/builder.py  |   27 +++++++++++++++++++++++----
 bitbake/lib/bb/ui/crumbs/template.py |   17 ++++++++++++++++-
 bitbake/lib/bb/ui/hob.py             |    2 +-
 3 files changed, 40 insertions(+), 6 deletions(-)

-- 
1.7.6



