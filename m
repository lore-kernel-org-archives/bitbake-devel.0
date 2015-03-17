Return-Path: <alexandru.damian@intel.com>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by mail.openembedded.org (Postfix) with ESMTP id 9B8AB72E53
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 14:38:03 +0000 (UTC)
Received: by wibgn9 with SMTP id gn9so16319328wib.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 20 Mar 2015 07:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=S5VH/sfeIgezA0oGvnwbzoeFsSl16MSgNXNJO9aMBig=;
	b=nMCsjoqKxjLL6WWKIUHt9wYHx6xahCsN0aiDkaArIGOxgt1q2QOIRgcazhq/+I6bJI
	2nAisOA80dbfLZn83KUoD7XH9rj1XZIcjLiq7kp4SgZCUiQ5lSjqzt5EJL/PFPSpXjRP
	5acYQ90Pq9Uq0TDQ3V5Zno4qDvn25BeaYXCmwwZNSty1roXi8AaMiOX77C1VAj0FZu3X
	fpi6mPL0QsGg5di6UQewLycnSphPnGtb+GJoufJ1l4v2UdZFgo8RRe1d3HFBvS43GXJ8
	glMnpTqmPhSqoCNQCoWI9QXBITGqpNYWkgLQABIImGfNibItDiVwadwrBn458GnGVG4D
	eL9A==
X-Gm-Message-State: ALoCoQlKpNLCfLChFjK8cqzYKHmwVeOiTPeAyVnnZpfiBEJw46a4FKqXBLh86IfGqZui2WGWOHxr
X-Received: by 10.180.13.146 with SMTP id h18mr24968232wic.73.1426862284391;
	Fri, 20 Mar 2015 07:38:04 -0700 (PDT)
Received: from adamian-desk.local ([83.217.123.106])
	by mx.google.com with ESMTPSA id j7sm3312668wix.4.2015.03.20.07.38.01
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 20 Mar 2015 07:38:02 -0700 (PDT)
Received: by adamian-desk.local (Postfix, from userid 1000)
	id 254D2562056; Tue, 17 Mar 2015 13:28:04 +0000 (GMT)
From: Alex DAMIAN <alexandru.damian@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 17 Mar 2015 13:28:03 +0000
Message-Id: <cover.1426598797.git.alexandru.damian@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: Dave Lerner <dave.lerner@windriver.com>,
	David Reyna <David.Reyna@windriver.com>
Subject: [PATCH 00/14] Toaster patchset
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
X-List-Received-Date: Fri, 20 Mar 2015 14:38:04 -0000

From: Alexandru DAMIAN <alexandru.damian@intel.com>

Hello,

This is a toaster patchset that fixes various issues in the interface,
and in build process.

Can you please pull ?

Thanks,
Alex

The following changes since commit 4b07195405b124ff39703e1ddc226dee420fed22:

  toaster: Fix the orderkey to match the column (2015-03-16 17:43:51 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib adamian/20150317-submission-bb
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=adamian/20150317-submission-bb

Alexandru DAMIAN (7):
  toasterui: improve info in the toaster_ui.log
  toaster: targets page performance improvement
  toastergui: fix machines page search
  toastergui: builds and projects outcome filter
  toaster: do not throw exception on misconfigured data
  toasterui: fix error message parameter
  toastergui: recipe and layer identification

Belen Barros Pena (1):
  toaster: display bitbake output after process start

Dave Lerner (1):
  toaster: leave cancel enabled for release change

David Reyna (3):
  toaster: Incorrect breadcrumb behaviour in the project page
  toaster: display machine and project values in input fields
  toaster: insure IMAGE_INSTALL_append values have a space prefix

Michael Wood (2):
  toaster: Add cancel build to latest build section
  toaster: tasks trigger the select related tables before ordering

 lib/bb/ui/buildinfohelper.py                       | 31 ++++++++++++----
 lib/bb/ui/toasterui.py                             |  8 +++++
 lib/toaster/bldcontrol/localhostbecontroller.py    | 14 +++++---
 lib/toaster/orm/models.py                          | 14 ++++----
 lib/toaster/toastergui/static/js/libtoaster.js     | 28 +++++++++++++++
 .../toastergui/templates/baseprojectpage.html      |  6 ++++
 .../toastergui/templates/managed_mrb_section.html  | 42 +++++++++-------------
 lib/toaster/toastergui/templates/mrb_section.html  | 39 --------------------
 lib/toaster/toastergui/templates/project.html      |  6 ++--
 lib/toaster/toastergui/templates/projectconf.html  | 18 ++++++----
 lib/toaster/toastergui/templates/projects.html     |  2 +-
 lib/toaster/toastergui/views.py                    | 35 ++++++++++++------
 12 files changed, 138 insertions(+), 105 deletions(-)

-- 
1.9.1


