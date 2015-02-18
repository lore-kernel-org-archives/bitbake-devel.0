Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f42.google.com (mail-wg0-f42.google.com [74.125.82.42])
	by mail.openembedded.org (Postfix) with ESMTP id 613DE6B0CB
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 19:10:59 +0000 (UTC)
Received: by mail-wg0-f42.google.com with SMTP id n12so3096003wgh.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Feb 2015 11:11:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=TvK0g+NWrsKRChqL6NAgizETSI30NzRu4eqPlPHF72o=;
	b=mDJZ+LuQrkKDmTCFCF0YgkO6YQxK4eDE1twwuHVez6UWne5m2/QzpovlaVEEW1uFmG
	eEozEIoZ9UAvDOix42YPpDMasFbV8i7h/sUa/lSDVt0JZsLTLC/edec47RO5orml31Q+
	fXZqfhrjXi7azzm1RYyzl2uORq9Tq8uCqugChcnlyovA8aGkPqpeJMIaOv7do0L9Qw/Q
	ymvqqqaArB/R4kTHYVe1y/We9KTS2QQhzZpWNVkNDYdBTVXUmXa1DHhpH7dYlwonT899
	QIZGkghnLcGwZkT89dSW6mT583oQnVhHtBNjMCHuk0VGsp7vwDC8kxekF3vQYKPFJCfU
	GFMA==
X-Gm-Message-State: ALoCoQk5kJ2HvlznwYrJOvNa+D0XhYVdZzETqUZdVJ9CwqsC74qkGfeDDpfCMkf68GFflm9shW+i
X-Received: by 10.195.11.72 with SMTP id eg8mr1725655wjd.48.1424286660588;
	Wed, 18 Feb 2015 11:11:00 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id ul1sm33965569wjc.0.2015.02.18.11.10.59
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 18 Feb 2015 11:10:59 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id A0F72560444; Wed, 18 Feb 2015 19:11:01 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 18 Feb 2015 19:11:00 +0000
Message-Id: <cover.1424286571.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 00/10] Toaster patchset
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
X-List-Received-Date: Wed, 18 Feb 2015 19:11:04 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This is a toaster patchset with bug fixes and new features. The patches
have been reviewed on the toaster mailing list. 

Can you please pull ?

Cheers,
Alex

The following changes since commit 7cfe279bf77b59d5cbd20d8a93e1d33279bebc20:

  toasterui: empty state for pages (2015-02-16 17:48:30 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150218-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150218-submission-bb

Alexandru DAMIAN (4):
  toaster: bitbake cooker log saving and downloading
  toaster: properly detect starting in rolling log file
  toasterui: UI query performance improvements
  toaster: get proper version string

Alexandru Damian (1):
  toasterui: fix time estimation in project page

Belen Barros Pena (2):
  toasterui: style the Toaster version information
  toasterui: remove layer directory in managed mode

David Reyna (1):
  toaster: landing page when no build module

Michael Wood (2):
  toaster: layerdetails Don't show None type in description/summary
  toaster: importlayer Remove description input field

 lib/bb/ui/buildinfohelper.py                       |   3 +-
 lib/bb/ui/toasterui.py                             |  29 +++-
 lib/toaster/bldcontrol/localhostbecontroller.py    |  12 +-
 .../management/commands/checksettings.py           |  17 +++
 .../bldcontrol/management/commands/runbuilds.py    |  29 +++-
 .../bldcontrol/migrations/0008_brarchive.py        | 138 +++++++++++++++++
 lib/toaster/bldcontrol/models.py                   |   2 +
 lib/toaster/orm/models.py                          |  13 +-
 lib/toaster/toastergui/static/css/default.css      |  22 +--
 lib/toaster/toastergui/static/js/importlayer.js    |   1 -
 lib/toaster/toastergui/static/js/projectapp.js     |  24 ++-
 lib/toaster/toastergui/templates/base.html         |  13 +-
 lib/toaster/toastergui/templates/bpackage.html     |   4 +-
 lib/toaster/toastergui/templates/build.html        |   9 +-
 .../toastergui/templates/builddashboard.html       |  11 +-
 lib/toaster/toastergui/templates/importlayer.html  |   6 -
 .../toastergui/templates/landing_not_managed.html  |  32 ++++
 lib/toaster/toastergui/templates/layerdetails.html |   4 +-
 .../toastergui/templates/managed_builds.html       |   9 +-
 .../toastergui/templates/managed_mrb_section.html  |   3 +-
 lib/toaster/toastergui/templates/project.html      |   2 +-
 .../toastergui/templates/projectbuilds.html        |  14 +-
 .../toastergui/templates/unavailable_artifact.html |  17 +++
 lib/toaster/toastergui/views.py                    | 168 ++++++++++++++-------
 lib/toaster/toastermain/settings.py                |   3 +-
 lib/toaster/toastermain/urls.py                    |   6 +-
 26 files changed, 465 insertions(+), 126 deletions(-)
 create mode 100644 lib/toaster/bldcontrol/migrations/0008_brarchive.py
 create mode 100644 lib/toaster/toastergui/templates/landing_not_managed.html
 create mode 100644 lib/toaster/toastergui/templates/unavailable_artifact.html

-- 
1.9.1


