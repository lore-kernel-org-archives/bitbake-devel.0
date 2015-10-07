Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
	[209.85.220.53])
	by mail.openembedded.org (Postfix) with ESMTP id 6600B73D13
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  7 Oct 2015 03:19:26 +0000 (UTC)
Received: by pablk4 with SMTP id lk4so6514107pab.3
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 06 Oct 2015 20:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=XtD3UXYa5JOPHmIT3OZc9pLBnv8t9EM5B4r4ZXCF7iY=;
	b=1Aa2gczvAdiLvD29QlvvEUsbdjoxgKbR/l5nJ4ulYZvvUdjdinA5+KxLC+ZoYkf330
	WtsRl86ObR+V3NQ4XkTy04PWELQXktVFtqF3mfqvsnX2n2Q2dvUnrxRop8eqZuXIqulx
	WSd0eV+LsTuiR+S1YvY4V0U5gz+5LjTKio1gAIJ/fgFp7OzTQRW5ukpiKeN3vVdnj0Kx
	d5Mhq6RtmsS2x8g40w7/AaTwCTsVWXIkyA0PkM/cJCPIiCnu/jxCOcIFTTsFq37SXEi1
	EBde07lIBABC6NJDMmXaJ8BAWHMk/DBCYYJxc1+HGT1Q+NoyTGfrc6nyDo0eqfO+qiyN
	My+w==
X-Received: by 10.66.119.167 with SMTP id kv7mr25797763pab.141.1444187967249; 
	Tue, 06 Oct 2015 20:19:27 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	gj10sm36172720pbc.68.2015.10.06.20.19.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 06 Oct 2015 20:19:26 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  6 Oct 2015 20:21:18 -0700
Message-Id: <cover.1444187945.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/1] toaster: fix orm machine typo
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
X-List-Received-Date: Wed, 07 Oct 2015 03:19:27 -0000

this fixes a type that was preventing the machine typeahead
search from working.

-b

The following changes since commit b0833604e6b67c93abee7eb8a791c1ea298f4da9:

  toaster: Rationalise mimetype guessing to fix artifact downloads (2015-10-06 19:58:53 -0700)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/michaelw/2015-09-29_orm_machines
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/michaelw/2015-09-29_orm_machines

Michael Wood (1):
  toaster: orm Machines filter don't pass self in as parameter

 lib/toaster/orm/models.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--
1.9.1

