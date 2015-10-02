Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
	[209.85.220.50])
	by mail.openembedded.org (Postfix) with ESMTP id ACF9D770C2
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Oct 2015 18:03:26 +0000 (UTC)
Received: by padhy16 with SMTP id hy16so112573303pad.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Oct 2015 11:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=Wencq9QCs0ldx5owZeHrc99YwN76KRSjA4AN1IkinTU=;
	b=cae/Xv4ddEx14FtoR5+XBA4VM6uSM/8ngLN/CMxisrXjQzVVlwPXQkchwmolM3GYpB
	NMY86ZHNaGj2Ekfrz9GpAMCsOphjbskQLr1aQlohZyKE84BiAhmUcXEZpb47S8Elhzrb
	DImGrhCxKo75ZJxoLa3GEvkHXndNkW36P3+cvSeWq86sI03fTiamLXC0yjtmA3gAiNVQ
	o5wZWCvRYQDMcouxpd6BP6G2Shicvxf4g5VjGTgXu0kkyvmeGDN0IoGPo8Oavm2unHxn
	AcsmLCCeyB0n7E6GiKmlbh/NMYq+ead64jwjPXF5Lgfm8RspirGJsm90WNDoqBjqB3ey
	Ek7A==
X-Received: by 10.68.137.202 with SMTP id qk10mr21639862pbb.30.1443809007141; 
	Fri, 02 Oct 2015 11:03:27 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	eu2sm13113718pbc.48.2015.10.02.11.03.26
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 02 Oct 2015 11:03:26 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri,  2 Oct 2015 11:05:09 -0700
Message-Id: <cover.1443809021.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/5] toaster:Add layer dependencies recursively #8004
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
X-List-Received-Date: Fri, 02 Oct 2015 18:03:32 -0000

This lets a layer that has 2nd level dependencies (depends on x that depends on y)        
have all the dependent layers added to your project, not just the 1st level deps.                                                                                                                                                  

-b                                                                                                                                                                                                                                 
The following changes since commit af1e3160922a30b8a538959335a5f8945f2f3549:

  toaster: Remove project name from latest project builds (2015-10-02 14:44:14 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/ed/2015-10-02_layerdeps-8004
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/ed/2015-10-02_layerdeps-8004

Ed Bartosh (5):
  toaster: implement API to get full list of deps
  toaster: use get_alldeps in layerdetails renderer
  toaster: fix NameError
  toaster: fix orm tests
  toaster: test get_alldeps API

 lib/toaster/orm/models.py       | 21 +++++++++++++++-
 lib/toaster/orm/tests.py        | 53 ++++++++++++++++++-----------------------
 lib/toaster/toastergui/views.py |  4 ++--
 3 files changed, 45 insertions(+), 33 deletions(-)

-- 
1.9.1


