Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1SzFiv-0005Qt-7J
	for bitbake-devel@lists.openembedded.org;
	Thu, 09 Aug 2012 01:31:33 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q78NJhDT001655
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 8 Aug 2012 16:19:43 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Wed, 8 Aug 2012 16:19:43 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 8 Aug 2012 18:19:41 -0500
Message-ID: <cover.1344467794.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
MIME-Version: 1.0
Subject: [PATCH 0/1] cooker.py: disignore explicitly requested packages
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
X-List-Received-Date: Wed, 08 Aug 2012 23:31:33 -0000
Content-Type: text/plain

It turns out that ASSUMED_PROVIDED trumps command-line. This is surprising,
and more so because there is no diagnostic; the user is not told "this
package is being ignored", you just get told that 0 out of 0 tasks were
run, and all succeeded. We could add a diagnostic, but really, it seems as
though it makes sense to trust the user; a user who really wants to build
bzip2-native even though it is presumably provided by the host probably has
reasons. (Note: "The test plan says..." is a reason.)

The following changes since commit 23bd5300b4a99218a15f4f6b0ab4091d63a602a5:
  Richard Purdie (1):
        data_smart: Fix unanchored regexp causing strange parsing issue

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib seebs/cooker
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=seebs/cooker

Peter Seebach (1):
  cooker.py: Remove explicit build targets from the ignored list

 lib/bb/cooker.py |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)



