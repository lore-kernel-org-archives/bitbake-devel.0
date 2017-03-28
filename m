Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id EA0DB71A0F
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 28 Mar 2017 00:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1490662269; x=1522198269;
	h=from:to:cc:subject:date:message-id;
	bh=0v3zA7G3kwv46cjnHEx8dkCI5eLjkhk2Ueua8UuCygI=;
	b=tFGqVBo3UIs2F7NPkgxLwK3WGCRGb48GFP9DjSnkGQ+EaET6SW1JZkKB
	D09gJJxa83qcVYf4Fnr0NenjSs5QnA==;
Received: from orsmga003.jf.intel.com ([10.7.209.27])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	27 Mar 2017 17:51:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.36,234,1486454400"; d="scan'208";a="948821371"
Received: from dalin-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.138.23])
	by orsmga003.jf.intel.com with ESMTP; 27 Mar 2017 17:51:05 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 28 Mar 2017 13:51:00 +1300
Message-Id: <cover.1490662146.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 0/1] Follow-up fix for tinfoil series
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
X-List-Received-Date: Tue, 28 Mar 2017 00:51:08 -0000

This resolves the minor regression that caused a few debug messages
to get printed after recent bitbake commit
824e73e0f3eaa96b4d84da7e31f9a17ce5c5d7ee.


The following changes since commit 921592026c69287cdb40ffd90944d5944f28e2c3:

  main: Improve -v and -D option documentation (2017-03-27 11:11:05 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/codeparser-log
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/codeparser-log

Paul Eggleton (1):
  lib/bb/codeparser: ensure BufferedLogger respects target filtering

 lib/bb/codeparser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.9.3


