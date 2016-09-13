Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 510C5731FC
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 13 Sep 2016 02:12:05 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 12 Sep 2016 19:12:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.30,326,1470726000"; d="scan'208";a="1055111520"
Received: from wooi-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.156.68])
	by fmsmga002.fm.intel.com with ESMTP; 12 Sep 2016 19:12:04 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Sep 2016 14:11:40 +1200
Message-Id: <cover.1473732670.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH 0/1] Minor npm fetcher optimisation
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
X-List-Received-Date: Tue, 13 Sep 2016 02:12:06 -0000

The following changes since commit 57912de63fa83550c0ae658eb99b76e9cc91a8d1:

  cooker: record events on cooker exit (2016-09-06 10:36:34 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-npm-download-fix
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-npm-download-fix

Paul Eggleton (1):
  fetch2/npm: don't download same URL multiple times

 lib/bb/fetch2/npm.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

-- 
2.5.5


