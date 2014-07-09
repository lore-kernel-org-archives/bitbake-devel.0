Return-Path: <alexandru.damian@intel.com>
Received: from mail-wg0-f41.google.com (mail-wg0-f41.google.com [74.125.82.41])
	by mail.openembedded.org (Postfix) with ESMTP id BF7CE703FE
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Jul 2014 16:55:11 +0000 (UTC)
Received: by mail-wg0-f41.google.com with SMTP id k14so5098759wgh.12
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 09 Jul 2014 09:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=Gv3X3cVQDl4P3qwCkkWgp0sodxp7MzpaJ+HRJZCYOcQ=;
	b=HhTxR8kmy1o568UU5/rshTRXuQxGZqWRV2sFhDiOr+2bICM7qMLg19gkdgs/RPlAJi
	yv3NstOYcY/IgPAv+p2rfT7nqRwP8FJznG0PAMJm0fG4vYyInoCNLY5ZyoatY88c+FSs
	wArq8hGEhl/SlK+kx0T0PyPeV4dEfWjf72cIEKii626Dn6rSSAA2/5Fh/mf8kjQDwcna
	75iYP3N3C2MVvzRy3yCG+Q3DyLeLFNpIFPezDRrgn4yo5jDXlBAZikers+NyhpZv22g8
	E0g7lBXu7+He6p0wkN+B/W+E+M51NtPX3KI/GvaoEcWaodvztlCN8J1K3mRKhm1V+iMF
	wOEg==
X-Gm-Message-State: ALoCoQnTj7aPRM6biUYdf6PkiLrxNxEw5ujROXL/UzqVvc9FPqKTMx1gwvKLYMfsgw5T574qJ+Hq
X-Received: by 10.180.206.144 with SMTP id lo16mr12720243wic.52.1404924912197; 
	Wed, 09 Jul 2014 09:55:12 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	ei3sm18726442wib.13.2014.07.09.09.55.10 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 09 Jul 2014 09:55:11 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id B4698560126; Wed,  9 Jul 2014 17:55:09 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  9 Jul 2014 17:55:07 +0100
Message-Id: <cover.1404924713.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1404477729.git.alexandru.damian@intel.com>
References: <cover.1404477729.git.alexandru.damian@intel.com>
Cc: Dave Lerner <dave.lerner@windriver.com>,
	Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 0/9] [V2] toaster pull request
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
X-List-Received-Date: Wed, 09 Jul 2014 16:55:19 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

Can you please merge these changes into the master tree ?

This patchset consists of some bug fixes and new feature related to
the project building functionality. The patchset has been reviewed
on the toaster mailing list. This is version 2, with bug fixes.

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
 lib/toaster/orm/models.py                          |  38 +++
 lib/toaster/toastergui/templates/base.html         |  13 ++
 lib/toaster/toastergui/templates/newproject.html   |  43 ++++
 lib/toaster/toastergui/templates/project.html      |   6 +
 lib/toaster/toastergui/templatetags/projecttags.py |  18 +-
 lib/toaster/toastergui/urls.py                     |   5 +
 lib/toaster/toastergui/views.py                    | 115 +++++++--
 lib/toaster/toastermain/settings.py                |  28 ++-
 lib/toaster/toastermain/urls.py                    |  16 +-
 13 files changed, 531 insertions(+), 37 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0010_auto__add_field_project_branch__add_field_project_short_description__a.py
 create mode 100644 lib/toaster/toastergui/templates/newproject.html
 create mode 100644 lib/toaster/toastergui/templates/project.html

-- 
1.9.1


