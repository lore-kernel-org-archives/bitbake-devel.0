Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id D2537776C7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Mar 2017 04:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1489982829; x=1521518829; h=from:to:subject:date:message-id;
	bh=YY9BWf8yiGgG6cU/bpEsKcZ1dL1LIcHp8qbB4RCX9mo=;
	b=s8ZEtLexb/hEaZENAMgMF0SXhWGI0vb7IyqarxqnAbZwQRobl+7RHfML
	+v9qCNes34I3KyalIDTTmzjWTv4NUw==;
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Mar 2017 21:07:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,191,1486454400"; d="scan'208";a="68903095"
Received: from cloy-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.161.201])
	by orsmga004.jf.intel.com with ESMTP; 19 Mar 2017 21:07:07 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Mar 2017 17:07:03 +1300
Message-Id: <cover.1489982808.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
Subject: [PATCH 0/1] bitbake-layers: fix layerindex-fetch for Python 3
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
X-List-Received-Date: Mon, 20 Mar 2017 04:07:07 -0000

The following changes since commit 1ff9b3c669fa187f152de7b8b57d14c2468d926c:

  tests/data: Add inactive remove override test (2017-03-16 12:54:59 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bblayers-fix
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bblayers-fix

Paul Eggleton (1):
  bitbake-layers: fix layerindex-fetch for Python 3

 lib/bblayers/layerindex.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.9.3


