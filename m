Return-Path: <Hongxu.Jia@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 8453C7114B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 27 Aug 2014 11:55:35 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id s7RBsvwH023972
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 27 Aug 2014 04:54:57 -0700 (PDT)
Received: from pek-hjia-d1.corp.ad.wrs.com (128.224.162.194) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.174.1; Wed, 27 Aug 2014 04:54:56 -0700
From: Hongxu Jia <hongxu.jia@windriver.com>
To: <bitbake-devel@lists.openembedded.org>,
	<richard.purdie@linuxfoundation.org>
Date: Wed, 27 Aug 2014 19:54:47 +0800
Message-ID: <cover.1409140298.git.hongxu.jia@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Cc: Zhangle.Yang@windriver.com
Subject: [PATCH V3 0/1] bitbake: runqueue: catch HashValidateFailure errors in RunQueueExecuteScenequeue
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
X-List-Received-Date: Wed, 27 Aug 2014 11:55:36 -0000
Content-Type: text/plain

Changed in V3:
- Add exception HashValidateFailure for the specific error

Changed in V2: 
- Strip the commit message within 80 characters a line

//Hongxu

The following changes since commit 52b788c6df9201764130ab744bf67b770b24b896:

  autogen-native: inherit pkgconfig to fix a build failure (2014-08-25 10:26:00 +0100)

are available in the git repository at:

  git://git.pokylinux.org/poky-contrib hongxu/bitbake
  http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=hongxu/bitbake

Hongxu Jia (1):
  bitbake: runqueue: catch HashValidateFailure errors in
    RunQueueExecuteScenequeue

 bitbake/lib/bb/runqueue.py | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

-- 
1.9.1


