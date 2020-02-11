Return-Path: <akuster808@gmail.com>
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
	[209.85.210.194])
	by mail.openembedded.org (Postfix) with ESMTP id A488260B4A
	for <bitbake-devel@openembedded.org>;
	Tue, 11 Feb 2020 01:47:54 +0000 (UTC)
Received: by mail-pf1-f194.google.com with SMTP id k29so4607276pfp.13
	for <bitbake-devel@openembedded.org>;
	Mon, 10 Feb 2020 17:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=fcIdNv9emcYjkRslXWOS97DjxYu4eC3Ui4CjKapsovI=;
	b=RcUdZ8pnADj+RLyVhD9o55WjG/JQ7m76J1vWjh9oz2rCAUYb6xughZaoB0F32TeufP
	aaSMS0SY95+PLR5oG8qoBzfFny5rlzr+Ne60lRo1Z872i22fNz2G9f9pYQYWzJZ+dy8Q
	eBrjSlzohFz8YhDKJkDwZd4mjfNHi59oMBLR+dO6qIQfrh0x6VPezIRteiXExx0CDnY4
	7ZquMVGdbekBvhqiZxsTG/b52STE5lSIXM5puUS349VEg4MRBJSijHa2vHbIepz57WH7
	mzm2BqaVcRft0AjOatRfMr50ZTESizHSUDVlG9uz4I7812Z2Mq+59G9r3VNCksBFtJdf
	UmUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=fcIdNv9emcYjkRslXWOS97DjxYu4eC3Ui4CjKapsovI=;
	b=h+pzOASwoP3/ZSYLcnCAT1BLWQnv7lJqGeMUHzGCA7uh1RnPouDMMr1Rx6kV9ttOtK
	SJ9sjIagaO5LZvESwRgD23YmWNwoDqSR9QyZBLq/eDO48mZRvMv+F37j2/33j1wWHV8R
	kAQHzl1CKMkLE0sdeFNIkna6v9druEKtzO4kiQ4GzyN3Y4vJZ853HMCvZfEJ02efjZUQ
	Zhk0x8IJhjtXyjjrf97m//JiyFSEcpuevqFt967JgQV+aV7nyF8CZPDZInDWErcp8A6b
	bf95SnJ8tNYST7AGp1ikmzK9anLZmOHSlSiBzaAsZJOL5E/DEfxvy58FdFn3lXv5ErZr
	rVvg==
X-Gm-Message-State: APjAAAVX/q+TyFHYUvXfpmUr3Jh2l8/qDqU9yNTBaf89Hz5bPaRL5ciA
	mMR61KBKN98YG9REn0Fo+pljqnZ8
X-Google-Smtp-Source: APXvYqzS1Zxk5ZRLyZcXh0Pm7ZXtRZS7K0aD3z1EnceELlWk+EATfMlzjgdv8SzfAemim6+jVyUTag==
X-Received: by 2002:a65:6909:: with SMTP id s9mr4575026pgq.80.1581385675304;
	Mon, 10 Feb 2020 17:47:55 -0800 (PST)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:a5c0:58cf:c2e4:7ede:a168])
	by smtp.gmail.com with ESMTPSA id 70sm1388145pgd.28.2020.02.10.17.47.54
	for <bitbake-devel@openembedded.org>
	(version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
	Mon, 10 Feb 2020 17:47:54 -0800 (PST)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@openembedded.org
Date: Mon, 10 Feb 2020 17:47:43 -0800
Message-Id: <cover.1581385547.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.17.1
Subject: [1.44 0/7] Pull request
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
X-List-Received-Date: Tue, 11 Feb 2020 01:47:55 -0000

Consolidate pull request, Cover letter only.

The following changes since commit 1a026d4aca47ed1b0b74a8a818635e7520e8f9c8:

  runqueue: Use a set for the setscene tasks list (2020-01-18 12:20:38 -0800)

are available in the Git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.44-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.44-next

Chris Laplante (3):
  fetch2: do not suffix srcrev cache key with PN
  fetch2/git: _revision_key: collapse adjacent slashes
  persist_data.py: Immediately get exclusive lock in __setitem__

Frazer Clews (1):
  cooker/toaster: replaced deprecated method warn() with warning()

Richard Purdie (3):
  siggen: Optimise get_unihash disk based cache handling
  siggen: Cache unihash values to avoid cache lookup
  siggen: Avoid cache mismatch issues with locked sigs

 lib/bb/cooker.py                              |  2 +-
 lib/bb/fetch2/__init__.py                     |  3 +-
 lib/bb/fetch2/git.py                          |  4 +-
 lib/bb/persist_data.py                        |  3 +
 lib/bb/siggen.py                              | 68 +++++++++++++------
 .../management/commands/runbuilds.py          |  6 +-
 6 files changed, 60 insertions(+), 26 deletions(-)

-- 
2.17.1


