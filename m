Return-Path: <kergoth@gmail.com>
Received: from mail-pf0-f194.google.com (mail-pf0-f194.google.com
	[209.85.192.194])
	by mail.openembedded.org (Postfix) with ESMTP id 8B90E71974
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Mar 2017 18:40:44 +0000 (UTC)
Received: by mail-pf0-f194.google.com with SMTP id r137so19481823pfr.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Mar 2017 11:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=Zw5vn4EmazhPWt53W5r7sLAAibZfJuTkLOJEV+gvI0o=;
	b=HhYZ9ACxi1zE3yhwgNzOD4IOTwns4CW9Eh9kId7HpAWbwyA1/6T8FLyTGHR9hFoYOV
	lhjMjUaxXpKL3VUUwnmRLW2v/R8frZRqOW3AijLgOfBqXWQxwZQmSgRepq2jbGUbJQF1
	N3wcgBzE1YAP3g0JEqJy/gMWFv22CukYdeXXKrnsZ5Dm/8NWpThVwbs349xQ/2fgaBBM
	885zsb792x3F67ScgsYRrjbgzDvbPqA9Wkz7P8ByLUQN3ISf+7mGb/ZHw7f29BaZeQz4
	GRJqViNBulNsbT72e5Kad7VAYIMVYVwJxUE4Bd8j9ejsdrv+3OaKUXlN2fWd/ws1uei1
	EqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Zw5vn4EmazhPWt53W5r7sLAAibZfJuTkLOJEV+gvI0o=;
	b=BT9jLbqh+/0CCfY3WaH1VRxVWSK+kQAWUVjXXoBTGOm6nHJd4irjDlSwTXX5BqB9u6
	IFaxwOIFHTVSCqGYQtCQ+NraR4eJs8/mBCGZBqe5ghKLDQXRAEhn3PWFK1q0/A+lDlZx
	siEakLTD63pCdPyq/Kc0vQ9yUf09mBe0Gip+FEttq+LlbcmAW6KZ4EWdlnIBDEQF3KZP
	tPohiJPJ76uLC4mxRskB8BUtV4e1984q2ggaKoFOX4+aH0o3VtNHCD6gHO8xK3nG+33F
	lfvUnTiD9vjn5pAPT8rMdU/xOXPVX6B7KISx4Ld4ALEyeDU2vQD+TdcpFuSLoH50EztW
	xxww==
X-Gm-Message-State: AFeK/H25VybdbZ80UXPGbKQwiL/BSMT8Hn+dichC5WkuxyME9HjUOhbmlgAg2hNc0aYBiQ==
X-Received: by 10.98.12.148 with SMTP id 20mr41025535pfm.116.1490121646272;
	Tue, 21 Mar 2017 11:40:46 -0700 (PDT)
Received: from quark.alm.mentorg.com (nat-lmt.mentorg.com. [139.181.28.34])
	by smtp.gmail.com with ESMTPSA id
	w28sm35938489pfl.115.2017.03.21.11.40.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 21 Mar 2017 11:40:45 -0700 (PDT)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 21 Mar 2017 11:40:16 -0700
Message-Id: <cover.1490121529.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.8.0
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 0/4] fetch/git: a few cleanups and one minor fix
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
X-List-Received-Date: Tue, 21 Mar 2017 18:40:46 -0000

From: Christopher Larson <chris_larson@mentor.com>

The following changes since commit 1ff9b3c669fa187f152de7b8b57d14c2468d926c:

  tests/data: Add inactive remove override test (2017-03-16 12:54:59 +0000)

are available in the git repository at:

  git@github.com:kergoth/bitbake bb-fetch-git-cleanup

for you to fetch changes up to 0f71517b5208e117133b67fe728d482e7a575f35:

  fetch/git: fix FetchError reference (2017-03-17 14:32:25 -0700)

----------------------------------------------------------------
Christopher Larson (4):
  fetch/git: use enumerate for ud.names
  fetch/git: kill pointless quotes around single % args
  fetch/git: drop pointless os.path.join, workdir=
  fetch/git: fix FetchError reference

 lib/bb/fetch2/git.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

-- 
2.8.0


