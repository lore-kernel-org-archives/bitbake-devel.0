Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
	[209.85.220.43])
	by mail.openembedded.org (Postfix) with ESMTP id 4EF1B76BEA
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 16:37:20 +0000 (UTC)
Received: by pacti10 with SMTP id ti10so93268667pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 09:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=eFL+Fcm4omYJk9uEALKlI02A6qS4WCL2PHl7WIyWX14=;
	b=Gp0Ef/KvmR9Q6unnQG3X+rbRFzqwGcvM/xiwCmSMgZPfG1dL7zL2GJjDm4jUjFQZA+
	zFSIRATmOKhvg1Q2o4buUGkHDVfGo9dyWkpziKgqgl6fJa4A9cdlXZ/3Rjcp/DXljngo
	pqElEa2en7YSbLag4tmrupVGtNNHlPtlwsdmFi05JPZvwZm5f9pHQajEao7mo+JR9WzH
	3o2p2bF6XrBeEC6BOhnJK7GIuZN2BohYIbEPlgbqldA9dkmV9ge3rGzwveavAa4hp1sk
	TTJef+/I7ac3Wl6xWFeQNF//DjfNWvhHLVYu4qi9Mhi75H6x7w4XbcGb6vaSshzExHu5
	hX0w==
X-Received: by 10.68.203.42 with SMTP id kn10mr71814984pbc.43.1440607040611;
	Wed, 26 Aug 2015 09:37:20 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	qe3sm25214673pbc.73.2015.08.26.09.37.19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 26 Aug 2015 09:37:19 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Aug 2015 09:38:04 -0700
Message-Id: <1440607088-14563-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 0/4] Implement git shallow mirror tarball support
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
X-List-Received-Date: Wed, 26 Aug 2015 16:37:20 -0000

From: Christopher Larson <chris_larson@mentor.com>

Supercedes `[RFC PATCH 0/5] Implement git shallow mirror tarball support`.

The shallow mirror tarball filename includes branch, revision, and depth. To
enable, use the BB_GIT_SHALLOW variable, or BB_GIT_SHALLOW_<name> for specific
URLs. This variable can hold either a clone depth (e.g. 1 to just get SRCREV),
or a ref or commit, in which case we keep history up to that commit.

Example:

    BB_GIT_SHALLOW ?= "1"
    BB_GIT_SHALLOW_pn-linux-yocto = ""
    BB_GIT_SHALLOW_pn-linux-mel_mx6 = "v3.14"
    BB_GIT_SHALLOW_pn-testrepo = "testbranch"

Example in a recipe with multiple named uris, or multiple named branches in a
single git URI:

    BB_GIT_SHALLOW_main = "1"
    BB_GIT_SHALLOW_doc = ""

BB_GIT_SHALLOW affects both the tarballs being fetched and the mirror tarball
which is created when BB_GENERATE_MIRROR_TARBALLS is enabled. If the shallow
mirror tarball cannot be fetched, it will try to fetch the full mirror tarball
and use that.

Limitations:

The shallow support will not, at this time, function correctly for
linux-yocto, due to its branching scheme & validation.

This implements support for shallow mirror tarballs, not shallow clones.
Supporting shallow clones directly would be rather more problematic, as we'd
need to hardcode the depth between branch HEAD and the SRCREV, and that depth
would change as the branch is updated.

Christopher Larson (4):
  bb.fetch: simplify mirror tarball handling in try_mirror_url
  bb.fetch: support ud.mirrortarballs
  bb.fetch.git: add support for shallow mirror tarballs
  bb.fetch.git: truncate branches to SRCREV

 lib/bb/fetch2/__init__.py |  27 +++----
 lib/bb/fetch2/git.py      | 177 +++++++++++++++++++++++++++++++++++-----------
 2 files changed, 152 insertions(+), 52 deletions(-)

-- 
2.2.1


