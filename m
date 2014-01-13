Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 101626C6EC
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jan 2014 08:19:58 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s0D8Jx6S022637
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 13 Jan 2014 00:19:59 -0800 (PST)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Mon, 13 Jan 2014 00:19:58 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 13 Jan 2014 03:19:55 -0500
Message-ID: <cover.1389601138.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Subject: [PATCH 0/1] bitbake: data.py: convert "__" to "-" for PREFERRED_VERSION
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
X-List-Received-Date: Mon, 13 Jan 2014 08:19:59 -0000
Content-Type: text/plain

The following changes since commit 6ee5d95317de77c1cfb6db6f1ab2de77f5fa085e:

  bitbake: fetch2/gitannex: Fix function arguments to match bitbake master (2014-01-08 15:27:37 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/pv
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/pv

Robert Yang (1):
  bitbake: data.py: convert "__" to "-" for PREFERRED_VERSION

 bitbake/lib/bb/data.py |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

-- 
1.7.10.4


