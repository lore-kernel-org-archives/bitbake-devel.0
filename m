Received: from mail-yw0-f47.google.com ([209.85.213.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1RvvC3-0003OS-OL
	for bitbake-devel@lists.openembedded.org;
	Fri, 10 Feb 2012 19:27:35 +0100
Received: by yhfq46 with SMTP id q46so1642713yhf.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Feb 2012 10:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=from:to:cc:subject:date:message-id:x-mailer;
	bh=LZlvuSFT0/O0BrARu/kuGPivAnK2vg9NQnNNHxbPf+E=;
	b=xVyF6mFw0TofLVgD05yHOmvyo64pLVqDPXrxlGcDhzuH0s/HjOmiGZrNfbOrSVLbe8
	nyIqwNKO2iBf1K30bg6y+DuAL+9AzYADiSba7ca9Stw/3LQL7SF+WHxLAcvCOY/v73Vp
	CqUYLrwsHRU1bQo+n6hlM40BAhC5hZWkjxBKk=
Received: by 10.236.154.137 with SMTP id h9mr10456964yhk.91.1328897969256;
	Fri, 10 Feb 2012 10:19:29 -0800 (PST)
Received: from localhost.localdomain (hsvwanfw1-nat.mentorg.com.
	[139.181.24.34])
	by mx.google.com with ESMTPS id 34sm15352384anp.13.2012.02.10.10.19.26
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 10 Feb 2012 10:19:27 -0800 (PST)
From: Christopher Larson <kergoth@gmail.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 10 Feb 2012 12:19:21 -0600
Message-Id: <cover.1328897859.git.chris_larson@mentor.com>
X-Mailer: git-send-email 1.7.7
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: [PATCHv2 0/2] Resolve parsing hang issues
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Fri, 10 Feb 2012 18:27:35 -0000

From: Christopher Larson <chris_larson@mentor.com>

The following changes since commit db689a99beffea1a285cdfc74a58fe73f1666987:

  Revert the switch to futures for now (2012-02-03 08:12:56 -0700)

are available in the git repository at:
  git://github.com/kergoth/bitbake.git hang-issue-fix
  https://github.com//tree/hang-issue-fix

Christopher Larson (2):
  cooker: roll our own process pool
  knotty: shut down more cleanly

 lib/bb/cooker.py    |  155 ++++++++++++++++++++++++++++++++++++++++++---------
 lib/bb/ui/knotty.py |   15 ++---
 2 files changed, 136 insertions(+), 34 deletions(-)

-- 
1.7.7



