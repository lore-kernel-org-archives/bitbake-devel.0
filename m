Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 11ABD7F00E
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 11:12:13 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id x8RBCFQW029272
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Sep 2019 04:12:15 -0700 (PDT)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.468.0; Fri, 27 Sep 2019 04:12:14 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 27 Sep 2019 19:12:16 +0800
Message-ID: <cover.1569582663.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/2] [meta-networking] Fixes for corosync and net-snmp
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
X-List-Received-Date: Fri, 27 Sep 2019 11:12:14 -0000
Content-Type: text/plain

The following changes since commit 41fe46157ca3caa96408a9a749d62c8bbc3c2794:

  python-paste: upgrade 3.2.0 -> 3.2.1 (2019-09-25 22:51:10 -0700)

are available in the git repository at:

  git://git.openembedded.org/meta-openembedded-contrib rbt/pkgconfig
  http://cgit.openembedded.org/meta-openembedded-contrib/log/?h=rbt/pkgconfig

Robert Yang (2):
  corosync: Fix PACKAGECONFIG flag for rdma
  net-snmp: Fix PACKAGECONFIG for perl

 meta-networking/recipes-extended/corosync/corosync_2.4.4.bb | 2 +-
 meta-networking/recipes-protocols/net-snmp/net-snmp_5.8.bb  | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.7.4


