Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id E1E4171F1B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Feb 2015 17:52:57 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga103.fm.intel.com with ESMTP; 20 Feb 2015 09:45:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,616,1418112000"; d="scan'208";a="680980786"
Received: from marazel-mobl2.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.23.180])
	by fmsmga002.fm.intel.com with ESMTP; 20 Feb 2015 09:52:52 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Feb 2015 17:52:40 +0000
Message-Id: <cover.1424454574.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/3] bitbake-layers layer index fetching support & refactoring
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 20 Feb 2015 17:52:58 -0000

Refactor bitbake-layers, fix logging, and allow fetching layers from
the OE layer index and adding them to bblayers.conf with a single
command.

Note - there's an additional set of patches that should be applied to
OE-Core to make this work fully.


The following changes since commit 605298ff3ce919127003dadef95798472327f943:

  toaster: importlayer Remove description input field (2015-02-18 19:08:41 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bblayers-layerindex
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bblayers-layerindex

Chong Lu (1):
  bitbake-layers: add ability to fetch layers and their dependencies
    from layer index

Paul Eggleton (2):
  bitbake-layers: refactor to use argparse instead of cmd
  bitbake-layers: fix logging

 bin/bitbake-layers | 525 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 373 insertions(+), 152 deletions(-)

-- 
1.9.3


