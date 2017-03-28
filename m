Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id D554D77B9F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 20:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1490733721; x=1522269721;
	h=from:to:cc:subject:date:message-id;
	bh=yZljHGf5EoXSyOmeGGdHlxybpxVpN6n9czEfRxwTeNU=;
	b=AVed0b+mUGjFoj3hAjjkpMo+W+Us2nLD/7cUhFnCN0SiQ/0EqhuevCoj
	w/UvoOz1EPjN4/NhVHJDOd7qIl0w+A==;
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	28 Mar 2017 13:41:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,238,1486454400"; d="scan'208";a="1128218134"
Received: from dalin-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.138.23])
	by fmsmga001.fm.intel.com with ESMTP; 28 Mar 2017 13:41:55 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 29 Mar 2017 09:41:46 +1300
Message-Id: <cover.1490733586.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH v2 0/1] Follow-up fix for tinfoil series
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
X-List-Received-Date: Tue, 28 Mar 2017 20:42:01 -0000

This resolves the minor regression that caused a few debug messages
to get printed after recent bitbake commit
824e73e0f3eaa96b4d84da7e31f9a17ce5c5d7ee.

Changes since v1:
 - It's not about filtering, and calling filter() just checks if the
   record should be filtered out or not (which handle() already does),
   we need to explicitly check whether the target logger is enabled
   for the level of the record. Thanks to Chris Larson for pointing
   this out.


The following changes since commit 921592026c69287cdb40ffd90944d5944f28e2c3:

  main: Improve -v and -D option documentation (2017-03-27 11:11:05 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/codeparser-log
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/codeparser-log

Paul Eggleton (1):
  lib/bb/codeparser: ensure BufferedLogger respects target logging level

 lib/bb/codeparser.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

-- 
2.9.3


