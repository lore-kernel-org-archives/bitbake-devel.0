Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id CED4C71C72
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Apr 2017 22:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=intel.com; i=@intel.com; q=dns/txt; s=intel;
	t=1491863745; x=1523399745; h=from:to:subject:date:message-id;
	bh=GLYJ0TLffRCqb+kfNVQgi4asgyyNs0zT6M+m8G6qaHk=;
	b=lpRYGggu3skru+25zjSeDaHHvWVxHkmZ+B3Tss6DksYod8A6yO6wB9x1
	Ru3YcgrQ8oiVBb1S2N/qVpwGMe9aEQ==;
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	10 Apr 2017 15:35:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,183,1488873600"; d="scan'208";a="87467138"
Received: from lheah-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com.fritz.box) ([10.255.133.64])
	by fmsmga006.fm.intel.com with ESMTP; 10 Apr 2017 15:35:43 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 11 Apr 2017 10:35:38 +1200
Message-Id: <cover.1491863723.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.3
Subject: [PATCH 0/1] bitbake-diffsigs: fix traceback with no arguments
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
X-List-Received-Date: Mon, 10 Apr 2017 22:35:44 -0000

The following changes since commit 04a023c8fdea1e1812fcdcaf00345aab59f9abe1:

  bitbake-diffsigs: colourise output (2017-04-07 00:51:12 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib paule/bb-sigstuff-fix
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=paule/bb-sigstuff-fix

Paul Eggleton (1):
  bitbake-diffsigs: fix traceback with no arguments

 bin/bitbake-diffsigs | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.9.3


