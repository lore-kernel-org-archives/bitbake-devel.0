Return-Path: <avery.brian@gmail.com>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
	[209.85.220.43])
	by mail.openembedded.org (Postfix) with ESMTP id E5F4777152
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Oct 2015 17:28:54 +0000 (UTC)
Received: by pacfv9 with SMTP id fv9so28342841pac.3
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 16 Oct 2015 10:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=from:to:cc:subject:date:message-id;
	bh=l5UXJ8JLpWAI1X34NphFnZxXQGw1QakPVPLcrZqZrrE=;
	b=o2llPdz6i4T42FrtywjaLNGfvt875Sx7YKLx/3B5xEtBgurSMXGwu8jKHcSTOHV+Zm
	ROnpz2HiwCeCukHHq6N6q+OKFxeXrnbbD4AH8bzHkGbjsh3xSmpckaf0b8/5kCIu/f/1
	ps2Pdb/FcJCRzRToRSJqyXYEeSb5ygPl3uAZo709hV17X8OAXtW8ODxJe1lPlCwQ81Zb
	XFNmMPJ2usd8BU5Uc8daHBbX7gzgwubey1zTUahLzsENujAa9hvoUcS/G+dF/5V3skdJ
	B2qmXekw+YxY9dq4rcNJQpNog14aWs3ePMIZOKzyxm5yg5sLtj+s0w4PcBVqZXEky4lp
	bsrg==
X-Received: by 10.66.246.162 with SMTP id xx2mr17499869pac.144.1445016534919; 
	Fri, 16 Oct 2015 10:28:54 -0700 (PDT)
Received: from whisper.hsd1.or.comcast.net
	(c-98-232-142-195.hsd1.or.comcast.net. [98.232.142.195])
	by smtp.gmail.com with ESMTPSA id
	sn9sm22424162pac.16.2015.10.16.10.28.54
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 16 Oct 2015 10:28:54 -0700 (PDT)
From: brian avery <avery.brian@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 16 Oct 2015 10:31:03 -0700
Message-Id: <cover.1445016378.git.avery.brian@gmail.com>
X-Mailer: git-send-email 1.9.1
Subject: [PATCH 0/1] toaster:add-get_or_create_targets-API
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
X-List-Received-Date: Fri, 16 Oct 2015 17:28:55 -0000

Target objects are created before the build if build is
started from UI in build mode. However, in analysis mode Target
objects don't exist and need to be created using information
from bitbake events.

Added new API call get_or_create_targets to retrive existing
target objects or create them if they don't exist yet.

-b

The following changes since commit a9053ac0829eb01f6f002587854d01e47a78e6f0:

  bitbake: toaster: Add tests for error message display on the build dashboard (2015-10-16 15:00:00 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib bavery/submit/ed/2015-10-16_add-get_or_create_targets-API
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=bavery/submit/ed/2015-10-16_add-get_or_create_targets-API

Ed Bartosh (1):
  toaster: add get_or_create_targets API

 lib/bb/ui/buildinfohelper.py | 36 +++++++++++++++++++++---------------
 1 file changed, 21 insertions(+), 15 deletions(-)

--
1.9.1

