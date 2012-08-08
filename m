Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1Sz8tM-0006yC-IU
	for bitbake-devel@lists.openembedded.org;
	Wed, 08 Aug 2012 18:13:52 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q78G231U029815
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 8 Aug 2012 09:02:03 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Wed, 8 Aug 2012 09:02:03 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 8 Aug 2012 11:02:00 -0500
Message-ID: <cover.1344438893.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
MIME-Version: 1.0
Subject: [PATCH 0/2] Variable/include tracking (rebased)
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
X-List-Received-Date: Wed, 08 Aug 2012 16:13:53 -0000
Content-Type: text/plain

This is a set of changes so that "bitbake -e" will report a list of all
the files processed (and from what they were included), and prefix the
variable values with their assignment history.

The following changes since commit 23bd5300b4a99218a15f4f6b0ab4091d63a602a5:
  Richard Purdie (1):
        data_smart: Fix unanchored regexp causing strange parsing issue

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib seebs/ntracking
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=seebs/ntracking

Peter Seebach (2):
  data_smart.py: Provide (optional) logging of variable modifications
  data_smart.py: Track configuration file inclusions

 lib/bb/cooker.py         |    2 +
 lib/bb/data.py           |   65 +++++++++++++++++-----
 lib/bb/data_smart.py     |  140 +++++++++++++++++++++++++++++++++++++--------
 lib/bb/parse/__init__.py |    6 ++-
 lib/bb/parse/ast.py      |   65 ++++++++++++----------
 5 files changed, 209 insertions(+), 69 deletions(-)



