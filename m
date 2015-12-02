Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
	[209.85.220.47])
	by mail.openembedded.org (Postfix) with ESMTP id 5030B60616
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  2 Dec 2015 17:59:21 +0000 (UTC)
Received: by pabfh17 with SMTP id fh17so48531958pab.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Dec 2015 09:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=Mr+lGPzY8m5r9mWF6HAmlDhq+v5IfKIZroj96iW+kRc=;
	b=K6vACcOh4OidhXnTAHIx/evqg9m1xgOUlEVTQ54+jPPmsBkvq4gdwfUvkpAOkfGB1G
	KkmkUipJecXnY6yuvm7S/BQV2HnauHb3DcyPylmMQ0ZF8MR6zh3U2xx/C+jXpnqQ4+dE
	32Wrq7Py2YtmUJY6NaY7y9Pbc8DQrqXiKPeT5NBdi5Rm/mfCmmbcBQ0TjvDUP2OlY7ZM
	TuFwg2PjOHNAb1ALN2vF7E3sF23OTmJXMP4x9rwncss4PrCsrhiUd3A699aJBxma4/TK
	dTtJV9X7McQMhAmsCVkdgyxbzG0nyWCS3ECIihiSbTdGdNcAsDfqBsbzI+0nUdL1Wg7t
	Ykrg==
X-Received: by 10.66.236.162 with SMTP id uv2mr6459237pac.101.1449079162256;
	Wed, 02 Dec 2015 09:59:22 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id g8sm5668983pfd.40.2015.12.02.09.59.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Dec 2015 09:59:21 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Dec 2015 10:02:53 -0800
Message-Id: <cover.1449078919.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 00/30] toaster: Merge analysis and managed modes
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
X-List-Received-Date: Wed, 02 Dec 2015 17:59:22 -0000

This large patchset merges the analysis (cli) and managed (toaster ui) modes so that
toaster can be started in one way (sourced just like oe-init-build-env) and can then
handle builds of both types.
-brian

The following changes since commit f09bf40d0d1a6fbaf2251f903d41d970c8a66e3a:

  toaster: toastergui tests Add generic test for ToasterTables widget (2015-12-02 10:41:34 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/ed/2015-12-2_runOneWay-8279
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/ed/2015-12-2_runOneWay-8279

Ed Bartosh (29):
  toaster: don't allow to run toaster as a script
  toaster: implement get-dburl command
  toaster: set DATABASE_URL in toaster script
  toaster: run bitbake the same way
  toaster: remove unused variable
  toaster: check for toaster configuration later
  toaster: use parent of the build dir
  toaster: make runbuilds to loop
  toaster: start 'manage.py runbuilds' in the script
  toaster: update brbe and project attributes
  toaster: implement stop_bitbake function
  toaster: implement start_bitbake function
  toaster: implement 'toaster restart-bitbake'
  toaster: remove _setupBE function
  toaster: reimplemented startBBServer method
  toaster: remove stopBBServer API
  toaster: do not terminate bb server
  toaster: remove usage of BUILD_MODE variable
  toaster: do not create duplicate HelpText objects
  toaster: implement BitbakeController.getVariable
  toaster: set varibales on bitbake server
  toaster: remove writeConfFile API
  toaster: stop using toaster-pre.conf
  toaster: remove SDKMACHINE from project variables
  toaster: get rid of complicated heuristics
  toaster: unset environment variables
  command: add CommandStarted event
  bb/ui: ignore CommandStarted event
  toasterui: process CommandStarted event

Michael Wood (1):
  toaster: buildinfohelper Broaden the toaster created recipe data case

 bin/toaster                                        | 166 +++++++++------------
 lib/bb/command.py                                  |   6 +
 lib/bb/ui/buildinfohelper.py                       |  68 +++------
 lib/bb/ui/crumbs/runningbuild.py                   |   3 +-
 lib/bb/ui/knotty.py                                |   3 +-
 lib/bb/ui/toasterui.py                             |  21 +--
 lib/toaster/bldcontrol/bbcontroller.py             |  15 +-
 lib/toaster/bldcontrol/localhostbecontroller.py    | 140 ++++-------------
 .../bldcontrol/management/commands/runbuilds.py    |  13 +-
 lib/toaster/bldcontrol/sshbecontroller.py          |  10 --
 lib/toaster/bldcontrol/tests.py                    |   4 -
 lib/toaster/toastergui/templates/base.html         |   9 +-
 lib/toaster/toastergui/templates/landing.html      |  10 --
 lib/toaster/toastergui/templates/projectconf.html  |  70 +--------
 lib/toaster/toastergui/tests.py                    |   4 -
 lib/toaster/toastergui/views.py                    |  29 ----
 .../toastermain/management/commands/get-dburl.py   |   9 ++
 lib/toaster/toastermain/settings.py                |   3 -
 lib/toaster/toastermain/urls.py                    |   9 +-
 19 files changed, 167 insertions(+), 425 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastermain/management/commands/get-dburl.py

--
1.9.1

