Return-Path: <joshua.g.lock@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id CAA5B7016E
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 May 2016 09:10:58 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga101.fm.intel.com with ESMTP; 09 May 2016 02:10:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,600,1455004800"; d="scan'208";a="949088271"
Received: from jlock-mobl2.ger.corp.intel.com ([10.252.11.52])
	by orsmga001.jf.intel.com with ESMTP; 09 May 2016 02:10:57 -0700
From: Joshua Lock <joshua.g.lock@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 May 2016 10:10:53 +0100
Message-Id: <cover.1462784896.git.joshua.g.lock@intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [1.26][PATCH 0/2] Backport fixes for bitbake-selftest
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
X-List-Received-Date: Mon, 09 May 2016 09:10:58 -0000

When trying to run a fido build on the Yocto Project autobuilder I saw one
error and one failure in the bitbake-selftest. This pull request backports
fixes for these issues.

The following changes since commit b09966906ef054834f0b465f0c5a2a937b4c4a4c:

  toaster: Rework mimetype guessing to fix artifact downloads (2015-12-18 12:16:34 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib joshuagl/bitbake-fido
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=joshuagl/bitbake-fido

Paul Eggleton (1):
  tests/fetch: ensure fetch tests preserve current dir

Richard Purdie (1):
  bb/tests/fetch: Update cups url

 lib/bb/tests/fetch.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
2.5.5


