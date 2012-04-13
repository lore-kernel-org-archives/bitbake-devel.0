Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1SIcFc-0003a8-63
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Apr 2012 10:53:04 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 13 Apr 2012 01:43:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="153169125"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.110])
	by fmsmga002.fm.intel.com with ESMTP; 13 Apr 2012 01:43:41 -0700
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 13 Apr 2012 16:37:16 +0800
Message-Id: <cover.1334306019.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PATCH 0/1] Hob fixing: fixed unfunctional toolchain.
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
X-List-Received-Date: Fri, 13 Apr 2012 08:53:04 -0000

This fixed the Yocto bug #2274, generating an unfunctional toolchain based 
on image profile minimal.

The following changes since commit 3c2808b67384e92601cbd66877c36ca40df7c7ba:
  Shane Wang (1):
        Hob: fix the missing functions

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib llu/bug2274
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=llu/bug2274

Lianhao Lu (1):
  Hob: Added required packages for toolchain.

 lib/bb/ui/crumbs/hoblistmodel.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)



