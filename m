Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id A70576A4AC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jul 2013 08:19:51 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 29 Jul 2013 01:19:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,767,1367996400"; d="scan'208";a="378174433"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.122.206])
	by orsmga002.jf.intel.com with ESMTP; 29 Jul 2013 01:19:51 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 29 Jul 2013 09:19:40 +0100
Message-Id: <cover.1375085732.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [1.18][PATCH 0/2] Bitbake changes for 1.18 branch
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 29 Jul 2013 08:19:52 -0000

This includes one backport from master and one Hob change which applies
only to 1.18 (implementation in master is different.)

The following BitBake changes (against poky dylan, but apply cleanly
against the bitbake 1.18 branch with -p2) are available in the git
repository at:

  git://git.yoctoproject.org/poky-contrib paule/dylan-next-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/dylan-next-bb

Cristiana Voicu (1):
  hob: save the base image name for the customized images

Richard Purdie (1):
  bitbake: data_smart: Ensure variable flags are accounted for in config
    data hash

 bitbake/lib/bb/data_smart.py                     | 6 ++++++
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py | 1 +
 2 files changed, 7 insertions(+)

-- 
1.8.1.2


