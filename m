Return-Path: <michael.g.wood@intel.com>
Received: from mail-pa0-f44.google.com (mail-pa0-f44.google.com
	[209.85.220.44])
	by mail.openembedded.org (Postfix) with ESMTP id 108A965CBF
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 16:22:42 +0000 (UTC)
Received: by mail-pa0-f44.google.com with SMTP id cm16so27478187pac.0
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Sep 2016 09:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=from:to:cc:subject:date:message-id;
	bh=8/5FcqU0hL7AloRi9GcSvqMbs2I6V0K+BuzXP6O4PGs=;
	b=yEzg6CdZpzkxFiEpPEgmomdU18UlsNArr+m0egir0ivxRLDP5D0ZI53MjsyPrnzG4N
	37NWYDHCLQrHXYwaGWHko8IzAIZ4Dp/D4Erug9NvQRt8eepiA6BqOcd9wOXO0OzgAI5+
	dhxPAlXThSMBt8Ly3LGI0Rw2bMz+Aan44qVJMMBM49/LYn19O2lcR6/0rHQnaO2WvSKl
	p9RcDmrdJuGCUkFD8Goxu6LrqK4C0GkiT+TVjDQPsQ9j2aS9fDj7ckWtJgpdpa9PL996
	4sobgXLuvlPmqmlQcCtk7PWzx5U5ssowXhLyOx6PXTcXz7ha7Fn1edkg4BFxtzBsbaXW
	bwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:from:to:cc:subject:date:message-id;
	bh=8/5FcqU0hL7AloRi9GcSvqMbs2I6V0K+BuzXP6O4PGs=;
	b=Fg95eTr1Aod2B8A3b72yG+IjzhFHv1Mk/asyLJEdycGtR9y1LBN1bUxsxU73Jb8IMu
	FpWxinmmjiE9P7eJcRHa19zjZDXx8K9gIToERuRNCEZEM0SOx22YHJyw3vXgNvAVk9lk
	2O2nz5tqbULAvL+H/CnUcfJNX1XuJ3UBsunH+4eW6Oo5v16iOfzUsjSfoEJO5v391IsW
	83LUKEU1w/c7NR17I9oFAtGdmMVt6Sv1E9sgAQ9BWzngE2W4aNgqUJgJ0RM0MPgbnG/2
	juuc36+LN0ciULJSHJqq3ZpLw9taW0AK05OdUtex9gw5PNQv3VxGkzKubaFg2bWk+kGL
	vmFw==
X-Gm-Message-State: AE9vXwMhW6ceCW1w3D1PMmJeUfN1ubss4QfNzkORJ7uIQZpQQh22Sze0gVUiORWAX0jyWVjN
X-Received: by 10.66.51.129 with SMTP id k1mr4371751pao.5.1474042963375;
	Fri, 16 Sep 2016 09:22:43 -0700 (PDT)
Received: from orion.ger.corp.intel.com (fmdmzpr04-ext.fm.intel.com.
	[192.55.55.39]) by smtp.gmail.com with ESMTPSA id
	bm8sm13336146pac.16.2016.09.16.09.22.41
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Sep 2016 09:22:42 -0700 (PDT)
From: Michael Wood <michael.g.wood@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Sep 2016 17:22:27 +0100
Message-Id: <1474042955-12618-1-git-send-email-michael.g.wood@intel.com>
X-Mailer: git-send-email 2.7.4
Subject: [PATCH 0/8]
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
X-List-Received-Date: Fri, 16 Sep 2016 16:22:44 -0000

Series to improve process handling of runbuilds and one additional patch for fixing checking out HEAD as a reference. Changes reviewed on toaster mailing list.

Copy of process handling patchset cover letter:

This patchset introduced a bit lighter way of handling builds.
Instead of polling database every second we process builds only when runbuilds
receives SIGUSR1. The signal is sent when build is either scheduled, canceled or
finished. A little bit of code cleanup is also included into this patchset.

Test instructions:
 - Create multiple builds in UI. Check if they'll be built sequentially
 - Create multiple builds in UI, cancel one. Check if the next one starts building.
 - Repeat first two test cases when command line build is run. Only one UI build
   should be run in parallel with command line build.
 - Test any other combinations of running and cancelling builds to make sure
   there are no regressions.



Ed Bartosh (8):
  toaster: fix checking of repository url
  toaster: implement signal_runbuilds function
  toaster: notify runbuilds when build status changes
  runbuilds: process builds on SIGUSR1
  runbuilds: process builds on start
  runbuilds: code cleanup - whitespaces, long lines
  runbuilds: code cleanup - remove unused imports
  toaster: unlock BuildEnvirnoment when build is done

 lib/bb/ui/buildinfohelper.py                       | 12 ++++--
 lib/toaster/bldcontrol/localhostbecontroller.py    |  2 +-
 .../bldcontrol/management/commands/runbuilds.py    | 49 ++++++++++------------
 lib/toaster/orm/models.py                          | 10 ++++-
 4 files changed, 42 insertions(+), 31 deletions(-)

-- 
2.7.4


