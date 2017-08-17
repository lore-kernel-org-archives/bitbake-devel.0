Return-Path: <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 0F7CE7846E
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 17 Aug 2017 20:41:17 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	17 Aug 2017 13:41:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,389,1498546800"; d="scan'208";a="891183021"
Received: from jairdeje-mobl1.zpn.intel.com ([10.219.4.45])
	by FMSMGA003.fm.intel.com with ESMTP; 17 Aug 2017 13:41:14 -0700
From: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 17 Aug 2017 15:40:49 -0500
Message-Id: <cover.1503000752.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [selftest][PATCH V1 0/5] QA: Extend unit tests for event module
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
X-List-Received-Date: Thu, 17 Aug 2017 20:41:18 -0000

Included on V1:
 
  This patch-set extends the unit test module for bitbake event
  including increased coverage for event filtering features and
  testing of public interfaces of event and helper classes. It
  also includes two small fixes for issues found during the unit
  test development.

[YOCTO #10773]

The following changes since commit 6016ec177af2406cacfeb3276dfcb8bfc3df8fce:

  poky.conf: Enable vulkan by default (2017-08-16 00:04:39 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib jairglez/bbevent_extended
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=jairglez/bbevent_extended

Jair Gonzalez (5):
  bitbake: tests: Include tests for event filtering features
  bitbake: tests: Add test for bb.event.worker_fire
  bitbake: tests: Remove empty assignments from event tests
  bitbake: tests: Initialize data attribute on BuildBase event
  bitbake: tests: Add event classes test class

 lib/bb/event.py       |   1 +
 lib/bb/tests/event.py | 646 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 634 insertions(+), 13 deletions(-)

-- 
2.7.4


