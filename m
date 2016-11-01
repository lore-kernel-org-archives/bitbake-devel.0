Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id BFE2871A8D
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  1 Nov 2016 15:05:13 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga105.jf.intel.com with ESMTP; 01 Nov 2016 08:05:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,580,1473145200"; d="scan'208";a="186337513"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2016 08:05:13 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  1 Nov 2016 17:05:10 +0200
Message-Id: <1478012712-17287-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
Subject: [PATCH 0/2] Fixes in exception handling
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
X-List-Received-Date: Tue, 01 Nov 2016 15:05:13 -0000

The first patch of these fixes an obvious bug in bb.data.exported_vars(). I'm
not entirely certain about the solution, though. That is, we keep ignoring
exceptions, although we now print a warning if exceptions are caught. The
reason I did not change the code to start raising exceptions is that I didn't
want to break existing builds.

The second patch is just meant to make debugging these kind of issues easier in
the future.

[YOCTO #10393]

The following changes since commit 00f79096f639ce3a9c0b7c72cfb36f14e264733d:

  toaster: Update default release to Morty (2016-10-15 13:21:49 +0100)

are available in the git repository at:

  git://git.openembedded.org/openembedded-core-contrib marquiz/bitbake/fixes-10393
  http://git.openembedded.org/openembedded-core-contrib/log/?h=marquiz/bitbake/fixes-10393


Markus Lehtonen (2):
  data: fix exception handling in exported_vars()
  bitbake-worker: print full traceback instead of message only

 bin/bitbake-worker | 5 +++--
 lib/bb/data.py     | 8 +++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

-- 
2.6.6


