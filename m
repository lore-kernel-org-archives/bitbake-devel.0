Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 1E7F9764BA
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Aug 2015 07:08:48 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.15.1/8.15.1) with ESMTPS id t7D78mnF027414
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 13 Aug 2015 00:08:49 -0700 (PDT)
Received: from ala-blade48.wrs.com (147.11.105.68) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.3.235.1;
	Thu, 13 Aug 2015 00:08:48 -0700
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 13 Aug 2015 00:08:47 -0700
Message-ID: <cover.1439449677.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Subject: [PATCH 0/1] fetch2/git.py: fix _latest_revision for local PREMIRROR
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
X-List-Received-Date: Thu, 13 Aug 2015 07:08:49 -0000
Content-Type: text/plain

The following changes since commit 64da20b8555350e1b0d761c36499532e83ca9827:

  multilib_global.bbclass: fix PREFERRED_VERSION for cross-canadian (2015-08-12 23:51:13 -0700)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/auto
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/auto

Robert Yang (1):
  fetch2/git.py: fix _latest_revision for local PREMIRROR

 bitbake/lib/bb/fetch2/git.py |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
1.7.9.5


