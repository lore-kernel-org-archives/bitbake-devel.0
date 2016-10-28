Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 42A7371DA8
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Oct 2016 15:48:49 +0000 (UTC)
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga105.fm.intel.com with ESMTP; 28 Oct 2016 08:48:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,410,1473145200"; d="scan'208";a="24800150"
Received: from linux.intel.com ([10.54.29.200])
	by fmsmga006.fm.intel.com with ESMTP; 28 Oct 2016 08:48:51 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id D2F2F6A4006;
	Fri, 28 Oct 2016 08:48:15 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Oct 2016 18:48:39 +0300
Message-Id: <cover.1477669486.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 0/8] toaster: Fixes and clean ups
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
X-List-Received-Date: Fri, 28 Oct 2016 15:48:53 -0000

Hi,

This is series is available on the poky-contrib repository branch michaelw/toaster/tests_fixes_and_clean_ups

Note: this removes the tts contrib directory which is redundant.

The following changes since commit ef627ab364d52fe19994c94c1a78fbe21620a32c:

  local.conf.sample.extended: remove RM_OLD_IMAGE (2016-10-19 17:07:41 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib ed/toaster/submit/michaelw/toaster/tests_fixes_and_clean_ups
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ed/toaster/submit/michaelw/toaster/tests_fixes_and_clean_ups

Michael Wood (8):
  toaster: views Tests fix all pyflake identified issues
  toaster: Move views tests to main testing module
  toaster: Delete useless bldcontrol/test
  toaster: Remove contrib tts
  toaster: test browser test_layerdetails_page add wait_until_visible
  toaster: orm models Handle run builds process not yet running
  toaster: tests builds Update buildtest
  toaster: tests builds test_core_image_min Clean ups

 lib/toaster/bldcontrol/tests.py                    |  141 --
 lib/toaster/contrib/README                         |    6 -
 lib/toaster/contrib/tts/README                     |   41 -
 lib/toaster/contrib/tts/TODO                       |    9 -
 lib/toaster/contrib/tts/config.py                  |   98 -
 lib/toaster/contrib/tts/launcher.py                |  101 -
 lib/toaster/contrib/tts/recv.py                    |   56 -
 lib/toaster/contrib/tts/runner.py                  |  222 --
 lib/toaster/contrib/tts/settings.json              |    5 -
 lib/toaster/contrib/tts/shellutils.py              |  141 --
 lib/toaster/contrib/tts/tests.py                   |  115 -
 .../contrib/tts/toasteruitest/run_toastertests.py  |  155 --
 .../tts/toasteruitest/toaster_automation_test.py   | 2376 --------------------
 .../contrib/tts/toasteruitest/toaster_test.cfg     |   25 -
 lib/toaster/contrib/tts/urlcheck.py                |   53 -
 lib/toaster/contrib/tts/urllist.py                 |   39 -
 lib/toaster/orm/models.py                          |    8 +-
 .../tests/browser/test_layerdetails_page.py        |    3 +-
 lib/toaster/tests/builds/buildtest.py              |  129 +-
 lib/toaster/tests/builds/test_core_image_min.py    |   50 +-
 lib/toaster/tests/views/README                     |    4 +
 .../tts/log/.create => tests/views/__init__.py}    |    0
 .../tests.py => tests/views/test_views.py}         |   95 +-
 23 files changed, 160 insertions(+), 3712 deletions(-)
 delete mode 100644 bitbake/lib/toaster/bldcontrol/tests.py
 delete mode 100644 bitbake/lib/toaster/contrib/README
 delete mode 100644 bitbake/lib/toaster/contrib/tts/README
 delete mode 100644 bitbake/lib/toaster/contrib/tts/TODO
 delete mode 100644 bitbake/lib/toaster/contrib/tts/config.py
 delete mode 100755 bitbake/lib/toaster/contrib/tts/launcher.py
 delete mode 100755 bitbake/lib/toaster/contrib/tts/recv.py
 delete mode 100755 bitbake/lib/toaster/contrib/tts/runner.py
 delete mode 100644 bitbake/lib/toaster/contrib/tts/settings.json
 delete mode 100644 bitbake/lib/toaster/contrib/tts/shellutils.py
 delete mode 100644 bitbake/lib/toaster/contrib/tts/tests.py
 delete mode 100755 bitbake/lib/toaster/contrib/tts/toasteruitest/run_toastertests.py
 delete mode 100755 bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_automation_test.py
 delete mode 100644 bitbake/lib/toaster/contrib/tts/toasteruitest/toaster_test.cfg
 delete mode 100644 bitbake/lib/toaster/contrib/tts/urlcheck.py
 delete mode 100644 bitbake/lib/toaster/contrib/tts/urllist.py
 create mode 100644 bitbake/lib/toaster/tests/views/README
 rename bitbake/lib/toaster/{contrib/tts/log/.create => tests/views/__init__.py} (100%)
 rename bitbake/lib/toaster/{toastergui/tests.py => tests/views/test_views.py} (89%)

-- 
2.1.4


