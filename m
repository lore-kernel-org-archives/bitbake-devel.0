Received: from mail-qc0-f175.google.com ([209.85.216.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei@gherzan.ro>) id 1SoYaN-0005dW-T6
	for bitbake-devel@lists.openembedded.org;
	Tue, 10 Jul 2012 13:26:32 +0200
Received: by qcad10 with SMTP id d10so5685451qca.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 10 Jul 2012 04:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:cc:subject:date:message-id:x-mailer:x-gm-message-state;
	bh=2h+pciZb2+HVptKzd/8T8JqB4svfbCPScE5qL/RSMmU=;
	b=PdjyA2f44qFsVspGqUs7cJBMcgDHECiJCpnFl4wgfB95c5AqtLhTJWsxgcJuMopflG
	M63pOWAPKXrfzgsC40oAObL23/hJkDnujEDOckRU86+ekU4OOKPSLLGuhL7kIvJJVqVS
	ORgAM21gs6ZpRmcBp3zrrNgghmIL2uJuelYWEy8IHWfaaxIkGeq344dLHPXQjnXEYPKF
	XS8o0nTXnaCLSwLzP3d3j/wHfJuKjM6HpXm5ip2ylpF1Z9kEwl5l6E18zkrkmUqOOgCM
	N0i2ZDUfBCthBqh5nGC7f/Y5O2TX4JcyE7IRIGdpRW4pG9BZzzd1CDvBlc6zMnsYE0a+
	UlTQ==
Received: by 10.229.135.195 with SMTP id o3mr23564153qct.87.1341918920930;
	Tue, 10 Jul 2012 04:15:20 -0700 (PDT)
Received: from otp-agherzan-l1.corp.ad.wrs.com ([89.121.200.106])
	by mx.google.com with ESMTPS id fx5sm65157617qab.14.2012.07.10.04.15.18
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 10 Jul 2012 04:15:19 -0700 (PDT)
From: Andrei Gherzan <andrei@gherzan.ro>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 10 Jul 2012 14:15:10 +0300
Message-Id: <cover.1341918809.git.andrei@gherzan.ro>
X-Mailer: git-send-email 1.7.9.5
X-Gm-Message-State: ALoCoQl5Mw5Hu5eHUrBNMiD+baC9LBImr3UbkYu9eshzPpSpPOzg4/xNKybspslXJ8Db+nlGB5M4
Subject: [PATCH 0/5] Modify fetchers to warn user if "param" is used
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
X-List-Received-Date: Tue, 10 Jul 2012 11:26:32 -0000

Andrei Gherzan (5):
  fetch2/bzr.py: Use "protocol" parameter and warn user if recipe is
    using "proto"
  fetch2/git.py: Use "protocol" parameter and warn user if recipe is
    using "proto"
  fetch2/hg.py: Use "protocol" parameter and warn user if recipe is
    using "proto"
  fetch2/osc.py: Use "protocol" parameter and warn user if recipe is
    using "proto"
  fetch2/svn.py: Use "protocol" parameter and warn user if recipe is
    using "proto"

 bitbake/lib/bb/fetch2/bzr.py |    7 ++++++-
 bitbake/lib/bb/fetch2/git.py |    4 ++++
 bitbake/lib/bb/fetch2/hg.py  |    7 ++++++-
 bitbake/lib/bb/fetch2/osc.py |    7 ++++++-
 bitbake/lib/bb/fetch2/svn.py |    7 ++++++-
 5 files changed, 28 insertions(+), 4 deletions(-)

-- 
1.7.9.5



