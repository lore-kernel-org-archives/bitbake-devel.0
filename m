Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 3F80B60053
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 30 Jul 2015 16:25:14 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga103.jf.intel.com with ESMTP; 30 Jul 2015 09:25:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,577,1432623600"; d="scan'208";a="758532096"
Received: from linux.intel.com ([10.23.219.25])
	by fmsmga001.fm.intel.com with ESMTP; 30 Jul 2015 09:25:15 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.65])
	by linux.intel.com (Postfix) with ESMTP id A78A36A4005;
	Thu, 30 Jul 2015 09:24:28 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 30 Jul 2015 19:25:04 +0300
Message-Id: <cover.1438271912.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 00/11] toaster: tts fixes
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
X-List-Received-Date: Thu, 30 Jul 2015 16:25:16 -0000

Hi reviewers,

This is a set of fixes for Toaster TTS testing system from Alex.

The patchset has been reviewed by me. Please review and accept.

The following changes since commit bef724057f1ea81571dd3ac5a9cf862f818434b5:

  build: Exit scripts with result of last shell function (2015-07-27 16:29:11 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib ed/toaster/submit/adamian/20150715_testfixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ed/toaster/submit/adamian/20150715_testfixes

Alexandru DAMIAN (11):
  toaster: tts: fix pylint warnings
  toaster: tts: clean up HTML5 compatible url list
  toaster tests: gitignore and use absolute path for log file
  toaster: tts: improve debugging information
  toaster: tts: improve logging in urlcheck.py
  toaster: tts: fix startup and cleanup for managed mode
  toaster: tts: delete pyc files before the tests start
  toaster: tts: delete the database only if created
  toaster: tts: make sure to import data
  toaster: tts: execute tests in numeric order
  toaster: toastergui: run pylint on the toaster files

 .gitignore                            |   3 +
 lib/toaster/contrib/tts/config.py     |  37 +++++++-----
 lib/toaster/contrib/tts/launcher.py   |  35 +++++------
 lib/toaster/contrib/tts/recv.py       |  17 ++++--
 lib/toaster/contrib/tts/runner.py     | 110 ++++++++++++++++++++--------------
 lib/toaster/contrib/tts/scratchpad.py |  20 -------
 lib/toaster/contrib/tts/shellutils.py |  64 ++++++++++----------
 lib/toaster/contrib/tts/tests.py      |  63 ++++++++++---------
 lib/toaster/contrib/tts/urlcheck.py   |  38 ++++++++----
 lib/toaster/contrib/tts/urllist.py    |  83 ++++++++++++-------------
 10 files changed, 250 insertions(+), 220 deletions(-)
 delete mode 100644 lib/toaster/contrib/tts/scratchpad.py

--
Regards,
Ed

