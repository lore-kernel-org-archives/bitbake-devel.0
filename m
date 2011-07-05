Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ke.yu@intel.com>) id 1Qe5T5-0005N4-4r
	for bitbake-devel@lists.openembedded.org;
	Tue, 05 Jul 2011 15:15:11 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 05 Jul 2011 06:11:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,479,1304319600"; d="scan'208";a="23577706"
Received: from kyu3-dev32.bj.intel.com (HELO localhost) ([10.238.153.187])
	by orsmga001.jf.intel.com with ESMTP; 05 Jul 2011 06:11:20 -0700
From: Yu Ke <ke.yu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  5 Jul 2011 21:11:08 +0800
Message-Id: <cover.1309870780.git.ke.yu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PATCH 0/1] fetcher2: retry mirror if upstream checksum mismatch
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
X-List-Received-Date: Tue, 05 Jul 2011 13:15:11 -0000

fetcher2: retry mirror if upstream checksum mismatch

This patch is for [YOCTO #1085] fix.

The following changes since commit ad2363278f0ea86fcf3464f8f6073d3a3d06be63:
  Khem Raj (1):
        uclibc: Fix compilation in thumb mode

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib kyu3/bug1085
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=kyu3/bug1085

Yu Ke (1):
  fetcher2: retry mirror if upstream checksum mismatch

 bitbake/lib/bb/fetch2/__init__.py |   27 ++++++++++++++++-----------
 1 files changed, 16 insertions(+), 11 deletions(-)



