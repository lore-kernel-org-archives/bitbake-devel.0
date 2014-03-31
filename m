Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f178.google.com (mail-we0-f178.google.com
	[74.125.82.178])
	by mail.openembedded.org (Postfix) with ESMTP id AD02E6EDF9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 16:47:11 +0000 (UTC)
Received: by mail-we0-f178.google.com with SMTP id u56so4937111wes.23
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 31 Mar 2014 09:47:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=pImpYeVPYSANqTqHouWGsWR7A3Wthf68jBhrk2Cq4KQ=;
	b=EO/jFmkmO3Q6mqKcfRdlTnU4OmM0NqFlEJNo2rpgm7gXQGJMxtcyDQSpaEVr0ax7K5
	4Cy89FXdA/CGy+Gu/8KXQfwDCoVRpTnrd0Eru2i9BMV1FnIYGxTzeKOVWzKbgg4xwYuY
	78gJw8Q0zmxHNsBHdz12S1p6b0iFVyrai230BMoQn1gKrqKkttp+i3m/ws6bavjzO6AH
	+oCmfK0Cxe0+CCgDwfKtDt8YW/iA0/Mutn6rON6ePcUQKKpWM6YvxBR1iW0fF57RHGvG
	NusuDpuE+5aPbQrYcXCo9fKfz0HUujnlx9rgeZhyWzUK77nsx+4Wb6kmlfBwpWcMad8A
	OwrQ==
X-Gm-Message-State: ALoCoQmGCxQr6jHpNKAwKk4wnSZy/v/zupVxkcP/h4vVYf3YNA+QzW7akxrgBEMfFltZLvk3P6qp
X-Received: by 10.194.104.197 with SMTP id gg5mr15974175wjb.26.1396284432570; 
	Mon, 31 Mar 2014 09:47:12 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id f3sm27699924wiv.2.2014.03.31.09.47.10
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 31 Mar 2014 09:47:11 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 740335601AD; Mon, 31 Mar 2014 17:47:11 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 31 Mar 2014 17:47:10 +0100
Message-Id: <cover.1396284354.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Dave Lerner <dave.lerner@windriver.com>,
	David Reyna <David.Reyna@windriver.com>,
	Ravi Chintakunta <ravi.chintakunta@timesys.com>,
	Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 00/14] Toaster pull request
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
X-List-Received-Date: Mon, 31 Mar 2014 16:47:13 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This is a Toaster patchset pull request. These patches have been reviewed on the toaster
mailing list.

Can you please pull at your convenience ?

Thank you,
Alex

The following changes since commit f4ebc4de63d64e3b5f87e1d0f51507760c3d82d7:

  user-manual-execution.xml: Added how BB processes curly braces. (2014-03-30 10:19:41 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20140331-bb-submission
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20140331-bb-submission

Alexandru DAMIAN (2):
  toaster: update saving sstate task data
  toaster: fix timezone detection

Belen Barros Pena (7):
  toaster: Show "No builds found" in the builds table
  toaster: Remove trailing spaces from 'name'
  toaster: Small tweaks to the packages included interface
  toaster: Fix the fade out animation
  toaster: Increase animation duration
  toaster: Match search results form to no results form
  toaster: Update help text in format_vpackage_namehelp tag

Cristiana Voicu (1):
  toaster: use deploy_dir var to obtain the license.manifest path

Dave Lerner (1):
  toaster: unbuilt package dependency formats

David Reyna (2):
  toaster: disable configvar sorts for value and files
  toaster: secondary sort key as table's default order

Ravi Chintakunta (1):
  toaster: Display task description

 lib/bb/ui/buildinfohelper.py                       | 19 +++++-
 lib/toaster/orm/models.py                          |  7 ++
 lib/toaster/toastergui/static/css/default.css      |  3 +-
 .../toastergui/templates/basetable_top.html        |  2 +-
 lib/toaster/toastergui/templates/build.html        |  6 +-
 .../templates/package_built_dependencies.html      | 75 ++++++++++------------
 .../templates/package_included_tabs.html           |  2 +-
 lib/toaster/toastergui/templates/recipe.html       |  2 +-
 lib/toaster/toastergui/templates/target.html       |  8 +--
 lib/toaster/toastergui/templates/tasks.html        |  2 +-
 lib/toaster/toastergui/templatetags/projecttags.py |  2 +-
 lib/toaster/toastergui/views.py                    | 37 +++++------
 lib/toaster/toastermain/settings.py                | 20 +++++-
 13 files changed, 106 insertions(+), 79 deletions(-)

-- 
1.9.1


