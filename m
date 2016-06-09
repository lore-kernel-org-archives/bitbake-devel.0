Return-Path: <andrew@bradfordembedded.com>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
	[66.111.4.26])
	by mail.openembedded.org (Postfix) with ESMTP id 9473A607A5
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  9 Jun 2016 13:44:42 +0000 (UTC)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id B8D7420DE4;
	Thu,  9 Jun 2016 09:44:42 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
	by compute6.internal (MEProxy); Thu, 09 Jun 2016 09:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	bradfordembedded.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=ZLX7VeFivgWrnfVtW+SDBWtWmCE
	=; b=H9taPMjB/Ccii0nxTAoFLREtVvwsz3cyaEePdiLeyJw2+626SZixKMrE3qf
	vrwjaySz0DbTDhfZs8OgvGHmgmKwC0SpOzqbb4TqAmxLDFNp5UQaPxoya4Qmsc1a
	H73y5PSjypaEU7CzHy22qeLAKh/tDaM2Scg8/ta6hJb2W94k=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:date:from:message-id:subject:to
	:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ZLX7VeFivgWrnfVtW+SDBWtWmC
	E=; b=k5Ce5yjpsPwPR2j/LHBXeuSmFKWIL4tCWdCvsQv1ggbzmWAy65Uvb8wdU8
	SSLAoOmbGj2AT8a+ZRW/25jY19fp6Xy7fNVR1zkXFfll9FyPXkIO0m8dXjR/f+8L
	mOTI5g8Fsn4TWYZJlcyiScVBIVSUO3IVUimw1cufNnrJ2f+O4=
X-Sasl-enc: lqwV184kCzkQRN8L6EK/c9Ud66JnGAkByHjTXMxADRF0 1465479882
Received: from kaim-eeyore.kodakalaris.net (clr-vpn01.kodakalaris.com
	[198.140.222.129])
	by mail.messagingengine.com (Postfix) with ESMTPA id 00073CCDAC;
	Thu,  9 Jun 2016 09:44:41 -0400 (EDT)
From: Andrew Bradford <andrew@bradfordembedded.com>
To: bitbake-devel@lists.openembedded.org
Date: Thu,  9 Jun 2016 09:44:07 -0400
Message-Id: <1465479849-28634-1-git-send-email-andrew@bradfordembedded.com>
X-Mailer: git-send-email 2.8.1
Cc: Andrew Bradford <andrew.bradford@kodakalaris.com>
Subject: [PATCH v2 0/2] Enhance and document perforce fetcher
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
X-List-Received-Date: Thu, 09 Jun 2016 13:44:43 -0000

From: Andrew Bradford <andrew.bradford@kodakalaris.com>

Allow the perforce fetcher to act more like the other source control
fetchers so that it can use AUTOREV and the use of the p4 P4CONFIG
variable to specify many p4 settings.  Also document these changes and
how to use this new implementation of the perforce fetcher.

This series depends only on one patch from my oe-core series [1]
which enables srcrev capability for the perforce fetcher.  The other
patches in my oe-core series are not required.

[1]: http://patches.openembedded.org/patch/123523/

Changes from v1:
* Rebase on bitbake python3 changes
* Enable ability to fetch a single file from perforce, not just
  directories
* Slight cleanup of code style
* Remove some unneeded debug logging
* Set defaults for P4DIR and FETCHCMD_p4 in fetcher itself, not in
  oe-core
* Update documentation as per these changes


Andrew Bradford (2):
  fetch2/perforce: Rework to support SRCREV and P4CONFIG
  doc: Document use of Perforce fetcher

 .../bitbake-user-manual-fetching.xml               |  68 +++++-
 .../bitbake-user-manual-ref-variables.xml          |  11 +-
 lib/bb/fetch2/__init__.py                          |   3 +-
 lib/bb/fetch2/perforce.py                          | 270 +++++++++++----------
 4 files changed, 225 insertions(+), 127 deletions(-)

-- 
2.8.1


