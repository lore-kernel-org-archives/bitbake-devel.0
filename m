Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0FC9460D9D
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 25 Dec 2013 02:19:31 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id rBP2JVaN008050
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Dec 2013 18:19:31 -0800 (PST)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Tue, 24 Dec 2013 18:19:31 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 24 Dec 2013 21:19:25 -0500
Message-ID: <cover.1387937195.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Subject: [dora-next] [PATCH 0/4] bitbake: several fixes
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
X-List-Received-Date: Wed, 25 Dec 2013 02:19:31 -0000
Content-Type: text/plain

The following changes since commit 3cf2d232529c4fd6b58f87ddbf3df9d805e4180f:

  libsoup-2.4: add intltool-native to DEPENDS (2013-12-20 09:29:05 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib robert/dora-next-bitbake
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/dora-next-bitbake

Richard Purdie (4):
  bitbake: runqueue/bitbake-worker: Fix dry run fakeroot issues
  bitbake: data: Fix output inconsistencies for emit_var
  bitbake: parse/ConfHander/BBHandler/utils: Fix cache dependency bugs
  bitbake: imagedetailspage: Fix crash with more than 15 layers

 bitbake/bin/bitbake-worker                   |    3 ++-
 bitbake/lib/bb/data.py                       |    4 ++--
 bitbake/lib/bb/parse/__init__.py             |   19 +++++++++++++++----
 bitbake/lib/bb/parse/parse_py/BBHandler.py   |    5 ++++-
 bitbake/lib/bb/parse/parse_py/ConfHandler.py |    9 ++++++++-
 bitbake/lib/bb/runqueue.py                   |    2 +-
 bitbake/lib/bb/ui/crumbs/imagedetailspage.py |    2 +-
 bitbake/lib/bb/utils.py                      |    8 +++++++-
 8 files changed, 40 insertions(+), 12 deletions(-)

-- 
1.7.10.4


