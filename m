Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 299317ED4A
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 22 Oct 2019 09:04:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 64A889C0470;
	Tue, 22 Oct 2019 05:04:14 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id QxeF93dk498z; Tue, 22 Oct 2019 05:04:13 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id AE6EB9C0462;
	Tue, 22 Oct 2019 05:04:13 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id khP1pcCRcxGw; Tue, 22 Oct 2019 05:04:13 -0400 (EDT)
Received: from sulaco.home (lfbn-1-7821-217.w92-167.abo.wanadoo.fr
	[92.167.224.217])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id F38E39C045F;
	Tue, 22 Oct 2019 05:04:12 -0400 (EDT)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Tue, 22 Oct 2019 11:04:06 +0200
Message-Id: <20191022090408.1368-1-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: brendan.le.foll@intel.com, paul.eggleton@linux.intel.com,
	rennes@savoirfairelinux.com
Subject: [RFC][PATCH 0/2] NPM refactoring
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
X-List-Received-Date: Tue, 22 Oct 2019 09:04:13 -0000
Content-Transfer-Encoding: quoted-printable

These patches are part of a set which are mainly in OE-core.

More infos can be found on the openembedded-core list.

Jean-Marie LEMETAYER (2):
  bitbake: utils.py: add sha384_file and sha512_file
  fetch2/npm.py: refactor the npm fetcher

 lib/bb/fetch2/npm.py | 464 +++++++++++++++++++------------------------
 lib/bb/utils.py      |  24 +++
 2 files changed, 224 insertions(+), 264 deletions(-)

--
2.20.1


