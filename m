Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id E1C4471A22
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 12 Dec 2016 21:53:57 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga101.jf.intel.com with ESMTP; 12 Dec 2016 13:53:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.33,338,1477983600"; d="scan'208";a="1071256953"
Received: from mauric9x-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.158.7])
	by orsmga001.jf.intel.com with ESMTP; 12 Dec 2016 13:53:56 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 13 Dec 2016 10:53:50 +1300
Message-Id: <cover.1481579534.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.5.5
Subject: [PATCH 0/1] lib/bb/build: enable access to logger within tasks
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
X-List-Received-Date: Mon, 12 Dec 2016 21:53:58 -0000

This patch is required to support the patch sent to OE-Core to fix
bbwarn/bberror also triggering log_check.


The following changes since commit b65a8193368ffa1d15af24a6acde8dce6bd4d383:

  toaster: views Remove old code that converts template context to JSON (2016-12-12 20:44:47 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-logger-access
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-logger-access

Paul Eggleton (1):
  lib/bb/build: enable access to logger within tasks

 lib/bb/build.py |  1 +
 lib/bb/utils.py | 11 +++++++++++
 2 files changed, 12 insertions(+)

-- 
2.5.5


