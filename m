Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
	[209.85.220.45])
	by mail.openembedded.org (Postfix) with ESMTP id 00570608B7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Sep 2015 22:33:18 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so53255549pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Sep 2015 15:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=6q3+sPMHO4+VUBRCjNPqsCd3jONkDXzyr0GrDv9amiE=;
	b=HKbFEZJuyRAVsgATv77CT192csJSTmJ7f6zMNgt6J8xSJ/VB6aNguMIcc9KJT1TP3c
	W0ZID41A+0bMHtGqrlgbsKGiToM/a7YJUggiFpHzxENfTaBjkE28KxWalVCn0S13NAWu
	7TkVJgtGZ2B3hUalLF7FDe5TsSBuSJ0dLgTzYQsFUD80ibKaa4aVzq5F2AzSUj7mWSes
	pwSHnuM9wuIkp9iR+Qnr+jxpkgjvRAl4ra46BDGpvCkXu2glvY00XHq+s70XiLWPjqo+
	Hdr5t10Nn1+ffpgo0iu/BMpD6oGoSX/rkR0z9z5vr2QSWmmkPvCZElLCyuDZ6VYBdflR
	NYTA==
X-Received: by 10.68.65.104 with SMTP id w8mr40520240pbs.48.1443047599231;
	Wed, 23 Sep 2015 15:33:19 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	vw7sm9893518pab.15.2015.09.23.15.33.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 23 Sep 2015 15:33:18 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 23 Sep 2015 15:34:46 -0700
Message-Id: <cover.1443047547.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/6] fixes and improvements for layers cloning
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
X-List-Received-Date: Wed, 23 Sep 2015 22:33:20 -0000

This patchset includes changes for Toaster cloning functionality:
 - used more appropriate git commands: git reset --hard instead of
   git checkout && git rebase.
 - changed naming of clone directories, made them unique
 - moved clones to subdirectory

The following changes since commit 524ddd86c305af1b029c1773affe5cebffc62b28:

  oeqa/utils/qemurunner.py: Remove duplicate message on LoggingThread start (2015-09-23 09:53:21 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/ed/20150923-better-git-layers
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/ed/20150923-better-git-layers

Ed Bartosh (6):
  toaster: don't use --single-branch when cloning
  toaster: use git reset --hard instead of rebase
  toaster: fix bug in resetting git repository
  toaster: fix reimporting module
  toaster: make clone directory name unique
  toaster: move clones into subdirectory

 lib/toaster/bldcontrol/localhostbecontroller.py | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

-- 
1.9.1


