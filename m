Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 1727A770A2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 May 2016 23:17:20 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga101.jf.intel.com with ESMTP; 30 May 2016 16:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,392,1459839600"; d="scan'208";a="113081693"
Received: from klsmgloan09.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.145.237])
	by fmsmga004.fm.intel.com with ESMTP; 30 May 2016 16:17:20 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 31 May 2016 11:16:57 +1200
Message-Id: <cover.1464650184.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH 0/1] Minor fix for bitbake-layers
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
X-List-Received-Date: Mon, 30 May 2016 23:17:22 -0000

The following changes since commit d830dccf948d188492cecfcf2ff053f31740dc21:

  classes/base.bbclass: Fix missing getVarFlag parameter (2016-05-24 15:55:01 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-bitbake-layers-fix
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-bitbake-layers-fix

Paul Eggleton (1):
  bitbake-layers: show-layers: disable parsing

 lib/bblayers/query.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.5.5


