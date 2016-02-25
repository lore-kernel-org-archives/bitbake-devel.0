Return-Path: <brendan.le.foll@intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id 129DA6014F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 25 Feb 2016 15:06:36 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 25 Feb 2016 07:06:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.22,498,1449561600"; d="scan'208";a="923777618"
Received: from jupiter.iwi.intel.com ([172.28.33.51])
	by fmsmga002.fm.intel.com with ESMTP; 25 Feb 2016 07:06:37 -0800
From: brendan.le.foll@intel.com
To: bitbake-devel@lists.openembedded.org
Date: Thu, 25 Feb 2016 15:07:05 +0000
Message-Id: <1456412828-11343-1-git-send-email-brendan.le.foll@intel.com>
X-Mailer: git-send-email 2.7.1
Subject: [PATCH 0/3] npm: Add an npm fetcher
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
X-List-Received-Date: Thu, 25 Feb 2016 15:06:39 -0000

This series adds an NPM fetcher that does strict dependency resolution and
supports both npm-shrinkwrap and npm-lockdown files so that you can be sure
that npm packages will always be rebuilt the same. It also adds mirroring
support for the fetcher. There is also a matching npm.bbclass being submitted
to oe-core

There is an example of layer here:
https://github.com/arfoll/meta-brendan-nodepkgs


