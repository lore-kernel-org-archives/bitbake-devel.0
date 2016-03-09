Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id C081E65CB6
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Mar 2016 04:22:50 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 08 Mar 2016 20:22:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,559,1455004800"; d="scan'208";a="905624068"
Received: from mlim-mobl4.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.143.14])
	by orsmga001.jf.intel.com with ESMTP; 08 Mar 2016 20:22:48 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Mar 2016 17:22:11 +1300
Message-Id: <cover.1457497288.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.0
Subject: [PATCH 0/3] Some more npm fetcher fixes
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
X-List-Received-Date: Wed, 09 Mar 2016 04:22:50 -0000

The following changes since commit 12f1fb8c9b70fea0c9145f881bcceb8af32df6af:

  toasterui: fix warning 'Unknown event' (2016-03-07 17:21:07 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-npm-fixes2
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-npm-fixes2

Paul Eggleton (3):
  fetch2/npm: fix errors with some version specifications
  fetch2/npm: properly handle npm dependencies
  fetch2/npm: add missing URL argument to ParameterError

 lib/bb/fetch2/npm.py | 70 +++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 48 insertions(+), 22 deletions(-)

-- 
2.5.0


