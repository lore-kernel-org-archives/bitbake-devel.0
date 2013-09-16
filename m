Return-Path: <ddalex@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 91D9160662
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Sep 2013 11:56:34 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 16 Sep 2013 04:56:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.90,914,1371106800"; d="scan'208";a="402317182"
Received: from adamian-desktop.isw.intel.com ([10.237.224.35])
	by fmsmga002.fm.intel.com with ESMTP; 16 Sep 2013 04:56:35 -0700
Received: by adamian-desktop.isw.intel.com (Postfix, from userid 1000)
	id 027B8560407; Mon, 16 Sep 2013 12:56:35 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	richard.purdie@linuxfoundation.org
Date: Mon, 16 Sep 2013 12:56:26 +0100
Message-Id: <cover.1379332511.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.1.2
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 0/8] webhob related changes in bitbake, version 2
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
X-List-Received-Date: Mon, 16 Sep 2013 11:56:35 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

I'm sending in version 2 of the patches that bring in changes that prepare bitbake
for supporting WebHob-related tasks.

The changes focus on improving and standardizing the information sent through
the event system, and cleaning up code in bitbake.

The following changes since commit 5fca4d286eec240ad57d90defa43cd0ff24f88ed:

  linux-yocto/3.10: genericx86 meta data factoring (2013-09-14 08:36:26 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/bitbake-core-changes-1609
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/bitbake-core-changes-1609

Alexandru DAMIAN (8):
  bitbake: cooker: clean up code and avoid duplication
  bitbake: event: send the task dependency tree to UI
  bitbake: runqueue: add runQueueTaskSkipped event
  bitbake: cooker: add extra recipe information
  bitbake: build: add logfile path for all Task events
  bitbake: cooker, command: add a command to return global data
  bitbake: event: adding events to allow bbclasses to push custom info
  bitbake: runqueue: add task hash to Queue events

 bitbake/lib/bb/build.py     | 18 ++++++++---
 bitbake/lib/bb/command.py   |  8 +++++
 bitbake/lib/bb/cooker.py    | 79 +++++++++++++++++++++++++++++----------------
 bitbake/lib/bb/event.py     | 16 +++++++++
 bitbake/lib/bb/runqueue.py  | 35 ++++++++++++++++++--
 bitbake/lib/bb/ui/knotty.py |  5 +++
 6 files changed, 125 insertions(+), 36 deletions(-)

-- 
1.8.1.2


