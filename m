Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f65.google.com (mail-pa0-f65.google.com
	[209.85.220.65])
	by mail.openembedded.org (Postfix) with ESMTP id A34CF760B0
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 19:44:10 +0000 (UTC)
Received: by mail-pa0-f65.google.com with SMTP id i5so15302256pag.3
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 30 Apr 2016 12:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=NmGACt024gG+CEC78E931+gq+NZH4l5z8tpHQIqfu9k=;
	b=cMIN7+pevq3n3bFggbi1GAqlMclaO+vj6Q4x06aj6M8vJD3a8FeOyjTk9DA7iKdXw3
	UX4uawBA1HKT0E3cfF0WM9QDROc2LUjtfmOlAb9DFKzpJBNkrEEam5987dKecuJPlE1i
	gI/NJTVJohpzznx9nvnjUHKTIfdfLEPuNXMPR//RahLPpm/kU3yzCTES1OWdTK9L6fij
	IJvS2Dt0VnpSNm+3aVElYILcWDVRzeJ1Q2tdfi7Q4EEshyy+0BsbtQ9biU8db2AdjecU
	Yo/bzymOf+7crM52fWuN6h2imsV0F/YF2qQACt8fhuyvBgu5dL4IoQAvG/munpbRf7jr
	Vjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=NmGACt024gG+CEC78E931+gq+NZH4l5z8tpHQIqfu9k=;
	b=LFPqVr8IgKX1CLsz2RTTxHdznL98cj2QyOvFwiVsfrM99njNjU5DK0qc2AbfDZU8+x
	SZTfdWwKvdyRRUHWuXFCk9fhDZH9w1juOtAi/iNkJTgycWnkxHvqSbxuTN7FuygeH34O
	jIHXJ28+Ggx0jMVAZqP0jnm2VTQyAVZbVoPVT/V3NvRhJZILSLu6txrx/Z+FzwRC1GD0
	+Jfg1n3onOph5cjstt2NLtu+YkfSv/vNuy6UlFR/Xw+g5Mv4sfAL37/dGXVisevKgVH2
	BPpLoU5RRk0EQsq7OqB7TGwDhjbLRlKgufaM0b2ByUNDXfNIMFuHajTfKLbGwSd4s2Xv
	AvSQ==
X-Gm-Message-State: AOPr4FUbE4KPlmDQq0ihMm26bsz+OrUmFQd3ZQYTNofbmRAzp5gaDt3VEJAQZb7MWURWKQ==
X-Received: by 10.67.13.78 with SMTP id ew14mr4061606pad.127.1462045451004;
	Sat, 30 Apr 2016 12:44:11 -0700 (PDT)
Received: from amyr.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	i6sm32670102pfc.65.2016.04.30.12.44.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 30 Apr 2016 12:44:09 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 30 Apr 2016 12:44:06 -0700
Message-Id: <cover.1462040903.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.8.0
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [master][PATCH 0/3] Implement support for shallow git mirror tarballs
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
X-List-Received-Date: Sat, 30 Apr 2016 19:44:11 -0000

From: Christopher Larson <chris_larson@mentor.com>

This adds support to the git fetcher for fetching and generating mirror
tarballs of shallow git repositories, with the specified revisions / depths.

This implements support for shallow mirror tarballs, not shallow clones.
Supporting shallow clones directly would be rather more problematic, as we'd
need to hardcode the depth between branch HEAD and the SRCREV, and that depth
would change as the branch is updated. Sadly, git's remote protocol is
extremely limited.

When BB_GIT_SHALLOW is enabled, we will always attempt to fetch a shallow
mirror tarball. If the shallow mirror tarball cannot be fetched, it will try
to fetch the full mirror tarball and use that.

Multiple variables exist to exert control over what revisions and refs are
kept at what are not.

BB_GIT_SHALLOW: enable/disable shallow support as a whole, boolean
BB_GIT_SHALLOW_DEPTH: specify commit depth for the included refs. defaults to 1 (the top commit alone). This can be set to 0 or the empty string.
BB_GIT_SHALLOW_DEPTH_<name>: specify commit depth for a specific named url/branch
BB_GIT_SHALLOW_REVS: specific revisions whose history should be removed, beyond that specified by refs+depth
BB_GIT_SHALLOW_TRIM_REFS: by default, unused refs/branches are removed. set this to 0 or the empty string to keep all refs around. this is required for linux-yocto kernel repositories, otherwise the branch checking done by the kernel scripts will fail
BB_GIT_SHALLOW_EXTRA_REFS: additional refs to keep beyond those referenced in SRC_URI, when TRIM_REFS is enabled
BB_GENERATE_SHALLOW_TARBALLS: explicitly control creation of shallow mirror tarballs. this defaults to enabled when BB_GENERATE_MIRROR_TARBALLS is enabled

Example usage:

    BB_GIT_SHALLOW ?= "1"
    BB_GIT_SHALLOW_DEPTH ?= "1"

    # Usage in a recipe with multiple named uris or multiple named branches
    BB_GIT_SHALLOW_DEPTH_doc = ""

    # Remove the upstream history from our kernel repo, keeping our own
    BB_GIT_SHALLOW_REVS_pn-linux-mel_mx6 = "v3.14"
    BB_GIT_SHALLOW_DEPTH_pn-linux-mel_mx6 = ""

    # Keep the branches in linux-yocto repositories
    BB_GIT_SHALLOW_TRIM_REFS_pn-linux-yocto = "0"


Please review the following changes for suitability for inclusion. If you have
any objections or suggestions for improvement, please respond to the patches. If
you agree with the changes, please provide your Acked-by.

The following changes since commit 309f5907a3661821e041ed14645b5d165007b058:

  bitbake: Switch to post release version (2016-04-29 07:41:34 +0100)

are available in the git repository at:

  https://github.com/kergoth/bitbake shallow-simplify
  https://github.com/kergoth/bitbake/tree/shallow-simplify

Christopher Larson (3):
  bb.fetch: simplify mirror tarball handling in try_mirror_url
  bb.fetch: support ud.mirrortarballs
  bb.fetch.git: add support for shallow mirror tarballs

 lib/bb/fetch2/__init__.py |  27 ++---
 lib/bb/fetch2/git.py      | 260 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 255 insertions(+), 32 deletions(-)

-- 
2.8.0


