Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 560B36E51F
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 11:44:43 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s0KBihC8000489
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 20 Jan 2014 03:44:43 -0800 (PST)
Received: from pek-blade16.wrs.com (128.224.153.44) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.2.347.0;
	Mon, 20 Jan 2014 03:44:44 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 20 Jan 2014 19:44:52 +0800
Message-ID: <cover.1390218256.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Subject: [PATCH 0/1] siggen.py: fix the SignatureGenerator()
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
X-List-Received-Date: Mon, 20 Jan 2014 11:44:43 -0000
Content-Type: text/plain

The following changes since commit 47b1d3283f93b4b12ba5da4c6b049d46f64e7414:

  sstate.bbclass: remove previous version's stamp (2014-01-20 17:26:47 +0800)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/noop
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/noop

Robert Yang (1):
  siggen.py: fix the SignatureGenerator()

 bitbake/lib/bb/siggen.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

-- 
1.8.3.1


