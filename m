Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 21AB978304
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Aug 2017 23:31:19 +0000 (UTC)
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	30 Aug 2017 16:31:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,450,1498546800"; d="scan'208";a="1189995032"
Received: from ekooi-mobl5.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.141.249])
	by fmsmga001.fm.intel.com with ESMTP; 30 Aug 2017 16:31:18 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 31 Aug 2017 11:30:42 +1200
Message-Id: <cover.1504135776.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
Subject: [PATCH 0/5] tinfoil/other fixes for devtool/recipetool
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
X-List-Received-Date: Wed, 30 Aug 2017 23:31:20 -0000

Some changes in aid of fixing issues with OE's devtool and recipetool.


The following changes since commit 8a60106c6f7d586c793b965c5e9460b6016fab15:

  main: Attempt to gain bitbake.lock rather than just waiting (2017-08-24 11:19:41 +0100)

are available in the git repository at:

  git://git.openembedded.org/bitbake-contrib paule/tinfoil-fixes-bb4
  http://cgit.openembedded.org/bitbake-contrib/log/?h=paule/tinfoil-fixes-bb4

Paul Eggleton (5):
  tinfoil: fix log message doubling when config_only=False
  tinfoil: ensure log lines get printed when tasks fail
  tinfoil: ensure variable history tracking works when parsing a recipe
  cooker: ensure we can run buildFileInternal() after cache is populated
  fetch2/npm: add noverify parameter to skip lockdown/shrinkwrap

 lib/bb/cooker.py     |  8 ++++----
 lib/bb/fetch2/npm.py | 41 +++++++++++++++++++++--------------------
 lib/bb/tinfoil.py    | 47 ++++++++++++++++++++++++++++++++++++-----------
 lib/bb/ui/knotty.py  | 50 +++++++++++++++++++++++++++-----------------------
 4 files changed, 88 insertions(+), 58 deletions(-)

-- 
2.9.5


