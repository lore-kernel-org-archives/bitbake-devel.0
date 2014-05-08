Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f173.google.com (unknown [74.125.82.173])
	by mail.openembedded.org (Postfix) with ESMTP id 7786B65F65
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  8 May 2014 13:30:39 +0000 (UTC)
Received: by mail-we0-f173.google.com with SMTP id u57so2502811wes.18
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 08 May 2014 06:30:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=sLWW0gIOoKGpT6CLZlglfxARZUiiQs754EFXdBP1pDs=;
	b=kTLFf0cyjMlYHjqVRzxgVA7rVtIG0cVZMgaT3Hx+Dg2WexKMQfs8tp18jXueogyPPK
	5ytyCRQRpKCHbgH3dntOa7mNGRNOdxSK5ZFwSPShK34RORyi2gC1lm/H78I5n8pk+V8H
	4JiZbkY/ryNe8kKjw42nn6RnnsNPJla07rtrSfAdY93p2DlWELSdhU4CHeFr/9AhtUWr
	UV+AVWEPIaqab1WXl654tlXAFgY//9usOdLSvBzFnMU8gian2DekoYc/70cajL+J+gHR
	8EMOftsem2BpjAdfdDJCjYvxDE4rF77jSfR/Q+7Ar9mcdnTIrqbW/evJEV4knPGFYhJe
	nPyQ==
X-Gm-Message-State: ALoCoQnCGZnqWYgcGbYAN1zsWo40DNHcczlXwNf6Gok3oDEdzXOeZ4K46D6M6xpnYSEIlUJEUxIR
X-Received: by 10.180.77.225 with SMTP id v1mr12885108wiw.5.1399555472937;
	Thu, 08 May 2014 06:24:32 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id
	lj15sm4195104wic.13.2014.05.08.06.24.31 for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 08 May 2014 06:24:31 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 256F65603A0; Thu,  8 May 2014 21:24:31 +0800 (HKT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  8 May 2014 14:24:29 +0100
Message-Id: <cover.1399555312.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Dave Lerner <dave.lerner@windriver.com>,
	Alexandru DAMIAN <alexandru.damian@intel.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 0/5] toaster changeset pull request
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
X-List-Received-Date: Thu, 08 May 2014 13:30:40 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

Can you please pull this changeset for Toaster ?

All patches have been reviewed on the toaster mailinglist.

Thank you,
Alex 

The following changes since commit 13beb6c9f92c0b3d56fc9aa06eb2259fb8390949:

  setup.py: fix documentation build (2014-05-07 10:30:26 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20140508-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20140508-submission-bb

Alexandru DAMIAN (2):
  toaster: fix migration code for MySQL
  toaster: modify SQL data type constraints

Belen Barros Pena (1):
  toaster: Make sure layer branch only shows when not empty

Dave Lerner (1):
  toaster: fix span2 headings for packages

David Reyna (1):
  toaster: sort outcome and sstate columns by string value

 .../0004_auto__add_field_package_installed_name.py |   1 +
 ...e__add_target_file__add_field_variablehistor.py |  56 ++---
 ...story_operation__chg_field_recipe_descriptio.py | 225 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |  20 +-
 lib/toaster/toastergui/templates/dirinfo.html      |   4 +-
 .../templates/package_built_dependencies.html      |   4 +-
 .../toastergui/templates/package_built_detail.html |   4 +-
 .../toastergui/templates/package_detail_base.html  |  21 +-
 .../templates/package_included_tabs.html           |   4 +-
 lib/toaster/toastergui/templates/recipe.html       |  22 +-
 lib/toaster/toastergui/templates/target.html       |   6 +-
 lib/toaster/toastergui/templates/task.html         |   2 +-
 lib/toaster/toastergui/templates/tasks.html        |   2 +-
 lib/toaster/toastergui/views.py                    |  18 +-
 14 files changed, 310 insertions(+), 79 deletions(-)
 create mode 100644 lib/toaster/orm/migrations/0008_auto__chg_field_variablehistory_operation__chg_field_recipe_descriptio.py

-- 
1.9.1


