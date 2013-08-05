Return-Path: <ross.burton@intel.com>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
	[74.125.82.170])
	by mail.openembedded.org (Postfix) with ESMTP id 6195460958
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  5 Aug 2013 16:12:28 +0000 (UTC)
Received: by mail-we0-f170.google.com with SMTP id w60so2696267wes.15
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 05 Aug 2013 09:12:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=from:to:subject:date:message-id:x-mailer:x-gm-message-state;
	bh=bMse9bnYSS4ZKo3xdOeLLrahhYf+v56Veg2IUt1Nl+g=;
	b=jhPTeZWQNbVQbN5peW+aPBVjCyJ1IfRjgGXNk4V4s/0bCWZYm0WMCP+2KaLid/urV7
	tlD0Ia5Lkvv3kDnhALmvr6Ye9ncDi37X0AfpYnEZcJ0a8rTiRHcI2JULPaxfSIHjVKb5
	Tke3+je7dLJ/qkb1euhFNpZkqzWp0/rL7hWOQe3PkgZk/ZUe2xPfKUZ3IJbNvKY3NYzf
	sUeVPJ7BKP5AYV9XXbSFyCakUNlaPEZpaTjI7T0/KM9GtL9KO4TGK2Y06mduNhcFKatn
	ShamjtXHuQSQU+u/TYhOcfuvSL4X0H6Jryk/XEZlWVanGMNqnYB90vwUjDNULS7f9eMl
	YuMA==
X-Received: by 10.180.208.45 with SMTP id mb13mr7226141wic.27.1375719148352;
	Mon, 05 Aug 2013 09:12:28 -0700 (PDT)
Received: from melchett.burtonini.com (35.106.2.81.in-addr.arpa. [81.2.106.35])
	by mx.google.com with ESMTPSA id
	fd3sm22434156wic.10.2013.08.05.09.12.26
	for <bitbake-devel@lists.openembedded.org>
	(version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Mon, 05 Aug 2013 09:12:27 -0700 (PDT)
From: Ross Burton <ross.burton@intel.com>
To: bitbake-devel@lists.openembedded.org
Date: Mon,  5 Aug 2013 17:12:20 +0100
Message-Id: <cover.1375718812.git.ross.burton@intel.com>
X-Mailer: git-send-email 1.7.10.4
X-Gm-Message-State: ALoCoQndulsOe5P1liryhX0ZNk5RITSje8YG3iGvuFVlRST8o6gOTJfBvlhaFV5aEd7aD6Szabv/
Subject: [PATCH 0/3] Depexp fixes
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
X-List-Received-Date: Mon, 05 Aug 2013 16:12:28 -0000

Hi,

I was doing some depexp runs against a world build and almost died of boredom.
So, after at least five years I'll try and finish depexp off...

Attached is a series to fix a runtime exception and DOUBLE the speed of loading
the data.  Whilst this sounds good the time to get the data from the bitbake
structures to the GTK+ widgetry is still ~30 seconds on my machine.  Still,
better than 60 seconds.

Ross

The following changes since commit 4cff3defb545643132b7233fcffb3fedc1bf182b:

  grep: Add patch for texinfo 5.1 (2013-08-03 10:33:14 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib ross/depexp

for you to fetch changes up to 8b1a3c7eb0110cbb2345d32f26d37cb7fc5e8d6e:

  depexp: fix typo in variable name (2013-08-05 16:39:47 +0100)

----------------------------------------------------------------
Ross Burton (3):
      depexp: make parse() a member function
      depexp: insert data instead of append/set, for speed
      depexp: fix typo in variable name

 bitbake/lib/bb/ui/depexp.py |   28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

Ross Burton (3):
  depexp: make parse() a member function
  depexp: insert data instead of append/set, for speed
  depexp: fix typo in variable name

 bitbake/lib/bb/ui/depexp.py |   28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

-- 
1.7.10.4


