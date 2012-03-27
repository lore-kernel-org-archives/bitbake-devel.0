Received: from mga01.intel.com ([192.55.52.88])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SCNG3-0004Nd-TL
	for bitbake-devel@lists.openembedded.org;
	Tue, 27 Mar 2012 05:39:44 +0200
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 26 Mar 2012 20:30:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="145976522"
Received: from unknown (HELO shamshir.amr.corp.intel.com) ([10.255.12.109])
	by fmsmga002.fm.intel.com with ESMTP; 26 Mar 2012 20:30:42 -0700
From: Joshua Lock <josh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 26 Mar 2012 20:30:34 -0700
Message-Id: <cover.1332818913.git.josh@linux.intel.com>
X-Mailer: git-send-email 1.7.7.6
Subject: [PATCH 0/4] More Hob tweaks
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
X-List-Received-Date: Tue, 27 Mar 2012 03:39:44 -0000

Hi all,

Here's some more tweaks for Hob.

The primary/secondary button styling change is similar to the same titled patch I submitted recently only the 'Advanced settings' dialogue retains it's Save/Cancel buttons.

I've also included some layout changes to match design and ensure the widgets are not moved around when re-drawing the layout.

Cheers,
Joshua

The following changes since commit 02d3451b2e0744204a1280f9effe9fd862bb4faf:

  Hob: add build status labels in the build details screen to make it more close to the visual design (2012-03-25 12:13:58 +0100)

are available in the git repository at:
  git://github.com/incandescant/bitbake josh/hob
  https://github.com/incandescant/bitbake/tree/josh/hob

Joshua Lock (4):
  lib/bb/ui/crumbs: apply primary/secondary dialogue button styling
  lib/bb/ui/crumbs: tweak build status display
  lib/bb/ui/crumbs/imageconfigurationpage: ensure widgets stay
    positioned
  lib/bb/ui/crumbs/imagedetails: use secondary button style for 'View
    files'

 lib/bb/ui/crumbs/builddetailspage.py       |    9 ++-
 lib/bb/ui/crumbs/builder.py                |  111 +++++++++++++++++----------
 lib/bb/ui/crumbs/hig.py                    |   34 +++++----
 lib/bb/ui/crumbs/imageconfigurationpage.py |   20 ++++--
 lib/bb/ui/crumbs/imagedetailspage.py       |    6 +-
 5 files changed, 115 insertions(+), 65 deletions(-)

-- 
1.7.7.6



