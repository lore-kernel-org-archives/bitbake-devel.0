Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f47.google.com (mail-wm0-f47.google.com [74.125.82.47])
	by mail.openembedded.org (Postfix) with ESMTP id 1CD8960722
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 14:19:08 +0000 (UTC)
Received: by mail-wm0-f47.google.com with SMTP id i5so28393108wmg.0
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Jul 2016 07:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id;
	bh=Fwt273brT04uhXhd1y1YBHaIEdbLCO/u2Uc3OMC/J/0=;
	b=nL5jVo+LSBYjEvF11EwqjEpT5IFAZlHNGrnwNiE57C2Z7FLolNvn06P3JGbonGmwLf
	lvJGkzYUqbGegRPidx3rGArz4SRPZ4pvHO9KzBjO6K3pBdvjsbfXVmzZ72b9EZinEt+o
	X4p9oUNi9gYlhjGUa2qBbmUUg/HgqYwCEbe+YDQtO2i4/rAzKFalEz1a3r5jF6UfaUbe
	WDtkaFOEG9ZIMoor4N3NC/jjRGwMYjSwRK6yo5DNgskgB85jVc1vqYcQQMIqOkkCMz8t
	TtAMstwUD7Bt14nb3/EOLez61NWYISfKgCgdPRLp87y0+Kaa82xOcm1hNnLmbnfQtjFP
	EfaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:subject:date:message-id;
	bh=Fwt273brT04uhXhd1y1YBHaIEdbLCO/u2Uc3OMC/J/0=;
	b=HkPjtb3VppK3dzcD+gYE0RT67r506OIK+ARApwnHTU+ObPlX9X/Wo+g+jsnd4fPezo
	6A7FiW9dChCrdCNc1tFy/insJ0ZmD/3TwcKHpKprs5SuzkpgA4fEv+SL81C8S0ZvS1tX
	n6VpAPWpIoEjEJjWSaIoGJ91MAvboByguuGFIf+Rr492nrKOxPN6m4tKcwEwZkCtSStY
	o7RGcIRgE/DBxIw/87Bdzo2I5/8/vpBCnnnXtyGmV4qhZv9mp9ewz+8J0Y676JDsKA79
	fvV27LWVz8RvMLoqUIdjZs23TLRvkHf+1zTkWLA260ErCCAdTMjQMeLh0jrJZBVA7hX/
	xVSQ==
X-Gm-Message-State: ALyK8tKFHnSFYVsCl9M2iKTzXufJKtONKD3R6EWX9FSYnQ9I3w3eKbeDg0pMaU+Z+TU1RuK7
X-Received: by 10.28.27.211 with SMTP id b202mr5035847wmb.12.1468937948987;
	Tue, 19 Jul 2016 07:19:08 -0700 (PDT)
Received: from flashheart.burtonini.com (home.burtonini.com. [81.2.106.35])
	by smtp.gmail.com with ESMTPSA id
	z18sm23318573wmz.6.2016.07.19.07.19.07
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Tue, 19 Jul 2016 07:19:08 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 19 Jul 2016 15:19:04 +0100
Message-Id: <1468937944-14508-1-git-send-email-ross.burton@intel.com>
X-Mailer: git-send-email 2.8.1
Subject: [PATCH] lib/bb/utils: no need to unsetenv when manipulating os.environ
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
X-List-Received-Date: Tue, 19 Jul 2016 14:19:09 -0000

Doing both os.unsetenv(foo) and then del os.environ[foo] is pointless as del
will call unsetenv automatically.

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/utils.py | 1 -
 1 file changed, 1 deletion(-)

diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
index 561db6b..995089a 100644
--- a/bitbake/lib/bb/utils.py
+++ b/bitbake/lib/bb/utils.py
@@ -600,7 +600,6 @@ def filter_environment(good_vars):
             continue
 
         removed_vars[key] = os.environ[key]
-        os.unsetenv(key)
         del os.environ[key]
 
     # If we spawn a python process, we need to have a UTF-8 locale, else python's file
-- 
2.8.1


