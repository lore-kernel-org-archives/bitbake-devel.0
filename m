Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f182.google.com (mail-wi0-f182.google.com
	[209.85.212.182])
	by mail.openembedded.org (Postfix) with ESMTP id 370CE617B8
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  4 Jul 2014 12:44:25 +0000 (UTC)
Received: by mail-wi0-f182.google.com with SMTP id bs8so3755716wib.15
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 04 Jul 2014 05:44:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=6NCZVnQ+WzyQGDntlIKGyw/jiXwd1qDYl2FBvIlU5tQ=;
	b=RFeTsMGkrmNeRsI456HKG3Pzaar2wDWM1u1f6yuhhqm3oIpHNyRtjUlvc2nFfxFgdM
	M/pEUeQbfo4Ts0FmucPfqdOPfn6CBswPjk8AwTBHF61cua0o+jdr6EyYUzBQkTZ7ya5+
	WCRGo9xmgT5x1jbvuQPQKIsP7HwI5wdh0HobYdMCdW1lyqkUPat7DxoYmMaI3e/6i3Hi
	DfMgK2uQA4KRu5AXsRrQckex/lJKH0dUITo60mYl2iDDMPeRneV66fW60MaVr3aHYF2i
	7e0tlCFl1pG97ywrLqoqMsBXWa8+4yEdxqABwRdGMkKmkN9PZyZMM0eAEmdu/jmlnLM3
	DgfA==
X-Gm-Message-State: ALoCoQndmf+Oz1jWNYH1lXtSRIw9aR3xMZgnEWGEoM2In8Z3+qLf5e4wYF551oMIUjobBFiwo/uP
X-Received: by 10.194.121.6 with SMTP id lg6mr3250291wjb.116.1404477864400;
	Fri, 04 Jul 2014 05:44:24 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	nf11sm45052563wic.9.2014.07.04.05.44.23 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 04 Jul 2014 05:44:23 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 23D5B560609; Fri,  4 Jul 2014 13:44:23 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  4 Jul 2014 13:44:21 +0100
Message-Id: <cover.1404477729.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Dave Lerner <dave.lerner@windriver.com>,
	Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 0/9] toaster pull request
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
X-List-Received-Date: Fri, 04 Jul 2014 12:44:29 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

Can you please merge these changes into the master tree ?

This patchset consists of some bug fixes and new feature related to 
the project building functionality. The patchset has been reviewed
on the toaster mailing list.

Thank you,
Alex

The following changes since commit 56c294dc30b6c2575b1cf904e26b8b8bef7677c2:

  fetch2/svn: Add transportuser parameter (2014-07-03 14:09:17 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20140704-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20140704-submission-bb

Alexandru DAMIAN (8):
  toaster: remove strftime calls in filters
  toaster: automatically discover urls.py files
  toaster: automatically enable applications
  toaster: add project pages
  toaster: add automated login in new project page
  toaster: whitespace fix
  toaster: new project page implementation
  toasterui: fix build - project identification

Dave Lerner (1):
  toasterui: Show in the log that ToasterUi is ready to receive events.

 bin/toaster                                        |   1 +
 lib/bb/ui/buildinfohelper.py                       |  17 +-
 lib/bb/ui/toasterui.py                             |  11 +-
 ...anch__add_field_project_short_description__a.py | 257 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |   7 +
 lib/toaster/toastergui/templates/base.html         |  13 ++
 lib/toaster/toastergui/templates/newproject.html   |  43 ++++
 lib/toaster/toastergui/templates/project.html      |   6 +
 lib/toaster/toastergui/templatetags/projecttags.py |  18 +-
 lib/toaster/toastergui/urls.py                     |   5 +
 lib/toaster/toastergui/views.py                    | 106 +++++++--
 lib/toaster/toastermain/settings.py                |  28 ++-
 lib/toaster/toastermain/urls.py                    |  16 +-
 13 files changed, 491 insertions(+), 37 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0010_auto__add_field_project_branch__add_field_project_short_description__a.py
 create mode 100644 lib/toaster/toastergui/templates/newproject.html
 create mode 100644 lib/toaster/toastergui/templates/project.html

-- 
1.9.1


