Received: from mga11.intel.com ([192.55.52.93])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <dongxiao.xu@intel.com>) id 1SUAtc-0002p7-B3
	for bitbake-devel@lists.openembedded.org;
	Tue, 15 May 2012 08:06:08 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga102.fm.intel.com with ESMTP; 14 May 2012 22:56:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="153031553"
Received: from dongxiao-osel.sh.intel.com (HELO localhost) ([10.239.36.11])
	by fmsmga001.fm.intel.com with ESMTP; 14 May 2012 22:56:06 -0700
From: Dongxiao Xu <dongxiao.xu@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 15 May 2012 13:52:13 +0800
Message-Id: <cover.1337060999.git.dongxiao.xu@intel.com>
X-Mailer: git-send-email 1.7.4.1
Subject: [PATCH 0/2][PULL] Hob: Add white/black pattern to filter images
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
X-List-Received-Date: Tue, 15 May 2012 06:06:08 -0000

Hi Richard,

This pull request adds white/black pattern to filter images listed in image combobox.

Besides, it fixes a small issue on update_image_desc() function.

Please help to review and pull.

Thanks,
Dongxiao

The following changes since commit f8bf4499549f978ce7c93bc088a66f74cd751e2c:

  setup.py: fix path for bitbake-selftest (2012-05-13 20:01:59 +0100)

are available in the git repository at:
  git://git.pokylinux.org/poky-contrib dxu4/hob-bugfix
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=dxu4/hob-bugfix

Dongxiao Xu (2):
  Hob: Add filter for images listed in image combo
  Hob: Get image name internally when updating the image description

 lib/bb/ui/crumbs/builder.py                |    6 +++-
 lib/bb/ui/crumbs/hobeventhandler.py        |    2 +
 lib/bb/ui/crumbs/imageconfigurationpage.py |   42 ++++++++++++++++++++++++----
 3 files changed, 43 insertions(+), 7 deletions(-)

-- 
1.7.4.1



