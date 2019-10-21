Return-Path: <kergoth@gmail.com>
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
	[209.85.221.44])
	by mail.openembedded.org (Postfix) with ESMTP id C6CBA606B2
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 17:08:54 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id p4so14868464wrm.8
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Oct 2019 10:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=mwzy0596Lvg6AyuhnBGwtdIyi8b2uR+VkJdZPffpx3k=;
	b=ChJ1p+PmSJVgUY+lvIB5ONtVIZrbSygrVZOEGuu5zqha0AVgsRsfKye2gC6jIlI8dH
	7wZDnBIHUKbCnFP5ZmZCHklKcwtSUIA68NHrac+x5HpJEPxZ8lMb9MKJbXpoeKoxMUds
	7qk0C3KqxsNvW/xSh/5Nm9jKOlzSNSdLmsuVW2eej1gba+dBG5t3bJDXdElx2dvCGVy/
	wE68CVYqfg2ComKZhRhcTMDCtTE3q0a+l+b4uocl+EsjNqr4Sy+12tS06iGHm+a/TmeF
	8G3Uy4pb5sRibzj+EtZq5kR2BzC+zd2q8UCBwNtOVjAmHcU+z6oH4Gz8AlXqfhmqV3cZ
	JaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=mwzy0596Lvg6AyuhnBGwtdIyi8b2uR+VkJdZPffpx3k=;
	b=dzz7oJjlpo8EUYerYoHD47kV4lfN/1LT4ea72O+Xg7AB3qmnCZKleW8dfa7MnCnT1v
	gwLYmkklkJI5tCbcgg5x73ztrJEmWjoJyBjUDpRGQnTtwsozxwKqc191fPtnUXQmxqxK
	/Uqohtp3KbmqlltK6Mjsst6biLzNfIEfS7XCPNViIHtdzvitKYLprrXoNEvbFLECQfk7
	1wYJMNffzT4e9OqYmp07M/46rLObgqXA+VYhLOAzc5CfuIktvR4vokuykdFuNsySTHI1
	TJy63AygCkOBfgO5kMYm/vULwo+ccXBB/DexbvHZ6Ce+CnPsQD0F8e5ssOvl2rZF1Cbi
	/f9g==
X-Gm-Message-State: APjAAAUQP2xTiJLXa6Yc9h2UNyDXIXi6nUFE7fEg+zlOLqWOkZC9ITYJ
	LO/O0dJqJpkIcAdGSzaNy7ZmR8tz
X-Google-Smtp-Source: APXvYqxJB7+FLmRf9gCDOt3XxrP/mWk/cd7qQmagBdZ9gP+jE1M9L/LZI5Xx902a/RE09iEfrIDaEw==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr6574060wrm.104.1571677734920; 
	Mon, 21 Oct 2019 10:08:54 -0700 (PDT)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id y1sm18532170wrw.6.2019.10.21.10.08.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Mon, 21 Oct 2019 10:08:53 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 21 Oct 2019 22:09:52 +0500
Message-Id: <cover.1571423184.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.11.1
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 0/2] fetch2/git: fetch shallow revs when needed
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
X-List-Received-Date: Mon, 21 Oct 2019 17:08:55 -0000

From: Christopher Larson <chris_larson@mentor.com>

When bitbake determines if a git clone needs updating, it only checks for the
needed srcrevs, not the revs listed in BB_GIT_SHALLOW_REVS, which will fail if
using shallow and the needed rev was added to the upstream git repo after a
previous fetch. Ensure that we also check for shallow revs.

[YOCTO #13586]

The following changes since commit 5d83d828cacb58ccb7c464e799c85fd2d2a50ccc:

  bitbake: Update to version 1.44.0 (2019-10-09 14:10:21 +0100)

are available in the git repository at:

  git@github.com:kergoth/bitbake 13586

for you to fetch changes up to 47e7f25073fe14cae3d1c181bb52766adfad59da:

  tests/fetch: add test for fetching shallow revs (2019-10-18 23:25:13 +0500)

----------------------------------------------------------------
Christopher Larson (2):
      fetch2/git: fetch shallow revs when needed
      tests/fetch: add test for fetching shallow revs

 lib/bb/fetch2/git.py  | 23 ++++++++++++++++-------
 lib/bb/tests/fetch.py | 20 ++++++++++++++++++++
 2 files changed, 36 insertions(+), 7 deletions(-)

-- 
2.11.1


