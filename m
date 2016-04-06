Return-Path: <elliot.smith@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 70E8177029
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  6 Apr 2016 13:54:38 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 06 Apr 2016 06:54:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.24,447,1455004800"; d="scan'208";a="952922946"
Received: from lmcenteg-mobl4.ger.corp.intel.com (HELO lp.ger.corp.intel.com)
	([10.252.21.33])
	by fmsmga002.fm.intel.com with ESMTP; 06 Apr 2016 06:54:36 -0700
From: Elliot Smith <elliot.smith@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  6 Apr 2016 14:54:29 +0100
Message-Id: <cover.1459950757.git.elliot.smith@intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/6] Incorporate QUnit tests
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
X-List-Received-Date: Wed, 06 Apr 2016 13:54:38 -0000

Modify QUnit tests so that they run as part of the Selenium test suite.

The following changes since commit 385df903ddf0c8647667d7025c2bfd6175e98fa5
(toaster-next):

  toaster: add rev dep column to image detail pages (2016-04-06 14:43:57 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib elliot/toaster/michaelw/unit_tests
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=elliot/toaster/michaelw/unit_tests

Elliot Smith (1):
  bitbake: update LICENSE file with QUnit details

Michael Wood (5):
  toaster: Add quint to project so that it can be used offline
  toaster: tests Set MACHINE for the test projects
  toaster: views jsunittest Add MACHINE and an extra layer to test
    project
  toaster: testsjs Add call back to append elements on completion of
    tests
  tests: browser Add test to run the js unit tests

 LICENSE                                            |   2 +
 lib/toaster/tests/browser/test_js_unit_tests.py    |  57 ++++
 .../fixtures/toastergui-unittest-data.xml          |   4 +-
 lib/toaster/toastergui/static/css/qunit-1.18.0.css |   1 +
 lib/toaster/toastergui/static/js/qunit-1.18.0.js   | 347 +++++++++++++++++++++
 lib/toaster/toastergui/static/js/tests/test.js     |   7 +
 .../toastergui/templates/js-unit-tests.html        |   4 +-
 lib/toaster/toastergui/views.py                    |  18 +-
 8 files changed, 432 insertions(+), 8 deletions(-)
 create mode 100644 bitbake/lib/toaster/tests/browser/test_js_unit_tests.py
 create mode 100644 bitbake/lib/toaster/toastergui/static/css/qunit-1.18.0.css
 create mode 100644 bitbake/lib/toaster/toastergui/static/js/qunit-1.18.0.js

--
1.9.3

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.


