Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by mail.openembedded.org (Postfix) with ESMTP id 89F97719B8
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Feb 2017 03:42:33 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga105.fm.intel.com with ESMTP; 08 Feb 2017 19:42:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.35,349,1484035200"; d="scan'208";a="223091747"
Received: from ystew-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.191.171])
	by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2017 19:42:32 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  9 Feb 2017 16:42:28 +1300
Message-Id: <cover.1486611730.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
Subject: [PATCH 0/1] tinfoil: ensure PATH includes bitbake's bin directory
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
X-List-Received-Date: Thu, 09 Feb 2017 03:42:34 -0000

The following changes since commit 95deecabfffdb6a7009ecc385c8b12290fbfcb73:

  bitbake: Update version to 1.33.1 (2017-02-07 14:35:48 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/tinfoil-path
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/tinfoil-path

Paul Eggleton (1):
  tinfoil: ensure PATH includes bitbake's bin directory

 lib/bb/tinfoil.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
2.9.3


