Return-Path: <joe.slater@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
	by mail.openembedded.org (Postfix) with ESMTP id 8061D79F27
	for <bitbake-devel@lists.openembedded.org>;
	Thu,  3 Jan 2019 23:57:15 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
	by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id x03NvFwG008636
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 3 Jan 2019 15:57:16 -0800 (PST)
Received: from ALA-MBD.corp.ad.wrs.com ([169.254.3.138]) by
	ALA-HCB.corp.ad.wrs.com ([147.11.189.41]) with mapi id 14.03.0415.000;
	Thu, 3 Jan 2019 15:57:03 -0800
From: "Slater, Joseph" <joe.slater@windriver.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: /run/user/<id>/bb
Thread-Index: AdSjwAZNvzqBZKMyRUWDYcLm1JFf5A==
Date: Thu, 3 Jan 2019 23:57:03 +0000
Message-ID: <007BD92917A2324FA403BCF9A464CF84F3723F13@ALA-MBD.corp.ad.wrs.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [147.11.117.235]
MIME-Version: 1.0
Subject: /run/user/<id>/bb
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
X-List-Received-Date: Thu, 03 Jan 2019 23:57:15 -0000
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_007BD92917A2324FA403BCF9A464CF84F3723F13ALAMBDcorpadwrs_"

--_000_007BD92917A2324FA403BCF9A464CF84F3723F13ALAMBDcorpadwrs_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

TMPDIR is useful, but named sockets need a "short" pathname, so it it might=
 be nice to have a RUNDIR, or something similar, under /run/user/<id>/bb.  =
Could this be added?  I would do it if the concept is accepted.

Joe


--_000_007BD92917A2324FA403BCF9A464CF84F3723F13ALAMBDcorpadwrs_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" id=3D"owaParaStyle"></style>
</head>
<body fpstyle=3D"1" ocsi=3D"0">
<div style=3D"direction: ltr;font-family: Tahoma;color: #000000;font-size: =
10pt;">TMPDIR is useful, but named sockets need a &quot;short&quot; pathnam=
e, so it it might be nice to have a RUNDIR, or something similar, under /ru=
n/user/&lt;id&gt;/bb. &nbsp;Could this be added? &nbsp;I would
 do it if the concept is accepted.
<div><br>
</div>
<div>Joe</div>
<div><br>
</div>
</div>
</body>
</html>

--_000_007BD92917A2324FA403BCF9A464CF84F3723F13ALAMBDcorpadwrs_--
