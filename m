Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id E95976BB2D
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 09:35:27 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id x0P9Z3UJ009478
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 25 Jan 2019 01:35:18 -0800
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.408.0; Fri, 25 Jan 2019 01:35:01 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 25 Jan 2019 17:53:28 +0800
Message-ID: <cover.1548409947.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/1] bitbake: ConfHandler: Don't strip leading spaces
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
X-List-Received-Date: Fri, 25 Jan 2019 09:35:28 -0000
Content-Type: text/plain

The following changes since commit 1979d9162a335b7d4718a6697ca57bfa16237f0e:

  bitbake: gitsmy.py: Fix unpack of submodules of submodules (2019-01-24 17:45:49 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/conf
  http://git.pokylinux.org/cgit.cgi//log/?h=rbt/conf

Robert Yang (1):
  bitbake: ConfHandler: Don't strip leading spaces

 bitbake/lib/bb/parse/parse_py/ConfHandler.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4


