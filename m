Return-Path: <matt@madison.systems>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 8655E73212
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 17:08:55 +0000 (UTC)
Received: by mail-pa0-f54.google.com with SMTP id ti13so17564837pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2016 10:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=madison-systems.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=iLpUyoyqpHWDm/wrqU2NGyRe3PHhEcYGy44mKFVphAY=;
	b=Gb3spxRSGS0LQNY4UFsOAtYfKBc1X5DxYhDhA1DnDqWnfIf99jE1Tjz1HTF1l/lHIF
	5Sfa1UUQ/m93o7KRhmariJvodDXxhwR07bPM438u8CnvGpo3ccLuuPUf39Xnd8h4niTf
	izccTuR3hBOQIVmCVv+j0n+Z+RC0S0tqT+MplAG2fqTADBtwH4JRUxkoTpr9TEytVyz3
	AYcksLcG0wf/lmO5Cr20wH/cVig8+q8yQEJUaCo1fV2Q886yaBbPUO0MTOvBfDVDFl4W
	jT2lja/aR4L2/yKrYfMkfucwQ3ui20ceLgiHID7pLe/kEyGPqFQq9yQsIMTxJ7JK5uff
	FIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=iLpUyoyqpHWDm/wrqU2NGyRe3PHhEcYGy44mKFVphAY=;
	b=EXue1UwjA/DVSOfnTzGBU8BzH3uDnftQPdCbP6IE5gftlyA04TknzcXiFb/O5LXxaT
	YUMyyna7NgGmP2r4gRYT6snfXaE8JzFB8yIg1n9aJH/1iOEf8KxdafymtOAGrBWiifLY
	goEB/DxJB8rmxIOAYQG5uXV089ubQi24NUmoFQg6HJa2azb7LGBOssOWtiVf61iO/eyq
	L3flRazFBAlqXFpUH725L2AcyjemVibAsWAZ2qU7jHnwZLeiPPFfhFodwc2g2kXp8V5Q
	d2yTGeEQE2Du4YHrkNelci5kkgG7YuM4MqOr+5UiCfsNvszdf5gvxmkqZnWAFtG9C4TZ
	8awg==
X-Gm-Message-State: AEkoousB8oB3zB6E0NkaorcnZ7RWCh/p//qh/EvD/hws8U1W9W3jex6bW6QU1ghwN3bKrQ==
X-Received: by 10.66.15.138 with SMTP id x10mr8919567pac.92.1470848936216;
	Wed, 10 Aug 2016 10:08:56 -0700 (PDT)
Received: from localhost.localdomain ([12.30.244.5])
	by smtp.gmail.com with ESMTPSA id
	q26sm65399617pfj.53.2016.08.10.10.08.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 10 Aug 2016 10:08:55 -0700 (PDT)
From: Matt Madison <matt@madison.systems>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Aug 2016 10:08:15 -0700
Message-Id: <1470848896-23041-1-git-send-email-matt@madison.systems>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH v2] Fixes for fetcher cwd changes
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
X-List-Received-Date: Wed, 10 Aug 2016 17:08:56 -0000

Here is a more complete patch to fix the working directory changes in
fetcher methods.  In most cases, the pattern was an os.chdir() call
followed by a runfetchcmd or other subprocess call, so I updated
runfetchcmd to take an extra keyword argument to set the cwd of the
child process.  For the remaining cases, the cwd is saved and restored.

The only exceptions are the try_mirror* methods, which look like
they're only used internally by other methods, and those callers
have been updated to preserve cwd.

This fixes my original issue with bitbake reporting 'changed cwd'
warnings from setscene tasks, and also fixes the bitbake-selftest
failures with my first patch (which were cause by dangling cwd
changes to temporary directories that got wiped after test cases
were finished).


Matt Madison (1):
  fetch2: preserve current working directory

 lib/bb/fetch2/__init__.py  | 21 +++++++++++----------
 lib/bb/fetch2/bzr.py       | 11 ++++-------
 lib/bb/fetch2/clearcase.py |  6 ++----
 lib/bb/fetch2/cvs.py       | 15 ++++++++-------
 lib/bb/fetch2/git.py       | 45 ++++++++++++++++++++-------------------------
 lib/bb/fetch2/gitannex.py  | 24 +++++++++++-------------
 lib/bb/fetch2/gitsm.py     | 23 ++++++++++-------------
 lib/bb/fetch2/hg.py        | 28 ++++++++++------------------
 lib/bb/fetch2/npm.py       | 22 +++++++---------------
 lib/bb/fetch2/osc.py       | 10 ++++------
 lib/bb/fetch2/perforce.py  |  6 ++----
 lib/bb/fetch2/repo.py      | 13 ++++++-------
 lib/bb/fetch2/svn.py       | 13 +++++--------
 13 files changed, 100 insertions(+), 137 deletions(-)

-- 
2.7.4


