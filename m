Return-Path: <alexandru.damian@intel.com>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
	[74.125.82.170])
	by mail.openembedded.org (Postfix) with ESMTP id 9F0596FAF2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 18:02:36 +0000 (UTC)
Received: by mail-we0-f170.google.com with SMTP id w61so572739wes.15
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 25 Mar 2014 11:02:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=WQr7JoPaiGDH9JRpymOsXCnVRLPnHcRErvygJf7yeAk=;
	b=IAjzrUj49hY5jkq3JOx2jdkc1XyEema5GB0T4wFHdHLVnEzh7P97sFIwb+nx8vWLIQ
	mYr2I5IK4fTIKQReA9e4wNlBGmyWk3SK78LQqMM4QsVEKEb396a08bnDuoQv98UjLfOc
	zfKgNrcUC0yyBl+uoj79lqhBmXPIRvJt/zlgZx9nv+9YjG4lV3Rf+zR5Pur9Pcd2nVVH
	kLLYvfCT6qiKe5pDcS3kgXO5pNV430oU9A3dfdiB49cNtagCmXjLgIST0vNHVHHU8vZK
	Vy56LpIoo1VDKlBhxhpITyGgJwUtbTMFmutlJ4EFYge7gPsmp4q/qixFKBJZPDKqABUp
	wmFg==
X-Gm-Message-State: ALoCoQn4ktHIboumrjeyptPCTt40z1cdxgWiW8aaGn928BNxO3XFNPvhV1zzaNut3ZPoQ4MtialP
X-Received: by 10.180.189.106 with SMTP id gh10mr25807463wic.3.1395770556997; 
	Tue, 25 Mar 2014 11:02:36 -0700 (PDT)
Received: from adamian-desk.corp.intel.com ([83.217.123.106])
	by mx.google.com with ESMTPSA id h8sm10310911wiz.12.2014.03.25.11.02.34
	for <multiple recipients>
	(version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 25 Mar 2014 11:02:35 -0700 (PDT)
Received: by adamian-desk.corp.intel.com (Postfix, from userid 1000)
	id 401A4560407; Tue, 25 Mar 2014 17:51:09 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 25 Mar 2014 17:51:08 +0000
Message-Id: <cover.1395769683.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.8.3.2
Cc: Dave Lerner <dave.lerner@windriver.com>,
	Alexandru DAMIAN <alexandru.damian@intel.com>
Subject: [PATCH 0/5] please pull toaster patchset
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
X-List-Received-Date: Tue, 25 Mar 2014 18:02:39 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

This is a patchset with UI fixes for Toaster. The patches have been reviewed
on the mailing list.

Can you please pull ?

Thanks,
Alex

The following changes since commit bdbcd8866104c315fc9da631407d4280433dbfde:

  hob: fix set_extra_setting function (2014-03-25 13:26:47 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20140325-bb-submission
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20140325-bb-submission

Belen Barros Pena (4):
  toaster: Change placeholder attribute in variables table
  toaster: Remove commented-out code from views.py
  toaster: Fix help text typos
  toaster: Small fixes in tasks UI

Dave Lerner (1):
  toaster: format packages with size = -1

 .../toastergui/templates/package_detail_base.html   |  2 +-
 .../templates/package_included_dependencies.html    | 19 ++++++++++++++++---
 .../package_included_reverse_dependencies.html      |  9 ++++++++-
 lib/toaster/toastergui/templates/recipe.html        |  6 ++++--
 lib/toaster/toastergui/templates/task.html          | 18 ++++++++----------
 lib/toaster/toastergui/templates/tasks.html         |  3 ++-
 lib/toaster/toastergui/templatetags/projecttags.py  | 21 ++++++++++++++++++++-
 lib/toaster/toastergui/views.py                     | 19 +++++++------------
 8 files changed, 66 insertions(+), 31 deletions(-)

-- 
1.8.3.2


