Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 52C7B7C33D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 06:51:01 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x0P6p1AJ020021
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 24 Jan 2019 22:51:02 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Thu, 24 Jan 2019 22:51:01 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 25 Jan 2019 15:09:28 +0800
Message-ID: <cover.1548400142.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/1] bitbake: cookerdata: Check duplicated BBFILE_COLLECTIONS
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
X-List-Received-Date: Fri, 25 Jan 2019 06:51:01 -0000
Content-Type: text/plain

The following changes since commit 1979d9162a335b7d4718a6697ca57bfa16237f0e:

  bitbake: gitsmy.py: Fix unpack of submodules of submodules (2019-01-24 17:45:49 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/bbfile
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/bbfile

Robert Yang (1):
  bitbake: cookerdata: Check duplicated BBFILE_COLLECTIONS

 bitbake/lib/bb/cookerdata.py | 4 ++++
 1 file changed, 4 insertions(+)

-- 
2.7.4


