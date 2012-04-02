Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SEcLe-0007d5-LY
	for bitbake-devel@lists.openembedded.org;
	Mon, 02 Apr 2012 10:10:46 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 02 Apr 2012 01:01:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="136468683"
Received: from yocto-build5.sh.intel.com (HELO localhost) ([10.239.48.3])
	by fmsmga001.fm.intel.com with ESMTP; 02 Apr 2012 01:01:36 -0700
From: Shane Wang <shane.wang@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  2 Apr 2012 16:29:12 +0800
Message-Id: <cover.1333355236.git.shane.wang@intel.com>
X-Mailer: git-send-email 1.7.6
Subject: [PATCH 0/6][Resend] Hob fixes
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
X-List-Received-Date: Mon, 02 Apr 2012 08:10:46 -0000

One of these patches is to fix a bug by removing the top empty spacing in
the image combo on the image configuration screen.

The others are minor cleanup and code correction by code review.


The following changes since commit 8691a588267472eb5a32b978a0eb9ddfd0c91733:

  cross-canadian.bbclass: fix rpath for sdk executables (2012-03-31 18:00:59 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib shane/hob-fixes-1
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=shane/hob-fixes-1

Shane Wang (6):
  Hob: handle exceptions in get_parameters() from the bitbake
  Hob: handle exceptions when loading templates
  Hob: unify _size_to_string() and _string_to_size()
  Hob: avoid the empty white space appearing on top of the gtk.ComboBox
  Hob: a minor fix on image_fstypes
  Hob: a minor fix on pmake

 bitbake/lib/bb/ui/crumbs/builder.py                |   26 ++++++++++----
 bitbake/lib/bb/ui/crumbs/hobeventhandler.py        |   35 ++++++++++++++----
 bitbake/lib/bb/ui/crumbs/hoblistmodel.py           |   18 +++------
 bitbake/lib/bb/ui/crumbs/hobpages.py               |   39 ++++++++++++++++++++
 bitbake/lib/bb/ui/crumbs/imageconfigurationpage.py |    2 +
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py       |   11 +-----
 bitbake/lib/bb/ui/crumbs/packageselectionpage.py   |   21 +++--------
 7 files changed, 99 insertions(+), 53 deletions(-)

-- 
1.7.6



