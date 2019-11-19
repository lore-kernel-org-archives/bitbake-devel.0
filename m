Return-Path: <andrej.valek@siemens.com>
X-Greylist: delayed 1178 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 19 Nov 2019 13:41:21 UTC
Received: from thoth.sbs.de (thoth.sbs.de [192.35.17.2])
	by mail.openembedded.org (Postfix) with ESMTP id 817727F814
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Nov 2019 13:41:21 +0000 (UTC)
Received: from mail2.siemens.de (mail2.siemens.de [139.25.208.11])
	by thoth.sbs.de (8.15.2/8.15.2) with ESMTPS id xAJDLhAL013778
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Nov 2019 14:21:43 +0100
Received: from ATVIES991U8MSX.ww300.siemens.net
	(atvies991u8msx.ww300.siemens.net [158.226.163.42])
	by mail2.siemens.de (8.15.2/8.15.2) with ESMTPS id xAJDLhEc010335
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 19 Nov 2019 14:21:43 +0100
Received: from ATNETS9912WMSX.ww300.siemens.net ([169.254.10.2]) by
	ATVIES991U8MSX.ww300.siemens.net ([158.226.163.42]) with mapi id
	14.03.0468.000; Tue, 19 Nov 2019 14:21:43 +0100
From: "Valek, Andrej" <andrej.valek@siemens.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Git shallow copy problem
Thread-Index: AdWe1+8qvZ9fELuKQSW1LI4ImNGtLg==
Date: Tue, 19 Nov 2019 13:21:42 +0000
Message-ID: <D55698ECEC159B488D62A508E18D7FEC1252C522@ATNETS9912WMSX.ww300.siemens.net>
Accept-Language: en-US, de-AT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [158.226.163.12]
MIME-Version: 1.0
Cc: "Klein, Lubomir" <Lubomir.Klein@siemens.com>
Subject: Git shallow copy problem
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
X-List-Received-Date: Tue, 19 Nov 2019 13:41:22 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Everyone!

We have made one problem during experimenting with shallow copy tarballs.
Looks like, that the revision inside the archive is not the right one... .

| ERROR: kern-tools-native-0.2+gitAUTOINC+bb6df0ef23-r12 do_unpack: Unpack =
failure for URL: 'git://git.yoctoproject.org/yocto-kernel-tools.git'. No up=
 to date source found: clone directory not available or not up to date: /ho=
me/projects/downloads/git2/git.yoctoproject.org.yocto-kernel-tools.git; sha=
llow clone not available: /home/projects/downloads/gitshallow_git.yoctoproj=
ect.org.yocto-kernel-tools.git_bb6df0e-1_master.tar.gz
	- Naming looks also fine. "git_bb6df0e" is matching with our revision, whi=
ch we are trying to use bb6df0ef2365689cd3df6f76a8838cddae0d9343.=20
	- A packed-refs is also fine. "bb6df0ef2365689cd3df6f76a8838cddae0d9343 re=
fs/remotes/origin/master"
So what's wrong there?

So we have removed downloads/archives completely via "bitbake kern-tools-na=
tive -c cleanall" and rm -rf "*git.yoctoproject.org.yocto-kernel-tools*" in=
side downloads and git2 directories.
After these steps, compilation was successful.
So we have checked the revision inside the archive and it's different as we=
 expected. packed-refs: "09afff364c48f84249094ec8d9a171fc332c17e4 refs/remo=
tes/origin/master". Why was the wrong revision been taken?
We reproduced the steps manually.
	- git clone git://git.yoctoproject.org/yocto-kernel-tools.git
	- cd yocto-kernel-tools
	- git-make-shallow -s -r refs/remotes/origin/master bb6df0ef2365689cd3df6f=
76a8838cddae0d9343
	 - From the bitbake's class looks like, that bitbake is searching for revi=
sion (bb6df0ef2365689cd3df6f76a8838cddae0d9343) inside the cloned repositor=
y. It finds the revision and removes the rest. After that just packs the co=
ntent. But we think, that is wrong. Should be some "git checkout" to switch=
 for certain revision before packing? Because it just check, "fine, revisio=
n is inside, pack the current HEAD".
Bitbake fetcher just downloads this archive and checks the content. There i=
s only one revision, which is not matching with the expected and will fail.

Correct as please, if we are wrong. But we think, there is a problem with s=
witching to certain revision before shallow tarballs creating.

Thank you,
Andrej & Lubomir

