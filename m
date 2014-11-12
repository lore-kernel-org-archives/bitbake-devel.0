Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180])
	by mail.openembedded.org (Postfix) with ESMTP id D0F2365CED
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Nov 2014 13:41:15 +0000 (UTC)
Received: by mail-wi0-f180.google.com with SMTP id hi2so4882414wib.7
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Nov 2014 05:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Moyvc9RyKp/s1t1MEheTfMMPBwqxcbFFfp1n0am1jZ8=;
	b=izRuqJ9W/uzpS+u+YHVX1tlg/ctWnVmlM7HclJD4M5Yd0QlgRbNPXOyIoLuIDf9NUa
	+Pv5YiP4gWtOAAbF2Rkkg53L8fKqz/ajFexKuUlgG6+vDde+ej//Ef09PvL4IJuJeGEp
	a1b1b0D7YJdPj75/rT/6Ho5OVyleriPO1KaNFlD9u1B64T094YQiuSJ3J+StGLmTkIbq
	tBvqmXZ9MCxcJAwjYyaTljTeBEL+zAa9WJvBEq6P28f0b5zZYbRGxuwrEeKtmPC37T9E
	CkHKqCpx7KXEGepBBvikPlEO03urPp1s1c6u+DEMDG4cJgcN4Qsj1R+GOR5M08yDSlwS
	n9dA==
X-Gm-Message-State: ALoCoQmFFcwxngtTa8R+ZM4EpKCvrw3WeB7/MkN1d1Q6e7pq833A6UjolD4STYRpMMrf1YvjRy0U
X-Received: by 10.180.90.45 with SMTP id bt13mr28802401wib.75.1415799675357;
	Wed, 12 Nov 2014 05:41:15 -0800 (PST)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	dm10sm14013696wib.18.2014.11.12.05.41.14 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Nov 2014 05:41:14 -0800 (PST)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id A7F64562B81; Wed, 12 Nov 2014 13:41:13 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 12 Nov 2014 13:41:12 +0000
Message-Id: <cover.1415799384.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 00/14] toaster patchset for build functionality
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
X-List-Received-Date: Wed, 12 Nov 2014 13:41:23 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hi,

This patchset contains user interface pages for all layers and all targets pages;
fixes for the project page and other pages; and fixes for the backend build functionality.

The patches have gone through multiple rounds of review and testing.

Can you please pull at your convenience ?


Cheers,
Alex

The following changes since commit 9f171ea755644ecd9d2b3d7ed13bf8ec09ec917a:

  data_smart.py: fix variable splitting at _remove mechanism (2014-11-08 11:01:36 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20141112-submission
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20141112-submission

Alexandru DAMIAN (10):
  toaster script: webport option and other improvements
  toasterui: performance improvements
  toaster: SQL query logging
  toaster: update Release model to pinpoint to specific Branch
  adding angular-animate plugin
  toastergui: Various fixes for projects, layers and targets page
  toaster: separate the load configuration file command
  toastergui: changes for the Project page, round 3 of reviews
  toaster: importing angular service
  toastergui: fix XSS injection points in projects page

Belen Barros (1):
  toastergui: Silly UI fixes

Michael Wood (3):
  toaster: Fix the table data so that it matches the column order
  toaster: Update filter count labels when Add/Remove layers
  toaster: Replace bootstrap js with the correct version

 bin/toaster                                        |    96 +-
 lib/bb/ui/buildinfohelper.py                       |   207 +-
 lib/bb/ui/toasterui.py                             |    10 +-
 lib/toaster/bldcontrol/bbcontroller.py             |    19 +
 lib/toaster/bldcontrol/localhostbecontroller.py    |    38 +-
 .../management/commands/checksettings.py           |   140 +-
 .../bldcontrol/management/commands/loadconf.py     |   157 +
 lib/toaster/bldcontrol/models.py                   |    35 +-
 lib/toaster/bldcontrol/sshbecontroller.py          |    46 +-
 lib/toaster/bldcontrol/tests.py                    |     2 +-
 ...lptext__chg_field_release_branch__add_index_.py |   359 +
 lib/toaster/orm/models.py                          |    65 +-
 lib/toaster/toastergui/static/css/default.css      |    33 +-
 .../toastergui/static/js/angular-animate.min.js    |    28 +
 .../toastergui/static/js/angular-route.min.js      |    14 +
 .../toastergui/static/js/angular-sanitize.min.js   |    15 +
 lib/toaster/toastergui/static/js/bootstrap.min.js  |    11 +-
 lib/toaster/toastergui/static/js/jquery-ui.js      | 15003 -------------------
 lib/toaster/toastergui/static/js/projectapp.js     |   207 +-
 lib/toaster/toastergui/templates/base.html         |     3 +-
 .../toastergui/templates/basetable_bottom.html     |    13 +-
 .../toastergui/templates/filtersnippet.html        |     4 +-
 lib/toaster/toastergui/templates/layers.html       |   137 +-
 lib/toaster/toastergui/templates/mrb_section.html  |    11 +-
 lib/toaster/toastergui/templates/project.html      |   135 +-
 lib/toaster/toastergui/templates/target.html       |    10 +-
 lib/toaster/toastergui/templates/targets.html      |   350 +-
 lib/toaster/toastergui/templatetags/projecttags.py |     6 +-
 lib/toaster/toastergui/views.py                    |   228 +-
 lib/toaster/toastermain/settings.py                |    21 +
 30 files changed, 1696 insertions(+), 15707 deletions(-)
 create mode 100644 lib/toaster/bldcontrol/management/commands/loadconf.py
 create mode 100644 lib/toaster/orm/migrations/0016_auto__add_field_release_helptext__chg_field_release_branch__add_index_.py
 create mode 100644 lib/toaster/toastergui/static/js/angular-animate.min.js
 create mode 100644 lib/toaster/toastergui/static/js/angular-route.min.js
 create mode 100644 lib/toaster/toastergui/static/js/angular-sanitize.min.js
 delete mode 100644 lib/toaster/toastergui/static/js/jquery-ui.js

-- 
1.9.1


