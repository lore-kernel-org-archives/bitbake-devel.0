Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1TDk8q-0003Tu-N8
	for bitbake-devel@lists.openembedded.org;
	Tue, 18 Sep 2012 00:50:13 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id q8HMbXTd009865
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 17 Sep 2012 15:37:33 -0700 (PDT)
Received: from ord-lpggp2.wrs.com (128.224.65.244) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Mon, 17 Sep 2012 15:37:32 -0700
From: Jason Wessel <jason.wessel@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Mon, 17 Sep 2012 17:43:47 -0500
Message-ID: <1347921831-60604-1-git-send-email-jason.wessel@windriver.com>
X-Mailer: git-send-email 1.7.1
MIME-Version: 1.0
Subject: [PATCH 0/4] Add ability to auto spawn screen on a controlling terminal
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
X-List-Received-Date: Mon, 17 Sep 2012 22:50:13 -0000
Content-Type: text/plain

This is a series of 4 patches, 2 for bitbake and 2 for oe-core.  On
the bitbake side the idea is to have a new type of event which can
exec a command or print a log message if there is no controlling
terminal available.

When a controlling terminal is available the knotty UI can directly
execute the command on the controlling terminal, instead of printing
something, which occurs in all the other UI's.  What is really nice
about this is that you don't have to spawn screen in separate
terminals when you only want to use a single terminal to a build
server.

--
 lib/bb/event.py                  |    9 +++++++++
 lib/bb/ui/crumbs/progress.py     |    3 +++
 lib/bb/ui/crumbs/runningbuild.py |   15 +++++++++++++++
 lib/bb/ui/knotty.py              |   19 +++++++++++++++++++
 lib/bb/ui/ncurses.py             |    2 ++
 meta/classes/terminal.bbclass    |    4 ++--
 meta/lib/oe/terminal.py          |   33 +++++++++++++++++++--------------
 7 files changed, 69 insertions(+), 16 deletions(-)


