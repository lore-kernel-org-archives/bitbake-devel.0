Return-Path: <alexandru.damian@intel.com>
Received: from mail-pa0-f47.google.com (mail-pa0-f47.google.com
	[209.85.220.47])
	by mail.openembedded.org (Postfix) with ESMTP id A7B9965C78
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 16:50:59 +0000 (UTC)
Received: by mail-pa0-f47.google.com with SMTP id kq14so2905607pab.20
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 20 Nov 2014 08:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=BkZfdaBxT0FMSW5wMvlpoSGhkzWDpup70W/UbHI9mwE=;
	b=LtjkE+FnjHtnn/uiXXG1ucpSzZkEGVCfUUzfboGF1V4ttYHwCYGUZ1fXNKgkMtPQPF
	iXhhNgpaO6nc+huFtlujS8QmgG2RR8leiSpJXwHDfQdfExymkdb6OT9uas5hMsCijoC/
	sM8SO4jkDYoqG95NUC7P/u4CD3rTkvjPrtOIbhAgC/4ErdUFukIjvzzJL/XFzRzNXnFs
	HT8K0Pj/XezcyBRCfGVwl058ICW1FsvhbfvU309bH4oFzgNU3G/lWORL1TWkzIoLrIDZ
	Gtsf2KH2s/6hgXrfw41GONRq8xJJuU2y8RvlGErRqLhHd23GfCmaEgxSZWYkJMuNoIS6
	ZwGg==
X-Gm-Message-State: ALoCoQnx2+LuKdw14rXDN5J5DR6ujLoBB0I/DUc4jN4PXa5ucsDEqdOBN/iFNbcMyjv/i0yYhkUj
X-Received: by 10.68.217.197 with SMTP id pa5mr44178654pbc.32.1416502259950;
	Thu, 20 Nov 2014 08:50:59 -0800 (PST)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id dk1sm2519365pdb.48.2014.11.20.08.50.58
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 20 Nov 2014 08:50:59 -0800 (PST)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 06204563E83; Thu, 20 Nov 2014 16:27:24 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu, 20 Nov 2014 16:27:22 +0000
Message-Id: <cover.1416500715.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>,
	Belen Barros Pena <belen.barros.pena@linux.intel.com>
Subject: [PATCH 00/11] please pull Toaster patchset
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
X-List-Received-Date: Thu, 20 Nov 2014 16:51:08 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hi,

This is a Toaster patchset which brings in the New Build Button feature,
and a number of fixes for both the frontend and the backend, including compatibility
with the upstreamed versions of the toasterconf.json files.

Can you please pull at your convenience ?

Cheers,
Alex


The following changes since commit 40d2ae0723de2bf5fee343faafb4afda40546839:

  bitbake-worker: exit normally when SIGHUP (2014-11-20 14:15:28 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20141120-submission
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20141120-submission

Alexandru DAMIAN (1):
  toastergui: layer name correlation

Belen Barros Pena (5):
  toaster: fix file name collision
  toaster: Tiny refinements to the new build button dialog
  toaster: add no results state to all layers page
  toaster: fix dependencies dialog layout
  toaster: do not show target if target name is empty

Michael Wood (5):
  toaster: skip virtualenv when searching for django apps
  toaster: Create libtoaster.js with some utility functions
  toaster: libtoaster: Add getProjectInfo utility function
  toaster: Add New Build Button feature
  toaster: project page remove additional tooltip for Change pencil

 bin/toaster                                        |   4 +-
 .../management/commands/checksettings.py           |  47 ++-
 .../bldcontrol/management/commands/loadconf.py     |  29 +-
 ...faultlayer__add_releaselayersourcepriority__.py | 396 +++++++++++++++++++++
 lib/toaster/orm/models.py                          | 115 ++++--
 lib/toaster/orm/tests.py                           |  11 +-
 lib/toaster/toastergui/static/css/default.css      |   8 +
 lib/toaster/toastergui/static/js/base.js           | 125 +++++++
 lib/toaster/toastergui/static/js/libtoaster.js     | 259 ++++++++++++++
 lib/toaster/toastergui/static/js/main.js           | 111 ------
 lib/toaster/toastergui/static/js/projectapp.js     |   2 +
 lib/toaster/toastergui/templates/base.html         |  98 +++--
 lib/toaster/toastergui/templates/layers.html       |  22 +-
 lib/toaster/toastergui/templates/project.html      |  10 +-
 lib/toaster/toastergui/templates/targets.html      |   2 +
 lib/toaster/toastergui/urls.py                     |   4 +
 lib/toaster/toastergui/views.py                    | 117 ++++--
 lib/toaster/toastermain/settings.py                |   4 +
 lib/toaster/toastermain/urls.py                    |   4 +
 19 files changed, 1123 insertions(+), 245 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0017_auto__del_toastersettingdefaultlayer__add_releaselayersourcepriority__.py
 create mode 100644 lib/toaster/toastergui/static/js/base.js
 create mode 100644 lib/toaster/toastergui/static/js/libtoaster.js
 delete mode 100644 lib/toaster/toastergui/static/js/main.js

-- 
1.9.1


