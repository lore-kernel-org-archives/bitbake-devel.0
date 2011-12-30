Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1RgTcO-0003zc-CE
	for bitbake-devel@lists.openembedded.org;
	Fri, 30 Dec 2011 04:58:56 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP; 29 Dec 2011 19:50:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="101536789"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.146])
	by fmsmga001.fm.intel.com with ESMTP; 29 Dec 2011 19:50:31 -0800
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 30 Dec 2011 11:49:01 +0800
Message-Id: <cover.1325213895.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PRService/bitbake 0/2] new PRService features in bitbake
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
X-List-Received-Date: Fri, 30 Dec 2011 03:58:56 -0000

NOTE: This set of patches added supporting for new features in bitbake.
It should work together with another branch of patches in meta layers.
    git://git.pokylinux.org/poky-contrib llu/PRService_oecore

It added PRService's export/import support in bitbake and also added a 
no history mode as the default mode for PRSerivce. In this mode, the 
AUTOPR value(which will be included in the finale PKGR) returned by 
the PRService will never decrement. It also added PACKAGE_ARCH into 
the index to the DB table, so the packages for different architcture 
will have different AUTOPR values.

The PRService can be started in 2 ways. If the user wants share the 
PRService for multiple buildings, it can start the PRService in the old
way, by running "bitbake-prserv --start [options]", and set PRSERV_HOST 
and PRSERV_PORT in local.conf accordingly.

If the user only wants the PRService to be used by current build, a local
service may be started automatically by setting PRSERV_HOST to "localhost"
and PRSERV_PORT to "0". This automatically started local service will only
be effective to the builds running in the same build directory.

The following changes since commit f5aa3bbda623c8fae3a761d72fddc95631ad0706:
  Saul Wold (1):
        coreutils: ensure --color works so DEPEND on libcap

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib llu/PRService_bitbake
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=llu/PRService_bitbake

Lianhao Lu (2):
  bitbake/PRservice: Added no_hist mode and export/import.
  bitbake: Automatically start local PR service.

 bitbake/bin/bitbake-prserv     |   26 +++---
 bitbake/lib/bb/cooker.py       |    3 +
 bitbake/lib/prserv/__init__.py |    5 +-
 bitbake/lib/prserv/db.py       |  213 +++++++++++++++++++++++++++++++++------
 bitbake/lib/prserv/serv.py     |  208 +++++++++++++++++++++++++++++----------
 5 files changed, 358 insertions(+), 97 deletions(-)
 mode change 100644 => 100755 bitbake/bin/bitbake-prserv



