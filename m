Received: from anubis.se.axis.com ([195.60.68.12])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <olof.johansson@axis.com>) id 1UZeO0-0000Ui-FW
	for bitbake-devel@lists.openembedded.org;
	Tue, 07 May 2013 11:40:42 +0200
Received: from localhost (localhost [127.0.0.1])
	by anubis.se.axis.com (Postfix) with ESMTP id 191A219DDE
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 May 2013 11:22:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at anubis.se.axis.com
Received: from anubis.se.axis.com ([127.0.0.1])
	by localhost (anubis.se.axis.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1UPwKpWoT+7y for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 May 2013 11:22:39 +0200 (CEST)
Received: from boulder.localdomain (boulder.se.axis.com [10.0.2.104])
	by anubis.se.axis.com (Postfix) with ESMTP id 278A619D19
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 May 2013 11:22:39 +0200 (CEST)
Received: from boulder.localdomain (localhost [127.0.0.1])
	by postfix.imss71 (Postfix) with ESMTP id F05698A5
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 May 2013 11:22:38 +0200 (CEST)
Received: from seth.se.axis.com (seth.se.axis.com [10.0.2.172])
	by boulder.localdomain (Postfix) with ESMTP id E58FE74F
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 May 2013 11:22:38 +0200 (CEST)
Received: from xmail2.se.axis.com (xmail2.se.axis.com [10.0.5.74])
	by seth.se.axis.com (Postfix) with ESMTP id E44503E052
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  7 May 2013 11:22:38 +0200 (CEST)
Received: from lnxolofjn.se.axis.com (10.92.17.1) by xmail2.se.axis.com
	(10.0.5.74) with Microsoft SMTP Server id 8.2.176.0;
	Tue, 7 May 2013 11:22:38 +0200
Received: by lnxolofjn.se.axis.com (Postfix, from userid 20466)	id AF17F9C07C; 
	Tue,  7 May 2013 11:22:38 +0200 (CEST)
From: Olof Johansson <olof.johansson@axis.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Tue, 7 May 2013 11:22:36 +0200
Message-ID: <1367918558-16136-1-git-send-email-olof.johansson@axis.com>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Subject: [WIP 0/2] Adding support for shell arithmetics
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
X-List-Received-Date: Tue, 07 May 2013 09:40:55 -0000
X-List-Received-Date: Tue, 07 May 2013 09:40:55 -0000
Content-Type: text/plain

Hi,

A week or so I found out that shell fragments in bitbake recipes
don't support shell arithmetics (`$((1+1))`). The reason for this
is the shell lexing throwing NotImplemented exceptions. I've made
some progress in adding support for shell arithmetics, but I have
a hard time getting support for corner cases.

It was suprising to see that currently, only a subset of posix
shell scripts is supported, even though they are sent through to
be executed by the system shell. I think I understand the reason
for having to do the shell lexing; knowing what functions and
variables to export right? But I wonder if it's possible to do
the shell lexing as a best effort, and ignore any errors.

What are the risks with this approach? Is it feasibile to do so?

This patch series is a work in progress, and does support the use
cases we had issues with, however, I currently skip one unit
test, as I can't get it to work. Comments and feedback much
appreciated!

The branch is also pushed to github at:

 https://github.com/olof/bitbake/tree/topic/shlex_shell_arith

Olof Johansson (2):
  pysh: Say what kind of token isn't implemented
  initial work on supporting shell arith

 bin/bitbake-selftest       |    1 +
 lib/bb/pysh/pyshlex.py     |   48 ++++++++++++++++--
 lib/bb/tests/codeparser.py |   22 ++++++++
 lib/bb/tests/pysh.py       |  119 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 186 insertions(+), 4 deletions(-)
 create mode 100644 lib/bb/tests/pysh.py

-- 
1.7.10.4



