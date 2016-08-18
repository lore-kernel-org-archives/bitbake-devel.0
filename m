Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 0A5727687B
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Aug 2016 16:55:56 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga103.jf.intel.com with ESMTP; 18 Aug 2016 09:55:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,540,1464678000"; d="scan'208";a="1016782674"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by orsmga001.jf.intel.com with ESMTP; 18 Aug 2016 09:55:55 -0700
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 18 Aug 2016 19:55:50 +0300
Message-Id: <1471539354-32382-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
Subject: [PATCH 0/4] Improvements to bitbake-selftest
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
X-List-Received-Date: Thu, 18 Aug 2016 16:55:58 -0000

This patchset aims at making it easier to debug and develop bitbake unit tests.
It makes it possible to have finer control of which tests to run and improves
the console output, especially for failed tests. One patch also allows
preserving temporary directories for deeper debugging.

The following changes since commit 3ff1c66e6f336e5de7dcbc983a97fcd19ddc6b81:

  bitbake: Update version to 1.31.1 (2016-08-18 10:05:26 +0100)

are available in the git repository at:

  git://git.openembedded.org/openembedded-core-contrib marquiz/bitbake/unittest
  http://git.openembedded.org/openembedded-core-contrib/log/?h=marquiz/bitbake/unittest


Markus Lehtonen (4):
  bitbake-selftest: utilize unittest.main better
  bitbake-selftest: add help text for env variable(s)
  bitbake-selftest: introduce BB_TMPDIR_NOCLEAN
  bitbake-selftest: enable bitbake logging to stdout

 bin/bitbake-selftest  | 61 ++++++++++++++++++++++++++++++++-------------------
 lib/bb/tests/fetch.py |  5 ++++-
 2 files changed, 43 insertions(+), 23 deletions(-)

-- 
2.6.6


