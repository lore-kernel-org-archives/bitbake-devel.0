Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jessica.zhang@intel.com>) id 1TBaLN-0008EF-Ug
	for bitbake-devel@lists.openembedded.org;
	Wed, 12 Sep 2012 01:58:14 +0200
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 11 Sep 2012 16:44:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.80,407,1344236400"; d="scan'208";a="191815165"
Received: from jzhang-desktop.jf.intel.com (HELO localhost) ([10.7.201.69])
	by orsmga001.jf.intel.com with ESMTP; 11 Sep 2012 16:44:36 -0700
From: Jessica Zhang <jessica.zhang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Sep 2012 16:55:51 -0700
Message-Id: <cover.1347407412.git.jessica.zhang@intel.com>
X-Mailer: git-send-email 1.7.9.5
Subject: [PATCH 0/1] HOB fix for proxy tab tooltip text
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
X-List-Received-Date: Tue, 11 Sep 2012 23:58:14 -0000

[YOCTO #2499]
The following changes since commit 7250638ec895bc89508711831083d43b9e1e9826:

  upstream_tracking: Fix format issues (2012-09-10 23:21:12 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib jzhang/HOB2499
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=jzhang/HOB2499

Jessica Zhang (1):
  Fixed hob proxy tab tooltip text per review suggestions [YOCTO #2499]

 bitbake/lib/bb/ui/crumbs/hig.py |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
1.7.9.5



