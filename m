Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id CDB9D774A3
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 30 Jan 2017 20:14:07 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga105.fm.intel.com with ESMTP; 30 Jan 2017 12:14:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,312,1477983600"; d="scan'208";a="1119872124"
Received: from unknown (HELO peggleto-mobl.ger.corp.intel.com.fritz.box)
	([10.255.191.81])
	by fmsmga002.fm.intel.com with ESMTP; 30 Jan 2017 12:14:05 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 31 Jan 2017 09:14:00 +1300
Message-Id: <cover.1485807144.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
Subject: [1.32][PATCH 0/1] tinfoil: clean environment when starting up cooker
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
X-List-Received-Date: Mon, 30 Jan 2017 20:14:08 -0000

A tinfoil fix applicable to the 1.32 branch only.


The following changes since commit 1469828fa747da0aaaa3e964954ff17f2b3180fa:

  cookerdata: Convert multiconfig to use BB_CURRENT_MC (2017-01-11 17:21:12 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/tinfoil-env-1.32
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/tinfoil-env-1.32

Paul Eggleton (1):
  tinfoil: clean environment when starting up cooker

 lib/bb/tinfoil.py | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.9.3


