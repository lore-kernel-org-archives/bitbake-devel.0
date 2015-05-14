Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id E40946013D
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 14 May 2015 13:33:59 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga103.fm.intel.com with ESMTP; 14 May 2015 06:34:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,427,1427785200"; d="scan'208";a="710148891"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com) ([10.252.30.48])
	by fmsmga001.fm.intel.com with ESMTP; 14 May 2015 06:34:00 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 14 May 2015 14:33:48 +0100
Message-Id: <cover.1431610370.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH 0/2] Git fetcher remote fix
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
X-List-Received-Date: Thu, 14 May 2015 13:34:00 -0000

A minor fix for the git fetcher in aid of OE's devtool, as well as a fix
for a bitbake-selftest issue I noticed at the same time.


The following changes since commit c7263096ba31ba45daeeb9de90c1cb9ebef24a28:

  fetch2: Add BB_ALLOWED_NETWORKS support (2015-05-12 12:17:08 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/fetchfix
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/fetchfix

Paul Eggleton (2):
  fetch2/git: ensure the unpacked origin remote points upstream
  tests/fetch: ensure fetch tests preserve current dir

 lib/bb/fetch2/git.py  | 31 +++++++++++++++++--------------
 lib/bb/tests/fetch.py |  2 ++
 2 files changed, 19 insertions(+), 14 deletions(-)

-- 
2.1.0


