Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id C9AE171F1B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Feb 2015 15:30:11 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP; 25 Feb 2015 07:30:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,645,1418112000"; d="scan'208";a="683267056"
Received: from gcattani-mobl.ger.corp.intel.com (HELO
	peggleto-mobl5.ger.corp.intel.com) ([10.252.20.5])
	by fmsmga002.fm.intel.com with ESMTP; 25 Feb 2015 07:30:01 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 25 Feb 2015 15:29:57 +0000
Message-Id: <cover.1424878172.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 1.9.3
Subject: [PATCH 0/1] bitbake-layers fix
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
X-List-Received-Date: Wed, 25 Feb 2015 15:30:12 -0000

The following change since commit 8a5c83c953c1e541704fe979e90d9d3be66e9ffd:

  toasterui: fix ETA calculation (2015-02-24 23:35:39 +0000)

is available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bitbake-layers-fix
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bitbake-layers-fix

Paul Eggleton (1):
  bitbake-layers: fix wildcard support in remove-layer

 bin/bitbake-layers | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
1.9.3


