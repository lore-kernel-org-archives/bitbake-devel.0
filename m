Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
	[209.85.220.42])
	by mail.openembedded.org (Postfix) with ESMTP id E1A57770B1
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 16:32:02 +0000 (UTC)
Received: by padcn9 with SMTP id cn9so10659067pad.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Oct 2015 09:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=+4jjxDOCleIDqxHe0qjSz17e6dSw+AydaM6WOGHDBq0=;
	b=TxdSOcUgCE8afiK2BFKz0U2+RUGsX7pdiRI4U1uZGK/AC/tYWGIriq8qeGu3Ei60yU
	pLRtvXZHIsjK0KpNPHzwK8CprBG+xcMd+rfFFIJoScdSM/zL9FER6dItbUqWy0wDwW2b
	WVWWqvMRdaTuqftWhP4BHVuoZvIV/c2DeoolPeUAH9MNTVZ+kb5LogfFLK6sp1rH3X1c
	vzzQhi5kSVxWhmRY21eKyXGu4KWNzE1+velxd4U0CasWYB6YXD0Tnt9hXepXhfRKK4KD
	r2J9alEQU7uec3eumyJhTCrkl0yqobC4xSP+ZleDgp0oYfgD3SbYLpjw+ajIZekngtBx
	NF/g==
X-Received: by 10.68.247.106 with SMTP id yd10mr10960840pbc.105.1444926722847; 
	Thu, 15 Oct 2015 09:32:02 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	of1sm16320309pbc.11.2015.10.15.09.32.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Thu, 15 Oct 2015 09:32:02 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 15 Oct 2015 09:34:07 -0700
Message-Id: <cover.1444926648.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/4] toaster: fixes for toaster script
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
X-List-Received-Date: Thu, 15 Oct 2015 16:32:06 -0000

This has fixes for the startup script so it can work in
both managed and analysis mode.

The following changes since commit a8e82d93bfa8feb722912d03ee26bbad7e6fe9f7:

  toaster: Modify "New build" button behaviour for cli builds project (2015-10-15 14:54:27 +0300)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/ed/2105-10-15_fixes-for-toaster-script
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/ed/2105-10-15_fixes-for-toaster-script

Ed Bartosh (4):
  toaster: use path to the script to guess config path
  toaster: get rid of SRCFILE
  toaster: set TOASTER_MANAGED variable
  toaster: exit or return depending on the mode

 bin/toaster | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--
1.9.1

