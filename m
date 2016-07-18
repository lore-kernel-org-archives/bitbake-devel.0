Return-Path: <ed.bartosh@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id DD8EA60797
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jul 2016 16:31:54 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by fmsmga103.fm.intel.com with ESMTP; 18 Jul 2016 09:31:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,384,1464678000"; d="scan'208";a="736167549"
Received: from linux.intel.com ([10.54.29.200])
	by FMSMGA003.fm.intel.com with ESMTP; 18 Jul 2016 09:31:42 -0700
Received: from vmed.fi.intel.com (vmed.fi.intel.com [10.237.72.68])
	by linux.intel.com (Postfix) with ESMTP id CEB766A4080
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jul 2016 09:31:31 -0700 (PDT)
From: Ed Bartosh <ed.bartosh@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 18 Jul 2016 19:07:15 +0300
Message-Id: <cover.1468857803.git.ed.bartosh@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 0/3] Autostart bitbake server
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
X-List-Received-Date: Mon, 18 Jul 2016 16:31:56 -0000

Hi,

This patchet contains implementation of autostart feature. Bitbake server
is automatically started if BBSERVER variable is set to 'autostart'.

The following changes since commit 627d01997fcf6a0581d88047735769ffb2592b82:

  useradd-staticids: use map() instead of imap() (2016-07-12 23:12:00 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib ed/bitbake/resident-autoload-5534
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=ed/bitbake/resident-autoload-5534

Ed Bartosh (3):
  bitbake: xmlrpc: implement check of connection to server
  bitbake: utils: add BBSERVER to the list of preserved variables
  bitbake: main: implement server autostart feature

 bitbake/lib/bb/main.py          | 21 ++++++++++++++++-----
 bitbake/lib/bb/server/xmlrpc.py | 17 +++++++++++++++++
 bitbake/lib/bb/utils.py         |  1 +
 3 files changed, 34 insertions(+), 5 deletions(-)

---
Regards,
Ed



