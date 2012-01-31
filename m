Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1Rs7BI-0003kH-Hx
	for bitbake-devel@lists.openembedded.org;
	Tue, 31 Jan 2012 07:27:05 +0100
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 30 Jan 2012 22:19:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="118398688"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.146])
	by fmsmga002.fm.intel.com with ESMTP; 30 Jan 2012 22:19:09 -0800
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 31 Jan 2012 14:18:01 +0800
Message-Id: <cover.1327990542.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PATCH 0/1] bitbake: fix bug #1492
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
X-List-Received-Date: Tue, 31 Jan 2012 06:27:05 -0000

The following changes since commit 636d7e308fefe7cca67166d564c3a8f877f2ca86:
  Richard Purdie (1):
        useradd.bbclass: Fix missing quote

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib llu/bug1942
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=llu/bug1942

Lianhao Lu (1):
  prserv: Do not ping PRService if not required

 bitbake/lib/prserv/serv.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)



