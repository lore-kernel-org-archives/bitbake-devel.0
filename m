Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id C69C57061F
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jul 2014 12:14:58 +0000 (UTC)
Received: by mail-wi0-f182.google.com with SMTP id d1so740401wiv.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jul 2014 05:14:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=y8LD1rQET3u1WnrexQQgbVGIP41dhm//t2QnUHt02vw=;
	b=iZkqasJ7siz67UHPZfVYaFGfya7A/UJhNVk04erW48TU/9La8yUhexp9EkwwusG2+S
	O8Hg1sOXFQio9meuw+kwlaV7jsTinQoEdHYka/X1MAVVkYN8krrldmjlk9KQRSuldU1a
	LgKfjR7LxD6mofRV3wuWeibxoXNV9NBw31EllfoGFFo8XhEwswEV1FvcqBycGOXvaTev
	mXCx0dGMwWJ9r3syD1oRNEVa7J2uLVghb0tmMTHahAa6w19tQsrmrdoJ1JAPjAO8rldj
	wMxlVS8N1o4ZpSUtq7tfUFsaTpyP1kSa4NBwZSADgbHxcRvAJVidZEs7hCLHUPQuHQnb
	Onwg==
X-Gm-Message-State: ALoCoQnQH5fWfAIFAQYU7h7siiuabJCCVIicY1fc4Iz9K+F9RIqhesjUrkEnMmNuZFfV1iz/GgED
X-Received: by 10.194.243.200 with SMTP id xa8mr5997868wjc.97.1405685699201;
	Fri, 18 Jul 2014 05:14:59 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	au7sm13794623wjc.41.2014.07.18.05.14.57 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 18 Jul 2014 05:14:58 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id D15F5560262; Fri, 18 Jul 2014 13:14:58 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@yoctoproject.org
Date: Fri, 18 Jul 2014 13:14:57 +0100
Message-Id: <cover.1405685308.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 0/8] Toaster project main page and other bugfixes and enhancements
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
X-List-Received-Date: Fri, 18 Jul 2014 12:15:01 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>


Hello,

This patchset adds the main project edit page, where you can edit project settings, and
trigger builds. Currently, only the target add/delete setting is working.

There are two patches that add provisions for running Toaster inside a virtualenv environment,
and Django 1.6 compatibility support.

A fix for 6332 requested by WR is included.

This patchset HAS NOT BEEN REVIEWED independently on toaster mailing list, so this
submission is also CCed there for review. 

Can you please pull on your convenience ?

Thank you,
Alex

The following changes since commit af1d3373706d365f9138caec110fcb20a5966b7b:

  toasterui: fix build - project identification (2014-07-09 17:33:35 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/bitbake-fixes-build-enhancements
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/bitbake-fixes-build-enhancements

Alexandru DAMIAN (8):
  toaster: add fields for sourcedir and builddir paths
  toaster: added subdirectory entry for build layers
  toaster: move bldcontrol initial_data fixture to code
  toaster: add project main edit page
  toaster: properly set layers when running a build
  document requirements for the python environment
  toaster start script allows for Django 1.6
  toasterui: fixing event.data clash

 .gitignore                                         |   2 +
 bin/toaster                                        |  18 +-
 lib/bb/event.py                                    |   2 +-
 lib/bb/ui/buildinfohelper.py                       |  30 +-
 lib/toaster/bldcontrol/bbcontroller.py             | 137 ++++++--
 lib/toaster/bldcontrol/fixtures/initial_data.json  |   1 -
 .../management/commands/checksettings.py           |  38 +++
 .../bldcontrol/management/commands/runbuilds.py    |  23 +-
 ...onment_sourcedir__add_field_buildenvironment.py | 106 ++++++
 .../0003_auto__add_field_brlayer_dirpath.py        |  99 ++++++
 .../bldcontrol/migrations/0004_loadinitialdata.py  | 104 ++++++
 .../migrations/0005_auto__add_brerror.py           | 112 +++++++
 lib/toaster/bldcontrol/models.py                   |  12 +-
 .../0011_auto__add_field_projectlayer_dirpath.py   | 242 ++++++++++++++
 ...layer_optional__add_field_projecttarget_task.py | 252 +++++++++++++++
 lib/toaster/orm/models.py                          |  25 +-
 lib/toaster/toastergui/static/css/default.css      |  42 ++-
 lib/toaster/toastergui/templates/base.html         |   4 +
 lib/toaster/toastergui/templates/project.html      | 356 +++++++++++++++++++++
 lib/toaster/toastergui/urls.py                     |   3 +
 lib/toaster/toastergui/views.py                    | 105 +++++-
 requirements.txt                                   |   4 +
 22 files changed, 1632 insertions(+), 85 deletions(-)
 delete mode 100644 lib/toaster/bldcontrol/fixtures/initial_data.json
 create mode 100644 lib/toaster/bldcontrol/management/commands/checksettings.py
 create mode 100644 lib/toaster/bldcontrol/migrations/0002_auto__add_field_buildenvironment_sourcedir__add_field_buildenvironment.py
 create mode 100644 lib/toaster/bldcontrol/migrations/0003_auto__add_field_brlayer_dirpath.py
 create mode 100644 lib/toaster/bldcontrol/migrations/0004_loadinitialdata.py
 create mode 100644 lib/toaster/bldcontrol/migrations/0005_auto__add_brerror.py
 create mode 100644 lib/toaster/orm/migrations/0011_auto__add_field_projectlayer_dirpath.py
 create mode 100644 lib/toaster/orm/migrations/0012_auto__add_field_projectlayer_optional__add_field_projecttarget_task.py
 create mode 100644 requirements.txt

-- 
1.9.1


