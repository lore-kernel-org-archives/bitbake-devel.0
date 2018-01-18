Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 14763787D0
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Jan 2018 08:57:18 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w0I8vK8K015752
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 18 Jan 2018 00:57:20 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.361.1; Thu, 18 Jan 2018 00:57:19 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 18 Jan 2018 16:57:39 +0800
Message-ID: <cover.1516265726.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/2] fixes for cache and parsing
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
X-List-Received-Date: Thu, 18 Jan 2018 08:57:19 -0000
Content-Type: text/plain

The following changes since commit a783bd7e457f183a279dbe5a4ef3d4c17bb4c18c:

  bitbake-user-manual: Removed stray parenthesis (2018-01-16 20:38:53 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/cache
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/cache

Robert Yang (2):
  cache.py: improve debug message
  parse: don't add attempted files to dependencies

 lib/bb/cache.py                      | 5 ++++-
 lib/bb/parse/__init__.py             | 2 --
 lib/bb/parse/parse_py/BBHandler.py   | 3 ---
 lib/bb/parse/parse_py/ConfHandler.py | 2 --
 4 files changed, 4 insertions(+), 8 deletions(-)

-- 
2.7.4


