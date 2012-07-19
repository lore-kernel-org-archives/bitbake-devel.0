Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <nitin.a.kamble@intel.com>) id 1Ss1S1-0005hU-CB
	for bitbake-devel@lists.openembedded.org;
	Fri, 20 Jul 2012 02:52:13 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 19 Jul 2012 17:39:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="168720804"
Received: from yocto-hm1.jf.intel.com ([10.23.232.32])
	by orsmga001.jf.intel.com with ESMTP; 19 Jul 2012 17:39:44 -0700
From: nitin.a.kamble@intel.com
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Jul 2012 17:39:16 -0700
Message-Id: <cover.1342635547.git.nitin.a.kamble@intel.com>
X-Mailer: git-send-email 1.7.3.4
X-Mailman-Approved-At: Fri, 20 Jul 2012 11:07:59 +0200
Cc: Nitin A Kamble <nitin.a.kamble@intel.com>
Subject: [PATCH 0/1] V2 add downloadfilename param to wget fetcher
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
X-List-Received-Date: Fri, 20 Jul 2012 00:52:13 -0000

From: Nitin A Kamble <nitin.a.kamble@intel.com>

This add a new parameter to wget fetcher. It enables storing the
downloaded file with any custom name which can be different than
the basename of the url.

It is useful for situations like this:
SRC_URI = "https://edc.intel.com/Download.aspx?id=6190;downloadfilename=LIN_IEMGD_1_14_GOLD_2443.tgz"

Thanks,
Nitin

The following changes since commit 5b014eae151a1584df4e3d3b96d18f9df3e55665:

  fix my typos in patch headers (2012-07-16 21:45:01 -0700)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib nitin/misc
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=nitin/misc

Nitin A Kamble (1):
  bitbake wget fetcher: add parameter: downloadfilename

 bitbake/lib/bb/fetch2/wget.py |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

-- 
1.7.3.4



