Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1QWNje-0000Dv-My
	for bitbake-devel@lists.openembedded.org;
	Tue, 14 Jun 2011 09:08:26 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 14 Jun 2011 00:03:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,363,1304319600"; d="scan'208";a="15935959"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.87])
	by fmsmga002.fm.intel.com with ESMTP; 14 Jun 2011 00:03:55 -0700
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 14 Jun 2011 15:12:04 +0800
Message-Id: <cover.1308034271.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [RFC PATCH 0/1] process cmd line parsing result by individual UI
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
X-List-Received-Date: Tue, 14 Jun 2011 07:08:26 -0000

This patch tries to allow the individual UI to decide whether it should display the cmd line parsing result.

The command "getCmdLineAction" now returns either None or a dictionary with the key of {'action', 'msg'}. 

If it returns None, it means no command line action parameters are provided. 

If it returns a dictionary, the entry of the key 'action' stores the list which should be used with server.runCommand(); the entry of the key 'msg' stores the error message from the cmd line parsing result (in which case the 'action' entry is None). 

It is up to the individual UI to decide whether and how to display those parsing result.

Please review the following changes for suitability for inclusion. If you have
any objections or suggestions for improvement, please respond to the patches. If
you agree with the changes, please provide your Acked-by.

The following changes since commit a27fbe5e25a5aee956d2a43a2e2bf671c6d985f2:
  Scott Rifenbark (1):
        documentation/yocto-project-qs/yocto-project-qs.xml: removed 5.0 references

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib llu/cmdLineParsing
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=llu/cmdLineParsing

Lianhao Lu (1):
  bitbake cooker/ui: handle cmd line parsing result by individual UI.

 bitbake/lib/bb/cooker.py     |   34 ++++++++++++++++------------------
 bitbake/lib/bb/ui/depexp.py  |    7 +++++--
 bitbake/lib/bb/ui/goggle.py  |    6 +++++-
 bitbake/lib/bb/ui/knotty.py  |    6 +++++-
 bitbake/lib/bb/ui/ncurses.py |    6 +++++-
 5 files changed, 36 insertions(+), 23 deletions(-)



