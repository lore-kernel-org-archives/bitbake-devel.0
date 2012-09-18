Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1TDnTq-0007Ui-UJ
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 04:24:07 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q8I2BQAo011556
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Sep 2012 19:11:27 -0700 (PDT)
Received: from localhost.localdomain (172.25.34.64) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Mon, 17 Sep 2012 19:11:26 -0700
From: Peter Seebach <peter.seebach@windriver.com>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Sep 2012 21:11:23 -0500
Message-ID: <cover.1347933709.git.peter.seebach@windriver.com>
X-Mailer: git-send-email 1.7.0.4
MIME-Version: 1.0
Subject: v4 or so [PATCH 0/2] variable/include tracking: revised
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
X-List-Received-Date: Tue, 18 Sep 2012 02:24:07 -0000
Content-Type: text/plain

This is a revision of the variable/include tracking stuff. The first
patch adds include tracking, the second adds variable tracking on top of
it.

I am a little unsure about some of this. The big design issue I ran into
is that I often wanted to specify the name of the variable being passed,
but that if I passed a **loginfo containing a 'var' key, this clashed with
the positional 'var' parameter. So I changed the name to 'variable'. I also
made the inference code smarter; it can guess at variable name and value
in common cases, reducing typing. Similarly, there is no longer a need
for an explicit 'ignore'; rather, if the keyword dictionary is empty,
'ignore' is assumed. (It can still be specified explicitly if we find
an exception, such as a case where we often but not always want to record
an operation.)

There's a lot of things that could likely be improved with this; my
starting point was to make it produce basically the same results as the
previous patch set, then clean up the output quite a bit. So reporting
on overrides and _append/_prepend overrides is smarter now, output
format is cleaned up a bit, and so on.

Feedback welcome, as always. There may be some loose ends left over from
things I tried and then abandoned; I've tried to catch them all, but the
code's all blurred together for me at this point. Sending it out in part
because I suspect people might want to mess with this a bit, or give feedback.

The following changes since commit ac75b06744e73399ca1fbda322ef851ae5754b0a:
  Valentin Popa (1):
        Implement 'settings' dialog as designed

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib seebs/incvar
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=seebs/incvar

Peter Seebach (2):
  data_smart.py and friends: Track file inclusions for bitbake -e
  data_smart.py and friends: Track variable history

 lib/bb/cooker.py                   |   15 +++-
 lib/bb/data.py                     |   28 ++++-
 lib/bb/data_smart.py               |  216 ++++++++++++++++++++++++++++++++----
 lib/bb/parse/__init__.py           |    3 +-
 lib/bb/parse/ast.py                |   25 ++++-
 lib/bb/parse/parse_py/BBHandler.py |    6 +-
 6 files changed, 257 insertions(+), 36 deletions(-)



