Return-Path: <akuster808@gmail.com>
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com
	[209.85.215.194])
	by mail.openembedded.org (Postfix) with ESMTP id A52706BF38
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 23 Mar 2019 01:40:35 +0000 (UTC)
Received: by mail-pg1-f194.google.com with SMTP id i2so2633798pgj.11
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 22 Mar 2019 18:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:subject:date:message-id;
	bh=WW//cmwMK0B/Ug/YhVNOAk7GajI7EcRhH7OITh7eLt0=;
	b=lELvdnY5AECI+USXPCxYjq9LWXUrRZe3GGkioKtjQMZ4AYocvehk1+ywOyqq/YhK8Q
	saLt+GtQXUjyjPlrvegXZ11c/05AU7AvLveTBTb3B+7JVft08gf7CR5FBdMRthFfixUN
	Qm/rGyXYU9S873r00ci2LFhj4a9+Nphafd/THhPICYWWo6pb0aE9Py8KUcd5YXNXWTrs
	BCe3amWVliSZ5idX8YQMJZR3daV7uj8Df21Ri4lSnh6n/MCpw+mTIxw60XkICTgIy0y1
	+cegLAKG/sznhTePex9sDOQMXAyeLsPHCGLBLf/RqpyILuW0hQNkvYdJdmvf15+OKRAj
	nZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=WW//cmwMK0B/Ug/YhVNOAk7GajI7EcRhH7OITh7eLt0=;
	b=LzgehQRCvyJa7mrrOUqM73A5BpNM4Qyan1Vyw/UOilpzZ8haAPStYq9C13wiO+SHQS
	qMTYmj318WLdILBrHoWKVGnFF7IsW5BOX/JMucU3yu3CNluRCaZffr9a1EGRe819vGnk
	S3teGFZtezw0fkhkgi5IxQTYihW4IHYW8HJFNBDQu6O5XLcx/r6RlXe1hM4DrLc70Lt4
	UJLK30EowyuJLA6FP0l4vlkg+V4rmiLwme+aSYMw3vzUjX5mZY2pDZNiXvjdGUIZGkxO
	aOMUZOmQkDDfYibioNef5X3jI6N/cnCy0XxCWokC3E5fIKX5fDSbNQMoG6Of0kdsT2QW
	XdFQ==
X-Gm-Message-State: APjAAAWkFEddCvqRcVu6QIali7QsuitElo5kcm19JDEmpVnQn8tdyhX9
	MlqwnL0HAdZEbcjaVD2e+5wgpu2h
X-Google-Smtp-Source: APXvYqyC+fM3bhADLEqwhKYeJyCPbdiZx0chG7fMaQ1y4tQzX7VIa/MnliUvgntjH31zrA/94mh3Zw==
X-Received: by 2002:a62:a515:: with SMTP id v21mr4720333pfm.41.1553305236516; 
	Fri, 22 Mar 2019 18:40:36 -0700 (PDT)
Received: from akuster-ThinkPad-T460s.mvista.com
	([2601:202:4180:c33:45a8:35fd:6c1a:9e02])
	by smtp.gmail.com with ESMTPSA id
	n24sm21166390pfi.123.2019.03.22.18.40.35
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 22 Mar 2019 18:40:35 -0700 (PDT)
From: Armin Kuster <akuster808@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 22 Mar 2019 18:40:23 -0700
Message-Id: <cover.1553304939.git.akuster808@gmail.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 00/10] 1.40 pull request
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
X-List-Received-Date: Sat, 23 Mar 2019 01:40:35 -0000

Please consider this changes for the next 1.40 release

The following changes since commit b59cb2bc63940b9ebd8288de7ca4b1d9e96e026c:

  cooker: Tweak multiconfig dependency resolution (2019-02-25 22:32:38 +0000)

are available in the git repository at:

  git://git.openembedded.org/bitbake-contrib stable/1.40-next
  http://cgit.openembedded.org/bitbake-contrib/log/?h=stable/1.40-next

Mark Hatle (10):
  gitsm.py: Fix when a submodule is defined, but not initialized
  gitsm.py: Add support for alternative URL formats from submodule files
  tests/fetch.py: Add alternative gitsm test case
  gitsm.py: Optimize code and attempt to resolve locking issue
  gitsm.py: revise unpack
  gitsm.py: Rework the shallow fetcher and test case
  gitsm.py: Refactor the functions and simplify the class
  gitsm.py: Fix relative URLs
  gitsmy.py: Fix unpack of submodules of submodules
  gitsm: The fetcher did not process some recursive submodules properly.

 lib/bb/fetch2/gitsm.py | 253 ++++++++++++++++++++-----------------------------
 lib/bb/tests/fetch.py  |  70 +++++++++++++-
 2 files changed, 172 insertions(+), 151 deletions(-)

-- 
2.7.4


