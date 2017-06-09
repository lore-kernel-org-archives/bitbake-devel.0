Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 15481782A3
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Jun 2017 15:14:13 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga104.jf.intel.com with ESMTP; 09 Jun 2017 08:14:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,317,1493708400"; d="scan'208";a="272296058"
Received: from therfet-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.41.2])
	by fmsmga004.fm.intel.com with ESMTP; 09 Jun 2017 08:14:14 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  9 Jun 2017 17:13:50 +0200
Message-Id: <cover.1497021176.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
Subject: [PATCH 0/1] Drop Hob support commands and functions
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
X-List-Received-Date: Fri, 09 Jun 2017 15:14:15 -0000

Drop some obsolete code.


The following changes since commit 705ab252e631903e6d2e46202b419a9e8adcd861:

  bitbake-layers: check layer dependencies before adding (2017-06-05 13:33:14 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-drob-hob-commands
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-drob-hob-commands

Paul Eggleton (1):
  command / cooker: drop Hob support commands and functions

 lib/bb/command.py |  60 -----------------
 lib/bb/cooker.py  | 193 ------------------------------------------------------
 2 files changed, 253 deletions(-)

-- 
2.9.4


