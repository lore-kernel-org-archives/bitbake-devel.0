Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f180.google.com (mail-wi0-f180.google.com
	[209.85.212.180])
	by mail.openembedded.org (Postfix) with ESMTP id CFA1A60556
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 17:53:12 +0000 (UTC)
Received: by mail-wi0-f180.google.com with SMTP id h11so27903608wiw.1
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 16 Feb 2015 09:53:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=GWm8GEpruit2UL4riuc3WmG74OgbCD0CqCYV1ArxR9Y=;
	b=C89kSxfR8uQjJ0PgBtNcJCmwmAoGDP9trArhthhev1j5FJmFLiRDtfriVQNs0exoFI
	caEn/k5uzev5+0/9AUiXXS3c10/KrCQv2ltx+Zd4XVRsNMh2Ey577qHiO8YWDySWb6F1
	Dq3LTkzvlAWGJOewNCQ1FjoDcyRJQJpBRIY+FNt9j/xOFPF1zdP0tjub1zhaz05JXcMn
	3qdxMHYFtU67WESKsl1KzGE8Y3W8/XT0BDh7gUEp+BlAfW3cc4G+5xUhWdEiONkpElbl
	nE6wh5MqiPAuWkSWSly2hsoUYtqqfLxphYa5Ya4MngHKqbOjhp4cxM00U6a61dYS/7Xq
	BgHw==
X-Gm-Message-State: ALoCoQkkv57NKeMZLA8tIuzptonhgu7K18aaUfdyOhgMaz/adWcXCF4o+7pXOqcIt4oyim3DLilf
X-Received: by 10.180.74.141 with SMTP id t13mr48781484wiv.45.1424109193921;
	Mon, 16 Feb 2015 09:53:13 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id n1sm16654716wib.11.2015.02.16.09.53.12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 16 Feb 2015 09:53:12 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 5A2F55605A7; Mon, 16 Feb 2015 17:53:14 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 16 Feb 2015 17:53:13 +0000
Message-Id: <cover.1424108976.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 00/10] Toaster patchset pull request
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
X-List-Received-Date: Mon, 16 Feb 2015 17:53:17 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>


Hello,

This is a patchset for Toaster bringing in fixes and new features.

The patches have been reviewed and tested on the Toaster mailing list.

Can you please pull whenever you can ?

Cheers,
Alex

The following changes since commit 2e4a03db967ac1459b2764108fc54c4566a7e371:

  tests/fetch.py: latest_versionstring add set of PN (2015-02-16 09:12:41 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150216-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150216-submission-bb

Alexandru DAMIAN (3):
  toaster: properly detect failed server start
  toaster: fix git checkout command
  toasterui: empty state for pages

David Reyna (1):
  toaster: Additional fixes for the project variable page

Michael Wood (6):
  toaster: Use on input event for validation rather than keyup
  toaster: layerdetails use new vcs reference api
  toaster: New build button allow arbitrary build targets
  toaster: Remove Layer source from machines, layers and targets
  toaster: Remove filtering from layers,machines and targets
  toaster: Set the machines page default pagesize to 100

 lib/toaster/bldcontrol/localhostbecontroller.py    |   7 +-
 .../bldcontrol/management/commands/runbuilds.py    |  12 +-
 lib/toaster/orm/models.py                          |   8 +-
 lib/toaster/toastergui/static/img/toaster_1.7.png  | Bin 0 -> 125151 bytes
 lib/toaster/toastergui/static/js/base.js           |   6 +-
 lib/toaster/toastergui/static/js/importlayer.js    |   6 +-
 lib/toaster/toastergui/static/js/layerdetails.js   |   2 +-
 lib/toaster/toastergui/templates/landing.html      |  55 ++++-
 lib/toaster/toastergui/templates/layerdetails.html |  13 +-
 lib/toaster/toastergui/templates/layers.html       |   1 -
 lib/toaster/toastergui/templates/machines.html     |  30 ++-
 .../toastergui/templates/managed_builds.html       |   6 +
 .../toastergui/templates/managed_mrb_section.html  |   5 +-
 lib/toaster/toastergui/templates/newproject.html   |   2 +-
 lib/toaster/toastergui/templates/project.html      |  14 ++
 .../toastergui/templates/projectbuilds.html        |  13 +-
 lib/toaster/toastergui/templates/projectconf.html  | 258 +++++++++++++++------
 lib/toaster/toastergui/templates/targets.html      |  13 +-
 lib/toaster/toastergui/views.py                    | 163 ++++---------
 19 files changed, 381 insertions(+), 233 deletions(-)
 create mode 100644 lib/toaster/toastergui/static/img/toaster_1.7.png

-- 
1.9.1


