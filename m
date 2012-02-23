Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <bruce.ashfield@windriver.com>) id 1S0g2K-0005Dz-KU
	for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 22:17:12 +0100
Received: from yow-bashfiel-l1.corp.ad.wrs.com
	(yow-bashfiel-d3.ottawa.windriver.com [128.224.147.67])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q1NL8lOt023655;
	Thu, 23 Feb 2012 13:08:47 -0800 (PST)
From: Bruce Ashfield <bruce.ashfield@windriver.com>
To: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
Date: Thu, 23 Feb 2012 16:08:41 -0500
Message-Id: <1330031322-22689-1-git-send-email-bruce.ashfield@windriver.com>
X-Mailer: git-send-email 1.7.4.1
Subject: fetch2/git: create bareclone option
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
X-List-Received-Date: Thu, 23 Feb 2012 21:17:13 -0000

Hi all,

The web interface to the bitbake devel list seems to be down, so
I couldn't do my customary research into who/where to send a patch.
I'm sending this off anyway to see if there are any comments
that I need to address.

I worked on this via oe-core/yocto, but I've also tested it on my
local bitbake clone.

The patch header pretty much says it all. I've got some follow up
patches to my kernel work in yocto, but this part is standalone
and should be safe everywhere.

Cheers,

Bruce



