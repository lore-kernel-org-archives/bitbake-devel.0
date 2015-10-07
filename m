Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
	[209.85.220.43])
	by mail.openembedded.org (Postfix) with ESMTP id AF5AC605D2
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 03:03:24 +0000 (UTC)
Received: by pacex6 with SMTP id ex6so6229565pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 06 Oct 2015 20:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=8yn/XFp0/gY6CfG5zq0StjfPHjdNwX5+D+eNTBfpxFM=;
	b=D2D5VTn2mlty6Pf/BOydVcheot9HXFzohnrU0/qAZZDKIn5t5y8B6sau8kJPrI0ebb
	sB9EnhimIjhHc46ZgeztRe4qfTl+1BFs+O//ognAMn+Clk6hj3FOiDrVjg/GV5S7PoQY
	+n3ehrcpbF4q67BQ53pU/rQlM9z4SShT+Fk5Y7ufxiJbqjKIyOvcXGVAlfnT7+UzQaiF
	qTJMLMVjKABTAPOsKTNHpIS56mNu9nRDb5k4vsXlqMoqqjMBpqMzechW9/+iVP+wG5wJ
	ULxOHRRfXQgDWlNn+WRqHPzHfwfquooR8+YjemBwF1OybgA0ysudn2CgHdREZuLsRE+Z
	U1/Q==
X-Received: by 10.66.120.80 with SMTP id la16mr50863981pab.1.1444187004337;
	Tue, 06 Oct 2015 20:03:24 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	oo2sm17191607pbb.86.2015.10.06.20.03.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 06 Oct 2015 20:03:23 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Oct 2015 20:05:14 -0700
Message-Id: <cover.1444187051.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/2] rationalise mime type guessing in toaster
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
X-List-Received-Date: Wed, 07 Oct 2015 03:03:25 -0000

This eliminates the filemagic external requirement and fixes the
image download links.

-b

The following changes since commit 19e5f3378e7f6dad9696ef97c074c738dbcef157:

  bitbake: toaster: display warnings for bad "IMAGE_FSTYPES" values (2015-10-06 19:50:29 -0700)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/elliot/2015-09-24_rationalise-mime-type-8369_t2
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/elliot/2015-09-24_rationalise-mime-type-8369_t2

Elliot Smith (2):
  toaster: Use Python's mimetypes module
  toaster: Rationalise mimetype guessing to fix artifact downloads

 lib/toaster/bldcontrol/models.py | 34 ----------------------------------
 lib/toaster/toastergui/views.py  | 17 ++++++++++++-----
 toaster-requirements.txt         |  1 -
 3 files changed, 12 insertions(+), 40 deletions(-)

--
1.9.1

