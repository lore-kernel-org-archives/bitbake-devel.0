Return-Path: <anibal.limon@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by mail.openembedded.org (Postfix) with ESMTP id AAC6073F9E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 23 Jun 2015 19:24:11 +0000 (UTC)
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga102.fm.intel.com with ESMTP; 23 Jun 2015 12:24:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.13,667,1427785200"; d="scan'208";a="749069796"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.55])
	by fmsmga002.fm.intel.com with ESMTP; 23 Jun 2015 12:24:12 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 23 Jun 2015 14:26:01 -0500
Message-Id: <1435087565-9981-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCH 0/4] Add connection cache support in wget checkstatus.
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
X-List-Received-Date: Tue, 23 Jun 2015 19:24:11 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

You can also review the changes at,

http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=alimon/fetch2-wget-checkstatus

Aníbal Limón (4):
  fetch2/__init__.py: Add FetchConnectionCache class
  fetch2: Add fetch parameter to checkstatus
  fetch2/__init__.py: Add connection_cache param in Fetch __init__.
  tests/fetch.py: Add FetchCheckStatusTest tests.

 lib/bb/fetch2/__init__.py |  59 +++++++++++++++----
 lib/bb/fetch2/git.py      |   2 +-
 lib/bb/fetch2/local.py    |   2 +-
 lib/bb/fetch2/wget.py     | 140 ++++++++++++++++++++++++++++++++++++++++++++--
 lib/bb/tests/fetch.py     |  39 +++++++++++++
 5 files changed, 224 insertions(+), 18 deletions(-)

-- 
1.9.1


