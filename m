Return-Path: <andy.voltz@timesys.com>
Received: from exchange07.timesys.com (exchange07.timesys.com
	[209.114.137.116])
	by mail.openembedded.org (Postfix) with ESMTP id 6B2EA7292A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 19 Dec 2014 16:36:45 +0000 (UTC)
Received: from smarf.timesys.com (192.168.3.76) by exchange07.timesys.com
	(192.168.1.221) with Microsoft SMTP Server id 8.1.436.0;
	Fri, 19 Dec 2014 11:31:36 -0500
From: Andy Voltz <andy.voltz@timesys.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 19 Dec 2014 11:31:36 -0500
Message-ID: <1419006697-2588-1-git-send-email-andy.voltz@timesys.com>
X-Mailer: git-send-email 2.1.3
MIME-Version: 1.0
Subject: fix ncurses ui
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 19 Dec 2014 16:36:46 -0000
Content-Type: text/plain

I decided to give the ncurses ui a try, but found it was broken.

The following patch updates the ncurses module main function to
accept the configParams arg passed from bitbake.


