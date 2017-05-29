Return-Path: <rebecca.swee.fun.chang@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id 1DC7960123
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 May 2017 00:43:40 +0000 (UTC)
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	28 May 2017 17:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.38,412,1491289200"; d="scan'208";a="108120552"
Received: from rebeccas.png.intel.com ([172.30.199.118])
	by fmsmga006.fm.intel.com with ESMTP; 28 May 2017 17:43:39 -0700
From: Chang Rebecca Swee Fun <rebecca.swee.fun.chang@intel.com>
To: Bitbake dev Mailing List <bitbake-devel@lists.openembedded.org>
Date: Mon, 29 May 2017 08:44:05 +0800
Message-Id: <1496018646-92426-1-git-send-email-rebecca.swee.fun.chang@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: Phoong Stanley Cheong Kwan <stanley.cheong.kwan.phoong@intel.com>
Subject: [PATCHv2] bitbake-layers: check layer dependencies before adding
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
X-List-Received-Date: Mon, 29 May 2017 00:43:41 -0000

Change log on v2 patch:
- Remove line "return 1", because bb.fatal raises an exception, hence
  return 1 is not needed.

Regards,
Rebecca

Chang Rebecca Swee Fun (1):
  bitbake-layers: check layer dependencies before adding

 bin/bitbake-layers     |  1 +
 lib/bblayers/action.py | 26 ++++++++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

-- 
2.7.4


