Return-Path: <michael.g.wood@intel.com>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
	[209.85.212.172])
	by mail.openembedded.org (Postfix) with ESMTP id 733E760043
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 16:28:34 +0000 (UTC)
Received: by wicja10 with SMTP id ja10so113345938wic.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Aug 2015 09:28:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
	:content-type:content-transfer-encoding;
	bh=xowlIun1ueU3JXB0gDLQCEhLWVp6S8IXy6z8kqqze/g=;
	b=NJxVqxO9j+vDyoXXBBBW/+1wmSSymUQRrwr7odPpPxWHNvd/27MajMpPQ0GiyNUhaN
	+G44j9uVjv9LpWxgg4CPk4T76oaiYjWUOq1ZjXEVuvq2bWXRs2rPyhckGRo6Fh8cvqxE
	wIOVIv6UFTLAqZtlJ4V5dsL4TcihfIAiCfHeSzSXSS7THwqGip8HMgg1CFpQXlTIHs4t
	yvb/AfqQaGHboYsAvxrlDhv/MFjbeAFKdYWgwGIVPJCIatcCxHhEoKPrAG3noyuHftSB
	GVUHoCCn0/DtN0vYviiFOCmjABvfsynAoEIYgHvNegYG5UKOU2dtXwkVOFbqIcxDHWon
	6HIw==
X-Gm-Message-State: ALoCoQllIydgib953rFOslcTZQGryjlAZOkTh3BeAeWxKSH8NSVGj/Ys8T4BDTxSnxvo0/sWCkKL
X-Received: by 10.194.176.201 with SMTP id ck9mr14807422wjc.108.1439915314821; 
	Tue, 18 Aug 2015 09:28:34 -0700 (PDT)
Received: from dorado.Home ([90.200.212.221]) by smtp.gmail.com with ESMTPSA id
	ck18sm27171385wjb.47.2015.08.18.09.28.33
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 18 Aug 2015 09:28:33 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 18 Aug 2015 17:28:21 +0100
Message-Id: <cover.1439915029.git.michael.g.wood@intel.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Subject: [PATCH 00/14] Toaster patches
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
X-List-Received-Date: Tue, 18 Aug 2015 16:28:39 -0000
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

Various bug fixes and pylint fixes. Reviewed by Belén and Michael.

The following changes since commit c348fa50186fb0796bc7b793c4b8d710419f2a0d:

  bitbake: toaster: move code from setup_lv_tests to setUp (2015-08-17 14:41:45 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib michaelw/toaster/submit/adamian/20150817_bug_fixes_poky
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=michaelw/toaster/submit/adamian/20150817_bug_fixes_poky

Alexandru DAMIAN (13):
  bitbake: toaster: pylint fixes
  bitbake: toaster: checksettings: fix guesspath initialization
  bitbake: toaster: checksettings: fix TEMPLATECONF detection
  bitbake: toaster: improve exception handling
  bitbake: toaster: models field initialization
  bitbake: toaster: use loggers instead of prints
  bitbake: toastergui: rename variables in views.py
  bitbake: toaster: do not stop data import on bad data
  bitbake: toaster: replace raising Exceptions in loadconf
  bitbake: toaster: fix updates on failed build requests
  bitbake: toaster logger: fix pylint issues
  toastergui: do not show in-progress builds in the table
  toastergui: fix projectbuilds page

Alexandru Damian (1):
  bitbake: toaster: fix pylint errors

 lib/bb/ui/buildinfohelper.py                       | 130 ++++++++-------
 lib/bb/ui/toasterui.py                             |  62 ++++---
 lib/toaster/bldcontrol/bbcontroller.py             |   2 +-
 .../management/commands/checksettings.py           |  15 +-
 .../bldcontrol/management/commands/loadconf.py     |  37 +++--
 .../bldcontrol/management/commands/runbuilds.py    |   2 +-
 lib/toaster/orm/models.py                          |  80 ++++-----
 .../toastergui/templates/projectbuilds.html        |  42 +----
 lib/toaster/toastergui/views.py                    | 183 +++++++++++----------
 lib/toaster/toastergui/widgets.py                  |   3 +
 .../toastermain/management/commands/perf.py        |   7 +-
 11 files changed, 293 insertions(+), 270 deletions(-)

-- 
2.1.4


