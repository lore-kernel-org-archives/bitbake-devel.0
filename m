Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 8A8B0766DF
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 24 Aug 2015 14:00:37 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 24 Aug 2015 07:00:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,738,1432623600"; d="scan'208";a="754364487"
Received: from achalot-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.20.62])
	by orsmga001.jf.intel.com with ESMTP; 24 Aug 2015 07:00:30 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 24 Aug 2015 15:00:21 +0100
Message-Id: <cover.1440424765.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH 0/1] Fix side-effects of listing server/UI modules
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
X-List-Received-Date: Mon, 24 Aug 2015 14:00:39 -0000

The following changes since commit f64def7cb6069dc1134fcd546bb59e4030c7376f:

  main: Handle RuntimeError exception in list_extension_modules (2015-08-20 22:03:42 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-extfix
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-extfix

Paul Eggleton (1):
  lib/bb/main: avoid importing all server/UI modules on every execution

 lib/bb/main.py | 60 +++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 22 deletions(-)

-- 
2.1.0


