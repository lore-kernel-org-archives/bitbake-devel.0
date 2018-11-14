Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 989096C17F
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 09:34:49 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id wAE9YokW004446
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2018 01:34:50 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Wed, 14 Nov 2018 01:34:49 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 14 Nov 2018 17:46:35 +0800
Message-ID: <cover.1542188647.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/6] bitbake: Improve error/exception handling
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
X-List-Received-Date: Wed, 14 Nov 2018 09:34:49 -0000
Content-Type: text/plain

The following changes since commit eddff2b361928e88e3628ebc22a1a0ebb119e01b:

  curl: actually apply latest CVE patches (2018-11-09 17:46:18 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/bb_improve_error
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/bb_improve_error

Robert Yang (6):
  bitbake: utils: better_compile(): Fix line number when report errors
  bitbake: parse/ast: fix line number for anonymous function
  bitbake: data_smart: Add original traceback to ExpansionError
  bitbake: data_smart: fix filename for compile()
  bitbake: server/process: print a message when no logfile
  bitbake: BBHandler: Fix __python_func_regexp__ for comment lines

 bitbake/lib/bb/data_smart.py               | 9 +++++++--
 bitbake/lib/bb/parse/ast.py                | 2 +-
 bitbake/lib/bb/parse/parse_py/BBHandler.py | 2 +-
 bitbake/lib/bb/server/process.py           | 4 ++++
 bitbake/lib/bb/utils.py                    | 7 +++++--
 5 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.7.4


