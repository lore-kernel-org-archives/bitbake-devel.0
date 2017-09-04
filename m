Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id AA8746FFD7
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Sep 2017 09:03:51 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	04 Sep 2017 02:03:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,474,1498546800"; d="scan'208";a="1191290657"
Received: from nabmajid-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.129.136])
	by fmsmga001.fm.intel.com with ESMTP; 04 Sep 2017 02:03:48 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  4 Sep 2017 21:03:10 +1200
Message-Id: <cover.1504515728.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
Subject: [PATCH 0/2] A couple of signature fixes
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
X-List-Received-Date: Mon, 04 Sep 2017 09:03:51 -0000

A fix for taskhash mismatch errors seen with BB_SERVER_TIMEOUT set as
well as a cleanup patch for siggen.py.


The following changes since commit 7234f33a7eb38ad51a8345f6689bc26e29f29f92:

  cooker: Ensure parseConfiguration clears parsecache_valid (2017-09-01 16:59:35 +0100)

are available in the git repository at:

  git://git.openembedded.org/bitbake-contrib paule/sigfixes
  http://cgit.openembedded.org/bitbake-contrib/log/?h=paule/sigfixes

Paul Eggleton (2):
  cooker: clear extra config settings and remote datastores on client
    disconnect
  siggen: move reset() definition to base SignatureGenerator class

 lib/bb/command.py | 3 +++
 lib/bb/cooker.py  | 2 ++
 lib/bb/siggen.py  | 6 ++----
 3 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.9.5


