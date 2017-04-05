Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 49536779C3
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  5 Apr 2017 22:27:46 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v35MRjQ1004150
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 5 Apr 2017 15:27:45 -0700 (PDT)
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.216.91) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Wed, 5 Apr 2017 15:27:45 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 5 Apr 2017 15:18:12 -0700
Message-ID: <cover.1491430559.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.216.91]
Cc: Libertad Cruz <libertad.cruz@intel.com>
Subject: [PATCH 0/1] toaster: Create selenium tests for project dashboard page
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
X-List-Received-Date: Wed, 05 Apr 2017 22:27:47 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

From: David Reyna <David.Reyna@windriver.com>

toaster:test:Create selenium tests for project dashboard page

The following changes since commit eff56e4f0d59b1d965a68e4f009b7f07717b7edd:

  bitbake: bitbake-user-manual: Fixed special character in -D output (2017-04-03 22:32:02 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib libby/toaster/functional_tests_9808
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/libby/toaster/functional_tests_9808

David Reyna (1):
  toaster:test:Create selenium tests for project dashboard page

 lib/toaster/tests/builds/buildtest.py              | 110 +++++-----
 lib/toaster/tests/functional/__init__.py           |   0
 lib/toaster/tests/functional/functional_helpers.py | 122 +++++++++++
 .../tests/functional/test_functional_basic.py      | 243 +++++++++++++++++++++
 4 files changed, 421 insertions(+), 54 deletions(-)
 create mode 100644 bitbake/lib/toaster/tests/functional/__init__.py
 create mode 100644 bitbake/lib/toaster/tests/functional/functional_helpers.py
 create mode 100644 bitbake/lib/toaster/tests/functional/test_functional_basic.py

-- 
1.9.1


