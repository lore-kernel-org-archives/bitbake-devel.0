Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
	by mail.openembedded.org (Postfix) with ESMTP id 5AD8071AD6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Aug 2017 12:10:59 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga104.jf.intel.com with ESMTP; 23 Aug 2017 05:11:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,416,1498546800"; d="scan'208";a="1209386435"
Received: from skhurana-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.139.43])
	by fmsmga002.fm.intel.com with ESMTP; 23 Aug 2017 05:10:59 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 24 Aug 2017 00:10:27 +1200
Message-Id: <cover.1503489977.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
Subject: [PATCH 0/1] fetch2: don't mandate path element in encodeurl()
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
X-List-Received-Date: Wed, 23 Aug 2017 12:11:00 -0000

The following changes since commit 27ca94c33234f0ef9753f8285213dde2871a3fcf:

  bitbake: ui: Sort 'Dependent tasks' in taskexp (2017-08-23 12:07:38 +0100)

are available in the git repository at:

  git://git.openembedded.org/bitbake-contrib paule/fetch2-encodeurl-fix
  http://cgit.openembedded.org/bitbake-contrib/log/?h=paule/fetch2-encodeurl-fix

Paul Eggleton (1):
  fetch2: don't mandate path element in encodeurl()

 lib/bb/fetch2/__init__.py | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

-- 
2.9.5


