Return-Path: <juro.bystricky@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by mail.openembedded.org (Postfix) with ESMTP id AEDA9731D0
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Jan 2016 19:01:44 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by fmsmga104.fm.intel.com with ESMTP; 04 Jan 2016 11:01:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,521,1444719600"; d="scan'208";a="853361935"
Received: from juro-precision-t5610.jf.intel.com ([10.7.198.145])
	by orsmga001.jf.intel.com with ESMTP; 04 Jan 2016 11:01:45 -0800
From: Juro Bystricky <juro.bystricky@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  4 Jan 2016 10:51:42 -0800
Message-Id: <1451933503-25881-1-git-send-email-juro.bystricky@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: richard.purdie@intel.com
Subject: [PATCH 0/1] Add support for 7-Zip compressed files
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
X-List-Received-Date: Mon, 04 Jan 2016 19:01:45 -0000

7-Zip offers substantially better compression than other compression
formats. In fact, 7-Zip explicitly claims it provides the best compression ratio.
To quickly test the claim, I compressed a gcc 5.2 538.8 MB tree snapshot in various ways:

tar.bz2: 114.0 MB
tar.gz:  112.4 MB
tar.7z:   70.3 MB

At present, there is no support for 7-Zip compressed files in Bitbake.
Various public Git repositories only allow pushing files of certain max size,
AFAIK Github only allows 100MB, so there are cases where it is desirable
to use maximum compression possible.


Juro Bystricky (1):
  bitbake:fetch2/__init__.py: Add support for 7-Zip

 bitbake/lib/bb/fetch2/__init__.py | 4 ++++
 1 file changed, 4 insertions(+)

-- 
1.9.1


