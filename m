Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id 5361075D4F
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Aug 2015 23:46:41 +0000 (UTC)
Received: by pabyb7 with SMTP id yb7so46980112pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Aug 2015 16:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id;
	bh=oXw+7Zc+NaiKexRky/8mNuGgVGkdSB92rJPc8+atZlA=;
	b=Nm2Qepw/a6ptUTFTbjcmUwFil10tIgwOourSt0Jw96yy2C4z5ZuEseeYMK1Hcjr+HC
	aqk1H0ISt39WHMN3Hbf9wLOU2npR0VW1gik3eEMiw+3pm9LVg215FQgfeO/eMbd5dVMh
	aLFaRb/VrUXaJCF0CJZ77gGy87EvY1/49U3N8oGEUB8slBgtXBnB2wSL4WFHuKQvdymh
	zdNvOtOJLA4lA3ruLTwNZmVJkDTWPXgpEPl5ED2SEplklFmn48bwquwZZlrO7/QAcf5y
	iQ0ltk8uC38fKyu/MJjSzHj0ohEYUBW4yabMmhqUzdHnnC/x/RiOmOz970lBVwP+a7z8
	FPig==
X-Received: by 10.66.250.226 with SMTP id zf2mr82079299pac.20.1439509601846;
	Thu, 13 Aug 2015 16:46:41 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	i10sm3883933pdr.78.2015.08.13.16.46.40
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 13 Aug 2015 16:46:41 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 13 Aug 2015 16:46:34 -0700
Message-Id: <cover.1439509247.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.2.1
Subject: [RFC PATCH 0/5] Implement git shallow mirror tarball support
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
X-List-Received-Date: Thu, 13 Aug 2015 23:46:44 -0000

From: Christopher Larson <chris_larson@mentor.com>

Please review the following changes for suitability for inclusion. If you have
any objections or suggestions for improvement, please respond to the patches. If
you agree with the changes, please provide your Acked-by.

This only implements support for shallow mirror tarballs, not shallow clones.

The mirror tarball filename includes branch, revision, and depth. To enable,
use the `BB_GIT_SHALLOW` variable, or `BB_GIT_SHALLOW_<name>` for specific
URLs. This variable can hold either a clone depth (e.g. `1` to just get
SRCREV), or a ref or commit, in which case we keep history up to that commit.

The shallow support will not, at this time, function correctly for
linux-yocto, due to its branching scheme & validation.

Example:

    BB_GIT_SHALLOW ?= "1"
    BB_GIT_SHALLOW_pn-linux-yocto = ""
    BB_GIT_SHALLOW_pn-linux-mel_mx6 = "v3.14"
    BB_GIT_SHALLOW_pn-testrepo = "testbranch"

This implementation will attempt to fetch a full mirror tarball if it was
unable to fetch a shallow tarball. If `BB_GIT_SHALLOW` and
`BB_GENERATE_MIRROR_TARBALLS` are enabled for a given recipe, a shallow
tarball will be emitted.


The following changes since commit 0c419902e5f58dcee9b7fbe9af1928da37e18399:

  toaster: reduced amount of instance attributes (2015-08-10 13:56:03 -0700)

are available in the git repository at:

  git@github.com:kergoth/bitbake shallow-git-mirror-tarballs

for you to fetch changes up to 01c1164fe4b54d5f3de1fd4863808af88f06c144:

  bb.fetch.git: use ud.mirrortarballs (2015-08-13 15:48:01 -0700)

----------------------------------------------------------------
Christopher Larson (5):
  bb.fetch.git: add support for shallow mirror tarballs
  bb.fetch.git: truncate branches to SRCREV
  bb.fetch: simplify mirror tarball handling in try_mirror_url
  bb.fetch: support ud.mirrortarballs
  bb.fetch.git: use ud.mirrortarballs

 lib/bb/fetch2/__init__.py |  27 ++++---
 lib/bb/fetch2/git.py      | 182 +++++++++++++++++++++++++++++++++++-----------
 2 files changed, 154 insertions(+), 55 deletions(-)

-- 
2.2.1


