Return-Path: <danismostlikely@gmail.com>
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com
	[209.85.213.182])
	by mail.openembedded.org (Postfix) with ESMTP id 964FD756CB
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Jun 2015 16:01:05 +0000 (UTC)
Received: by igbyr2 with SMTP id yr2so90486134igb.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 02 Jun 2015 09:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:subject:date:message-id;
	bh=zvh5GV4i/VPyR4FPcg7Hn8h7lgfyVl9ZqkLg9pRRC8Y=;
	b=ZJwYQQTq9y3bJxgG0fiOA82dXdIUvvNVusKkcRrSP7xsQMRff/pX9Sk7Q29omyRt5k
	Y2z79YYHAQWWKT7jlvGSuyq14ue+LNSWKu9qpcSKyembFmWNQ808aKkfVrSudeNnliRb
	laC6qwQpD7+v483Qk4sX9TwgrUVr3H++2U8wMLRZ6L8cvkord9JKDZxABO+1q0XQn1Z/
	jan3ILF+YKOjzC1LBOjbL4tqWmUdj8dxExJlbwO9YpBM9pRoZNBb/sAQJzPq4srH5T2Z
	+kQI0mb6vTulOu4RIBOyhbMAhmagdzE/OzpWoeC2erqL1R5+2tDg99LMzGuXOOPNXspJ
	4cnQ==
X-Received: by 10.50.50.98 with SMTP id b2mr20813281igo.42.1433260866190;
	Tue, 02 Jun 2015 09:01:06 -0700 (PDT)
Received: from mediabox.local (71-17-233-74.sktn.hsdb.sasknet.sk.ca.
	[71.17.233.74]) by mx.google.com with ESMTPSA id
	137sm12763178ioo.29.2015.06.02.09.01.05
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 02 Jun 2015 09:01:05 -0700 (PDT)
From: Dan McGregor <danismostlikely@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  2 Jun 2015 10:00:59 -0600
Message-Id: <1433260860-4674-1-git-send-email-danismostlikely@gmail.com>
X-Mailer: git-send-email 2.4.0
Subject: RFC: hg fetcher improvements
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
X-List-Received-Date: Tue, 02 Jun 2015 16:01:07 -0000

I've made some more changes to the Mercurial fetcher. I'd like
feedback on my changes; they're not that minor. I've made it
always fetch the full repo, and share the repo with the checkouts
in WORKDIR, just like the git fetcher.

The most important change, I think, is that it generates a Mercurial
bundle of the repository for the mirrors. Do people thing that's a good
idea, or should I switch it to creating a tarball of the hg repository
like git does?


