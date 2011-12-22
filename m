Received: from ecbiz66.inmotionhosting.com ([69.174.114.20])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <juraj.hercek@jhksoftware.com>) id 1RdoLf-0000aG-Lm
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Dec 2011 20:30:39 +0100
Received: from mail.hck.sk ([87.197.106.197]:64952 helo=localhost.localdomain)
	by ecbiz66.inmotionhosting.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <juraj.hercek@jhksoftware.com>)
	id 1RdjWm-00083W-JX; Thu, 22 Dec 2011 09:21:48 -0500
From: Juraj Hercek <juraj.hercek@jhksoftware.com>
To: Bitbake Devel <bitbake-devel@lists.openembedded.org>
Date: Thu, 22 Dec 2011 15:21:11 +0100
Message-Id: <1324563672-26403-1-git-send-email-juraj.hercek@jhksoftware.com>
X-Mailer: git-send-email 1.7.2.5
X-AntiAbuse: This header was added to track abuse,
	please include it with any abuse report
X-AntiAbuse: Primary Hostname - ecbiz66.inmotionhosting.com
X-AntiAbuse: Original Domain - lists.openembedded.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - jhksoftware.com
Subject: [PATCH] Fix for git fetcher when using ssh URL with port specification
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
X-List-Received-Date: Thu, 22 Dec 2011 19:30:39 -0000

Hello,

bitbake failed to build a package which uses git fetcher to fetch repository
from ssh URL which contains also port specification. The patch in following
email fixes this issue.

Cheers,
Juraj

Juraj Hercek (1):
  fetch2/git: change colon to dot in ud.host

 lib/bb/fetch2/git.py |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

-- 
1.7.2.5



