Received: from mga02.intel.com ([134.134.136.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SIUEv-0005LH-1u
	for bitbake-devel@lists.openembedded.org;
	Fri, 13 Apr 2012 02:19:49 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 12 Apr 2012 17:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,351,1309762800"; d="scan'208";a="131859607"
Received: from unknown (HELO shamshir.jf.intel.com) ([10.7.198.147])
	by orsmga002.jf.intel.com with ESMTP; 12 Apr 2012 17:10:27 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 12 Apr 2012 17:10:20 -0700
Message-Id: <cover.1334275549.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [RFC PATCH 0/3] Replace HobNotebook with gtk.Notebook
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 13 Apr 2012 00:19:49 -0000

The important patch in this RFC is the first which replaces the fully custom
HobNotebook with a simpler gtk.Notebook subclass.

It's an RFC as there's currently what looks like a rendering glitch in how the
tabs are displayed. See the white boxes in the tabs of this screenshot:
https://bugzilla.yoctoproject.org/attachment.cgi?id=465

I'm researching how to remove this artifact but wanted to gather feedback on the
patch as it stands as we are close to the checkin deadline.

Thanks,
Joshua

The following changes since commit 3c2808b67384e92601cbd66877c36ca40df7c7ba:

  Hob: fix the missing functions (2012-04-12 15:56:42 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake josh/hob
  https://github.com/incandescant/bitbake/tree/josh/hob

Joshua Lock (3):
  lib/bb/ui/crumbs/: replace custom HobNotebook
  lib/bb/ui/crumbs/hobwidget: use light text in HobIndicator
  lib/bb/ui/crumbs/imageconfiguration: fix combo boxes drop-down width

 lib/bb/ui/crumbs/builddetailspage.py       |    4 +-
 lib/bb/ui/crumbs/hobwidget.py              |  468 +++++-----------------------
 lib/bb/ui/crumbs/imageconfigurationpage.py |    2 -
 lib/bb/ui/crumbs/packageselectionpage.py   |    3 +-
 lib/bb/ui/crumbs/recipeselectionpage.py    |    5 +-
 5 files changed, 82 insertions(+), 400 deletions(-)

-- 
1.7.7.6



