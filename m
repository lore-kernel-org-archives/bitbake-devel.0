Return-Path: <Liezhi.Yang@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 161546B389
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jan 2014 10:54:42 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.5/8.14.5) with ESMTP id s0MAsh1d014826
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 22 Jan 2014 02:54:43 -0800 (PST)
Received: from pek-blade16.wrs.com (128.224.153.44) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server id 14.2.347.0;
	Wed, 22 Jan 2014 02:54:42 -0800
From: Robert Yang <liezhi.yang@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 22 Jan 2014 18:55:01 +0800
Message-ID: <cover.1390387902.git.liezhi.yang@windriver.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Subject: [PATCH 0/1] bitbake:cache.py: remove the add()
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
X-List-Received-Date: Wed, 22 Jan 2014 10:54:42 -0000
Content-Type: text/plain

The following changes since commit b314ad28a618d59429c790df7e2cdb6682c3149e:

  sanity.bbclass: check that TMPDIR is not located on nfs (2014-01-22 18:45:59 +0800)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib rbt/cache
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=rbt/cache

Robert Yang (1):
  bitbake:cache.py: remove the add()

 bitbake/lib/bb/cache.py | 13 -------------
 1 file changed, 13 deletions(-)

-- 
1.8.3.1


