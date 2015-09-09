Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
	[209.85.220.42])
	by mail.openembedded.org (Postfix) with ESMTP id 4CACE73D27
	for <bitbake-devel@lists.openembedded.org>;
	Wed,  9 Sep 2015 02:38:01 +0000 (UTC)
Received: by pacfv12 with SMTP id fv12so144930757pac.2
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 08 Sep 2015 19:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=1nLhbUwyr7yyGjU5BdXapLvjITbZZ/6n43y0AzfBZmw=;
	b=Lp7jhtWMAk+8/A1lZiknOleeWKaDk5IXDDcrmAOZdA/Qsj/eR73AYGV3b6EtGOVv0t
	7uo9tGKEFLNnm+OZ2wC3Uv0Ot40kLDENUJUlkR6fe8Rdr5buctRLhhR59CT4u7ZfFfCH
	JT1S1GRPCm0FzTxcbpiMBww9wZf7ktQ+qA+K1Cn7Evwn0FN62t9T47cHfF6ejvogKcsX
	/D6EdLuaM1u22FH82d7d5qUR4fK8Dde9sduxBUTQ07NAp5sbrC3NmzhPBCCimmTpxoV/
	dUXY1j700UP7uSlXnmWW0/i1Ijp+ck0C8jG2YB+ndqPVu9UgCFx8rAFiINCYW607x0iI
	orAg==
X-Received: by 10.66.163.136 with SMTP id yi8mr2247994pab.124.1441766282102;
	Tue, 08 Sep 2015 19:38:02 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	dj5sm5013652pdb.27.2015.09.08.19.38.00
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 08 Sep 2015 19:38:01 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue,  8 Sep 2015 19:39:02 -0700
Message-Id: <cover.1441766166.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/1] increase waiting time for bitbake
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
X-List-Received-Date: Wed, 09 Sep 2015 02:38:02 -0000

this increases the time toaster waits for bitbake to start to 25 seconds

The following changes since commit db92bc23880794be77373b0f2d8c26279dcecb84:

  bitbake: toaster: replace ETA with % of tasks done (2015-09-08 23:54:15 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/ed/20150908_increase-waiting-time-bitbake
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/ed/20150908_increase-waiting-time-bitbake

Ed Bartosh (1):
  toaster: increase waiting time

 lib/toaster/bldcontrol/localhostbecontroller.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
1.9.1


