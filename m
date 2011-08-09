Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ke.yu@intel.com>) id 1QqiNa-0007on-Sz
	for bitbake-devel@lists.openembedded.org;
	Tue, 09 Aug 2011 11:13:43 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 09 Aug 2011 02:09:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,342,1309762800"; d="scan'208";a="39572011"
Received: from kyu3-dev32.bj.intel.com (HELO localhost) ([10.238.153.157])
	by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2011 02:09:12 -0700
From: Yu Ke <ke.yu@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Tue,  9 Aug 2011 17:16:59 +0800
Message-Id: <cover.1312881309.git.ke.yu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PATCH 0/1] fetcher2 debug message fix for Yocto bug 1256
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
X-List-Received-Date: Tue, 09 Aug 2011 09:13:43 -0000

The following changes since commit 5cacdc4f1641eda1b5707c96f7c40924a9db6174:
  Joshua Lock (1):
        bb/cooker: mark parsed conf files as potential cache invalidators

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib kyu3/bug-1256
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=kyu3/bug-1256

Yu Ke (1):
  fetcher2: show warning message when checksum is mismatch

 lib/bb/fetch2/__init__.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)



