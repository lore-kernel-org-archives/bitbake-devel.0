Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 4B3146BBDA
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Sep 2013 13:41:23 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id r82DfNld005257
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 2 Sep 2013 06:41:23 -0700 (PDT)
Received: from pek-hostel-vm02.wrs.com (128.224.153.172) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.2.347.0; Mon, 2 Sep 2013 06:41:22 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 2 Sep 2013 09:41:18 -0400
Message-ID: <cover.1378121137.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Subject: [PATCH 0/2] taskdata.py: set PREFERRED_VERSION when it is in the item
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
X-List-Received-Date: Mon, 02 Sep 2013 13:41:24 -0000
Content-Type: text/plain

The following changes since commit c7994f83baa678a4670472e1f037bfc16cb1e3be:

  bitbake: runqueue: Fix scenequeue to pass file descriptors, not a float (2013-09-02 09:16:24 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib robert/preferred
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/preferred

Robert Yang (2):
  providers.py: enhance the runtime debug degbug messgae
  taskdata.py: set PREFERRED_VERSION when it is in the item

 bitbake/lib/bb/providers.py |    2 +-
 bitbake/lib/bb/taskdata.py  |   15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

-- 
1.7.10.4


