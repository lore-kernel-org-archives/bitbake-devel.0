Return-Path: <avery.brian@gmail.com>
Received: from mail-pg0-f50.google.com (mail-pg0-f50.google.com [74.125.83.50])
	by mail.openembedded.org (Postfix) with ESMTP id EE866605C3
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  1 Dec 2016 03:31:12 +0000 (UTC)
Received: by mail-pg0-f50.google.com with SMTP id x23so89549497pgx.1
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 30 Nov 2016 19:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=Mz6jwRPA/j8Zxi9w9vMvhjFQAw8pQsiLkXXPfUO5Wtw=;
	b=NgkZfMUcTjdFYRPCYIzpSMPYtFkuv7nn+xqgClEH0HunAeV+3KPtaY6993juFektLL
	7WJDrzrMHI2YhcBJpc/bGKLoP5AM9ag2qzWt12G1/Vwduerbq7L+NThHT9jxKZWW7kpg
	PYXHdp5vToSuLPH5xPk7MmDYTtLbH6k+qyxXWXaObOiPJs5glKxrIsR/fTIHaqbIuEpm
	WbFi9BXPazOiMvGEKZ16YiFexXBV4J+YTH77Mbqs/oiRiub8hRWglPWs8U6zrsVaxdHO
	zTHK5xKrsBbz7B9lLEvrWn2nhD10VEm4VnwMtvHsmA3Em3cBTCcWnVOaY17CBJyolk00
	EbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=Mz6jwRPA/j8Zxi9w9vMvhjFQAw8pQsiLkXXPfUO5Wtw=;
	b=DrafrRB4VWrXM58TopmWIUlj3OVq7KnFYjgDys2jXtNB1ibMZ+Tyc9xFveyHuR30uR
	C07MM84k0V0a0nT9E6gPvVycvWnKj4YFDe374Cw4IHeVEiHslF/zVbB+gZaL2mUjyxea
	UHEE2pcUhfWzCx+2rZBwR4jG6WF6/kS1bV/0buHF2MhXW6HaH1HMcLl4IdX0QJULNfJb
	psUgcOxNsGnxmlHqNgj78SCMGi3iRtznvB+x6/IVQaLYYxO0hZadFaZv2gCluL7JeHww
	0qqxQkFQMKimSMewRn5MXE9bbbh8nM30Ll05+c73dp11pRM5+jwUJ1+FvTBhU+SykK3J
	3oQQ==
X-Gm-Message-State: AKaTC00R+5Vd8aCzHQFUnn+gbrtgCUeLpXrwUzuoBa+Lf5fM6PFCqa9KENvxv2z7xWrNVw==
X-Received: by 10.84.193.101 with SMTP id e92mr79816994pld.12.1480563074003;
	Wed, 30 Nov 2016 19:31:14 -0800 (PST)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	r124sm88120931pgr.6.2016.11.30.19.31.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Wed, 30 Nov 2016 19:31:13 -0800 (PST)
From: brian avery <avery.brian@gmail.com>
X-Google-Original-From: brian avery <brian.avery@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Wed, 30 Nov 2016 19:35:24 -0800
Message-Id: <cover.1480563227.git.brian.avery@intel.com>
X-Mailer: git-send-email 1.9.1
Cc: brian avery <brian.avery@intel.com>
Subject: [PATCH 0/1] toaster: add Selenium Docker container as browser test driver option
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
X-List-Received-Date: Thu, 01 Dec 2016 03:31:13 -0000

So, this patch will allow you to run the standard tests using the Selenium docker container as the
driver rather than relying on host side drivers for firefox.

This is V2. It no longer overloads the TOASTER_TESTS_BROWSER with an address and now pulls the
liveserver address from the instance.

The README in lib/toaster/tests/browser has some instructions and more are located on the wiki
at https://wiki.yoctoproject.org/wiki/TipsAndTricks/TestingToasterWithContainers.

This patch assumes the firefox container. Later, if we want to, we can add an additional
env variable to override firefox or chrome containers.  Initially, I just wanted to get this
approach working so that we could use it.

-Brian
an intel employee
                                                                                                                                                                                                         The following changes since commit 9e63f81c78e284c9b325fe04a1b59e61c7ad8a1a:

  bitbake: ast: remove BBVERSIONS support (2016-11-30 15:48:10 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/toaster/remoteContainerTestV2
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/toaster/remoteContainerTestV2

brian avery (1):
  toaster: browser tests - add Selenium Docker container as driver

 lib/toaster/tests/browser/README                   | 21 +++++++++++++++++++--
 lib/toaster/tests/browser/selenium_helpers_base.py | 13 +++++++++++--
 2 files changed, 30 insertions(+), 4 deletions(-)

--
1.9.1

