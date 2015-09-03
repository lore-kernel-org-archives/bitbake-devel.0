Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f49.google.com (mail-pa0-f49.google.com
	[209.85.220.49])
	by mail.openembedded.org (Postfix) with ESMTP id 9F60F7702D
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Sep 2015 00:23:51 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so27620264pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 02 Sep 2015 17:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=LFgNhJpm8Pb/CtbMeftesiBJCoS5+FRB4xoN/27tttE=;
	b=fdqLE0qv0vYRMc7pczZSs97wai9xTv14KDnggBpTYZZLleRwh99YqS/jyJWxDwTEEZ
	DVmNIiQdlychSlawLUX6HcaabS5aTFTXk/XEwCs9roUgyouphwvMlkO5Oilp5pF3U1sA
	0hLwpb168RAGftKyvx6O3hZXnZrxeweC0dQuZqLsD0kYW4qqoP4rJFdNwBROAwoV5b9O
	R73gxmlo2Cwc1g64zJM+8w7Ti4klMfp/RocjMivPS+lrEyK6g/noe382iplrICZM3A0T
	njvy6KgqjiOCrdRL1FH9eXOBuMjMjDIMOs/t5/trnsF/aiB3h3FcBtTdjwuMmPPzZl8J
	XsrQ==
X-Received: by 10.68.249.36 with SMTP id yr4mr61180387pbc.18.1441239831407;
	Wed, 02 Sep 2015 17:23:51 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	x11sm23224941pas.46.2015.09.02.17.23.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 02 Sep 2015 17:23:50 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  2 Sep 2015 17:24:38 -0700
Message-Id: <cover.1441239229.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/6] Fix handling of "default" project
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
X-List-Received-Date: Thu, 03 Sep 2015 00:23:53 -0000

This fixes how we handle the default project used to house command
line builds. It originally started from a bug encountered when
using MySQL for the db back-end, but fixing that revealed some
other issues which needed to be resolved on top.

[YOCTO#7932]


The following changes since commit 71b0568fa43285f0946fae93fb43cea5f3bbecec:

  rt-tests: drop unnecessary added-missing-dependencies.patch (2015-09-01 11:44:04 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/elliot/20150830_default_project_flag_v2
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/elliot/20150830_default_project_flag_v2

Elliot Smith (6):
  toaster: Make 0021 migration compatible with MySQL
  toaster: Improve how default project is identified and fetched
  toaster: Only redirect to projects page if user has added projects
  toaster: Exclude default project unless it has builds
  toaster: Fix test for projects page JSON
  toaster: Add tests for pages which show the default project

 lib/bb/ui/buildinfohelper.py                       |   3 +-
 ...ect__chg_field_project_bitbake_version__chg_.py |   4 +-
 .../0025_auto__add_field_project_is_default.py     | 346 +++++++++++++++++++
 .../orm/migrations/0026_set_default_project.py     | 374 +++++++++++++++++++++
 lib/toaster/orm/models.py                          |  18 +-
 lib/toaster/toastergui/tests.py                    | 124 ++++++-
 lib/toaster/toastergui/views.py                    |  14 +-
 7 files changed, 870 insertions(+), 13 deletions(-)
 create mode 100644 bitbake/lib/toaster/orm/migrations/0025_auto__add_field_project_is_default.py
 create mode 100644 bitbake/lib/toaster/orm/migrations/0026_set_default_project.py

-- 
1.9.1


