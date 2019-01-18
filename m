Return-Path: <kergoth@gmail.com>
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
	[209.85.128.54])
	by mail.openembedded.org (Postfix) with ESMTP id 5BDB17C26B
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2019 16:46:02 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id r24so1385697wmh.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 18 Jan 2019 08:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id;
	bh=fTQ68TpcSbjF4iLl1POtZ29HEmwdgxa8D9SJR9jLMxA=;
	b=sQBdAGRpfHdIkuOeownVXtDiVOVM5xS2xYZuHocLyzMgumQzVB+dtpaH+LzdwsXSmV
	rLeWBFmBacmvRzh7UY8eDqbacG/IcslogmIsCyEBmNzEIBspeIdtCJwTNVhK7epEfe+z
	TB/Mb/+rS7zG06lcpjd4xOf2S9RnwwFd4VUP+GWNkWaLJJ5Qvm0WZHxSLCOuBwK8NWBZ
	Qc8oSuu+XBS/tz2GCfuvQGjp5eMoMCFraX+CSFqipeWR6gZwAIHwScMfx5NQ0BOxLweX
	v+HRxDL2lFy8k/PWMKaMPIf77NlkeyKRzOiirNCdckYXMQsY/ToXLaWaCGiyzWwCRfKQ
	O6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=fTQ68TpcSbjF4iLl1POtZ29HEmwdgxa8D9SJR9jLMxA=;
	b=Iogi7InIFRp9mLRq8FUq30GskfSZQphlE58SwKtQNCgFrKirBol9Iv+HvlmcdhyGtd
	WtA+rRV4Zj8/tOcGiMJ685gXQdE467o6X2jUGlFqcoZ/jpUlvpkgs1+pc4rosyn4xh/T
	BG7NcBIx2Elj8TrBO0L114zHX18m82X/OJehIsrL5DB/bFVLs0X0K0j52Hy+C5lMjjOR
	6zq28zk4xyiimD4E0r943gHBrET0lb+wr1c9PQnWlkETpNDboIqsSO3OuLqrNmHhyJp+
	EgI/KpjeGTA19txn2dQLYo121cwG99NGaF5/85BnZfGdNMIldg53JnyCh4tF0eqYN1bK
	ITsA==
X-Gm-Message-State: AJcUukf6fciBTC0cNLfOZvAwcEv6t/Oj20w2umOsmqp2MZS6wdNeja62
	p+0Ge2XrD1QZZ1vCFb5XcowNAYEj
X-Google-Smtp-Source: ALg8bN6nYg/IsElLqONuabspba0BTN2gMM4jrX0DMMIXoVX0KoNcns04KKfsfCTWb3mUioFBZqPFNg==
X-Received: by 2002:a1c:6442:: with SMTP id y63mr15607015wmb.143.1547829962467;
	Fri, 18 Jan 2019 08:46:02 -0800 (PST)
Received: from svr-pkl-eng-07.mgc.mentorg.com ([110.93.212.98])
	by smtp.gmail.com with ESMTPSA id
	b7sm78523175wrs.47.2019.01.18.08.46.00
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 08:46:01 -0800 (PST)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 18 Jan 2019 21:45:53 +0500
Message-Id: <cover.1547829050.git.chris_larson@mentor.com>
X-Mailer: git-send-email 2.11.1
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCH 0/2] Only try to expand refs to valid variable names
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
X-List-Received-Date: Fri, 18 Jan 2019 16:46:02 -0000

From: Christopher Larson <chris_larson@mentor.com>

This aligns the behavior of expansion with the recipe parser, only
attempting to expand references to valid variable names. This avoids
adding references for things like `${foo#${TOPDIR}}` to our vardeps
without imposing much additional processing overhead beyond the change
to the expansion regexp.

YOCTO #12987

The following changes since commit 610dbee5634677f5055e2b36a3043cd197fb8c51:

  gitsm.py: Refactor the functions and simplify the class (2019-01-15 22:22:29 +0000)

are available in the Git repository at:

  git@github.com:kergoth/bitbake yocto-12987-new

for you to fetch changes up to 9cb64e9781c98f1aaa42571af54655eaf6816583:

  bb.tests.codeparser: add parameter expansion modifiers test (2019-01-16 19:46:10 +0000)

----------------------------------------------------------------
Christopher Larson (2):
      bb.data_smart: only try to expand refs to valid variable names
      bb.tests.codeparser: add parameter expansion modifiers test

 lib/bb/data_smart.py       | 2 +-
 lib/bb/tests/codeparser.py | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

-- 
2.17.1


