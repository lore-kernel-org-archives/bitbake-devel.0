Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id BB0B77859E
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 29 Jul 2017 00:22:34 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id v6T0MZAN026736
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Jul 2017 17:22:35 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.157.78) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Fri, 28 Jul 2017 17:22:35 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 28 Jul 2017 17:14:03 -0700
Message-ID: <cover.1501286515.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.157.78]
Subject: [PATCH 0/2] toaster: cummulative 28072017 patch
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
X-List-Received-Date: Sat, 29 Jul 2017 00:22:34 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>


WARNING: there is one new file added with this patch:
  create mode 100644 bitbake/lib/toaster/toastergui/templates/health.html

* IMPORTANT: This fixes the fatal regressions to Toaster from xmlrpc changes in bitbake.
This also addresses a new race condition that Toaster suddenly started hitting where 
the 'bitbake.lock' existed but was not populated with the server info for period of time
(~ second).
  toaster: move to new bitbake xmlrpc default

* This provides a health ping URL, plus adds a JSON API for fetching 
Toaster status for multi-instance Toaster aggregators
  toaster: enable remote HTTP API for status aggregation


The following changes since commit 3c1c4ceaa470957fe5633d65215f165a38d61be7:

  yocto-project-qs, ref-manual: Upgraded tar to 1.27 from 1.24 (2017-07-27 23:00:23 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/cummulative_280717_patch
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/cummulative_280717_patch

David Reyna (2):
  toaster: enable remote HTTP API for status aggregation
  toaster: move to new bitbake xmlrpc default

 lib/toaster/bldcontrol/bbcontroller.py          |  4 +-
 lib/toaster/bldcontrol/localhostbecontroller.py | 19 ++++--
 lib/toaster/orm/models.py                       |  2 +-
 lib/toaster/toastergui/templates/health.html    |  6 ++
 lib/toaster/toastergui/urls.py                  |  7 +-
 lib/toaster/toastergui/views.py                 | 86 ++++++++++++++++++++++++-
 lib/toaster/toastermain/urls.py                 |  5 +-
 7 files changed, 118 insertions(+), 11 deletions(-)
 create mode 100644 bitbake/lib/toaster/toastergui/templates/health.html

-- 
1.9.1


