Return-Path: <Rob.Woolley@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 702F673745
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Feb 2015 14:32:24 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id t1REWPJL020133
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 27 Feb 2015 06:32:25 -0800 (PST)
Received: from yow-rwoolley-lx.wrs.com (128.224.146.40) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
	14.3.174.1; Fri, 27 Feb 2015 06:32:25 -0800
From: Rob Woolley <rob.woolley@windriver.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Fri, 27 Feb 2015 09:32:21 -0500
Message-ID: <1425047544-4820-1-git-send-email-rob.woolley@windriver.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Subject: [PATCH 0/3] knotty: Add automatic pager support
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
X-List-Received-Date: Fri, 27 Feb 2015 14:32:26 -0000
Content-Type: text/plain

The bitbake show_versions (-s) and show_environment (-e) commands provide
a lot of non-interactive output.  Even experienced users will sometimes
forget to page the output.

This series adds a feature to automatically page these commands when
using the knotty user interface.  It doesn't affect any other commands
and is designed to work in a similar fashion to the auto-paging in git.

This was tested with bitbake -s and bitbake -s | less (and -e) to ensure that
there were no regressions.  This includes testing broken pipe conditions
caused by quitting the pager before the full output has been sent through
the pipe.

knotty: Catch exceptions on broken pipes
 lib/bb/ui/knotty.py |   43 ++++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

knotty: Do not log show_versions output
 lib/bb/ui/knotty.py |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

knotty: Add automatic paging for bitbake -s and -e
 lib/bb/ui/knotty.py |   46 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

