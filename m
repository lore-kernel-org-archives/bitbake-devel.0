Return-Path: <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id D979A60767
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 31 May 2017 21:26:27 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	31 May 2017 14:26:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.39,276,1493708400"; d="scan'208";a="94079712"
Received: from jairdeje-mobl1.zpn.intel.com ([10.219.4.146])
	by orsmga002.jf.intel.com with ESMTP; 31 May 2017 14:26:27 -0700
From: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 31 May 2017 16:26:00 -0500
Message-Id: <cover.1496259855.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [selftest][PATCH V4 0/3] QA: create unit tests for event module
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
X-List-Received-Date: Wed, 31 May 2017 21:26:29 -0000

Changed in V4:
  -Rebased branch to master.
  -Improved comments for addded clarity on enable/disable threadlock test cases
   (bb.tests.event).

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

The following changes since commit bd063fa288b49b6e3ea77982d0ccc46610feb1ad:

  tune-mips32*.inc: use consistent comments across all three .inc files (2017-05-30 10:15:20 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib jairglez/bbevents4
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=jairglez/bbevents4

Jair Gonzalez (3):
  bitbake: tests: create unit tests for event module
  bitbake: selftest: add bb.tests.event to bitbake-selftest
  bitbake: event: remove mapping for deleted event handlers

 bin/bitbake-selftest  |   1 +
 lib/bb/event.py       |   6 +-
 lib/bb/tests/event.py | 377 ++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 383 insertions(+), 1 deletion(-)
 create mode 100644 lib/bb/tests/event.py

-- 
2.7.4


