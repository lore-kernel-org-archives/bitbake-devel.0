Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 971896CE3F
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  1 Nov 2013 15:58:38 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga102.jf.intel.com with ESMTP; 01 Nov 2013 08:55:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.93,535,1378882800"; d="scan'208";a="428337408"
Received: from unknown (HELO helios.ger.corp.intel.com) ([10.252.121.91])
	by orsmga002.jf.intel.com with ESMTP; 01 Nov 2013 08:58:39 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  1 Nov 2013 15:58:27 +0000
Message-Id: <cover.1383321482.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH 0/8] Toaster-related improvements
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
X-List-Received-Date: Fri, 01 Nov 2013 15:58:39 -0000

The following changes since commit f3ac2d3678f48c68a250a0a20c08cf8687322d38:

  monitordisk: lower inode check warning to note (2013-10-18 16:02:10 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/toaster2-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/toaster2-bb

Alexandru DAMIAN (7):
  toaster: fixes for null values from events
  cooker: add data to the dependency tree dump
  cooker: do not recreate recipecache in buildfile mode
  build, toaster: record proper task type
  toaster: fix timezone settings
  toaster: server shutdown on terminal exit
  toaster: enable required classes in the toaster startup script

Cristiana Voicu (1):
  toaster: add variable description for prefixed/suffixed variables

 bin/toaster                         | 41 +++++++++++++++++++++--------
 lib/bb/build.py                     |  7 ++++-
 lib/bb/cooker.py                    |  3 ++-
 lib/bb/ui/buildinfohelper.py        | 52 ++++++++++++++++++++-----------------
 lib/bb/ui/toasterui.py              |  3 +--
 lib/toaster/orm/models.py           |  8 +++---
 lib/toaster/toastermain/settings.py |  5 ++--
 7 files changed, 75 insertions(+), 44 deletions(-)

-- 
1.8.1.2


