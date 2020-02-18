Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 130F761176
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2020 10:46:07 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 01IAk7sm021065
	(version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 18 Feb 2020 02:46:08 -0800 (PST)
Received: from pek-lpg-core1.wrs.com (128.224.156.132) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.3.468.0; Tue, 18 Feb 2020 02:46:07 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 18 Feb 2020 18:48:01 +0800
Message-ID: <cover.1582022808.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Subject: [PATCH 0/1] bitbake/lib/bb/event.py: Remove duplicated ones from close matches
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
X-List-Received-Date: Tue, 18 Feb 2020 10:46:08 -0000
Content-Type: text/plain

The following changes since commit 925800570f9093cc8de90091008759998e5cd4f2:

  bitbake: cooker/siggen: Empty siggen cache during parsing (2020-02-17 23:11:38 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib rbt/close
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=rbt/close

Robert Yang (1):
  bitbake/lib/bb/event.py: Remove duplicated ones from close matches

 bitbake/lib/bb/event.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.7.4


