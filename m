Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
	[209.85.220.54])
	by mail.openembedded.org (Postfix) with ESMTP id 6D31A60053
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 17:04:01 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so48998488pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 10 Sep 2015 10:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=ReN4/eyuz4XKzGStCREi+xKQTIzqIfNsrO2nIIXkyVk=;
	b=k5Nt2qMl0BEwIkbNqDDI59WpPHTcYp2SDILq5Caw49e4d91KgXOK1T/KV14I3/b3jv
	Atoqgqi/hktTkL/r4szfO4g8+mRZY3ZMMIs6tE+nRygRJBqxDMr8s1nCs01pB0enS4JD
	P2kPNfYKHDuil8l9YFmUhiq3HILdVHfO20xW7ewgrdDmUHJCOTdzRwHd00gQHKtKd9zV
	hC39253nsUl0dttMKH7faWsMbM87NIodu2J0yZC7VrBvbcHdFrtR2LI4HjMYtop7kmR1
	NkoShg5t/LJiQvk1ly1CVgNAqE3JGFAC/DnQ/qZwiscsbZ76hzUmauPsdA544AiHv7Dk
	AYKw==
X-Received: by 10.68.93.133 with SMTP id cu5mr86171744pbb.71.1441904642151;
	Thu, 10 Sep 2015 10:04:02 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	fk8sm13081399pab.33.2015.09.10.10.04.01
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 10 Sep 2015 10:04:01 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 10 Sep 2015 10:05:03 -0700
Message-Id: <cover.1441904599.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/5] Hide irrelevant builds
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
X-List-Received-Date: Thu, 10 Sep 2015 17:04:02 -0000

This patch fixes the project builds view so it doesn't show
"in progress" builds or builds for other projects.

The following changes since commit db92bc23880794be77373b0f2d8c26279dcecb84:

  bitbake: toaster: replace ETA with % of tasks done (2015-09-08 23:54:15 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/elliot/20150902_hide_irrelevant_builds_v2
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/elliot/20150902_hide_irrelevant_builds_v2

Alexandru DAMIAN (1):
  toaster: hide irrelevant builds in the project builds view

Elliot Smith (4):
  toaster: Add tests for /project/X/builds page
  toaster: Show correct builds count on project pages
  toaster: Fix date range pickers on the project builds page
  toaster: Simplify redirects when build page parameters are missing

 lib/toaster/toastergui/static/js/base.js           |   4 +-
 .../toastergui/templates/projectbuilds.html        |   4 +-
 lib/toaster/toastergui/tests.py                    |  91 ++++++++++++++++-
 lib/toaster/toastergui/views.py                    | 108 +++++++++++++++------
 toaster-requirements.txt                           |   1 +
 5 files changed, 169 insertions(+), 39 deletions(-)

-- 
1.9.1


