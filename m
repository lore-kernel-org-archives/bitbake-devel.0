Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f174.google.com (mail-wi0-f174.google.com
	[209.85.212.174])
	by mail.openembedded.org (Postfix) with ESMTP id AB3FD723B3
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Mar 2015 08:58:29 +0000 (UTC)
Received: by wixw10 with SMTP id w10so28424294wix.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Mar 2015 01:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Dl79cyjXWbFXKxEc2exE64nm0ptIOWRwnAQOAsKz1kM=;
	b=AqI0xE4lAniyB68+ksYlB96GtBHBTOIGwybheYe4RCsB3GoYcRxmnUznNzhA0J92E5
	D9EYEz3y5mSEXHxY3t/u50NrK3uCiAUG2IOOAbg16lGOQqJTf3ue2x7O89DpPK10FOOS
	m56gOzIXtPykHV+VheJYdd6Kh0MlbBw4ir1n7yPuwSSD6M/E9eLuK4WJoVx886wP1plW
	tZDsXJs4noyptTHkzOSgDFeCVtTBUL/YBTt+5mBTZxBG6qTF8hQCzCNnvwFNmbZkq127
	uuZWtPtrW/TjRIQag2ubtHOMnLMgJnOxL3Sx9RPKO/nw4l23o9mUgI0zyMckFLF+vPul
	jAFg==
X-Gm-Message-State: ALoCoQlnFKqmm+Gytb1ypokLUCOJ3ZRxqXkgz803hBRsvdKZRKdzDUVq7lItMdxvjla/H2P7fL85
X-Received: by 10.180.240.172 with SMTP id wb12mr13490202wic.55.1427273910556; 
	Wed, 25 Mar 2015 01:58:30 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id l6sm2622662wjx.33.2015.03.25.01.58.28
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 25 Mar 2015 01:58:28 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 6824D561555; Tue, 24 Mar 2015 18:59:57 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 24 Mar 2015 18:59:55 +0000
Message-Id: <cover.1427223502.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Belen Barros Pena <belen.barros.pena@linux.intel.com>,
	Dave Lerner <dave.lerner@windriver.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 00/18] Toaster bugfixing patchset
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
X-List-Received-Date: Wed, 25 Mar 2015 08:58:31 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This is a toaster bugfixing patchset - the patches have been reviewed and tested on
the mailing list. 

Can you please pull before the 1.8 merge window closes ?

Thank you,
Alex


The following changes since commit fc0cec1f38aa6f2d09434cc008a429d350a5706f:

  toaster: insure IMAGE_INSTALL_append values have a space prefix (2015-03-21 00:00:02 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150324-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150324-submission-bb

Alexandru DAMIAN (2):
  uievent: catch and log exceptions in receiving events
  toasterui: enable sanity checker

Belen Barros Pena (8):
  toastergui: give button nice rounded corners
  toastergui: changes to the all projects table
  toastergui: changes to release change notifications
  toasterui: update links to Toaster manual
  toasterui: hide release when only one exists
  toasterui: Improve messaging for empty layer details
  toasterui: hide right column if empty
  toasterui: small changes to empty states

Dave Lerner (3):
  toaster: layer-relative paths for config files
  toaster: alert fixes for project release change
  toaster: most-build-targets bug fixes

David Reyna (4):
  toaster: machine not searchable in all builds/projects
  toaster: build date range selections static sources
  toaster: build date range selections
  toaster: PACKAGE_CLASSES variable does not show current value when
    editing

Michael Wood (1):
  toaster: Project page fix targets url and tooltip placement

 lib/bb/ui/toasterui.py                             |   2 +-
 lib/bb/ui/uievent.py                               |   7 +-
 lib/toaster/bldcontrol/models.py                   |   2 +-
 lib/toaster/toastergui/static/css/default.css      |  12 +-
 .../ui-bg_diagonals-thick_18_b81900_40x40.png      | Bin 0 -> 418 bytes
 .../ui-bg_diagonals-thick_20_666666_40x40.png      | Bin 0 -> 312 bytes
 .../css/images/ui-bg_flat_10_000000_40x100.png     | Bin 0 -> 205 bytes
 .../css/images/ui-bg_glass_100_f6f6f6_1x400.png    | Bin 0 -> 262 bytes
 .../css/images/ui-bg_glass_100_fdf5ce_1x400.png    | Bin 0 -> 348 bytes
 .../css/images/ui-bg_glass_65_ffffff_1x400.png     | Bin 0 -> 207 bytes
 .../images/ui-bg_gloss-wave_35_f6a828_500x100.png  | Bin 0 -> 5815 bytes
 .../ui-bg_highlight-soft_100_eeeeee_1x100.png      | Bin 0 -> 278 bytes
 .../ui-bg_highlight-soft_75_ffe45c_1x100.png       | Bin 0 -> 328 bytes
 .../static/css/images/ui-icons_222222_256x240.png  | Bin 0 -> 6922 bytes
 .../static/css/images/ui-icons_228ef1_256x240.png  | Bin 0 -> 4549 bytes
 .../static/css/images/ui-icons_ef8c08_256x240.png  | Bin 0 -> 4549 bytes
 .../static/css/images/ui-icons_ffd27a_256x240.png  | Bin 0 -> 4549 bytes
 .../static/css/images/ui-icons_ffffff_256x240.png  | Bin 0 -> 6299 bytes
 .../toastergui/static/css/jquery-ui.min.css        |   7 +
 .../static/css/jquery-ui.structure.min.css         |   5 +
 .../toastergui/static/css/jquery-ui.theme.min.css  |   5 +
 lib/toaster/toastergui/static/js/filtersnippet.js  |  95 ++++++++++++
 lib/toaster/toastergui/static/js/jquery-ui.min.js  |   7 +
 lib/toaster/toastergui/static/js/layerdetails.js   |   5 +
 lib/toaster/toastergui/static/js/projectapp.js     |  38 ++++-
 lib/toaster/toastergui/templates/base.html         |   2 +-
 lib/toaster/toastergui/templates/build.html        |  17 +++
 lib/toaster/toastergui/templates/configvars.html   |   4 +-
 .../toastergui/templates/filtersnippet.html        |  34 +++--
 lib/toaster/toastergui/templates/landing.html      | 100 ++++++-------
 .../toastergui/templates/landing_not_managed.html  |  12 +-
 lib/toaster/toastergui/templates/layerdetails.html |   6 +-
 lib/toaster/toastergui/templates/layers.html       |  16 +-
 lib/toaster/toastergui/templates/machines.html     |   6 +-
 .../toastergui/templates/managed_builds.html       |  19 ++-
 lib/toaster/toastergui/templates/project.html      |  44 +++---
 lib/toaster/toastergui/templates/projectconf.html  |  42 ++++--
 lib/toaster/toastergui/templates/projects.html     |   3 +-
 lib/toaster/toastergui/templates/targets.html      |  14 +-
 lib/toaster/toastergui/templatetags/projecttags.py |  19 +++
 lib/toaster/toastergui/views.py                    | 166 +++++++++++++++++----
 41 files changed, 521 insertions(+), 168 deletions(-)
 create mode 100755 lib/toaster/toastergui/static/css/images/ui-bg_diagonals-thick_18_b81900_40x40.png
 create mode 100755 lib/toaster/toastergui/static/css/images/ui-bg_diagonals-thick_20_666666_40x40.png
 create mode 100755 lib/toaster/toastergui/static/css/images/ui-bg_flat_10_000000_40x100.png
 create mode 100755 lib/toaster/toastergui/static/css/images/ui-bg_glass_100_f6f6f6_1x400.png
 create mode 100755 lib/toaster/toastergui/static/css/images/ui-bg_glass_100_fdf5ce_1x400.png
 create mode 100755 lib/toaster/toastergui/static/css/images/ui-bg_glass_65_ffffff_1x400.png
 create mode 100644 lib/toaster/toastergui/static/css/images/ui-bg_gloss-wave_35_f6a828_500x100.png
 create mode 100755 lib/toaster/toastergui/static/css/images/ui-bg_highlight-soft_100_eeeeee_1x100.png
 create mode 100755 lib/toaster/toastergui/static/css/images/ui-bg_highlight-soft_75_ffe45c_1x100.png
 create mode 100644 lib/toaster/toastergui/static/css/images/ui-icons_222222_256x240.png
 create mode 100644 lib/toaster/toastergui/static/css/images/ui-icons_228ef1_256x240.png
 create mode 100644 lib/toaster/toastergui/static/css/images/ui-icons_ef8c08_256x240.png
 create mode 100644 lib/toaster/toastergui/static/css/images/ui-icons_ffd27a_256x240.png
 create mode 100644 lib/toaster/toastergui/static/css/images/ui-icons_ffffff_256x240.png
 create mode 100755 lib/toaster/toastergui/static/css/jquery-ui.min.css
 create mode 100755 lib/toaster/toastergui/static/css/jquery-ui.structure.min.css
 create mode 100755 lib/toaster/toastergui/static/css/jquery-ui.theme.min.css
 create mode 100755 lib/toaster/toastergui/static/js/filtersnippet.js
 create mode 100755 lib/toaster/toastergui/static/js/jquery-ui.min.js

-- 
1.9.1


