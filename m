Return-Path: <david.reyna@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 0DB29782A9
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 26 Mar 2018 06:45:59 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id w2Q6k07T011509
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 25 Mar 2018 23:46:01 -0700 (PDT)
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.201]) by
	ALA-HCB.corp.ad.wrs.com ([147.11.189.41]) with mapi id 14.03.0361.001;
	Sun, 25 Mar 2018 23:46:00 -0700
From: "Reyna, David" <david.reyna@windriver.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH 0/2] toaster: cummulative 021518 patch
Thread-Index: AQHTpuDWxR8WOfTTY0OUHxk+qlEoqqPiTing
Date: Mon, 26 Mar 2018 06:46:00 +0000
Message-ID: <5E53D14CE4667A45B9A06760DE5D13D0F37F5CA3@ALA-MBD.corp.ad.wrs.com>
References: <cover.1518754951.git.David.Reyna@windriver.com>
In-Reply-To: <cover.1518754951.git.David.Reyna@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.11.117.93]
MIME-Version: 1.0
Subject: [PATCH 0/2] toaster: cummulative 021518 patch
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
X-List-Received-Date: Mon, 26 Mar 2018 06:46:00 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This patch was yet not pulled. Trying again. Thanks.

-----Original Message-----
From: Reyna, David=20
Sent: Thursday, February 15, 2018 8:26 PM
To: bitbake-devel@lists.openembedded.org
Cc: Reyna, David
Subject: [PATCH 0/2] toaster: cummulative 021518 patch

From: David Reyna <David.Reyna@windriver.com>


This patchset addresses two blocking issues for Toaster.


The following changes since commit f51f28b7b927fde9489e244cb812b562f28bbafa=
:

  icecc-create-env: Allow multiple tool aliases (2018-02-15 13:28:54 +0000)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/cumm=
ulative_021518_patch
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=3Ddreyna/submit/=
dreyna/toaster/cummulative_021518_patch

David Reyna (2):
  toaster: do not fail on optional 'custom.xml' file
  Toaster: fix shutdown and extra threads

 bin/toaster                                                 | 4 ++--
 lib/toaster/bldcontrol/management/commands/checksettings.py | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

--=20
2.7.4


