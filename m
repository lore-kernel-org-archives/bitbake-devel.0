Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id C9A6D60D67
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Dec 2013 14:48:58 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 20 Dec 2013 06:48:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.95,521,1384329600"; d="scan'208";a="453335465"
Received: from dsgunati-mobl.gar.corp.intel.com (HELO
	helios.ger.corp.intel.com) ([10.252.122.40])
	by fmsmga002.fm.intel.com with ESMTP; 20 Dec 2013 06:48:58 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 20 Dec 2013 14:48:43 +0000
Message-Id: <cover.1387550848.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.8.1.2
Subject: [PATCH 0/2] SRC_URI checksum handling fixes
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
X-List-Received-Date: Fri, 20 Dec 2013 14:49:00 -0000

The following changes since commit 4cc6e61fe11eb233bdba7c1bdc110b8cdafa56f8:

  Update to version 1.21.1 for master (2013-12-20 12:23:12 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-fetch-checksums
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-fetch-checksums

Paul Eggleton (2):
  fetch2: fail checksum validation if SRC_URI checksums set to ""
  fetch2: avoid printing "no checksum" error message twice

 lib/bb/fetch2/__init__.py | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

-- 
1.8.1.2


