Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 710C3774EC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Mar 2017 04:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1489982760; x=1521518760; h=from:to:subject:date:message-id;
	bh=z5itI5AUfyQbEbtJZAcDjXPoGAXPUdfN8Xz07ciBfSU=;
	b=fs/rxnBMzgOX7AaJ46Vtrdd3z4iMY67+gfhbOn+DZu0XxKEdqk4g3IaY
	vvwzlWnEPTXoSoYye31ulsOA7wiaig==;
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	19 Mar 2017 21:05:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,191,1486454400"; d="scan'208";a="78840416"
Received: from cloy-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.161.201])
	by fmsmga006.fm.intel.com with ESMTP; 19 Mar 2017 21:05:57 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Mar 2017 17:05:51 +1300
Message-Id: <cover.1489982696.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
Subject: [PATCH 0/2] Fixes for some tinfoil2 omissions
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
X-List-Received-Date: Mon, 20 Mar 2017 04:05:59 -0000

The following changes since commit 1ff9b3c669fa187f152de7b8b57d14c2468d926c:

  tests/data: Add inactive remove override test (2017-03-16 12:54:59 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/tinfoil-datastore-fixes
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/tinfoil-datastore-fixes

Paul Eggleton (2):
  tinfoil: fix override handling in remote datastores
  data_smart: implement missing remote datastore operations

 lib/bb/command.py    |  37 +++++++++++++--
 lib/bb/data_smart.py |  44 +++++++++++++----
 lib/bb/tests/data.py | 132 ++++++++++++++++++++++++++++++++++++++++++++-------
 lib/bb/tinfoil.py    |  37 +++++++++++++--
 4 files changed, 218 insertions(+), 32 deletions(-)

-- 
2.9.3


