Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1S3OQs-00032p-AT
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 10:05:46 +0100
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 02 Mar 2012 00:57:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="124081809"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.62])
	by fmsmga001.fm.intel.com with ESMTP; 02 Mar 2012 00:57:14 -0800
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Mar 2012 16:54:22 +0800
Message-Id: <cover.1330678346.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PATCH 0/1] Make bitbake-prserv executable
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
X-List-Received-Date: Fri, 02 Mar 2012 09:05:46 -0000

This patch fixed Yocot bug #2051 by set 'x' file mode bit of bitbake-prserv.

The following changes since commit 6b6aa170d5c618cfcd016dd1de926db647f7f932:
  Gary Thomas (1):
        busybox: Restore 'date' compatability

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib llu/bug2051
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=llu/bug2051

Lianhao Lu (1):
  bitbake/bitbake-prserv: Set file mode bits "x".

 0 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100644 => 100755 bitbake/bin/bitbake-prserv



