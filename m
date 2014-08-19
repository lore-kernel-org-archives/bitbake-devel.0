Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id AAB9660169
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Aug 2014 00:38:18 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id s7J0cJ6N025207
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Aug 2014 17:38:19 -0700 (PDT)
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.174.1;
	Mon, 18 Aug 2014 17:38:18 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 18 Aug 2014 17:38:17 -0700
Message-ID: <cover.1408408667.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Subject: [PATCH 0/1] newbb.vim: remove PR
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
X-List-Received-Date: Tue, 19 Aug 2014 00:38:18 -0000
Content-Type: text/plain

The following changes since commit d1d847771df0744a67684ad9c8f076fe758a2fd6:

  python3-distribute: fix interpreter (2014-08-17 19:34:35 -0700)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/vim
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/vim

Robert Yang (1):
  newbb.vim: remove PR

 bitbake/contrib/vim/plugin/newbb.vim |    1 -
 1 file changed, 1 deletion(-)

-- 
1.7.9.5


