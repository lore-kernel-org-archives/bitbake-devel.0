Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1SWUPa-0001Jc-BI
	for bitbake-devel@lists.openembedded.org;
	Mon, 21 May 2012 17:20:42 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q4LFAXpY014884
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 21 May 2012 08:10:33 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Mon, 21 May 2012 08:10:33 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 21 May 2012 10:10:30 -0500
Message-ID: <cover.1337612802.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
MIME-Version: 1.0
Subject: v2 [PATCH 0/2] data_smart.py: Track inclusions and assignments
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
X-List-Received-Date: Mon, 21 May 2012 15:20:42 -0000
Content-Type: text/plain

This revised patch now uses Python's traceback facility to assign
meaningful locations (file and function, rather than line) to operations
which weren't specified, and correspondingly does not specify file and
line when the file name would have been the python code making the
assignment; this makes the patch smaller and the output more meaningful.

As before, this is a patch to add tracking showing when and how variables
got their values, and which configuration files were included from which
other configuration files.

The following changes since commit 39adb5741d9eee0879d3181be505400dffc60804:
  Andrei Gherzan (1):
        bb/fetch2/__init__.py: Don't try to compute checksums for directories

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib seebs/tracking
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=seebs/tracking

Peter Seebach (2):
  data_smart.py: Provide (optional) logging of variable modifications
  data_smart.py: Track configuration file inclusions

 lib/bb/cooker.py         |    2 +
 lib/bb/data.py           |   65 +++++++++++++++++-----
 lib/bb/data_smart.py     |  140 +++++++++++++++++++++++++++++++++++++--------
 lib/bb/parse/__init__.py |    6 ++-
 lib/bb/parse/ast.py      |   65 ++++++++++++----------
 5 files changed, 209 insertions(+), 69 deletions(-)



