Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id BAC9776806
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 26 Jan 2016 13:34:34 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga101.fm.intel.com with ESMTP; 26 Jan 2016 05:34:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,350,1449561600"; d="scan'208";a="641616579"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by FMSMGA003.fm.intel.com with ESMTP; 26 Jan 2016 05:34:33 -0800
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 26 Jan 2016 15:34:26 +0200
Message-Id: <1453815272-8303-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 0/6] Improve caching task file dependency checksum caching
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
X-List-Received-Date: Tue, 26 Jan 2016 13:34:36 -0000

This patchset improves the caching of task file dependency checksums in two
ways. First, the patchset enables writing of the cache onto disk so that the
checksums can be re-used on subsequent runs of bitbake. Previously the task
signature checksums were calculated and cached in memory but never really
saved.

Second, this patchset makes the task file dependency checksum cache file
configurable. This is intended to be used e.g. with a further patchset for
oe-core that will utilize task file dependencies heavily.

[YOCTO #8853]

Markus Lehtonen (6):
  bb/cache: drop some unused arguments
  SignatureGenerator: add method for saving the file checksum cache
  bb/runqueue: save task file dependency cache onto disk
  FileChecksumCache: add get_checksums() method
  MultiProcessCache: make cache filename configurable
  SignatureGeneratorBasic: make checksum cache file configurable

 lib/bb/cache.py           |  9 ++++----
 lib/bb/checksum.py        | 47 ++++++++++++++++++++++++++++++++++++++++
 lib/bb/codeparser.py      |  8 +++----
 lib/bb/cooker.py          |  8 +++----
 lib/bb/fetch2/__init__.py | 55 ++++++-----------------------------------------
 lib/bb/runqueue.py        |  1 +
 lib/bb/siggen.py          | 25 ++++++++++++++++++++-
 7 files changed, 91 insertions(+), 62 deletions(-)

-- 
2.1.4


