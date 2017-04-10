Return-Path: <david.reyna@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 3CB0571ABD
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 10 Apr 2017 05:36:28 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v3A5aTnC018668
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 9 Apr 2017 22:36:29 -0700 (PDT)
Received: from ALA-MBC.corp.ad.wrs.com ([fe80::fcbe:9b7:1141:89a1]) by
	ALA-HCB.corp.ad.wrs.com ([147.11.189.41]) with mapi id 14.03.0294.000;
	Sun, 9 Apr 2017 22:36:28 -0700
From: "Reyna, David" <david.reyna@windriver.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [PATCH 0/1] toaster: fix add layer button for Machines
Thread-Index: AdKxvFSdd9+JAvzPT2iZfAC/d8gMpQ==
Date: Mon, 10 Apr 2017 05:36:27 +0000
Message-ID: <5E53D14CE4667A45B9A06760DE5D13D0CF60308E@ALA-MBC.corp.ad.wrs.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.11.117.92]
MIME-Version: 1.0
Subject: [PATCH 0/1] toaster: fix add layer button for Machines
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
X-List-Received-Date: Mon, 10 Apr 2017 05:36:31 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Fixing email title...

-----Original Message-----
From: Reyna, David=20
Sent: Sunday, April 09, 2017 10:13 PM
To: bitbake-devel@lists.openembedded.org
Cc: Reyna, David
Subject: [PATCH 0/1] toaster: fix SDK artifact capture

From: David Reyna <David.Reyna@windriver.com>

"toaster: fix add layer button for Machines". Tested on Firefox and Chrome.


The following changes since commit 633ad6c9f436f5d2b6ee1a005b697661a054a394=
:

  oeqa/runtime/utils/targetbuildproject: use parent classes defaults tmpdir=
 (2017-04-06 10:13:39 +0100)

are available in the git repository at:

  git://git.yoctoproject.org/poky-contrib dreyna/submit/dreyna/toaster/add_=
layers_machine_11213
  http://git.yoctoproject.org/cgit.cgi/poky-contrib/log/?h=3Ddreyna/submit/=
dreyna/toaster/add_layers_machine_11213

David Reyna (1):
  toaster: fix add layer button for Machines

 lib/toaster/toastergui/templates/machine_btn.html | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--=20
1.9.1


