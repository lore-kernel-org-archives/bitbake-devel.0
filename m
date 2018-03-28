Return-Path: <ross.burton@intel.com>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
	by mail.openembedded.org (Postfix) with ESMTP id B24D678449
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Mar 2018 09:54:18 +0000 (UTC)
Received: by mail-wm0-f68.google.com with SMTP id f125so4012687wme.4
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 28 Mar 2018 02:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:subject:date:message-id:in-reply-to:references;
	bh=W67i82+RlPEUAOnbYRCIY5tT+qNh9fBdvMFJt5yIx9A=;
	b=DnBKSTN/2lLNBFpFq3nlQoo4tSWzA8lFmP6O2aFoRmRp3f9BRJ6EW/J3Bo4KEs4LNB
	+SDOb3gqlTULm5w8RmdAH/fRSAGNPIP7BR54qHhtyGM/crpCao7hDzoJfI2U3K6V7I1g
	+LtIesPZeBBbC8Iz5/TYN4ZSXTjZc90FMyn4vewPqU3HQEF15yh1de8HQQwupAO7xRhK
	Ah6tnxHZcFvTHgMIunGFV45ahQqE0QGhijVf916l9684WdB1BboxEI/Lq14syvzPH2YB
	qI4GaM8iqjAFtHPwxYfpxpEsBbRnpLJ5GUI6vLA/BuD20YxiYySd4l6nIXOZqVf0bRO3
	v5Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references;
	bh=W67i82+RlPEUAOnbYRCIY5tT+qNh9fBdvMFJt5yIx9A=;
	b=piCL0AfTZ0ppqbo3+MsrKlMjGgrrmoDVUsjGl/oFVtjaSpz9CfhNhqzargEAJtu13q
	jCoMiOQYWtvZck9b4pPaayXNZ0mngLLufPxYikQ7Ba9VutGeuFtsoVVuBW63EszCdSBf
	hB421GF0WGBfSvSJWLTp3bE4ymHBdsgsItv8brSG+s7nVfnULjP2lEHZs4CjAK9OexOf
	4LFELtC+nScOh8JuRW9yCALGQDHbMHN2nMM9ShWyEzvu3Qr86o7VCOm0gLm4lPnL0Hnh
	G80H5U7tluU5rk1gmoufcJl2HUzf2aBpug+X9OsGQWLMHlRgSnCm42XxP2VRGDfQ+DKh
	Noaw==
X-Gm-Message-State: AElRT7HqfgAgXSqOLIyR/H0mIxtT9QEXm2gZMk/0ewqCQ8h3QblK+U1i
	i9I/F1xVjZP+DYxfr11Bkcg+LCo6
X-Google-Smtp-Source: AIpwx4+elbNZnHHGXq+0HEmUczDx//7h13RDi8kqBaFnMS2+nBqAGpEWW7kt4LT0uRsH3QfN3El5tw==
X-Received: by 10.28.17.142 with SMTP id 136mr1880310wmr.38.1522230859097;
	Wed, 28 Mar 2018 02:54:19 -0700 (PDT)
Received: from flashheart.burtonini.com (35.106.2.81.in-addr.arpa.
	[81.2.106.35])
	by smtp.gmail.com with ESMTPSA id m9sm3351496wrf.13.2018.03.28.02.54.18
	for <bitbake-devel@lists.openembedded.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 28 Mar 2018 02:54:18 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 28 Mar 2018 10:54:13 +0100
Message-Id: <20180328095413.32013-2-ross.burton@intel.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180328095413.32013-1-ross.burton@intel.com>
References: <20180328095413.32013-1-ross.burton@intel.com>
Subject: [PATCH 2/2] fetch2/git: log exception if ls-remote fails
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
X-List-Received-Date: Wed, 28 Mar 2018 09:54:18 -0000

Signed-off-by: Ross Burton <ross.burton@intel.com>
---
 bitbake/lib/bb/fetch2/git.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
index 35e0db56cff..3de83bed173 100644
--- a/bitbake/lib/bb/fetch2/git.py
+++ b/bitbake/lib/bb/fetch2/git.py
@@ -595,7 +595,8 @@ class Git(FetchMethod):
         tagregex = re.compile(d.getVar('UPSTREAM_CHECK_GITTAGREGEX') or "(?P<pver>([0-9][\.|_]?)+)")
         try:
             output = self._lsremote(ud, d, "refs/tags/*")
-        except bb.fetch2.FetchError or bb.fetch2.NetworkAccess:
+        except (bb.fetch2.FetchError, bb.fetch2.NetworkAccess) as e:
+            bb.note("Could not list remote: %s" % str(e))
             return pupver
 
         verstring = ""
-- 
2.11.0


