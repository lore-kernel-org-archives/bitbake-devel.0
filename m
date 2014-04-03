Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 5745B6116C
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Apr 2014 10:16:44 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 03 Apr 2014 03:16:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,786,1389772800"; d="scan'208";a="513599191"
Received: from pmcgurk-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.120.138])
	by fmsmga002.fm.intel.com with ESMTP; 03 Apr 2014 03:16:43 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  3 Apr 2014 11:16:22 +0100
Message-Id: <cover.1396520116.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
Subject: [PATCH 0/2] A couple of Toaster data collection fixes
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
X-List-Received-Date: Thu, 03 Apr 2014 10:16:47 -0000

The following changes since commit cec33d4fdc05db3a41e978f3a1ab977730c443eb:

  user-manual-metadata.xml: Added new section on mapping functions. (2014-04-02 14:15:21 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/toaster-fixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/toaster-fixes

Paul Eggleton (2):
  toaster: fix help texts not showing for most tasks
  toaster: fix mis-detection of targets as images

 lib/bb/ui/buildinfohelper.py                       |  31 +--
 .../orm/migrations/0007_auto__add_helptext.py      | 214 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |  13 +-
 3 files changed, 244 insertions(+), 14 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0007_auto__add_helptext.py

-- 
1.9.0


