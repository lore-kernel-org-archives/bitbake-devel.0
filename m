Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 2ECC260107
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Aug 2017 09:59:56 +0000 (UTC)
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 Aug 2017 02:59:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.41,337,1498546800"; d="scan'208";a="134560541"
Received: from peggleto-mobl1.ger.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.252.43.222])
	by orsmga005.jf.intel.com with ESMTP; 07 Aug 2017 02:59:57 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  7 Aug 2017 11:59:32 +0200
Message-Id: <cover.1502099961.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.4
Subject: [PATCH 0/1] Revert "tinfoil: fix duplication of log messages"
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
X-List-Received-Date: Mon, 07 Aug 2017 09:59:57 -0000

The following changes since commit 76c4f2c20216719736766e8ae7d089ccd061b71b:

  daemonize: Always print any remaning UI events at exit (2017-08-03 11:11:35 +0100)

are available in the git repository at:

  git://git.openembedded.org/bitbake-contrib paule/bb-tinfoil-logging2
  http://cgit.openembedded.org/bitbake-contrib/log/?h=paule/bb-tinfoil-logging2

Paul Eggleton (1):
  Revert "tinfoil: fix duplication of log messages"

 lib/bb/main.py    | 4 ++--
 lib/bb/tinfoil.py | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.9.4


