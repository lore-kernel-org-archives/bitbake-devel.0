Return-Path: <kergoth@gmail.com>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
	[209.85.220.46])
	by mail.openembedded.org (Postfix) with ESMTP id 1EBAF76DE3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 16:37:06 +0000 (UTC)
Received: by pacgr6 with SMTP id gr6so13811992pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 26 Aug 2015 09:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=OgTbnxfioXRLAZtbZ25hTSjEdL0nWs+sIxpfAW6BAn8=;
	b=NjmHAbAj4WNv40OFxIFWYGOwzQs7bNFEnbymd3UiHM/KV/pnnDdtkVZsB6wzVWDz8g
	GD5d9uoO8Z5WI9bO+XY2Zy3zYMvXFUYfarZ98l9VeMTkUWl90k2S6kLzMAa1WY+gXRmh
	tNbe7KG1bLNybj9C1KIgkJ+c9smmVSarWc9TiIYYZt4giCpO5Y6RZyy7O8Rn/9nacSeG
	L7RNrLeDaXlLdylTBuyihirqN3Cu2boiJExg7esNCWESrbI5SA5vdxKDIIMsOkiYBdFM
	Jbvy/ip6Sim3dchh5/ElGoNr4PucBanqZDSv1YzKLCfwUgk1cTqDdbzffX5YzDvgzM2k
	73DQ==
X-Received: by 10.67.15.36 with SMTP id fl4mr69970967pad.152.1440607026982;
	Wed, 26 Aug 2015 09:37:06 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	vw6sm23226840pab.14.2015.08.26.09.37.05
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 26 Aug 2015 09:37:05 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 26 Aug 2015 09:37:44 -0700
Message-Id: <1440607067-14461-1-git-send-email-kergoth@gmail.com>
X-Mailer: git-send-email 2.2.1
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 0/3] A few fetch bugfixes
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
X-List-Received-Date: Wed, 26 Aug 2015 16:37:07 -0000

From: Christopher Larson <chris_larson@mentor.com>

These were discovered and fixed as a part of the git shallow mirror tarball
support implementation.

Christopher Larson (3):
  bb.fetch.git: remove leading '.' from gitsrcname
  bb.fetch: handle checksums consistently for mirrors
  bb.fetch: don't remove the clone when an update fails

 lib/bb/fetch2/__init__.py | 13 ++++++++-----
 lib/bb/fetch2/git.py      |  5 ++++-
 2 files changed, 12 insertions(+), 6 deletions(-)

-- 
2.2.1


