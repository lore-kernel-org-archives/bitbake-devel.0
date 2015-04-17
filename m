Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id D2B4B73D92
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 Apr 2015 14:27:18 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 17 Apr 2015 07:27:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.11,595,1422950400"; d="scan'208";a="710873720"
Received: from pbrao1-mobl5.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.13.156])
	by fmsmga002.fm.intel.com with ESMTP; 17 Apr 2015 07:27:19 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 Apr 2015 15:26:58 +0100
Message-Id: <cover.1429280244.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.1.0
Subject: [PATCH 0/1] Add deletion safeguard
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
X-List-Received-Date: Fri, 17 Apr 2015 14:27:21 -0000

Try to guard against any repeat of bug 7620:

  https://bugzilla.yoctoproject.org/show_bug.cgi?id=7620

It won't protect usage of shutil.rmtree(), but there's not a lot
we can do about that and we use both of the functions that are protected
extensively throughout BitBake/OE.


The following change since commit e2879c60e905d7566091d40eab330372fa001313:

  bitbake-user-manual: Cleaned up parallelism note and formatted user input (2015-04-17 13:28:31 +0100)

is available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/rm-safeguard
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/rm-safeguard

Paul Eggleton (1):
  lib/bb/utils: add safeguard against recursively deleting things we shouldn't

 lib/bb/tests/utils.py | 17 +++++++++++++++++
 lib/bb/utils.py       | 21 +++++++++++++++++++++
 2 files changed, 38 insertions(+)

-- 
2.1.0


