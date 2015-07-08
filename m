Return-Path: <anibal.limon@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id 5FC42607A5
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  8 Jul 2015 23:32:13 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga103.jf.intel.com with ESMTP; 08 Jul 2015 16:32:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.15,435,1432623600"; d="scan'208";a="521077029"
Received: from alimon-thinkpad-w540.zpn.intel.com ([10.219.4.155])
	by FMSMGA003.fm.intel.com with ESMTP; 08 Jul 2015 16:32:12 -0700
From: =?UTF-8?q?An=C3=ADbal=20Lim=C3=B3n?= <anibal.limon@linux.intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed,  8 Jul 2015 18:34:14 -0500
Message-Id: <1436398461-26014-1-git-send-email-anibal.limon@linux.intel.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Subject: [PATCHv4 0/7] Add connection cache support in wget checkstatus
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
X-List-Received-Date: Wed, 08 Jul 2015 23:32:16 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This v4 fixes issues related to SSL cert validation in Python>=2.7.9, see
last commit.

You can also review the changes at,

http://git.yoctoproject.org/cgit/cgit.cgi/poky-contrib/log/?h=alimon/fetch2-wget-checkstatus

Aníbal Limón (7):
  fetch2/__init__.py: Add FetchConnectionCache class
  fetch2: Add fetch parameter to checkstatus
  fetch2/wget.py: Add support of connection cache in checkstatus.
  tests/fetch.py: Add FetchCheckStatusTest tests.
  fetch2/wget.py: checkstatus fix using proxy handler
  tests/fetch.py: FetchCheckStatusTest add cases for ftp and https.
  fetch2/wget.py: checkstatus disable SSL cert validation.

 lib/bb/fetch2/__init__.py |  59 +++++++++++++---
 lib/bb/fetch2/git.py      |   2 +-
 lib/bb/fetch2/local.py    |   2 +-
 lib/bb/fetch2/wget.py     | 168 ++++++++++++++++++++++++++++++++++++++++++++--
 lib/bb/tests/fetch.py     |  45 +++++++++++++
 5 files changed, 259 insertions(+), 17 deletions(-)

-- 
1.9.1


