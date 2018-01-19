Return-Path: <amanda.r.brindle@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 8829977FC9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Jan 2018 20:55:34 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Jan 2018 12:55:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,382,1511856000"; d="scan'208";a="167580715"
Received: from arbrindl-dev.jf.intel.com ([10.7.199.57])
	by orsmga004.jf.intel.com with ESMTP; 19 Jan 2018 12:55:27 -0800
From: Amanda Brindle <amanda.r.brindle@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 19 Jan 2018 12:52:32 -0800
Message-Id: <cover.1516394932.git.amanda.r.brindle@intel.com>
X-Mailer: git-send-email 2.7.4
X-Mailman-Approved-At: Mon, 22 Jan 2018 22:09:11 +0000
Cc: paul.eggleton@linux.intel.com
Subject: [PATCH 0/1] tinfoil.py: Check if BUILDDIR exists
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
X-List-Received-Date: Fri, 19 Jan 2018 20:55:35 -0000

The following changes since commit e153efde9754a650e555f46cba09680baabd7d7e:

  multilib.bbclass: deltask populate_sdk and populate_sdk_ext (2018-01-19 12:37:14 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib abrindle/tinfoil
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=abrindle/tinfoil

Amanda Brindle (1):
  tinfoil.py: Check if BUILDDIR exists

 bitbake/lib/bb/tinfoil.py | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.7.4


