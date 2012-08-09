Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1SzZRl-0005jA-1H
	for bitbake-devel@lists.openembedded.org;
	Thu, 09 Aug 2012 22:35:09 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q79KNJGk018818
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 9 Aug 2012 13:23:19 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Thu, 9 Aug 2012 13:23:18 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 9 Aug 2012 15:23:15 -0500
Message-ID: <cover.1344543257.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
MIME-Version: 1.0
Subject: [PATCH 0/3] Variable tracking: Cleaned up and less buggy
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
X-List-Received-Date: Thu, 09 Aug 2012 20:35:09 -0000
Content-Type: text/plain

So, I finally got around to looking at a couple of "hmm, that looks
funny" thoughts I had about the variable tracking, and went and cleaned
things up. Appends were being reported twice in many cases, but also
they were reporting ever-increasing stuff for large values; in my
build tree, the output for BBCLASSEXTEND *alone* was 10MB. (!!)

So to summarize:

-rw-r--r-- 1 seebs seebs 11078986 2012-08-09 13:09 bitbake-e.prepatch
-rw-r--r-- 1 seebs seebs   635832 2012-08-09 15:02 bitbake-e.postpatch

Of these files, the second contains more actual information about how
variables got set.

I've left the old patch alone and done this as a new patch. I could
merge them, but I figure anyone who's been using the old patch would
like to have a patch that can be applied on top of it. :)

The following changes since commit 23bd5300b4a99218a15f4f6b0ab4091d63a602a5:
  Richard Purdie (1):
        data_smart: Fix unanchored regexp causing strange parsing issue

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib seebs/ntracking
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=seebs/ntracking

Peter Seebach (3):
  data_smart.py: Provide (optional) logging of variable modifications
  data_smart.py: Track configuration file inclusions
  data_smart.py: Fix variable tracking

 lib/bb/cooker.py                     |    2 +
 lib/bb/data.py                       |   65 ++++++++++---
 lib/bb/data_smart.py                 |  177 +++++++++++++++++++++++++++-------
 lib/bb/parse/__init__.py             |    6 +-
 lib/bb/parse/ast.py                  |   70 ++++++++------
 lib/bb/parse/parse_py/ConfHandler.py |    4 +-
 6 files changed, 243 insertions(+), 81 deletions(-)



