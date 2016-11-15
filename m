Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id 886446093E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 15 Nov 2016 20:11:10 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga105.jf.intel.com with ESMTP; 15 Nov 2016 12:11:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,496,1473145200"; d="scan'208";a="786809692"
Received: from nnasirin-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.185.211])
	by FMSMGA003.fm.intel.com with ESMTP; 15 Nov 2016 12:11:08 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 16 Nov 2016 09:11:02 +1300
Message-Id: <cover.1479240639.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH 0/1] fetch2: npm: conditionally hide NPM_LOCKDOWN / NPM_SHRINKWRAP warnings
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
X-List-Received-Date: Tue, 15 Nov 2016 20:11:10 -0000

The following changes since commit 91c3b34625fac2a0f093a4b46a46e89f813e7972:

  lib/bb/cooker.py: fix for BBFILE_PATTERN = "" (2016-11-04 12:50:29 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-npm-warnings
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-npm-warnings

Paul Eggleton (1):
  fetch2: npm: conditionally hide NPM_LOCKDOWN / NPM_SHRINKWRAP warnings

 lib/bb/fetch2/npm.py | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

-- 
2.5.5


