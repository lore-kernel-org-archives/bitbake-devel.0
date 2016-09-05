Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 9919E773B4
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Sep 2016 22:58:00 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga105.fm.intel.com with ESMTP; 05 Sep 2016 15:58:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,288,1470726000"; 
   d="scan'208";a="5310800"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com)
	([10.255.181.236])
	by orsmga004.jf.intel.com with ESMTP; 05 Sep 2016 15:57:58 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Sep 2016 10:57:27 +1200
Message-Id: <cover.1473116117.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH 0/6] npm fetcher fixes
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
X-List-Received-Date: Mon, 05 Sep 2016 22:58:04 -0000

Some fixes for issues in the npm fetcher that I found while trying to
implement support for non-npm node.js source trees.


The following changes since commit dc756510a95f88b192352be6fcd1d5d77852c348:

  bb.fetch2.svn: correctly pass workdir when fetching (2016-09-02 16:29:36 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-npm-fixes3
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-npm-fixes3

Paul Eggleton (6):
  fetch2/npm: explicitly specify workdir
  fetch2/npm: fix broken fetches if more than one npm URL fetched
  fetch2/npm: support subdir= parameter
  fetch2/npm: handle top-level shrinkwrap file
  fetch2/npm: clarify comment
  lib/bb/utils: edit_metadata() comment tweaks

 lib/bb/fetch2/npm.py | 29 +++++++++++++++++++++--------
 lib/bb/utils.py      |  4 +++-
 2 files changed, 24 insertions(+), 9 deletions(-)

-- 
2.5.5


