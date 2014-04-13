Return-Path: <dlazzari@leapfrog.com>
Received: from mx3.leapfrog.com (mx3.leapfrog.com [63.114.26.253])
	by mail.openembedded.org (Postfix) with ESMTP id 7916065EAC
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Apr 2014 23:18:39 +0000 (UTC)
Received: from NAEMCASHT01.na.leapfrog.com (unknown [10.12.2.37])
	by mx3.leapfrog.com (Postfix) with ESMTP id 0E5E9615D
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 13 Apr 2014 16:18:28 -0700 (PDT)
Received: from NAEMMAIL01.na.leapfrog.com ([fe80::252e:28a6:3d8f:6991]) by
	NAEMCASHT01.na.leapfrog.com ([::1]) with mapi id 14.01.0379.000;
	Sun, 13 Apr 2014 16:18:28 -0700
From: Daniel Lazzari <dlazzari@leapfrog.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: Can't clone password protected git repo
Thread-Index: Ac9XbME12beOE+QOTei4dti+GE93Vw==
Date: Sun, 13 Apr 2014 23:18:26 +0000
Message-ID: <E7A9054A5ACABE48B0E540E46E862B0F0139F49EB2@NAEMMAIL01.na.leapfrog.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.2.72]
MIME-Version: 1.0
Subject: Can't clone password protected git repo
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
X-List-Received-Date: Sun, 13 Apr 2014 23:18:41 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_E7A9054A5ACABE48B0E540E46E862B0F0139F49EB2NAEMMAIL01nal_"

--_000_E7A9054A5ACABE48B0E540E46E862B0F0139F49EB2NAEMMAIL01nal_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

There's a project we are trying to pull from a private BitBucket repo. I tr=
ied setting the SRC_URI to something like:
SRC_URI =3D "git://user:pass@bitbucket.org/path/project;protocol=3Dhttps"

but bitbake hangs waiting for the password. Am I missing something? I'm stu=
ck on the ancient bitbake 1.15.2 in case this has been fixed in a later rel=
ease.

Thanks,
Daniel Lazzari Jr.
Firmware Engineer
dlazzari@leapfrog.com

--_000_E7A9054A5ACABE48B0E540E46E862B0F0139F49EB2NAEMMAIL01nal_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style id=3D"owaParaStyle" type=3D"text/css">P {margin-top:0;margin-bottom:=
0;}</style>
</head>
<body ocsi=3D"0" fpstyle=3D"1">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">Hello,<br>
<br>
There's a project we are trying to pull from a private BitBucket repo. I tr=
ied setting the SRC_URI to something like:<br>
SRC_URI =3D &quot;git://user:pass@bitbucket.org/path/project;protocol=3Dhtt=
ps&quot;<br>
<br>
but bitbake hangs waiting for the password. Am I missing something? I'm stu=
ck on the ancient bitbake 1.15.2 in case this has been fixed in a later rel=
ease.<br>
<br>
Thanks,<br>
Daniel Lazzari Jr.<br>
Firmware Engineer<br>
dlazzari@leapfrog.com<br>
</div>
</body>
</html>

--_000_E7A9054A5ACABE48B0E540E46E862B0F0139F49EB2NAEMMAIL01nal_--
