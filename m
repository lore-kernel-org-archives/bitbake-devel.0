Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
	[209.85.212.170])
	by mail.openembedded.org (Postfix) with ESMTP id C2F1865C9D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 14:39:01 +0000 (UTC)
Received: by wibdq8 with SMTP id dq8so49767547wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Jun 2015 07:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=nzEPBY2jJPmAIYqhkqsMaxH+vz8cO5H4QgpCoQDiX2E=;
	b=mAyx/yZEy9rP2Is6nnVvXufxnOxtNygNrxut6ZWRknKrPzTidKoCJfDUOw47vvkejH
	aG0dWCwwE+M2qn00FxBBsDkYQs1NDuEs5vNupSBh0Ce8Vyozm+C3vA/a8ofAjf7TMS8K
	glJGb1s34jv4GlX2OShOuYSsayevf5vHoGhtFYhBgoqdI2lImCW2ACL7PJF7FUfDkrgl
	0bJvxh8G1pw5VEE1Iw3ksZ73vN/Fm3Z+1RhRBoBl6GVjDce4SCt2KjDNwIIbaVu0wj+1
	3AFSxSm2GAvSo+TUginEug6F/+jDEtdcJFZAQTiggUwxueoqGWx6hP+kX21PVhsRZ0N8
	veGQ==
X-Gm-Message-State: ALoCoQnHMgg29Ola5u2bRNXOA8jItT8z05jWutituIUSe0OB04iExi9pv1AFcobQ9JXt2x/zAQ/X
X-Received: by 10.180.24.40 with SMTP id r8mr9385094wif.24.1433947142139;
	Wed, 10 Jun 2015 07:39:02 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id q9sm8290512wix.1.2015.06.10.07.39.00
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Jun 2015 07:39:01 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id EE7AF56105C; Wed, 10 Jun 2015 15:39:03 +0100 (BST)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 10 Jun 2015 15:39:02 +0100
Message-Id: <cover.1433946742.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Vlad Fulgeanu <andrei-vlad.fulgeanu@intel.com>
Subject: [PATCH 00/19] Toaster refactoring and bugfixing patchset
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
X-List-Received-Date: Wed, 10 Jun 2015 14:39:04 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This is a Toaster patchest that brings in refactoring in order to eliminate
duplicated code paths, and bring in improvements in the communication between
the browser and back-end.

The changes have been tested and reviewed on the Toaster mailing list.

Can you please pull when possible ?

Cheers,
Alex


The following changes since commit 430f7a288b4446600b3a943c51f6711ffcf9e619:

  bitbake: Bump version to 1.27.1 (2015-06-09 13:29:19 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150610-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150610-submission-bb

Alexandru DAMIAN (14):
  toaster: move project data typeahead to the REST API
  convert all project-based view to JSON APIs
  toaster: toastertables REST refactoring
  toastergui: use defaults on xhr_datatypeahead parameters
  toastergui: remove xhr_projectedit and xhr_projectinfo URLs
  toaster: toaster table add raw data
  toaster: ToasterTables add computational fields
  toaster: toastertables raise errors
  toaster: add class template view for single-object pages
  toaster: eliminate duplicate querysets
  toastergui: remove xhr_datatypeahead and xhr_XXXbuild
  toastergui: remove xhr_datatypeahaed layerdeps call
  toaster: fixes after refactoring
  toastergui: prevent contamination of libtoaster context

Ed Bartosh (2):
  toaster: Code cleanup: bashisms
  toaster: Make toaster script to work in dash

Michael Wood (2):
  toaster: Add ajax loading spinner
  toaster: Add global ajaxError handler

Vlad Fulgeanu (1):
  toaster: tables: Remove obsolete field_name for select column

 bin/toaster                                        |  82 ++--
 lib/toaster/contrib/tts/urllist.py                 |   5 -
 lib/toaster/orm/models.py                          |  44 +-
 lib/toaster/toastergui/static/css/default.css      |  49 +++
 lib/toaster/toastergui/static/js/base.js           | 140 +++---
 lib/toaster/toastergui/static/js/importlayer.js    |  14 +-
 lib/toaster/toastergui/static/js/layerdetails.js   |   6 +-
 lib/toaster/toastergui/static/js/libtoaster.js     |  60 ++-
 lib/toaster/toastergui/static/js/projectapp.js     | 146 ++++--
 lib/toaster/toastergui/static/js/table.js          |  37 +-
 lib/toaster/toastergui/tables.py                   | 120 +++--
 lib/toaster/toastergui/templates/base.html         |  29 +-
 .../toastergui/templates/basetable_bottom.html     |   2 +-
 .../templates/detail_pagination_bottom.html        |   2 +-
 lib/toaster/toastergui/templates/importlayer.html  |   1 -
 lib/toaster/toastergui/templates/layerdetails.html |   5 +-
 .../toastergui/templates/managed_mrb_section.html  |   2 +-
 lib/toaster/toastergui/templates/project.html      |  56 ++-
 lib/toaster/toastergui/templates/runagain.html     |   2 +-
 .../toastergui/templates/toastertable-simple.html  |   2 +-
 lib/toaster/toastergui/templates/toastertable.html |   2 +-
 lib/toaster/toastergui/templatetags/projecttags.py |   4 +-
 lib/toaster/toastergui/tests.py                    |   7 +-
 lib/toaster/toastergui/urls.py                     |  52 ++-
 lib/toaster/toastergui/views.py                    | 489 ++++++++++-----------
 lib/toaster/toastergui/widgets.py                  | 122 +++--
 lib/toaster/toastermain/settings.py                |   2 +-
 27 files changed, 881 insertions(+), 601 deletions(-)

-- 
1.9.1


