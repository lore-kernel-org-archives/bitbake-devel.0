Return-Path: <ari.parkkila@qt.io>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE85EB64D7
	for <webhook@archiver.kernel.org>; Mon, 26 Jun 2023 10:03:03 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.127])
 by mx.groups.io with SMTP id smtpd.web10.4207.1687773776571315922
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 26 Jun 2023 03:02:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@qt.io header.s=selector2 header.b=I6wWr1iC;
 spf=pass (domain: qt.io, ip: 40.107.8.127, mailfrom: ari.parkkila@qt.io)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KB9xFGUaNEK3hbSbbVFWos/uO5TMXkq+iQPyh78jckbBkh8b2PC/oOd61IjKHjJSYIVdBL9epzoFolppDXP/bXBnxqNiBi/AG9TDuveV9BGHmsnZrzOsOiDtSkx5JT8wpYFKQz6UbvbiTtzRVnJ7xphFry5hERSzO1XmX6CxZ+JJUZKtEhHl6+yUnKDD64alepsdOE08THNhrE6XKTmovhnjNLwunwYlP5xNNSTooYCPkeUByTPplh59/uiy8/n6RAT/ksHceyeispCJEowrdtZFD/za2Yk+0yFmTFmqbQXKfIhYV10pgwgsX4BE4sh5vXiebBeGm94AKaFj9ZyuAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjo2L+TvgDDRK9zqPDLrj0IgOQ4SAlm6FQb4oF4b9jU=;
 b=SJLoW/N9nMQYPNhoswI8J0WXszX0no+cVoeuEqJ1rS1+NVph7/eGgSG2FsAZIK4tpZNR131PXKcb41swXx5UUiPWCHsJWc5Xg6ZTGBC9fHpn+X6RlRUS6lIIMH04EJnvqWDMs/FyMI/brr5oWUn8oaU2UmgLsTXiwp3mTQGeMRY5zR68b2GSPIlXJ0d6mnp7AonaIfPAkRbQN+Vl+TrB+e1gMCJSaX0zwbC4S7Y0FvsrjT3TP/C61R1AQl5KbPvGvxkphbGVRVqTlbC5RdJRSkGyQt66/5i9J+k8HVNXV+azeHZA4sv7zwOPGA8nehBrSjxNfkPZSW64/91wzsdAFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qt.io; dmarc=pass action=none header.from=qt.io; dkim=pass
 header.d=qt.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qt.io; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjo2L+TvgDDRK9zqPDLrj0IgOQ4SAlm6FQb4oF4b9jU=;
 b=I6wWr1iCQFCBbcY70FCl7FZOaonUsYZQKyEkXvHM61iZakSZ8+4GsJozmLOQyfYg1XqhNyJEMGEe5606fzJL6deHFggoc2rxbBfgofoQUqjIdQfofKhb8eeYCGUYbQpTTvVaJHrqEBzLnTtJ9YUhlIl2sQZVfD7eoi7x3NRO4Yk=
Received: from AS4PR02MB8184.eurprd02.prod.outlook.com (2603:10a6:20b:4cf::19)
 by DB4PR02MB9558.eurprd02.prod.outlook.com (2603:10a6:10:3f5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.11; Mon, 26 Jun
 2023 10:02:50 +0000
Received: from AS4PR02MB8184.eurprd02.prod.outlook.com
 ([fe80::755b:1f23:bcf:a32e]) by AS4PR02MB8184.eurprd02.prod.outlook.com
 ([fe80::755b:1f23:bcf:a32e%4]) with mapi id 15.20.6544.008; Mon, 26 Jun 2023
 10:02:50 +0000
From: Ari Parkkila <Ari.Parkkila@qt.io>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Bitbake race failure with BBMULTICONFIG and setscene
Thread-Topic: Bitbake race failure with BBMULTICONFIG and setscene
Thread-Index: AQHZqAonmymSlY/aK0ykt0+3zZ2VcQ==
Date: Mon, 26 Jun 2023 10:02:50 +0000
Message-ID: 
 <AS4PR02MB81841D675E74F5FC5444743D8426A@AS4PR02MB8184.eurprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qt.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR02MB8184:EE_|DB4PR02MB9558:EE_
x-ms-office365-filtering-correlation-id: d89bba59-76fe-42a4-c652-08db762c8002
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 t1HX2oSUqxt9xlST0348ZF+pQmj/kEewGOO9rEuwuuhaVA/2AToeN/3Caswu3CjyPbIUSMoCWFiFXkph4JVVzNPcldNiP6Ck+EKtbNL6Fmh9Y7MjruRv15RRgM+e8Ql6wwVKPJFGzYS168SCI1HHpribrf/CD9dWPXfMljyoke+CvTsZ4Pt8Y2wRoajmdQDkpYgRPZev+6PZKncV3wX7DV+TGyid4V3LWXZRYvlkQ7XC/9pz78djale4/W7kZhksJCaPrg34/5OjAnyYzSE+k5I548ixkeCRsO4Muqhn1MitHzYXd66obt45Oo3c5S3FEwRLLbRlzey+bk70zb2Bxa45FR/W4FIAGXv5Re8U2N40iQHcjgFZ9Iw6pNrzdLf2TnxrJtzQl4k75xRvsQMUCdTkQdZwE4bD70UF27efiwVFfSTVXgO9rQFs3dCYeSj2ZzNQI151BhRoQc6a6cv0Cn1+cu472j2d6Ja4mP1cwPgP0Wa4dbgN6+qgjXwRYDyUAn5Du3Czv7d5UKf/nH9Ec88Dp49EAM8DUD6GeiWS+7KKc2x7/JR1D70YrpP58JpH9V+iL1Rvw359QUJNlTxYvVvMRT/u+wLFm2FrpPLZG8g=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR02MB8184.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(136003)(346002)(366004)(376002)(396003)(451199021)(19627405001)(26005)(186003)(2906002)(55016003)(38070700005)(33656002)(8676002)(6916009)(7696005)(966005)(478600001)(86362001)(316002)(122000001)(38100700002)(71200400001)(41300700001)(52536014)(5660300002)(83380400001)(91956017)(8936002)(66446008)(66556008)(66946007)(76116006)(64756008)(66476007)(6506007)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?OVtLXMyNFUtBFd6b9ofW3ribXYmwXYwq6HNleKa6o5zlczIdW/Irxb0H9O?=
 =?iso-8859-1?Q?hXYd3SoyLRzgkq5Qne1KGBxM5z7JUMS7bXi00IO6GxDv/3nbKKsRCkDgn2?=
 =?iso-8859-1?Q?BULAgNAmUUW4YNS3SpSOMSOFuWgZnZOIjKjqNTueGryoKIQmZyI1leBy5s?=
 =?iso-8859-1?Q?OJSlZFGOu9MH2UKPJmRaaH3nRaFgGGs9nY5wra229zRaUN6ggJHxc4w3o2?=
 =?iso-8859-1?Q?PUjTlBcaAVDiNJ2VZF0N9ZY+ZYwLxBP6OGGDs+/U/oFSeq3BFPJCesxcY3?=
 =?iso-8859-1?Q?IBHtQgUdZrRdU19H6VNLLVJwpsd7LJ9m8sGXoAzQIDGi7AfxHv7waOJP9U?=
 =?iso-8859-1?Q?BL0YiHARMOC/u8JlxnFQoQ4Sv0A7ynL/p70izUQTX9AhzrirqNpfWjcCzP?=
 =?iso-8859-1?Q?yyuVCPA+8C6GSioQCT086idp21asMog83Qtr3OR/v4/wOOF/xK476Hdl/G?=
 =?iso-8859-1?Q?mtqfMjGQf62g/lLED/WQX8sDjgSNuqTr9v1CLjZKp3CKKKw+0lKcxiEkyA?=
 =?iso-8859-1?Q?ZoEC0C7k9wIS7m6AzmQRQ3OUq0vI0IDPB4ZpUfxZO9nbz5lAqUzXrOgIum?=
 =?iso-8859-1?Q?pSRuGlOdsMdmoH9ZxYNvISt8aiX8ra505RECa7LjnbADeRNH5+Z4bRYiuq?=
 =?iso-8859-1?Q?l2BrFLmBUS7vCUmZv0M06pWBWWzuD1PxZ4+jQknI3iLAUqtjdHz53RXXnA?=
 =?iso-8859-1?Q?Cn/KpdQargHe3S2v3HocqKTEq22YXWKtKbEWnwnAbsqiV/HawSWuUK7GgW?=
 =?iso-8859-1?Q?lFWG8o5uAVI1LsoPTwp8shnitnPOD7YyqIemQC1aU7M8FuTi+9xEIsuAxF?=
 =?iso-8859-1?Q?cLYIIGQ22KCzk5SMvhCwlAzozrAM2CNxWLykgpjfWPn/QtopIbADtGo0mf?=
 =?iso-8859-1?Q?+fcAxEq9Moqh6nDQX3vCpvRS8c18jzKJ2p38ZnUOAbctJNyf9t6rI1rtPr?=
 =?iso-8859-1?Q?8L8WShX4Q45hqs/v/w5IYvFWVKInkhei7vB5kHtoC6n1Vx+cNZqOPH2WQ2?=
 =?iso-8859-1?Q?08VJuMM1oBgkjN5N21I6p4AZlrF3aOt+pcNJQPvHqQwhSLVgR+9MRyzyj8?=
 =?iso-8859-1?Q?55RalY58kq6qN3ZfKO4+ZvZPMawCaGGrysqez4HYVCDqPHaoELs4+FuYS+?=
 =?iso-8859-1?Q?LGygAHzk8yo8v2QpJkcdWMsooiRT7yH/M2aDcQhBbVCpFaOwYUm02g/6Tp?=
 =?iso-8859-1?Q?8xHFUWhhFZ7iiLIuJ54Dfif/b7CR0ETlY3B+2IcJLCn5b4R8ojGQxLrD3v?=
 =?iso-8859-1?Q?Ixuhe4iGWD4X9P3XKSD9ZUROWAR2bTsWTutrHnC3/qcwDl96KbEwm/lSvV?=
 =?iso-8859-1?Q?/84enE1X1tsghvEZm6C0Wo0LdThGzuBDtVmU1I4ZEKc7haz7TOXjXKjlR5?=
 =?iso-8859-1?Q?su5k7aEs61flP7Lu5iN7HfW1k2NhkDG445FpZltpPQi3xtbPNA5oVXp2Q8?=
 =?iso-8859-1?Q?XboxgEtn6Y31Dir8OuCiW/vb6lzoicyIu7hXDOQktUdy0nPzU59cZ/EBlx?=
 =?iso-8859-1?Q?yp65TGfKcgJDRRmEfcLQVE0F+qEtKboQ3Sv/sw0YKFtBFrfc1FjuYWU8K5?=
 =?iso-8859-1?Q?L9MjEit3w8FCRkLYIPPxORzOG4+ilVjOzvxuvBVds0rh1jj2SmtrqOqK4S?=
 =?iso-8859-1?Q?nkK7uSPZiMf6o=3D?=
Content-Type: multipart/alternative;
	boundary="_000_AS4PR02MB81841D675E74F5FC5444743D8426AAS4PR02MB8184eurp_"
MIME-Version: 1.0
X-OriginatorOrg: qt.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR02MB8184.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d89bba59-76fe-42a4-c652-08db762c8002
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 10:02:50.1167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 20d0b167-794d-448a-9d01-aaeccc1124ac
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DugzdmzbqASzbfNd6afgkbiYkE1/DxAk+3I67dSR/EcFF6eMhHFZwDG9QR3J7bwcGRBGZJeCf4FqdHQ1CABhAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR02MB9558
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 26 Jun 2023 10:03:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14860

--_000_AS4PR02MB81841D675E74F5FC5444743D8426AAS4PR02MB8184eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Bitbake (or some yocto-4.2.1 configuration) seems to have a race-like probl=
em when running populate_lic with BBMULTICONFIG and setscene. This occurs o=
nly when BBMULTICONFIG has at least two configurations and sstate-cache is =
ready for setscene task, see log below.

--- snip --- snap ---

NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Started
...
NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Started
ERROR: mc:k3r5-hs-fs:glibc-2.37-r1 do_populate_lic_setscene: Error executin=
g a python function in exec_func_python() autogenerated:
The stack trace of python calls that resulted in this exception/failure was=
:
 *** 0002:do_populate_lic_setscene(d)
File: 'poky/meta/classes-global/license.bbclass', lineno: 424, function: do=
_populate_lic_setscene
 *** 0424:    sstate_setscene(d)
File: 'poky/meta/classes-global/sstate.bbclass', lineno: 803, function: sst=
ate_setscene
 *** 0803:    accelerate =3D sstate_installpkg(shared_state, d)
File: 'poky/meta/classes-global/sstate.bbclass', lineno: 402, function: sst=
ate_installpkg
 *** 0402:    return sstate_installpkgdir(ss, d)
File: 'poky/meta/classes-global/sstate.bbclass', lineno: 424, function: sst=
ate_installpkgdir
 *** 0424:        bb.utils.rename(sstateinst + state[0], state[1])
File: 'poky/bitbake/lib/bb/utils.py', lineno: 1778, function: rename
 *** 1778:            raise err
File: 'poky/bitbake/lib/bb/utils.py', lineno: 1772, function: rename
 *** 1772:        os.rename(src, dst)
Exception: FileNotFoundError: [Errno 2] No such file or directory: 'build-a=
m62xx-evm/tmp/work/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/sstate-i=
nstall-populate_lic/license-destdir' -> 'build-am62xx-evm/tmp/work/armv7at2=
hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/license-destdir'
WARNING: Logfile for failed setscene task is build-am62xx-evm/tmp/work/armv=
7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/temp/log.do_populate_lic_setsce=
ne.910886
WARNING: Setscene task (mc:k3r5-hs-fs:poky/meta/recipes-core/glibc/glibc_2.=
37.bb:do_populate_lic_setscene) failed with exit code '1' - real task will =
be run instead
NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Started
ERROR: mc:k3r5-gp:glibc-2.37-r1 do_populate_lic_setscene: Error executing a=
 python function in exec_func_python() autogenerated:
The stack trace of python calls that resulted in this exception/failure was=
:
 *** 0002:do_populate_lic_setscene(d)
File: 'poky/meta/classes-global/license.bbclass', lineno: 424, function: do=
_populate_lic_setscene
 *** 0424:    sstate_setscene(d)
File: 'poky/meta/classes-global/sstate.bbclass', lineno: 803, function: sst=
ate_setscene
 *** 0803:    accelerate =3D sstate_installpkg(shared_state, d)
File: 'poky/meta/classes-global/sstate.bbclass', lineno: 402, function: sst=
ate_installpkg
 *** 0402:    return sstate_installpkgdir(ss, d)
File: 'poky/meta/classes-global/sstate.bbclass', lineno: 424, function: sst=
ate_installpkgdir
 *** 0424:        bb.utils.rename(sstateinst + state[0], state[1])
File: 'poky/bitbake/lib/bb/utils.py', lineno: 1778, function: rename
 *** 1778:            raise err
File: 'poky/bitbake/lib/bb/utils.py', lineno: 1772, function: rename
 *** 1772:        os.rename(src, dst)
Exception: FileNotFoundError: [Errno 2] No such file or directory: 'build-a=
m62xx-evm/tmp/work/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/sstate-i=
nstall-populate_lic/license-destdir' -> 'build-am62xx-evm/tmp/work/armv7at2=
hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/license-destdir'

WARNING: Logfile for failed setscene task is build-am62xx-evm/tmp/work/armv=
7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/temp/log.do_populate_lic_setsce=
ne.910888
WARNING: Setscene task (mc:k3r5-gp:poky/meta/recipes-core/glibc/glibc_2.37.=
bb:do_populate_lic_setscene) failed with exit code '1' - real task will be =
run instead
NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Started
NOTE: recipe glibc-2.37-r1: task do_populate_lic_setscene: Succeeded

--- snip --- snap ---

It seems that multiple tasks are running sstate_installpkgdir() simultaneou=
sly and trying to rename from sstate-install-populate_lic/license-destdir/ =
to license-destdir/. Buildstats indicate also that there might be multiple =
concurrent tasks:
Event: TaskStarted
glibc-2.37-r1: do_populate_lic_setscene
Status: PASSED
Event: TaskStarted
Event: TaskStarted
Event: TaskStarted

I can reproduce this on my machine (with 24 CPUs) quite reliably so I'm hap=
py to try any patches. Here are the steps to repro
- clone https://codereview.qt-project.org/c/yocto/boot2qt-manifest/+/478020
- export MACHINE=3Dam62xx-evm && source ./setup-environment.sh
- bitbake b2qt-embedded-qt6-image # to build sstate-cache
- rm -rf tmp/
- bitbake b2qt-embedded-qt6-image # to copy licenses from sstate-cache

These workarounds are good on my machine:
- Run bitbake multiple times without cleaning tmp/
- Run bitbake with BB_NUMBER_THREADS =3D "1"

Also tried with --no-setscene but that caused maybe unrelated problem:
ERROR: mc:k3r5-hs-se:texinfo-dummy-native-1.0-r0 do_populate_lic: QA Issue:=
 texinfo-dummy-native: LIC_FILES_CHKSUM points to an invalid file: /media/a=
riparkkila/d/ti/build-am62xx-evm/tmp/work/x86_64-linux/texinfo-dummy-native=
/1.0-r0/COPYING [license-checksum]

I'm not very familiar with this but it seems that maybe "license-destdir" s=
hould be named as per each configuration to make sure that BBMULTICONFIGs a=
re not racing for the same folder, and not overriding each others license f=
iles.

--_000_AS4PR02MB81841D675E74F5FC5444743D8426AAS4PR02MB8184eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);" class=3D"elementToProof ContentPasted0">
Bitbake (or some yocto-4.2.1 configuration) seems to have a race-like probl=
em when running populate_lic with BBMULTICONFIG and setscene. This occurs o=
nly when BBMULTICONFIG has at least two configurations and sstate-cache is =
ready for setscene task, see log
 below.
<div><br class=3D"ContentPasted0">
</div>
<div class=3D"ContentPasted0">--- snip --- snap ---</div>
<div><br class=3D"ContentPasted0">
</div>
<div class=3D"ContentPasted0">NOTE: recipe glibc-2.37-r1: task do_populate_=
lic_setscene: Started</div>
<div class=3D"ContentPasted0">...</div>
<div class=3D"ContentPasted0">NOTE: recipe glibc-2.37-r1: task do_populate_=
lic_setscene: Started</div>
<div class=3D"ContentPasted0">ERROR: mc:k3r5-hs-fs:glibc-2.37-r1 do_populat=
e_lic_setscene: Error executing a python function in exec_func_python() aut=
ogenerated:</div>
<div class=3D"ContentPasted0">The stack trace of python calls that resulted=
 in this exception/failure was:</div>
<div class=3D"ContentPasted0">&nbsp;*** 0002:do_populate_lic_setscene(d)</d=
iv>
<div class=3D"ContentPasted0">File: 'poky/meta/classes-global/license.bbcla=
ss', lineno: 424, function: do_populate_lic_setscene</div>
<div class=3D"ContentPasted0">&nbsp;*** 0424: &nbsp; &nbsp;sstate_setscene(=
d)</div>
<div class=3D"ContentPasted0">File: 'poky/meta/classes-global/sstate.bbclas=
s', lineno: 803, function: sstate_setscene</div>
<div class=3D"ContentPasted0">&nbsp;*** 0803: &nbsp; &nbsp;accelerate =3D s=
state_installpkg(shared_state, d)</div>
<div class=3D"ContentPasted0">File: 'poky/meta/classes-global/sstate.bbclas=
s', lineno: 402, function: sstate_installpkg</div>
<div class=3D"ContentPasted0">&nbsp;*** 0402: &nbsp; &nbsp;return sstate_in=
stallpkgdir(ss, d)</div>
<div class=3D"ContentPasted0">File: 'poky/meta/classes-global/sstate.bbclas=
s', lineno: 424, function: sstate_installpkgdir</div>
<div class=3D"ContentPasted0">&nbsp;*** 0424: &nbsp; &nbsp; &nbsp; &nbsp;bb=
.utils.rename(sstateinst + state[0], state[1])</div>
<div class=3D"ContentPasted0">File: 'poky/bitbake/lib/bb/utils.py', lineno:=
 1778, function: rename</div>
<div class=3D"ContentPasted0">&nbsp;*** 1778: &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp;raise err</div>
<div class=3D"ContentPasted0">File: 'poky/bitbake/lib/bb/utils.py', lineno:=
 1772, function: rename</div>
<div class=3D"ContentPasted0">&nbsp;*** 1772: &nbsp; &nbsp; &nbsp; &nbsp;os=
.rename(src, dst)</div>
<div class=3D"ContentPasted0">Exception: FileNotFoundError: [Errno 2] No su=
ch file or directory: 'build-am62xx-evm/tmp/work/armv7at2hf-vfp-poky-linux-=
gnueabi/glibc/2.37-r1/sstate-install-populate_lic/license-destdir' -&gt; 'b=
uild-am62xx-evm/tmp/work/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/li=
cense-destdir'</div>
<div class=3D"ContentPasted0">WARNING: Logfile for failed setscene task is =
build-am62xx-evm/tmp/work/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/t=
emp/log.do_populate_lic_setscene.910886</div>
<div class=3D"ContentPasted0">WARNING: Setscene task (mc:k3r5-hs-fs:poky/me=
ta/recipes-core/glibc/glibc_2.37.bb:do_populate_lic_setscene) failed with e=
xit code '1' - real task will be run instead</div>
<div class=3D"ContentPasted0">NOTE: recipe glibc-2.37-r1: task do_populate_=
lic_setscene: Started</div>
<div class=3D"ContentPasted0">ERROR: mc:k3r5-gp:glibc-2.37-r1 do_populate_l=
ic_setscene: Error executing a python function in exec_func_python() autoge=
nerated:</div>
<div class=3D"ContentPasted0">The stack trace of python calls that resulted=
 in this exception/failure was:</div>
<div class=3D"ContentPasted0">&nbsp;*** 0002:do_populate_lic_setscene(d)</d=
iv>
<div class=3D"ContentPasted0">File: 'poky/meta/classes-global/license.bbcla=
ss', lineno: 424, function: do_populate_lic_setscene</div>
<div class=3D"ContentPasted0">&nbsp;*** 0424: &nbsp; &nbsp;sstate_setscene(=
d)</div>
<div class=3D"ContentPasted0">File: 'poky/meta/classes-global/sstate.bbclas=
s', lineno: 803, function: sstate_setscene</div>
<div class=3D"ContentPasted0">&nbsp;*** 0803: &nbsp; &nbsp;accelerate =3D s=
state_installpkg(shared_state, d)</div>
<div class=3D"ContentPasted0">File: 'poky/meta/classes-global/sstate.bbclas=
s', lineno: 402, function: sstate_installpkg</div>
<div class=3D"ContentPasted0">&nbsp;*** 0402: &nbsp; &nbsp;return sstate_in=
stallpkgdir(ss, d)</div>
<div class=3D"ContentPasted0">File: 'poky/meta/classes-global/sstate.bbclas=
s', lineno: 424, function: sstate_installpkgdir</div>
<div class=3D"ContentPasted0">&nbsp;*** 0424: &nbsp; &nbsp; &nbsp; &nbsp;bb=
.utils.rename(sstateinst + state[0], state[1])</div>
<div class=3D"ContentPasted0">File: 'poky/bitbake/lib/bb/utils.py', lineno:=
 1778, function: rename</div>
<div class=3D"ContentPasted0">&nbsp;*** 1778: &nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp;raise err</div>
<div class=3D"ContentPasted0">File: 'poky/bitbake/lib/bb/utils.py', lineno:=
 1772, function: rename</div>
<div class=3D"ContentPasted0">&nbsp;*** 1772: &nbsp; &nbsp; &nbsp; &nbsp;os=
.rename(src, dst)</div>
<div class=3D"ContentPasted0">Exception: FileNotFoundError: [Errno 2] No su=
ch file or directory: 'build-am62xx-evm/tmp/work/armv7at2hf-vfp-poky-linux-=
gnueabi/glibc/2.37-r1/sstate-install-populate_lic/license-destdir' -&gt; 'b=
uild-am62xx-evm/tmp/work/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/li=
cense-destdir'</div>
<div><br class=3D"ContentPasted0">
</div>
<div class=3D"ContentPasted0">WARNING: Logfile for failed setscene task is =
build-am62xx-evm/tmp/work/armv7at2hf-vfp-poky-linux-gnueabi/glibc/2.37-r1/t=
emp/log.do_populate_lic_setscene.910888</div>
<div class=3D"ContentPasted0">WARNING: Setscene task (mc:k3r5-gp:poky/meta/=
recipes-core/glibc/glibc_2.37.bb:do_populate_lic_setscene) failed with exit=
 code '1' - real task will be run instead</div>
<div class=3D"ContentPasted0">NOTE: recipe glibc-2.37-r1: task do_populate_=
lic_setscene: Started</div>
<div class=3D"ContentPasted0">NOTE: recipe glibc-2.37-r1: task do_populate_=
lic_setscene: Succeeded</div>
<div><br class=3D"ContentPasted0">
</div>
<div class=3D"ContentPasted0">--- snip --- snap ---</div>
<div><br class=3D"ContentPasted0">
</div>
<div class=3D"ContentPasted0">It seems that multiple tasks are running ssta=
te_installpkgdir() simultaneously and trying to rename from sstate-install-=
populate_lic/license-destdir/ to license-destdir/. Buildstats indicate also=
 that there might be multiple concurrent
 tasks:</div>
<div class=3D"ContentPasted0">Event: TaskStarted</div>
<div class=3D"ContentPasted0">glibc-2.37-r1: do_populate_lic_setscene</div>
<div class=3D"ContentPasted0">Status: PASSED</div>
<div class=3D"ContentPasted0">Event: TaskStarted</div>
<div class=3D"ContentPasted0">Event: TaskStarted</div>
<div class=3D"ContentPasted0">Event: TaskStarted</div>
<div><br class=3D"ContentPasted0">
</div>
<div class=3D"ContentPasted0">I can reproduce this on my machine (with 24 C=
PUs) quite reliably so I'm happy to try any patches. Here are the steps to =
repro</div>
<div class=3D"ContentPasted0">- clone https://codereview.qt-project.org/c/y=
octo/boot2qt-manifest/+/478020</div>
<div class=3D"ContentPasted0">- export MACHINE=3Dam62xx-evm &amp;&amp; sour=
ce ./setup-environment.sh</div>
<div class=3D"ContentPasted0">- bitbake b2qt-embedded-qt6-image # to build =
sstate-cache<br>
</div>
<div class=3D"ContentPasted0">- rm -rf tmp/</div>
<div class=3D"ContentPasted0">- bitbake b2qt-embedded-qt6-image # to copy l=
icenses from sstate-cache<br>
</div>
<div><br class=3D"ContentPasted0">
</div>
<div class=3D"ContentPasted0">These workarounds are good on my machine:</di=
v>
<div class=3D"ContentPasted0">- Run bitbake multiple times without cleaning=
 tmp/</div>
<div class=3D"ContentPasted0">- Run bitbake with BB_NUMBER_THREADS =3D &quo=
t;1&quot;</div>
<div class=3D"ContentPasted0"><br>
</div>
<div class=3D"ContentPasted0">Also tried with --no-setscene but that caused=
 maybe unrelated problem:</div>
<div class=3D"ContentPasted0">ERROR: mc:k3r5-hs-se:texinfo-dummy-native-1.0=
-r0 do_populate_lic: QA Issue: texinfo-dummy-native: LIC_FILES_CHKSUM point=
s to an invalid file: /media/ariparkkila/d/ti/build-am62xx-evm/tmp/work/x86=
_64-linux/texinfo-dummy-native/1.0-r0/COPYING
 [license-checksum]</div>
<div><br class=3D"ContentPasted0">
</div>
<div class=3D"ContentPasted0">I'm not very familiar with this but it seems =
that maybe &quot;license-destdir&quot; should be named as per each configur=
ation to make sure that BBMULTICONFIGs are not racing for the same folder, =
and not overriding each others license files.</div>
</div>
</body>
</html>

--_000_AS4PR02MB81841D675E74F5FC5444743D8426AAS4PR02MB8184eurp_--

