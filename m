Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f46.google.com (mail-pa0-f46.google.com
	[209.85.220.46])
	by mail.openembedded.org (Postfix) with ESMTP id 1E31160053
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Sep 2015 20:56:13 +0000 (UTC)
Received: by padhk3 with SMTP id hk3so84320752pad.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 11 Sep 2015 13:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=HrKAdCvM7T4nT0tbqvNAc+lOJOhvjrp5LEz6FxEFfCw=;
	b=N1TStjECXckySJ8qrYx6O5yyNDxdpKs7OmqGdk3wIA7zu5AvkKP26MH2ju5Xrj/g5r
	DwT81HVhU6KsP8bSAUk1qMvAGIb+E0cMkpBd22O2by3V/GyWtScOcgEC1xfh4rZ4s7Q0
	Ip4YDIVR2c2z2eDXcJqZnk2olm4IzTEU4m1znao6Pyr4gVEuswD5z1E3PRaiWczisCXg
	45UW7A2lIzOH5dMP7MQarWRFENB3wscXTpgo1CdBfuBSidlptZj4Otas8v3oukmHNEF/
	g1wMoGgn/RDeD/ZN1cQBRSAZinnnMBHmknPHJs69eMWGvpH78DOP74rYbwmrL7O/3x7c
	yHhw==
X-Received: by 10.66.155.9 with SMTP id vs9mr1598716pab.63.1442004973551;
	Fri, 11 Sep 2015 13:56:13 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	qr5sm2062521pbb.26.2015.09.11.13.56.12
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 11 Sep 2015 13:56:12 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 11 Sep 2015 13:57:20 -0700
Message-Id: <cover.1442004911.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/3] Read correct cooker log
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
X-List-Received-Date: Fri, 11 Sep 2015 20:56:16 -0000

this patch selects the correct cooker log in both analysis and managed mode.

The following changes since commit d4585fa23d56a58c583ee33db067a23177a936b1:

  bsps: update 3.14 SRCREVs (2015-09-09 14:27:57 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/elliot/20150911_read-correct-cooker-log
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/elliot/20150911_read-correct-cooker-log

Elliot Smith (3):
  toaster: Read correct cooker log path from toasterui
  toaster: Avoid unnecessary local to local copy of cooker log
  toaster: Don't def a function for each call to build_artifact()

 lib/bb/ui/buildinfohelper.py                       |  8 ++--
 lib/bb/ui/toasterui.py                             |  2 +-
 .../management/commands/checksettings.py           | 22 ---------
 .../bldcontrol/management/commands/runbuilds.py    | 24 +---------
 lib/toaster/toastergui/views.py                    | 53 ++++++----------------
 toaster-requirements.txt                           |  1 +
 6 files changed, 23 insertions(+), 87 deletions(-)

-- 
1.9.1


