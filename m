Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (unknown [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 3858E6ABDB
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 May 2014 15:22:27 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by orsmga101.jf.intel.com with ESMTP; 23 May 2014 08:22:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.98,894,1392192000"; d="scan'208";a="545581318"
Received: from bidesilv-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.123.159])
	by orsmga002.jf.intel.com with ESMTP; 23 May 2014 08:22:27 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 23 May 2014 16:22:13 +0100
Message-Id: <cover.1400858501.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.0
Subject: [PATCH 0/4] bitbake-layers show-cross-depends improvements
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
X-List-Received-Date: Fri, 23 May 2014 15:22:30 -0000

The following changes since commit af3ce0fc0280e6642fa35de400f75fdbabf329b1:

  data_smart: Fix an unusual variable reference bug (2014-05-21 16:46:45 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bitbake-layers
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-layers

Paul Eggleton (4):
  bitbake-layers: show-cross-depends: add option to ignore a layer
  bitbake-layers: show-cross-depends: ignore global inherits
  bitbake-layers: show-cross-depends: ignore self-satisfied RDEPENDS
  bitbake-layers: show-cross-depends: add support for RRECOMMENDS

 bin/bitbake-layers | 72 +++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 52 insertions(+), 20 deletions(-)

-- 
1.9.0


