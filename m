Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by mail.openembedded.org (Postfix) with ESMTP id 2CDCC7721D
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  3 Feb 2016 10:33:40 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by orsmga101.jf.intel.com with ESMTP; 03 Feb 2016 02:33:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,389,1449561600"; d="scan'208";a="907544449"
Received: from marquiz.fi.intel.com ([10.237.72.155])
	by fmsmga002.fm.intel.com with ESMTP; 03 Feb 2016 02:33:40 -0800
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  3 Feb 2016 12:33:37 +0200
Message-Id: <1454495619-15453-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.1.4
Subject: [PATCH 0/2] data_smart: simple matching of curly brackets inside Python expressions
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
X-List-Received-Date: Wed, 03 Feb 2016 10:33:41 -0000

This patchset aims at making the parsing of Python expressions in variable
definitions a bit more reliable by adding simple matching of curly brackets.

[YOCTO #8849]

Markus Lehtonen (2):
  data_smart: simple bracket matching inside python expressions
  data_smart: handle '\x7d' in python parsing

 lib/bb/data_smart.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.1.4


