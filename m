Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 9C0886C5A4
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Nov 2018 10:56:26 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id wANAuR2R026926
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 23 Nov 2018 02:56:27 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Fri, 23 Nov 2018 02:56:26 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 23 Nov 2018 19:13:43 +0800
Message-ID: <cover.1542971536.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/1] bitbake: BBHandler: Check tab indentation for python code
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
X-List-Received-Date: Fri, 23 Nov 2018 10:56:26 -0000
Content-Type: text/plain

The following changes since commit 6b84ac788321b24cfa2e6a883806eb3f3198254b:

  ref-manual: Updated list of supported Linux Distros: (2018-11-22 12:20:52 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/py
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/py

Robert Yang (1):
  bitbake: BBHandler: Check tab indentation for python code

 bitbake/lib/bb/data.py                     |  2 --
 bitbake/lib/bb/parse/parse_py/BBHandler.py | 11 +++++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.7.4


