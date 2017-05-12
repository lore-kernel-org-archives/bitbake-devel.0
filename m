Return-Path: <kergoth@gmail.com>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
	by mail.openembedded.org (Postfix) with ESMTP id 23B4860766
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 21:46:39 +0000 (UTC)
Received: by mail-pg0-f65.google.com with SMTP id u187so8978198pgb.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 May 2017 14:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=AEYYV2S0ByON9AfH7QMEHpxHvFzoAtE9WF/yUolbhWk=;
	b=POKCrW/JaN9gWpfVGImq9vpx60KBajKNKm2QV0bDufNFb1u1KQbHz5T3HLYuy8HVKU
	HGaWITfPKvUBCAwE4JjJpDf5HF3lKK9f5vIjlnYOB1oHnaO4wpxAO+fQyAH1P6Bog6su
	sKCBQUO8pfp74ACNk7QUzPxB6Jb1iv+803Y4dMXjD7DoKwItyJwqZ2vyCIZ+H65TY4tt
	ogUWbKsFlQ+QSmeZbgWJeAdwrvA6tYhpwSdhLyef0dIku3bjSnGD/7fTrLhy6sCtrzkU
	XCCk/2EzSBOGjbhvv7I+zNBUkjwSrgLYzS2iCZvlThS5+dj9t2lqWyPKf/5TpXREqtsY
	WseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=AEYYV2S0ByON9AfH7QMEHpxHvFzoAtE9WF/yUolbhWk=;
	b=GtoK0acP2wJuytzYoGuGDXsV3RoM+TCyl/saQilOObjEpe/aXECEHIGEt9XWi0qG7/
	uCy1KDjDp9HOf19mvaJ2ygQli6dF+n4x0DzSswCDwtdrpFxluUYQD/N83BfFldROF7Yy
	HvYsDe6PBJerFM4+GcwlmWt8bxu9SXCNR5/85EU4G9cWNFXRPzmtf3bj9eE5C1hEFX1i
	B6+8zliWSRvc/IrvpDl9cR/2MeFCoXo9/f5MoLG0BdizVknIIP+TN/HYioMiunbpTWpK
	i1Ig+t1KY3LxOe22KEzG5tn6q5j3QQLA2IFEsqqNpMR7RF5/ExCewzA6a+weGNzfRJVJ
	Yerg==
X-Gm-Message-State: AODbwcArT2EehFffW8aDNZjQKJgkVltiY6pIByRaNpQy/v92q/S+GorV
	uOT37S398Jh9SlNfmPA=
X-Received: by 10.84.143.36 with SMTP id 33mr8349075ply.45.1494625600897;
	Fri, 12 May 2017 14:46:40 -0700 (PDT)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id
	v63sm1244051pfi.133.2017.05.12.14.46.38
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 12 May 2017 14:46:39 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 13 May 2017 02:46:25 +0500
Message-Id: <cover.1494623828.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.11.1
Subject: [PATCH 0/8] Add support for shallow mirror tarballs
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
X-List-Received-Date: Fri, 12 May 2017 21:46:40 -0000

The latest incarnation of the support for git shallow mirror tarballs. Updated
with ud.mirrortarball removed, fixes for gitsm and gitannex, more granular
commits to ease review, and unit tests added. Please let me know what you
think. Thanks.

The following changes since commit 21d963149b5d97452420230a252101115b708d85:

  toaster: move release lookup from morty to pyro (2017-04-20 07:59:30 +0100)

are available in the git repository at:

  git@github.com:kergoth/bitbake.git shallow

for you to fetch changes up to b4ca8fa8422818f7d09fbb1988bc189d2a8e7b52:

  fetch/git: add support for removing arbitrary revs for shallow (2017-05-13 01:22:30 +0500)

----------------------------------------------------------------
Christopher Larson (8):
      fetch: support multiple mirror tarball filenames
      git-make-shallow: add script to make a git repo shallow
      fetch/git: add support for shallow mirror tarballs
      fetch/git: support per-branch/per-url depths for shallow
      fetch/git: add support for keeping extra refs for shallow
      fetch/gitsm: add support for shallow mirror tarballs
      fetch/gitannex: add support for shallow mirror tarballs
      fetch/git: add support for removing arbitrary revs for shallow

 bin/git-make-shallow      | 165 +++++++++++++
 lib/bb/fetch2/__init__.py |  72 +++---
 lib/bb/fetch2/git.py      | 189 +++++++++++++--
 lib/bb/fetch2/gitannex.py |  23 +-
 lib/bb/fetch2/gitsm.py    |  17 +-
 lib/bb/fetch2/hg.py       |   5 +-
 lib/bb/fetch2/npm.py      |   7 +-
 lib/bb/tests/fetch.py     | 603 ++++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 1017 insertions(+), 64 deletions(-)
 create mode 100755 bin/git-make-shallow

-- 
2.11.1


