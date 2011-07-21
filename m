Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <liping.ke@intel.com>) id 1QjmMW-0007SQ-4u
	for bitbake-devel@lists.openembedded.org;
	Thu, 21 Jul 2011 08:03:56 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 20 Jul 2011 22:59:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,239,1309762800"; d="scan'208";a="32854701"
Received: from lke-nhm.sh.intel.com (HELO localhost) ([10.239.36.53])
	by fmsmga001.fm.intel.com with ESMTP; 20 Jul 2011 22:59:47 -0700
From: Ke Liping <liping.ke@intel.com>
To: yocto@yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Date: Thu, 21 Jul 2011 13:50:20 +0800
Message-Id: <cover.1310696828.git.liping.ke@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PATCH 0/1][Image Creator] Remove unused target tree data for Hob
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
X-List-Received-Date: Thu, 21 Jul 2011 06:03:56 -0000

From: Liping Ke <liping.ke@intel.com>

Since Hob only needes package dependency information, we can
create a new version of package information retrieving methods,
remove task dependency information, so that we can greatly
reduce data loading time for Hob

The following changes since commit fa4bcfdb73167f8159b88e5a4d711c0d37627a70:
  Darren Hart (1):
        bb-matrix: correct BB and PM number canonicalization

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib lke/hob_perf
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=lke/hob_perf

Liping Ke (1):
  Remove unused target tree data for Hob

 bitbake/lib/bb/cooker.py |   96 +++++++++++++++++++++++++++++++++++++---------
 1 files changed, 77 insertions(+), 19 deletions(-)



