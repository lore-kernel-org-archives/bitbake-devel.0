Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id DDB3760777
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Nov 2016 14:30:29 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id uALEUUHr014021
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 Nov 2016 06:30:30 -0800
Received: from ala-blade47.wrs.com (147.11.105.67) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.294.0;
	Mon, 21 Nov 2016 06:30:29 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 21 Nov 2016 06:30:28 -0800
Message-ID: <cover.1479738455.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 2.10.2
MIME-Version: 1.0
Subject: [PATCH 0/1] cooker.py: runqueue: fix for "bitbake -g world"
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
X-List-Received-Date: Mon, 21 Nov 2016 14:30:30 -0000
Content-Type: text/plain

The patch was from RP, I did some cleanup and sent it. morty branch also
needs it.

// Robert

The following changes since commit 7c3a47ed8965c3a3eb90a9a4678d5caedbba6337:

  bitbake: toaster: settings set ALLOWED_HOSTS to * in debug mode (2016-11-16 11:38:44 +0000)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/world_g
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/world_g

Richard Purdie (1):
  cooker.py: runqueue: fix for "bitbake -g world"

 bitbake/lib/bb/cooker.py | 3 +++
 1 file changed, 3 insertions(+)

-- 
2.10.2


