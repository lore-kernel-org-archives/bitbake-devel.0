Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
	[209.85.212.177])
	by mail.openembedded.org (Postfix) with ESMTP id 69C8B6EEFA
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 17:58:56 +0000 (UTC)
Received: by mail-wi0-f177.google.com with SMTP id cc10so2957402wib.10
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 14 Mar 2014 10:58:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=dv+DbT/X5Rht1F7FN1E7LPibWpVmB4RHQLWuzvdVyHM=;
	b=g2B+WllXYKU/IIgIxjFaUIl+e8UzOviJuECBIenFZ4uqLVX4c4UJJOffwS5bOZ97ON
	jMP6IRrfTFTocYnE8O5PN6BGsvHUGPHWQbt4DmRahJxahUEUZiin/gS/Tq0kAGGD4Kwb
	ilQIozJJZ5DjDKBiRx7+GNSx9yMeXG8JWDn+2Mk7qZzAVvJLXpreSLrI0L7oRdW2LTw/
	eamZVwKK22Yt7XGPdjuCVGCSqRD56t/At7nPxOHaEzZ98SDsHPSLg/mAq2nVufWw1vG5
	3oBofBZGNJEQDoMJe1aV3erceZH+uSU4Ph5DywYXuTjhtyyErVR/eAVTb1j1QbC8i1gd
	l7jQ==
X-Gm-Message-State: ALoCoQkNY/bUU835F+qYO8qu+wZM59S3xSSXvX/RPUjPp2tggHuqYLWmoKfnVkLg5rSaweH0hlmZ
X-Received: by 10.194.192.233 with SMTP id hj9mr2663649wjc.78.1394819937391;
	Fri, 14 Mar 2014 10:58:57 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id z1sm15535290wjq.19.2014.03.14.10.58.55
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Fri, 14 Mar 2014 10:58:56 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 39F345605D0; Fri, 14 Mar 2014 17:58:55 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 14 Mar 2014 17:58:53 +0000
Message-Id: <cover.1394819783.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
Cc: Farrell Wymore <farrell.wymore@windriver.com>,
	Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 00/19] toaster patchset
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
X-List-Received-Date: Fri, 14 Mar 2014 17:58:57 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This is a toaster interface and data collection patchset.

Can you please pull ?

Thanks,
Alex

The following changes since commit 81413d94f40f58d790d7a7dc4259108f9c5d4fc0:

  bitbake: cooker: some IMAGE_FEATURES not recognized (2014-03-14 07:25:35 -0700)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/submission-14032014
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=submission-14032014

Alexandru DAMIAN (2):
  toaster: fix target file inode type information
  toaster: improve recipe matching for native tasks

Belen Barros Pena (16):
  toaster: Move <tbody> outside for statement
  toaster: Make Order column part of the minimum table
  toaster: Format package size in recipe.html
  toaster: Replace hyphens with underscores in package name
  toaster: Small tweaks to the no results page
  toaster: Amend help text in package_built_detail.html
  toaster: Fixing "Show all builds" link
  toaster: Add no search results page
  toaster: Give an extra space to the caret
  toaster: Shorten dependency labels
  toaster: Presentation fixes for task.html
  bitbake:toaster: Not using task_color tag for execution heading
  toaster: Fix Recipe sorting in tasks table
  toaster: Don't show clear search button if text input field is empty
  toaster: Remove the data-toggle attribute
  toaster: Sort layers in alphabetical order

Farrell Wymore (1):
  toaster: added file types to the Outputs column in the build page

 lib/bb/ui/buildinfohelper.py                       | 26 ++++----
 lib/toaster/toastergui/static/css/default.css      |  4 +-
 .../toastergui/templates/basetable_top.html        |  2 +-
 lib/toaster/toastergui/templates/bpackage.html     | 13 ++++
 lib/toaster/toastergui/templates/build.html        | 18 +++---
 .../toastergui/templates/configuration.html        |  2 +-
 lib/toaster/toastergui/templates/configvars.html   | 16 ++++-
 .../templates/package_built_dependencies.html      | 70 +++++++++++-----------
 .../toastergui/templates/package_built_detail.html | 14 ++---
 .../toastergui/templates/package_detail_base.html  |  4 +-
 .../templates/package_included_dependencies.html   | 23 ++++---
 .../templates/package_included_detail.html         | 12 ++--
 .../package_included_reverse_dependencies.html     | 12 ++--
 lib/toaster/toastergui/templates/recipe.html       |  2 +-
 lib/toaster/toastergui/templates/recipes.html      | 14 +++++
 lib/toaster/toastergui/templates/task.html         | 49 ++++++++-------
 lib/toaster/toastergui/templates/tasks.html        | 15 +++++
 lib/toaster/toastergui/templatetags/projecttags.py | 27 +++++++++
 lib/toaster/toastergui/views.py                    |  6 +-
 19 files changed, 213 insertions(+), 116 deletions(-)

-- 
1.8.3.2


