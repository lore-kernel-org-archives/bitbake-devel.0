Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1RkV81-0005BE-Fj
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jan 2012 07:24:15 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 09 Jan 2012 22:15:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="96376245"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.146])
	by orsmga002.jf.intel.com with ESMTP; 09 Jan 2012 22:15:39 -0800
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Jan 2012 14:13:47 +0800
Message-Id: <cover.1326175837.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PRService/bitbake V2 0/2] new PRService features in bitbake
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
X-List-Received-Date: Tue, 10 Jan 2012 06:24:15 -0000

V2: rebase to latest code

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

The following changes since commit 468998cddbe1a803096c9b357e1b5daa3b7e8c2e:
  Dongxiao Xu (1):
        command.py: add parseConfigurationFiles API

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



