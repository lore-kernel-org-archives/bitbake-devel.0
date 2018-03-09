Return-Path: <pascal.bach@siemens.com>
X-Greylist: delayed 692 seconds by postgrey-1.34 at layers.openembedded.org;
	Fri, 09 Mar 2018 09:52:53 UTC
Received: from david.siemens.de (david.siemens.de [192.35.17.14])
	by mail.openembedded.org (Postfix) with ESMTP id 944DE788F8
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  9 Mar 2018 09:52:52 +0000 (UTC)
Received: from mail1.sbs.de (mail1.sbs.de [192.129.41.35])
	by david.siemens.de (8.15.2/8.15.2) with ESMTPS id w299fL3v007746
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 9 Mar 2018 10:41:21 +0100
Received: from DEFTHW99ERHMSX.ww902.siemens.net
	(defthw99erhmsx.ww902.siemens.net [139.22.70.133])
	by mail1.sbs.de (8.15.2/8.15.2) with ESMTPS id w299evcV032214
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 9 Mar 2018 10:41:21 +0100
Received: from DEFTHW99ERTMSX.ww902.siemens.net (139.22.70.200) by
	DEFTHW99ERHMSX.ww902.siemens.net (139.22.70.133) with Microsoft SMTP
	Server (TLS) id 14.3.361.1; Fri, 9 Mar 2018 10:40:58 +0100
Received: from DEFTHW99EH4MSX.ww902.siemens.net ([169.254.2.118]) by
	DEFTHW99ERTMSX.ww902.siemens.net ([139.22.70.200]) with mapi id
	14.03.0361.001; Fri, 9 Mar 2018 10:40:57 +0100
From: "Bach, Pascal" <pascal.bach@siemens.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Issue with bitbake fetch/unpack when using MIRRORS rewrite
Thread-Index: AdO3ipHaekI1Ua6UTPqze+w0jLH5dw==
Date: Fri, 9 Mar 2018 09:40:56 +0000
Message-ID: <355BE46A91031048906B695426A8D8E617342693@DEFTHW99EH4MSX.ww902.siemens.net>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [139.22.70.44]
MIME-Version: 1.0
Subject: Issue with bitbake fetch/unpack when using MIRRORS rewrite
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
X-List-Received-Date: Fri, 09 Mar 2018 09:52:54 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello Everyone

I finally got to pin down an issue that I occasionally observed in the past=
:

When using the git fetcher with shallow tarballs (BB_GIT_SHALLOW,BB_GIT_SHA=
LLOW_DEPTH) experience the following issues during the do_unpack task:

ERROR: pseudo-native-1.9.0+gitAUTOINC+d7c31a25e4-r0 do_unpack: Fetcher fail=
ure: [...]
tar (child): /home/projects/ccp3-labs/oe/build/../../../downloads2/gitshall=
ow_git.yoctoproject.org.pseudo_d7c31a2-1_master.tar.gz: Cannot open: No suc=
h file or directory
tar (child): Error is not recoverable: exiting now
tar: Child returned status 2
tar: Error is not recoverable: exiting now

The issue is that the do_unpack is trying to find the following file in the=
 downloads directory:
downloads2/gitshallow_git.yoctoproject.org.pseudo_d7c31a2-1_master.tar.gz

However this file doesn't exist, instead the following file was created by =
the fetch task:
downloads2/gitshallow_git.yoctoproject.org.git.pseudo_d7c31a2-1_master.tar.=
gz

After some digging I suspect that the following rewrite rule is causing the=
 issue:
MIRRORS +=3D "git://git.yoctoproject.org/.*                               g=
it://git.yoctoproject.org/git/PATH;protocol=3Dhttps \n"

The line exists because we don't have access to git.yoctoproject.org via th=
e git protocol. So we use the above rule to make access work via HTTPS.
However due to the way the Yocto git server is structured the rewrite cause=
s the URL path to change from / to /git which causes the additional .git in=
 the
resulting tarball, which then makes the unpack task look for the wrong file=
.

I think the proper behavior would be to always name the tarball after the o=
riginal SRC_URI not the rewritten one.

BTW: I was able to reproduce the issue with the shallow git tarballs but I =
think it also applies to normal git tarballs and possibly other fetchers.

The issue still exists with bitbake 1.37.0 on Poky master.

Regards
Pascal

