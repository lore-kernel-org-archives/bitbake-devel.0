Return-Path: <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by mail.openembedded.org (Postfix) with ESMTP id F1D87719BA
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 23 Jan 2017 23:26:08 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga105.jf.intel.com with ESMTP; 23 Jan 2017 15:26:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,275,1477983600"; d="scan'208";a="34475196"
Received: from jairdeje-mobl1.zpn.intel.com ([10.219.128.79])
	by orsmga002.jf.intel.com with ESMTP; 23 Jan 2017 15:26:08 -0800
From: Jair Gonzalez <jair.de.jesus.gonzalez.plascencia@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 23 Jan 2017 17:25:45 -0600
Message-Id: <cover.1485212879.git.jair.de.jesus.gonzalez.plascencia@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [[selftest][PATCH] 0/2] QA: create unit tests for event module
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
X-List-Received-Date: Mon, 23 Jan 2017 23:26:09 -0000

This patch set adds a test unit to the bitbake event module and appends it
to the bitbake-selftest script's dictionary containing the list of the default
tests to run when the script is executed without arguments.

The following changes since commit b47ecf28775830efab423fa12f0addb68671cc06:

  poky.ent: Added "pip3" as an essential host installation package (2017-01-20 11:57:25 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib jairglez/bbevents
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=jairglez/bbevents

Jair Gonzalez (2):
  bitbake: tests: create unit tests for event module
  bitbake: selftest: add bb.tests.event to bitbake-selftest

 bitbake/bin/bitbake-selftest  |   1 +
 bitbake/lib/bb/tests/event.py | 324 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 325 insertions(+)
 create mode 100644 bitbake/lib/bb/tests/event.py

-- 
2.7.4


