Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1TM4i9-0000cx-SB
	for bitbake-devel@lists.openembedded.org;
	Thu, 11 Oct 2012 00:25:06 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q9AMBtYj002724
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Oct 2012 15:11:55 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Wed, 10 Oct 2012 15:11:54 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Wed, 10 Oct 2012 17:11:53 -0500
Message-ID: <cover.1349907036.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
MIME-Version: 1.0
Subject: [PATCH 0/1] build.py: Emit meaningful errors when exiting automatically
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Wed, 10 Oct 2012 22:25:06 -0000
Content-Type: text/plain

The behavior of "set -e" has flaws, the biggest of which is that
the exit is silent. Add an exit handler to run.* scripts so that the
failure will be diagnosed meaningfully.

The following changes since commit 90fd57ee3cb2856c10bda1f5af4879d2b7cf2668:
  Cristiana Voicu (1):
        hob/imageconfigurationpage: a 'hob-image' appears listed in the base image combo box

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib seebs/errors
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=seebs/errors

Peter Seebach (1):
  build.py: Provide useful diagnostics when exiting.

 lib/bb/build.py |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)



