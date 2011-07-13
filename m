Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <ke.yu@intel.com>) id 1QgvXW-0006DK-A2
	for bitbake-devel@lists.openembedded.org;
	Wed, 13 Jul 2011 11:15:30 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 13 Jul 2011 02:09:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.65,524,1304319600"; d="scan'208";a="26616539"
Received: from kyu3-dev32.bj.intel.com (HELO localhost) ([10.238.153.187])
	by azsmga001.ch.intel.com with ESMTP; 13 Jul 2011 02:09:52 -0700
From: Yu Ke <ke.yu@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Wed, 13 Jul 2011 17:08:38 +0800
Message-Id: <cover.1310547939.git.ke.yu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PATCH 0/1] fetcher2: retry mirror if upstream checksum mismatch V2
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
X-List-Received-Date: Wed, 13 Jul 2011 09:15:30 -0000

This is the V2 patch. the main change is introduce new function update_stamp
per Richard's suggestion.

CC: Richard Purdie <richard.purdie@linuxfoundation.org>

The following changes since commit 7354fc9213f27aa1b643dbe88070437f1ee4c063:
  Paul Eggleton (1):
        insane.bbclass: skip rdepends QA checks for kernel / modules

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib kyu3/verify-checksum
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=kyu3/verify-checksum

Yu Ke (1):
  fetcher2: retry mirror if upstream checksum mismatch

 bitbake/lib/bb/fetch2/__init__.py |   31 ++++++++++++++++++++-----------
 1 files changed, 20 insertions(+), 11 deletions(-)



