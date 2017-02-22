Return-Path: <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 3240172F37
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Feb 2017 00:00:29 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	21 Feb 2017 16:00:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.35,191,1484035200"; d="scan'208";a="68032364"
Received: from jairdeje-mobl1.zpn.intel.com ([10.219.4.48])
	by fmsmga005.fm.intel.com with ESMTP; 21 Feb 2017 16:00:30 -0800
From: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Feb 2017 18:00:06 -0600
Message-Id: <cover.1487720132.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [selftest][PATCH V3 0/3] QA: create unit tests for event module
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
X-List-Received-Date: Wed, 22 Feb 2017 00:00:30 -0000

Changed in V3:
  Changed patches to be relative to bitbake devel tree.

Changed in V2:
  On bb.tests.event:
    - Fixed copyright typo.
    - Added assertions for event types in event handler calls.
    - Changed sleep calls on test_enable_threadlock and 
      test_disable_threadlock to the order of seconds to prevent an overlap
      offset because a thread scheduler's delay. Improved both tests by
      testing the event type and call order differentiating events coming
      from each worker thread.
  On bb.event:
    - Added commit to upgrade the remove method on bb.event class by
      updating the event mapping after a class event handler is removed.
      This fix is necessary for bitbake-selftest to pass
      test_change_handler_event_mapping.

[YOCTO #10368]

The following changes since commit e436a6398684d2872cb541f1cfb0f67b3618d15a:

  layer.conf: bump version for change in eSDK selftest behaviour (2017-02-19 09:39:03 -0800)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib jairglez/bbevents2
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=jairglez/bbevents2

Jair Gonzalez (3):
  bitbake: tests: create unit tests for event module
  bitbake: selftest: add bb.tests.event to bitbake-selftest
  bitbake: event: remove mapping for deleted event handlers

 bin/bitbake-selftest  |   1 +
 lib/bb/event.py       |   6 +-
 lib/bb/tests/event.py | 372 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 378 insertions(+), 1 deletion(-)
 create mode 100644 lib/bb/tests/event.py

-- 
2.7.4


