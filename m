Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1ShQ17-00052R-Av
	for bitbake-devel@lists.openembedded.org;
	Wed, 20 Jun 2012 20:52:38 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q5KIfa84001635
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 20 Jun 2012 11:41:36 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Wed, 20 Jun 2012 11:41:36 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 20 Jun 2012 13:41:33 -0500
Message-ID: <cover.1340217563.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
MIME-Version: 1.0
Subject: [PATCH 0/2] File inclusion and variable assignment tracking
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
X-List-Received-Date: Wed, 20 Jun 2012 18:52:38 -0000
Content-Type: text/plain

This is the assignment/inclusion tracking stuff I've had floating
around.  In further testing, I found one missing [1] that made it
fail for "bitbake -e [specific package]".  Haven't had any other
troubles with it.

This could totally use improvement, but I think this has reached a
point where:
1.  It's more useful to have it than not.
2.  It will be better improved by feedback from live usage.

Impact outside of the bitbake -e case is basically nil, and in the
-e case it's a HUGE improvement in usability.

The following changes since commit d316f28ed725ff40daa8771c1aa224ac46d5b224:
  Richard Purdie (1):
        methodpool: Improve method already seen error message

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



