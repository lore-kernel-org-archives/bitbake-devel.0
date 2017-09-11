Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 52236784A7
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Sep 2017 22:50:25 +0000 (UTC)
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	11 Sep 2017 15:50:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.42,380,1500966000"; d="scan'208";a="150679259"
Received: from nrahulx-mobl.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.249.73.25])
	by fmsmga006.fm.intel.com with ESMTP; 11 Sep 2017 15:50:25 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 12 Sep 2017 10:49:52 +1200
Message-Id: <cover.1505170163.git.paul.eggleton@linux.intel.com>
X-Mailer: git-send-email 2.9.5
Subject: [PATCH 0/2] A couple of fixes
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
X-List-Received-Date: Mon, 11 Sep 2017 22:50:26 -0000

The following changes since commit ed3aab90dbf9b6efefd9eb66d81123cb94d3c7da:

  toaster: update pyro to rocko as stable release (2017-09-11 11:00:11 +0100)

are available in the git repository at:

  git://git.openembedded.org/bitbake-contrib paule/bb-fixes
  http://cgit.openembedded.org/bitbake-contrib/log/?h=paule/bb-fixes

Paul Eggleton (2):
  runqueue: fix BB_SETSCENE_ENFORCE with empty BB_SETSCENE_ENFORCE_WHITELIST
  server/process: ensure server failure log is limited to current session

 lib/bb/runqueue.py       |  6 +++---
 lib/bb/server/process.py | 28 +++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 6 deletions(-)

-- 
2.9.5


