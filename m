Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 5CD457830A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 19 Oct 2017 03:32:51 +0000 (UTC)
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga105.fm.intel.com with ESMTP; 18 Oct 2017 20:32:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.43,399,1503385200"; d="scan'208";a="164336109"
Received: from klee4-mobl2.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.148.108])
	by fmsmga005.fm.intel.com with ESMTP; 18 Oct 2017 20:32:50 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 19 Oct 2017 16:32:20 +1300
Message-Id: <cover.1508383917.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
Subject: [PATCH 0/1] cooker: fix watching directories with Python 3.6+
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
X-List-Received-Date: Thu, 19 Oct 2017 03:32:52 -0000

The following changes since commit be393f247a08c0a4a50a6a76b8fd57f78295d2a1:

  toaster/highlight.pack.js: Fix corrupted file (2017-10-10 11:04:10 +0100)

are available in the git repository at:

  git://git.openembedded.org/bitbake-contrib paule/python-36-inotify-fix
  http://cgit.openembedded.org/bitbake-contrib/log/?h=paule/python-36-inotify-fix

Paul Eggleton (1):
  cooker: fix watching directories with Python 3.6+

 lib/bb/cooker.py | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

-- 
2.9.5


