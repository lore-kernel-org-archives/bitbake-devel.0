Return-Path: <sam.thursfield@codethink.co.uk>
Received: from ducie-dc1.codethink.co.uk (ducie-dc1.codethink.co.uk
	[185.25.241.215])
	by mail.openembedded.org (Postfix) with ESMTP id F0FC376DA6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Aug 2015 15:55:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTP id 93961461C06
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Aug 2015 16:45:48 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at ducie-dc1.codethink.co.uk
Received: from ducie-dc1.codethink.co.uk ([127.0.0.1])
	by localhost (ducie-dc1.codethink.co.uk [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id GBWZwZHopCTs for <bitbake-devel@lists.openembedded.org>; 
	Fri, 28 Aug 2015 16:45:46 +0100 (BST)
Received: from droopy.dyn.ducie.codethink.co.uk (unknown [10.24.1.220])
	by ducie-dc1.codethink.co.uk (Postfix) with ESMTPSA id 741EC4607B0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Aug 2015 16:45:46 +0100 (BST)
From: Sam Thursfield <sam.thursfield@codethink.co.uk>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 28 Aug 2015 16:45:39 +0100
Message-Id: <1440776740-26875-1-git-send-email-sam.thursfield@codethink.co.uk>
X-Mailer: git-send-email 2.4.3
Subject: Research into exporting BitBake recipes for consumption elsewhere
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
X-List-Received-Date: Fri, 28 Aug 2015 15:55:50 -0000

Hi

I wrote a proof-of-concept patch which lets you export all the tasks
from a BitBake project, as actual executable shell and Python scripts.
I'm sharing it here to see if anyone is interested in this sort of
thing, and to see if anyone reading can point out obvious improvements
that I haven't spotted.

This is the first time I've hacked on BitBake's internals, so this code
has quite a lot of room for improvement :-) Exporting is slow (~10
mins), blocks the 'cooker' process completely while it runs, and causes
BitBake to hang once it's finished. But, the generated scripts do
actually work, which is what motived me to share the results.

The goal of this is to have a tool for 'flattening' a set of recipes,
which I think is useful when reasoning about what they actually do.

Right now it produces almost 3GB of output for my test project. This is
mostly because the entire data dict is dumped for each .py file. I've
looked at deduplicating, but my naive implementation was incredibly slow
(checking each variable in the dict for each task dump), and I've not
thought of a more clever approach.

Anyway, I hope this is interesting to someone; I may be able to spend
some time turning it into a viable patch, if there is interest.

Sam

Sam Thursfield (1):
  Make an '--export-tasks' option

 bitbake/lib/bb/cooker.py     |  15 +-
 bitbake/lib/bb/cookerdata.py |   9 +
 bitbake/lib/bb/data.py       |   9 +-
 bitbake/lib/bb/export.py     | 426 +++++++++++++++++++++++++++++++++++++++++++
 bitbake/lib/bb/main.py       |   3 +
 bitbake/lib/bb/runqueue.py   |  11 ++
 6 files changed, 471 insertions(+), 2 deletions(-)
 create mode 100644 bitbake/lib/bb/export.py

-- 
2.4.3


