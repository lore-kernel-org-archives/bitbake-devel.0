Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f171.google.com (mail-wi0-f171.google.com
	[209.85.212.171])
	by mail.openembedded.org (Postfix) with ESMTP id A78BF738F6
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  9 Mar 2015 13:18:23 +0000 (UTC)
Received: by wibbs8 with SMTP id bs8so20354764wib.4
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 09 Mar 2015 06:18:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=kmZ0wI6KWtBUsoyLh4x5K9R/XwHB9NqkkhrFHrPQz0Q=;
	b=mSrnad0YAS+QVwsIk3tROzywQneNNCcPACuiBrE8R/FUGe3YRpwWxbsw9LBb8ToWuD
	Z377hriBwFvjrq9dgXX+OiF4XVL345Qu6t9XsjweHIpdXYd+rdFQ86nnKxVapTOyApzv
	aR6w9ussxHGIGhx7GFXRf13JK4IPAqsE0Xc3a506Q7P0EafmJFTl0gqM4bBEn4JVqLM5
	mzVY8ifserNqAiV/7rcoxui1wxb9iffiD+peObKkizG6BgExC12EAcDCJLxHDva0jMs1
	uN+/HIxRh9h8R6lF5qXeANuJZsQ6dNIpuM2L53zxCxY2gybcBZrh0OSHYQPsX5wXiP9r
	hrdg==
X-Gm-Message-State: ALoCoQmKKjinmuCOZZD4P5Z6gPp1sOAnt2zITI+VlvZovB62A/mv0BT9noev/fCPvozXe8CTl+Vx
X-Received: by 10.194.2.43 with SMTP id 11mr58086274wjr.104.1425907104235;
	Mon, 09 Mar 2015 06:18:24 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id fs8sm15495862wib.8.2015.03.09.06.18.22
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 09 Mar 2015 06:18:23 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id AFCC3560742; Mon,  9 Mar 2015 13:18:25 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  9 Mar 2015 13:18:24 +0000
Message-Id: <cover.1425906999.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Dave Lerner <dave.lerner@windriver.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 00/21] Toaster bug fixing patchset
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
X-List-Received-Date: Mon, 09 Mar 2015 13:18:24 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This is a toaster bugfix patchset. It has been reviewed and tested 
on the toaster mailing list.

Can you please pull at your convenience ?

Cheers,
Alex



The following changes since commit baec2940c2b4ec792cacad5cc8d8056d9162919b:

  toaster: config var layout fixes (2015-02-27 07:35:10 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150309-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150309-submission-bb

Alexandru DAMIAN (8):
  cooker: read file watches on server idle
  toaster: delete test data
  xmlrpcserver: do not connect client on error
  cooker: make sure state is properly used to accept clients
  xmlrpc server: delete function on errors
  toaster: models.py do not use transactions
  toastergui: bring back base URLs for pages that need them
  toaster: projectapp.js - clear up jslint warnings

Belen Barros Pena (5):
  toasterui: don't open layer details in a new tab
  toasterui: fix the h1 in the project builds page
  toasterui: apply correct class to latest builds targets
  toasterui: give some space to the download log button
  toaterui: shorten the unavailable artifact message

Dave Lerner (4):
  toaster: add sort, search, paging to recipe package page
  toaster: layer rev tooltip only if necessary
  toaster: commit id format on layers page
  toaster: cached outcome download button

David Reyna (2):
  toaster: hide special code for core vars not present, disable add
    button
  toaster: reconcile non-manage-mode landing classes

Michael Wood (2):
  toaster: Enforce unique layer names
  toaster: libtoaster Fix a few warnings picked up by jshint

 lib/bb/cooker.py                                   |     36 +-
 lib/bb/server/xmlrpc.py                            |      6 +
 lib/toaster/bldviewer/tests.py                     |      5 +-
 lib/toaster/orm/fixtures/orm_views_testdata.json   | 140835 ------------------
 lib/toaster/orm/models.py                          |     34 +-
 lib/toaster/toastergui/static/css/default.css      |      1 +
 lib/toaster/toastergui/static/js/.jshintrc         |     11 +
 lib/toaster/toastergui/static/js/importlayer.js    |     94 +-
 lib/toaster/toastergui/static/js/libtoaster.js     |     79 +-
 lib/toaster/toastergui/static/js/projectapp.js     |    181 +-
 lib/toaster/toastergui/templates/base.html         |      2 +-
 .../toastergui/templates/builddashboard.html       |      4 +-
 .../templates/detail_pagination_bottom.html        |     60 +
 .../toastergui/templates/detail_search_header.html |     68 +
 .../toastergui/templates/detail_sorted_header.html |     25 +
 lib/toaster/toastergui/templates/importlayer.html  |     41 +-
 lib/toaster/toastergui/templates/layerdetails.html |      8 +-
 lib/toaster/toastergui/templates/layers.html       |     15 +-
 lib/toaster/toastergui/templates/project.html      |     10 +-
 .../toastergui/templates/projectbuilds.html        |     26 +-
 lib/toaster/toastergui/templates/projectconf.html  |     81 +-
 lib/toaster/toastergui/templates/recipe.html       |     52 +-
 .../toastergui/templates/recipe_packages.html      |    123 +
 lib/toaster/toastergui/templates/task.html         |      8 +
 .../toastergui/templates/unavailable_artifact.html |     10 +-
 lib/toaster/toastergui/templatetags/projecttags.py |     12 +
 lib/toaster/toastergui/urls.py                     |      8 +-
 lib/toaster/toastergui/views.py                    |    110 +-
 28 files changed, 798 insertions(+), 141147 deletions(-)
 delete mode 100644 lib/toaster/orm/fixtures/orm_views_testdata.json
 create mode 100644 lib/toaster/toastergui/static/js/.jshintrc
 create mode 100644 lib/toaster/toastergui/templates/detail_pagination_bottom.html
 create mode 100644 lib/toaster/toastergui/templates/detail_search_header.html
 create mode 100644 lib/toaster/toastergui/templates/detail_sorted_header.html
 create mode 100644 lib/toaster/toastergui/templates/recipe_packages.html

-- 
1.9.1


