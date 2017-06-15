Return-Path: <david.reyna@windriver.com>
Received: from mail5.wrs.com (mail5.windriver.com [192.103.53.11])
	by mail.openembedded.org (Postfix) with ESMTP id 19AD677E8A
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Jun 2017 04:57:10 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id v5F4vBbX009530
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Jun 2017 21:57:11 -0700
Received: from ala-dreyna-lx3.corp.ad.wrs.com (147.11.200.76) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server
	(TLS) id 14.3.294.0; Wed, 14 Jun 2017 21:57:10 -0700
From: David Reyna <david.reyna@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 14 Jun 2017 21:48:25 -0700
Message-ID: <cover.1497501996.git.David.Reyna@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-Originating-IP: [147.11.200.76]
Subject: [PATCH 0/1] toaster: sub-layer dependency matching
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
X-List-Received-Date: Thu, 15 Jun 2017 04:57:13 -0000
Content-Type: text/plain

From: David Reyna <David.Reyna@windriver.com>

Support layers directories with sub-layers (for example meta-intel).
Toaster surrently breaks when trying to exact match a dependency event for
that sub-layer against the top level layer directory paths.

The following changes since commit 6964efddd31c479386d1643c1025bc102710392f:

  bitbake: cooker: ensure graceful exit after exception during BuildCompleted handler (2017-06-14 14:54:25 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/sub_layer_fail_11149
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=dreyna/submit/dreyna/toaster/sub_layer_fail_11149

David Reyna (1):
  toaster: fail on layers with sub-layer

 lib/bb/ui/buildinfohelper.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

-- 
1.9.1


