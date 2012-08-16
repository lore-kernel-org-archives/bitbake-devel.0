Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1T1oqr-0005sk-6k
	for bitbake-devel@lists.openembedded.org;
	Thu, 16 Aug 2012 03:26:21 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q7G1EM4a022933
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Aug 2012 18:14:23 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Wed, 15 Aug 2012 18:14:23 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Wed, 15 Aug 2012 20:14:20 -0500
Message-ID: <cover.1345079338.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
MIME-Version: 1.0
Subject: [PATCH 0/2] variable/include tracking and _remove
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
X-List-Received-Date: Thu, 16 Aug 2012 01:26:21 -0000
Content-Type: text/plain

These aren't entirely related, but I don't think I could get
the _remove feature separated out cleanly, and there was no way
I could implement it on a tree without the variable tracking. :)

Patch #1 is a rebase/merge/cleanup of the variable and include tracking
feature I've previously sent in; this version is much cleaned up,
and produces a lot less output (<1MB instead of >10MB for a typical
project in our build system) which is substantially more informative.

Patch #2 is a proof-of-concept demonstration of how to make a _remove
keyword. Usage:

        DUMMY = "foo"
        DUMMY += "bar"
        DUMMY_remove = "foo"
        # DUMMY="bar"

This only works for space-separated lists, but we have a LOT of those.
The only obvious things I see that really are lists, and aren't
space-separated, are OVERRIDES and PATH, and I'm pretty sure that
we don't *need* to remove things from those.

The following changes since commit 23bd5300b4a99218a15f4f6b0ab4091d63a602a5:
  Richard Purdie (1):
        data_smart: Fix unanchored regexp causing strange parsing issue

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib seebs/remove
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=seebs/remove

Peter Seebach (2):
  data_smart.py: track file inclusion and variable modifications
  data_smart.py: implement _remove as a keyword like _append.

 lib/bb/cooker.py                     |    2 +
 lib/bb/data.py                       |   65 ++++++++--
 lib/bb/data_smart.py                 |  220 +++++++++++++++++++++++++++-------
 lib/bb/parse/__init__.py             |    6 +-
 lib/bb/parse/ast.py                  |   76 +++++++-----
 lib/bb/parse/parse_py/ConfHandler.py |    6 +-
 6 files changed, 286 insertions(+), 89 deletions(-)



