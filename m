Return-Path: <anibal.limon@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 7B365731F8
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Feb 2016 00:49:47 +0000 (UTC)
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga101.jf.intel.com with ESMTP; 22 Feb 2016 16:49:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,487,1449561600"; d="scan'208";a="751272694"
Received: from alimonb-mobl1.zpn.intel.com ([10.219.5.35])
	by orsmga003.jf.intel.com with ESMTP; 22 Feb 2016 16:49:44 -0800
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 22 Feb 2016 18:51:50 -0600
Message-Id: <1456188718-13755-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Cc: alexandru.c.georgescu@intel.com, stanciux.mihail@intel.com
Subject: [[RFC][PATCH] 0/8] Toaster improve test suite
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
X-List-Received-Date: Tue, 23 Feb 2016 00:49:48 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This set of changes refactor/improve the current test suite now it can be
parameterized from command line.

The main goal for this set of patches are for integrate the toaster
test suite into AB. The AB part is already on master. [1] If this patchset
is merged the way for run Toaster test suite will change for use it read
README in this patchset.

Futher work are related to improve/fix the current test suite also i added
a TODO list.

[1] http://git.yoctoproject.org/cgit/cgit.cgi/yocto-autobuilder/commit/?id=4ad04739d7414046775be84eeb2553d12acf94ef

Aníbal Limón (8):
  toaster/tests: Reorder/move current test code.
  toaster/tests: Add __init__.py and base.py.
  toaster/tests: Improve ui.py module.
  toaster/tests: Adds setup test case.
  toaster/tests: Add helpers.py module.
  toaster-test: Refactor and imporvements.
  toaster/tests: Add README, TODO and requeriments.
  toaster/tests: Adds Copyright information.

 bin/toaster-test                                   |  238 ++
 .../contrib/tts/toasteruitest/run_toastertests.py  |  155 --
 .../tts/toasteruitest/toaster_automation_test.py   | 2376 -------------------
 .../contrib/tts/toasteruitest/toaster_test.cfg     |   25 -
 lib/toaster/tests/README                           |   64 +
 lib/toaster/tests/TODO                             |   13 +
 lib/toaster/tests/__init__.py                      |    0
 lib/toaster/tests/base.py                          |   28 +
 lib/toaster/tests/helpers.py                       |  192 ++
 lib/toaster/tests/setup.py                         |   94 +
 lib/toaster/tests/toaster_test.cfg                 |   25 +
 lib/toaster/tests/ui.py                            | 2379 ++++++++++++++++++++
 toaster-tests-requirements.txt                     |    5 +
 13 files changed, 3038 insertions(+), 2556 deletions(-)
 create mode 100755 bin/toaster-test
 delete mode 100755 lib/toaster/contrib/tts/toasteruitest/run_toastertests.py
 delete mode 100755 lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
 delete mode 100644 lib/toaster/contrib/tts/toasteruitest/toaster_test.cfg
 create mode 100644 lib/toaster/tests/README
 create mode 100644 lib/toaster/tests/TODO
 create mode 100644 lib/toaster/tests/__init__.py
 create mode 100644 lib/toaster/tests/base.py
 create mode 100755 lib/toaster/tests/helpers.py
 create mode 100644 lib/toaster/tests/setup.py
 create mode 100644 lib/toaster/tests/toaster_test.cfg
 create mode 100644 lib/toaster/tests/ui.py
 create mode 100644 toaster-tests-requirements.txt

-- 
2.1.4


