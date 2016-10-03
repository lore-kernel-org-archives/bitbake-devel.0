Return-Path: <brian.avery@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 9A4F7719E9
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  3 Oct 2016 23:54:56 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by orsmga103.jf.intel.com with ESMTP; 03 Oct 2016 16:54:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.31,292,1473145200"; d="scan'208";a="15932495"
Received: from bavery-ws-desk.jf.intel.com ([10.7.198.85])
	by orsmga005.jf.intel.com with ESMTP; 03 Oct 2016 16:54:57 -0700
From: bavery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  3 Oct 2016 16:56:21 -0700
Message-Id: <cover.1475538792.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: bavery <brian.avery@intel.com>
Subject: [PATCH 0/1] toaster: add Font Awesome license
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
X-List-Received-Date: Mon, 03 Oct 2016 23:55:02 -0000

Font Awesome fonts are bundled with the Toaster UI and are released
under the SIL Open Font License 1.1.  This patch adds that information
to the LICENSE file.

-bavery

The following changes since commit 3a73fe0efcb7aeefcca7011bba887caad03d4d03:

  beaglebone.conf: produce wic images for Beaglebone (2016-10-01 21:45:57 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/fontawesome
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/fontawesome

bavery (1):
  toaster: add Font Awesome license

 LICENSE | 2 ++
 1 file changed, 2 insertions(+)

--
1.9.1

