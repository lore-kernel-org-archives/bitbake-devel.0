Return-Path: <jean-marie.lemetayer@savoirfairelinux.com>
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
	[208.88.110.44])
	by mail.openembedded.org (Postfix) with ESMTP id 2B6777DD81
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 15:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id C55569C01E9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 11:14:17 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10032)
	with ESMTP id 4gMrM1CAp2CZ for <bitbake-devel@lists.openembedded.org>; 
	Fri, 17 May 2019 11:14:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 4384F9C02EE
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 11:14:17 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
	by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new,
	port 10026)
	with ESMTP id OZdfH_Z2i3f1 for <bitbake-devel@lists.openembedded.org>; 
	Fri, 17 May 2019 11:14:17 -0400 (EDT)
Received: from sulaco.jml.bzh (91-167-182-132.subs.proxad.net [91.167.182.132])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id CEA3A9C01E9
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 17 May 2019 11:14:16 -0400 (EDT)
From: Jean-Marie LEMETAYER <jean-marie.lemetayer@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org
Date: Fri, 17 May 2019 17:14:06 +0200
Message-Id: <20190517151410.8487-1-jean-marie.lemetayer@savoirfairelinux.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Subject: [PATCH 0/4] NPM fixes
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
X-List-Received-Date: Fri, 17 May 2019 15:19:56 -0000
Content-Transfer-Encoding: quoted-printable

Hi folks,

I have recently integrated a nodejs server with an angular application us=
ing
poky and meta-openembedded (thud branch). Some fixes were needed to make =
it
work.

Best regards,
Jean-Marie

Jean-Marie LEMETAYER (4):
  bitbake: fetch2/npm: fix npw view parsing
  npm: get npm package name from npm pack
  npm: fix node and npm default directory conflict
  npm: remove some temporary build files

 bitbake/lib/bb/fetch2/npm.py | 19 +++++--------------
 meta/classes/npm.bbclass     | 11 +++++++----
 2 files changed, 12 insertions(+), 18 deletions(-)

--
2.20.1


