Return-Path: <jussi.kukkonen@intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 4722C6FF91
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jun 2016 12:20:01 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP; 20 Jun 2016 05:19:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.26,498,1459839600"; d="scan'208";a="125265981"
Received: from theory.fi.intel.com ([10.237.72.196])
	by fmsmga004.fm.intel.com with ESMTP; 20 Jun 2016 05:19:59 -0700
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Jun 2016 15:19:51 +0300
Message-Id: <cover.1466424068.git.jussi.kukkonen@intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCHv2 0/1] depexp.py: port to gtk+3
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
X-List-Received-Date: Mon, 20 Jun 2016 12:20:02 -0000

This is based on Maxins patch from June 17th.

Changes since v1:
* Bring back the progress bar
* Call Gtk.init_check() in the correct thread
* Handle Gtk.init_check() return value properly


Jussi


The following changes since commit 09d08340fe0fca6f551c33d2fdcafb72f52812d2:

  Revert "cmake.bbclass: set the modules directory correctly" (2016-06-20 08:40:21 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib jku/depexp
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=jku/depexp

Jussi Kukkonen (1):
  bitbake: depexp.py: port to gtk+3

 bitbake/lib/bb/ui/depexp.py | 159 ++++++++++++++++++++++----------------------
 1 file changed, 80 insertions(+), 79 deletions(-)

-- 
2.1.4


