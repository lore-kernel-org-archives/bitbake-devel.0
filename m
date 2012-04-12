Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <lianhao.lu@intel.com>) id 1SIGYw-0001yJ-1P
	for bitbake-devel@lists.openembedded.org;
	Thu, 12 Apr 2012 11:43:34 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 12 Apr 2012 02:34:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="128237002"
Received: from llu-piketon.sh.intel.com (HELO localhost) ([10.239.36.110])
	by orsmga001.jf.intel.com with ESMTP; 12 Apr 2012 02:34:12 -0700
From: Lianhao Lu <lianhao.lu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Apr 2012 17:27:58 +0800
Message-Id: <cover.1334222502.git.lianhao.lu@intel.com>
X-Mailer: git-send-email 1.7.0.4
Subject: [PATCH 0/1] Modified the vercmp() to meet Debian rules
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
X-List-Received-Date: Thu, 12 Apr 2012 09:43:34 -0000

As we investigated, the vercmp() in bitbake didn't meet the Debian rules, 
and is not compatible to what opkg expected. Detailed information could be 
find at http://lists.linuxtogo.org/pipermail/bitbake-devel/2012-April/002641.html.

This patch fixed the vercmp() to meet the Debian rules.

The following changes since commit 4219e2ea033232d95117211947b751bdb5efafd4:
  Saul Wold (1):
        hig/builder: use the new which_terminal() function

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib llu/vercmp_bitbake
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=llu/vercmp_bitbake

Lianhao Lu (1):
  bb.utils: Modifed vercmp() to meet Debian rules.

 lib/bb/utils.py |   40 ++++++++++++++++------------------------
 1 files changed, 16 insertions(+), 24 deletions(-)



