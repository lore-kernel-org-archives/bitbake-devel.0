Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id DDA756FFE2
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Mar 2016 04:28:09 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga102.jf.intel.com with ESMTP; 06 Mar 2016 20:28:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,549,1449561600"; d="scan'208";a="918275384"
Received: from kgoh8-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.138.205])
	by fmsmga001.fm.intel.com with ESMTP; 06 Mar 2016 20:28:07 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Mar 2016 17:27:34 +1300
Message-Id: <cover.1457324829.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.0
Subject: [PATCH 0/3] npm fetcher fixes
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
X-List-Received-Date: Mon, 07 Mar 2016 04:28:10 -0000

The following changes since commit 19507b80f35d37dc4b1614bd390b8e261dd4a2bd:

  bitbake-user-manual: Added expand() function to list. (2016-03-03 17:33:59 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-npm-fixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-npm-fixes

Paul Eggleton (3):
  fetch2/npm: fix indentation
  fetch2/npm: handle alternative dependency syntax
  fetch2/npm: ignore unknown headers in tarballs

 lib/bb/fetch2/npm.py | 50 ++++++++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

-- 
2.5.0


