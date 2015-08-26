Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id B8DBC734B8
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 12:50:57 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 26 Aug 2015 05:50:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.17,416,1437462000"; d="scan'208";a="755743224"
Received: from tlomotow-mobl.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.18.45])
	by orsmga001.jf.intel.com with ESMTP; 26 Aug 2015 05:50:56 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Aug 2015 13:50:46 +0100
Message-Id: <cover.1440593403.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH 0/1] Allow BuildCompleted listeners to know if build was interrupted
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
X-List-Received-Date: Wed, 26 Aug 2015 12:50:59 -0000

The following changes since commit c9dc6d9c86e8b887821a6d00346bd0b09e1da97c:

  lib/bb/main: avoid importing all server/UI modules on every execution (2015-08-24 23:22:07 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-buildcompleted
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-buildcompleted

Paul Eggleton (1):
  lib/bb/cooker: add interrupted flag to BuildCompleted event

 lib/bb/cooker.py | 10 ++++++++--
 lib/bb/event.py  |  3 ++-
 2 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.1.0


