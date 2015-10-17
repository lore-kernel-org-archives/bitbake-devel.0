Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f41.google.com (mail-pa0-f41.google.com
	[209.85.220.41])
	by mail.openembedded.org (Postfix) with ESMTP id 000E17712B
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Oct 2015 17:43:38 +0000 (UTC)
Received: by padfb7 with SMTP id fb7so6711730pad.2
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 17 Oct 2015 10:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=NaSNXzNrBf9m6ELpuzQJ9NvWTBOkd8coeMLwfFkMUwA=;
	b=JbkSSEe2HMJ0vrnAen31vcfsdEUhnEyHKb3M5t0BRjGR9EEuV0IoGZgVD3fscYyjzS
	5/5sHqLlx/iqPb2ZsxUzAYvHU9ngvPvpBcDZDGUscMt0vfi+74UcYsJ6DKXUoKB1Z7us
	Y6YAo0eBadvQsEbvCDdyFXGVFlYbrB9xh1SKcGog59xaXb0yTHph4qmi5NkU/75OTDvW
	RQdmAIdKLJCaZch+TYhlhhEhD3AuVvPb8eiM4xRndc9l7+fvCgGaSKPmUnzUtj2cA3b1
	CyHgfApeoawIGZwlCP6OaB3vcaA0b+fFEeFaB2yKeZOOni4kTcqoB8EYuNhbOujz0wGO
	xhEA==
X-Received: by 10.68.69.108 with SMTP id d12mr23665182pbu.137.1445103818254;
	Sat, 17 Oct 2015 10:43:38 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	v13sm10975273pbs.51.2015.10.17.10.43.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Sat, 17 Oct 2015 10:43:37 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Sat, 17 Oct 2015 10:45:47 -0700
Message-Id: <cover.1445103849.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/6] toaster: hide other projects while in analysis mode
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
X-List-Received-Date: Sat, 17 Oct 2015 17:43:41 -0000

The UI currently shows all the navigation elements in both analysis
and build modes, even if they are irrelevant or broken.

As a temporary measure (until we merge the two modes), hide most
of the navigation and UI elements when in analysis mode, so the user
only gets to see the command-line builds project.

-b

The following changes since commit 049d42197c7096e2e8389cc136777770cda0e792:

  toaster: add get_or_create_targets API (2015-10-16 09:57:43 -0700)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/elliot/2015-10-16_hide-proj-analysis-mode
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/elliot/2015-10-16_hide-proj-analysis-mode

Elliot Smith (6):
  toaster: Add BUILD_MODE flag to context
  toaster: Show mode-appropriate landing page
  toaster: Hide top bar buttons in analysis mode
  toaster: Hide builds for non-cli projects in analysis mode
  toaster: Run tests in build mode
  toaster: Remove all navigation when not in build mode

 lib/toaster/toastergui/templates/base.html    |  22 ++++--
 lib/toaster/toastergui/templates/landing.html | 103 +++++++++++++++-----------
 lib/toaster/toastergui/tests.py               |   6 ++
 lib/toaster/toastergui/views.py               |  36 +++++++--
 lib/toaster/toastermain/settings.py           |   6 +-
 lib/toaster/toastermain/urls.py               |   2 +-
 6 files changed, 113 insertions(+), 62 deletions(-)

--
1.9.1

