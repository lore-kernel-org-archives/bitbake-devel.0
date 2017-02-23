Return-Path: <markus.lehtonen@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id B01EB72FD8
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 23 Feb 2017 10:22:21 +0000 (UTC)
Received: from orsmga004.jf.intel.com ([10.7.209.38])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Feb 2017 02:22:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.35,197,1484035200"; d="scan'208";a="61421069"
Received: from mburny-mobl.ger.corp.intel.com (HELO
	mqz-osx-suse64.fi.intel.com) ([10.252.22.38])
	by orsmga004.jf.intel.com with ESMTP; 23 Feb 2017 02:22:21 -0800
From: Markus Lehtonen <markus.lehtonen@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 23 Feb 2017 12:22:16 +0200
Message-Id: <1487845339-26473-1-git-send-email-markus.lehtonen@linux.intel.com>
X-Mailer: git-send-email 2.6.6
Subject: [PATCH 0/3] Fix rpm signing with GPG v2.1
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
X-List-Received-Date: Thu, 23 Feb 2017 10:22:22 -0000

This patchset makes signing work with all versions of GPG.  Previously, rpm
package signing in oe-core was not working with GPG v2.1 (which is becoming
more widespread). This was caused by a change in passphrase dialogue handling
of GPG.

[YOCTO #11054]

Markus Lehtonen (3):
  rpm: support customizing gpg command line
  lib/oe/gpg_sign: make gpg version a property of the signer
  lib/oe/gpg_sign: fix rpm signing with gpg > 2.1

 meta/lib/oe/gpg_sign.py                            | 12 +++---
 .../0001-macros-add-_gpg_sign_cmd_extra_args.patch | 43 ++++++++++++++++++++++
 meta/recipes-devtools/rpm/rpm_5.4.16.bb            |  1 +
 3 files changed, 51 insertions(+), 5 deletions(-)
 create mode 100644 meta/recipes-devtools/rpm/rpm/0001-macros-add-_gpg_sign_cmd_extra_args.patch

-- 
2.6.6


