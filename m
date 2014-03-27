Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f52.google.com (mail-wg0-f52.google.com [74.125.82.52])
	by mail.openembedded.org (Postfix) with ESMTP id D44A46B7B7
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 16:49:57 +0000 (UTC)
Received: by mail-wg0-f52.google.com with SMTP id k14so2699910wgh.35
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 27 Mar 2014 09:49:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=/ILUpND7z5Wvg1HJ+K9uBNgw48JUGAwlBmHL4wzAjIE=;
	b=a8yqvEFP7BGCIsRm5JAm8zwvNpoLWaKCabMww1W3nLxBNC5wi1CqmVyC+tKoMK6wT4
	L6TyCfI+FLWrSX1GwzpqSntymcUery3gcHaGjlDtF+cwPQf1QOQN7sNiq4JHFpI3eX+u
	7Yxz2GYBhUzRu01rPf7mAi+StagvP39LrRyRI5Asr9HIvBP0YirtrJLA+9Fe6F/zL2A7
	II817+F5vXTv+y+L1UoWRuZ6O7OqgWjz8lDx6fjlODTbWmvl+8uWbkgSL7Wc5sR6C5qT
	K8GW6T2Iqc1xo0vjamd+4XxRqeTE5tuTgd1QWYgDtHGgmAWV14zOQYGs7rP4M9KZRjjO
	brUQ==
X-Gm-Message-State: ALoCoQnT8D9L8GAZ0qLb/XX3m/ipOZFoHUQYtV1/dpPS34hkSs67fjZ0QUbI4Bv665YfHH6GCtV5
X-Received: by 10.180.19.138 with SMTP id f10mr6338350wie.11.1395938997987;
	Thu, 27 Mar 2014 09:49:57 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id fb6sm13912250wib.2.2014.03.27.09.49.56
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 27 Mar 2014 09:49:57 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id B40185608AD; Thu, 27 Mar 2014 16:49:56 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 27 Mar 2014 16:49:55 +0000
Message-Id: <cover.1395938903.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
Cc: Farrell Wymore <farrell.wymore@windriver.com>,
	Dave Lerner <dave.lerner@windriver.com>,
	Alexandru DAMIAN <alexandru.damian@intel.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 0/9] toaster patchset upstream submission
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
X-List-Received-Date: Thu, 27 Mar 2014 16:50:00 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This is a pull request for Toaster UI patches. The patches have been 
reviewed on the toaster mail list.

Can you please merge ?

Thank you,
Alex

The following changes since commit 0664fa15597785dd90cf205531a9801e6da6ba47:

  knotty: Show a link to the logfile for failed setscene tasks (2014-03-27 10:41:36 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20140326-bb-submission
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20140326-bb-submission

Belen Barros Pena (1):
  toaster: Fix typo in heading code

Dave Lerner (2):
  toaster: show installed package name
  toaster: fix dirinfo empty dir expansion

David Reyna (6):
  toaster: add Image detail and multiple targets to dashboard
  toaster: blocks for custom/highlighted navigation and breadcrumb links
  toaster: insure _get_query returns distinct records
  toaster: add support for empty states in pages
  toaster: added file types to the Outputs column in the build
  toaster: filter tasks with cache attempts for all attempts

 lib/toaster/orm/models.py                          |   5 +
 lib/toaster/toastergui/static/css/default.css      |   4 +-
 lib/toaster/toastergui/static/img/toaster.png      | Bin 0 -> 51986 bytes
 .../toastergui/templates/basebuildpage.html        |  51 ++++++--
 lib/toaster/toastergui/templates/bpackage.html     |  40 ++++--
 lib/toaster/toastergui/templates/build.html        |  56 ++++++--
 .../toastergui/templates/builddashboard.html       |  89 ++++++++++---
 .../toastergui/templates/configuration.html        |   6 +-
 lib/toaster/toastergui/templates/configvars.html   |  12 +-
 .../templates/package_built_dependencies.html      |  10 +-
 .../toastergui/templates/package_built_detail.html |   8 +-
 .../toastergui/templates/package_detail_base.html  |  36 ++++--
 .../templates/package_included_dependencies.html   |  31 +++--
 .../templates/package_included_detail.html         |  14 +-
 .../package_included_reverse_dependencies.html     |  17 ++-
 lib/toaster/toastergui/templates/recipes.html      |   4 +
 lib/toaster/toastergui/templates/target.html       |  10 ++
 lib/toaster/toastergui/templates/tasks.html        |  64 ++++++++--
 lib/toaster/toastergui/templatetags/projecttags.py |  19 +--
 lib/toaster/toastergui/views.py                    | 142 +++++++++++++++++----
 20 files changed, 474 insertions(+), 144 deletions(-)
 create mode 100755 lib/toaster/toastergui/static/img/toaster.png

-- 
1.8.3.2


