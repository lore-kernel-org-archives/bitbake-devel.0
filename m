Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1TLIcT-0007qW-Sw
	for bitbake-devel@lists.openembedded.org;
	Mon, 08 Oct 2012 21:04:02 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q98Iopkp013945
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 8 Oct 2012 11:50:53 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Mon, 8 Oct 2012 11:50:51 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 8 Oct 2012 13:50:49 -0500
Message-ID: <cover.1349721987.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
MIME-Version: 1.0
Subject: v5 [PATCH 0/2] variable history and file inclusion tracking
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
X-List-Received-Date: Mon, 08 Oct 2012 19:04:02 -0000
Content-Type: text/plain

This fixes one straight up bug (wrong kind of empty container literal)
and improves clarity of messages in a number of cases by reporting who
called finalize when a finalize() operation applies overrides. Fully
supporting that for oe-core would require a couple of tweaks in oe-core,
but this improves output regardless.

The following changes since commit 90fd57ee3cb2856c10bda1f5af4879d2b7cf2668:
  Cristiana Voicu (1):
        hob/imageconfigurationpage: a 'hob-image' appears listed in the base image combo box

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib seebs/incvar
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=seebs/incvar

Peter Seebach (2):
  data_smart.py and friends: Track file inclusions for bitbake -e
  data_smart.py and friends: Track variable history

 lib/bb/cooker.py                   |   15 ++-
 lib/bb/data.py                     |   34 +++++-
 lib/bb/data.pyc                    |  Bin 0 -> 14383 bytes
 lib/bb/data_smart.py               |  235 ++++++++++++++++++++++++++++++++----
 lib/bb/data_smart.pyc              |  Bin 0 -> 21279 bytes
 lib/bb/parse/__init__.py           |    3 +-
 lib/bb/parse/ast.py                |   25 +++-
 lib/bb/parse/parse_py/BBHandler.py |    6 +-
 8 files changed, 281 insertions(+), 37 deletions(-)
 create mode 100644 lib/bb/data.pyc
 create mode 100644 lib/bb/data_smart.pyc



