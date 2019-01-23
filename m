Return-Path: <juan.jose.aguilar.linares@everis.com>
X-Greylist: delayed 587 seconds by postgrey-1.34 at layers.openembedded.org;
	Wed, 23 Jan 2019 15:28:25 UTC
Received: from mail7.everis.com (mail7.everis.com [217.124.188.170])
	by mail.openembedded.org (Postfix) with ESMTP id 1C4416BE46
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 Jan 2019 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=everis.com; s=20180516; t=1548257307;
	h=from:to:subject:date:message-id:mime-version;
	bh=ZKXKPgcEK3A3kdCWTvD6UQCRiCRAx3mp/2K52ey3DGM=;
	b=xpXyj6eC7yd0P1hXo/MWMvFgU3ZUwCcAPsH5t0u6enYYT2hmPfjPofqO
	hhr4cOduQY9JhV2CcRjLiIkdWzJ7UqLKeCKpAq8XBKl2ip5h/EySDW12Z
	p8e/behz8R3b1VJuNthWbEsiGNxsuix2dLne4OeX8xp5Yw0GbuPCspEcC 8=;
X-IronPort-AV: E=Sophos;i="5.56,511,1539640800"; d="scan'208,217";a="86115049"
Received: from unknown (HELO SMAD01PMSHY01.usersad.everis.int) ([10.108.61.13])
	by mail7.everis.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	23 Jan 2019 16:18:38 +0100
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (104.47.14.58) by
	hub365.everis.com (10.108.61.246) with Microsoft SMTP Server (TLS) id
	14.3.339.0; Wed, 23 Jan 2019 16:18:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=everisgroup.onmicrosoft.com; s=selector1-everis-com;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=veYk6IKZMX6R7/YA11EAHjUBimsy9uTD4epxa7lMDh8=;
	b=NEJcvmry0/G8po01n66maRx3DYKcku1FtVy+JiOJ09XkYj0hZgObryAujdol7h4Tgo8VAmO+HXDXspG2GPAYmug7w9ZPlbsriQhmcdE5Xbs6MqaaX8B+JOxkdw+KGWjRLoXUPE4xxdRrfofuDc3kC3sbLRpoyC9ZNHbOPPidmsM=
Received: from AM0PR03MB4145.eurprd03.prod.outlook.com (20.176.214.74) by
	AM0PR03MB4388.eurprd03.prod.outlook.com (20.176.215.97) with Microsoft
	SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
	15.20.1537.31; Wed, 23 Jan 2019 15:18:37 +0000
Received: from AM0PR03MB4145.eurprd03.prod.outlook.com
	([fe80::7c77:a4a2:8936:4812]) by
	AM0PR03MB4145.eurprd03.prod.outlook.com
	([fe80::7c77:a4a2:8936:4812%5]) with mapi id 15.20.1537.031;
	Wed, 23 Jan 2019 15:18:37 +0000
From: Juan Jose Aguilar Linares <juan.jose.aguilar.linares@everis.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: eSDK 
Thread-Index: AdSzLq0ICfn39YVwRLyiCZuw+s7GlQ==
Date: Wed, 23 Jan 2019 15:18:37 +0000
Message-ID: <AM0PR03MB414523FD870737F89E5A31538D990@AM0PR03MB4145.eurprd03.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
	smtp.mailfrom=juan.jose.aguilar.linares@everis.com; 
x-originating-ip: [80.28.149.192]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM0PR03MB4388;
	6:yYICzo6/4svAF5CKCtpC3R7QbLOttW+mQRL61SaAvJ38Wk9hnnFFCQCu9a0EWlgWKwL8864Nmxr657jHQOxPrTqmMvUzdJjvo7bwRqOLH5RS0aESwkT6Vs1SLH7Er+7kycqvNpwAICMKGbguU7/Uoks9LK248Byr+Z5qvSuqPT2iw/v/q7n3osFBLTlMyzytTD0k92YhGupGMR9eACTbjJ91ovnpz3h/Z5QVxitob2BVdYBNRnqUIQkt/pIZpSFKdtYG6M7Dbv3+3sFvvQ3h2p8kdjkMtA3eLrl8/+MqmOATj2d9m8dNP0rBTbINSFwRFHUDrdFu++fXSniRC7ar0/sFn72BKtwIKZf62Z5Gpmn2SfH8tOlCN0S/HLIH8KLfL7bL1gZo/zt2t0tjc47VVXlrA2TxbnVLqG1D3n5GfGcoVE8viE80ZgJEpu997vrUJ3BuFa7fa3O8eF+H7Lb72A==;
	5:EhWRj2Vd6hru9YYJpuNMqaHQ3i0ltlnruG2VVZDoFU/7ilNI7F45r8lwfRqSnCmssh8oRuHfiw93RvJKeBfxKNYW8T4FEyLhvPakF1g2hqIP+hP6J5VL73ID39Pgmckms+Rt5/Zt6v9TryixSrIst3v6ICEncrEXhq/nlV+FHy1CD18N153eyBB53jD4d90zDRMkN+kbd6EWadr/+4Ls+Q==;
	7:HhDZ2RO9i8rP1t+UUf8zbYQNYD/N3zBeg3IeXYZwFSxT5dKjTXg8eFYl03BuMoQM4kwXLxte2rb2rpIfFLFFaSLgPfZ7+vIu63QmtXsxU2luZNJWlapYcBfy52q/0Eyz23uqYuB8jZC+0aN3VHTiuw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 48093e75-8227-435b-bb0d-08d681460c84
x-microsoft-antispam: BCL:0; PCL:0;
	RULEID:(2390118)(7020095)(4652040)(8989299)(5600110)(711020)(4605077)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);
	SRVR:AM0PR03MB4388; 
x-ms-traffictypediagnostic: AM0PR03MB4388:
x-microsoft-antispam-prvs: <AM0PR03MB438834459C65DEA1F048970F8D990@AM0PR03MB4388.eurprd03.prod.outlook.com>
x-forefront-prvs: 0926B0E013
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10019020)(39860400002)(396003)(376002)(346002)(366004)(136003)(199004)(189003)(8936002)(256004)(7696005)(19627235002)(218053001)(14444005)(86362001)(54896002)(6306002)(9686003)(790700001)(6116002)(3846002)(106356001)(2501003)(6506007)(486006)(2351001)(55016002)(3480700005)(102836004)(5640700003)(71190400001)(68736007)(71200400001)(413944005)(14454004)(478600001)(7736002)(66066001)(476003)(6436002)(25786009)(33656002)(186003)(53936002)(26005)(74316002)(4743002)(316002)(7116003)(8676002)(81166006)(81156014)(97736004)(6916009)(105586002)(2906002)(99286004)(124863001);
	DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR03MB4388;
	H:AM0PR03MB4145.eurprd03.prod.outlook.com; FPR:; SPF:None;
	LANG:en; PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: /fxWSoZ3GeYvxUXg8s/0j9p/nNM19bNYDj+SJ7qTksQrHWU6X66K688g02juGTqSPPKLxQU81AfTNAGKL6UWKWER2972LlqjcVQ7hNzcgFcIiZ0t5Q8OQpLJhj3h3F6g1rCdjx1O1QUIieukMpLZVsRCzCCiPEPn2ftGqcsJglmvZ10kaXISwdALUJX6pPDK6l4Weum6OT6JeCj0pDb5ZeGEu1BNICK68Y9QkK4I4mGUFwhjoEZ9Dk4iACGcv0845iO41xMgB+YGAdXEROkR7k1PAq9nJi5Gf9ijMoIfbfdc1X3+/ZfxfDSLbTFYJ6t3x5cUVfHxnugmOfpYFX3Y69ftJ00aMzx5SAM2tjbqkdP6430GZhCkDCEAmpdkYIemQCVGdFb2/jQFuutp9a/gmB2X94RQ8QfrHvWMg/kRiWk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 48093e75-8227-435b-bb0d-08d681460c84
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2019 15:18:37.6182 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3048dc87-43f0-4100-9acb-ae1971c79395
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB4388
X-OriginatorOrg: everis.com
X-Mailman-Approved-At: Thu, 24 Jan 2019 12:42:15 +0000
Subject: eSDK
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
X-List-Received-Date: Wed, 23 Jan 2019 15:28:26 -0000
Content-Language: es-ES
Content-Type: multipart/alternative;
	boundary="_000_AM0PR03MB414523FD870737F89E5A31538D990AM0PR03MB4145eurp_"

--_000_AM0PR03MB414523FD870737F89E5A31538D990AM0PR03MB4145eurp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Dear Yocto Team, I have practically no experience in yocto. I=E2=80=99m try=
ing to modify the snmp sources
to add a mib module and I have read that I need to install "devtool".

I execute the following commad.

$ bitbake fsl-image-gui -c populate_sdk_ext

Then, when I execute the generated script to install extensible sdk I get t=
he following error message:

defense@Defense:~/fsl-release-bsp/testBuild/tmp/deploy/sdk$ ./fsl-imx-x11-g=
libc-x86_64-fsl-image-gui-cortexa9hf-neon-toolchain-ext-4.1.15-2.1.0.sh
Freescale i.MX Release Distro Extensible SDK installer version 4.1.15-2.1.0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Enter target directory for SDK (default: ~/fsl-imx-x11_sdk): ~/fsl-imx-x11-=
sdk-0
You are about to install the SDK to "/home/defense/fsl-imx-x11-sdk-0". Proc=
eed[Y/n]? Y
Extracting SDK.............................................................=
..........................................done
Setting it up...
Extracting buildtools...
Preparing build system...
ERROR: SDK preparation failed: see /home/defense/fsl-imx-x11-sdk-0/preparin=
g_build_system.log

### Shell environment set up for builds. ###

You can now run 'bitbake <target>'

Common targets are:
    core-image-minimal
    core-image-sato
    meta-toolchain
    meta-ide-support

You can also run generated qemu images with a command like 'runqemu qemux86=
'
Preparing SDK for fsl-image-gui...
Parsing recipes...WARNING: /home/defense/fsl-imx-x11-sdk-0/layers/meta-sdk/=
recipes-qt5/qt5/gstreamer1.0-plugins-bad-qt_1.8.1.bb: Unable to get checksu=
m for gstreamer1.0-plugins-bad-qt SRC_URI entry 0001-introspection.m4-prefi=
x-pkgconfig-paths-with-PKG_CON.patch: file could not be found
WARNING: /home/defense/fsl-imx-x11-sdk-0/layers/meta-sdk/recipes-qt5/qt5/gs=
treamer1.0-plugins-bad-qt_1.8.1.bb: Unable to get checksum for gstreamer1.0=
-plugins-bad-qt SRC_URI entry 0001-Makefile.am-don-t-hardcode-libtool-name-=
when-running.patch: file could not be found
WARNING: /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia=
/gstreamer/gstreamer1.0_1.8.1.bb: Unable to get checksum for gstreamer1.0 S=
RC_URI entry 0001-introspection.m4-prefix-pkgconfig-paths-with-PKG_CON.patc=
h: file could not be found
WARNING: /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia=
/gstreamer/gstreamer1.0-rtsp-server_1.8.1.bb: Unable to get checksum for gs=
treamer1.0-rtsp-server SRC_URI entry 0001-Don-t-hardcode-libtool-name-when-=
using-introspection.patch: file could not be found
WARNING: /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia=
/gstreamer/gstreamer1.0-rtsp-server_1.8.1.bb: Unable to get checksum for gs=
treamer1.0-rtsp-server SRC_URI entry 0001-introspection.m4-prefix-pkgconfig=
-paths-with-PKG_CON.patch: file could not be found
WARNING: /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia=
/gstreamer/gstreamer1.0-plugins-good_1.8.1.bb: Unable to get checksum for g=
streamer1.0-plugins-good SRC_URI entry 0001-introspection.m4-prefix-pkgconf=
ig-paths-with-PKG_CON.patch: file could not be found
WARNING: /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia=
/gstreamer/gstreamer1.0-plugins-base_1.8.1.bb: Unable to get checksum for g=
streamer1.0-plugins-base SRC_URI entry 0001-introspection.m4-prefix-pkgconf=
ig-paths-with-PKG_CON.patch: file could not be found
WARNING: /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia=
/gstreamer/gstreamer1.0-plugins-base_1.8.1.bb: Unable to get checksum for g=
streamer1.0-plugins-base SRC_URI entry 0001-Makefile.am-don-t-hardcode-libt=
ool-name-when-running.patch: file could not be found
WARNING: /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia=
/gstreamer/gstreamer1.0-plugins-base_1.8.1.bb: Unable to get checksum for g=
streamer1.0-plugins-base SRC_URI entry 0002-Makefile.am-prefix-calls-to-pkg=
-config-with-PKG_CONF.patch: file could not be found
WARNING: /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia=
/gstreamer/gstreamer1.0-plugins-base_1.8.1.bb: Unable to get checksum for g=
streamer1.0-plugins-base SRC_URI entry 0003-riff-add-missing-include-direct=
ories-when-calling-in.patch: file could not be found
WARNING: /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia=
/gstreamer/gstreamer1.0-plugins-base_1.8.1.bb: Unable to get checksum for g=
streamer1.0-plugins-base SRC_URI entry 0004-rtsp-drop-incorrect-reference-t=
o-gstreamer-sdp-in-Ma.patch: file could not be found
WARNING: /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia=
/gstreamer/gstreamer1.0-plugins-bad_1.8.1.bb: Unable to get checksum for gs=
treamer1.0-plugins-bad SRC_URI entry 0001-introspection.m4-prefix-pkgconfig=
-paths-with-PKG_CON.patch: file could not be found
WARNING: /home/defense/fsl-imx-x11-sdk-0/layers/meta-bsp/recipes-multimedia=
/gstreamer/gstreamer1.0-plugins-bad_1.8.1.bb: Unable to get checksum for gs=
treamer1.0-plugins-bad SRC_URI entry 0001-Makefile.am-don-t-hardcode-libtoo=
l-name-when-running.patch: file could not be found
done.
Parsing of 2219 .bb files complete (0 cached, 2219 parsed). 2794 targets, 2=
10 skipped, 5 masked, 0 errors.
NOTE: Resolving any missing task queue dependencies
ERROR: Uninative selected but not configured, please set UNINATIVE_URL

Summary: There were 13 WARNING messages shown.
Summary: There was 1 ERROR message shown, returning a non-zero exit code.



I have reviewed mailing list and I=E2=80=99ve found some useful information=
 but I don=E2=80=99t understand the problem.

Could you help me to solve the error or give me some guidelines to do it?

Thanks,

Juanjo.



________________________________

AVISO DE CONFIDENCIALIDAD.
Este correo y la informaci=C3=B3n contenida o adjunta al mismo es privada y=
 confidencial y va dirigida exclusivamente a su destinatario. everis inform=
a a quien pueda haber recibido este correo por error que contiene informaci=
=C3=B3n confidencial cuyo uso, copia, reproducci=C3=B3n o distribuci=C3=B3n=
 est=C3=A1 expresamente prohibida. Si no es Vd. el destinatario del mismo y=
 recibe este correo por error, le rogamos lo ponga en conocimiento del emis=
or y proceda a su eliminaci=C3=B3n sin copiarlo, imprimirlo o utilizarlo de=
 ning=C3=BAn modo.

CONFIDENTIALITY WARNING.
This message and the information contained in or attached to it are private=
 and confidential and intended exclusively for the addressee. everis inform=
s to whom it may receive it in error that it contains privileged informatio=
n and its use, copy, reproduction or distribution is prohibited. If you are=
 not an intended recipient of this E-mail, please notify the sender, delete=
 it and do not read, act upon, print, disclose, copy, retain or redistribut=
e any portion of this E-mail.

--_000_AM0PR03MB414523FD870737F89E5A31538D990AM0PR03MB4145eurp_
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EstiloCorreo17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:70.85pt 3.0cm 70.85pt 3.0cm;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"ES" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span lang=3D"EN-US">Dear Yocto Team, I have practic=
ally no experience in yocto. I=E2=80=99m trying to modify the snmp sources
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">to add a mib module and I have =
read that I need to install &quot;devtool&quot;.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I execute the following commad.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">$ bitbake fsl-image-gui -c popu=
late_sdk_ext<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Then, when I execute the genera=
ted script to install extensible sdk I get the following error message:<o:p=
></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">defense@Defense:~/fsl-release-b=
sp/testBuild/tmp/deploy/sdk$ ./fsl-imx-x11-glibc-x86_64-fsl-image-gui-corte=
xa9hf-neon-toolchain-ext-4.1.15-2.1.0.sh
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Freescale i.MX Release Distro E=
xtensible SDK installer version 4.1.15-2.1.0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Enter target directory for SDK =
(default: ~/fsl-imx-x11_sdk): ~/fsl-imx-x11-sdk-0<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">You are about to install the SD=
K to &quot;/home/defense/fsl-imx-x11-sdk-0&quot;. Proceed[Y/n]? Y<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Extracting SDK.................=
...........................................................................=
...........done<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Setting it up...<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Extracting buildtools...<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Preparing build system...<o:p><=
/o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">ERROR: SDK preparation failed: =
see /home/defense/fsl-imx-x11-sdk-0/preparing_build_system.log<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">### Shell environment set up fo=
r builds. ###<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">You can now run 'bitbake &lt;ta=
rget&gt;'<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Common targets are:<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; core-image-m=
inimal<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; core-image-s=
ato<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; meta-toolcha=
in<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">&nbsp;&nbsp;&nbsp; meta-ide-sup=
port<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">You can also run generated qemu=
 images with a command like 'runqemu qemux86'<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Preparing SDK for fsl-image-gui=
...<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Parsing recipes...WARNING: /hom=
e/defense/fsl-imx-x11-sdk-0/layers/meta-sdk/recipes-qt5/qt5/gstreamer1.0-pl=
ugins-bad-qt_1.8.1.bb: Unable to get checksum for gstreamer1.0-plugins-bad-=
qt SRC_URI entry 0001-introspection.m4-prefix-pkgconfig-paths-with-PKG_CON.=
patch:
 file could not be found<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">WARNING: /home/defense/fsl-imx-=
x11-sdk-0/layers/meta-sdk/recipes-qt5/qt5/gstreamer1.0-plugins-bad-qt_1.8.1=
.bb: Unable to get checksum for gstreamer1.0-plugins-bad-qt SRC_URI entry 0=
001-Makefile.am-don-t-hardcode-libtool-name-when-running.patch:
 file could not be found<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">WARNING: /home/defense/fsl-imx-=
x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0_1.8.1.b=
b: Unable to get checksum for gstreamer1.0 SRC_URI entry 0001-introspection=
.m4-prefix-pkgconfig-paths-with-PKG_CON.patch:
 file could not be found<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">WARNING: /home/defense/fsl-imx-=
x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-rtsp-se=
rver_1.8.1.bb: Unable to get checksum for gstreamer1.0-rtsp-server SRC_URI =
entry 0001-Don-t-hardcode-libtool-name-when-using-introspection.patch:
 file could not be found<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">WARNING: /home/defense/fsl-imx-=
x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-rtsp-se=
rver_1.8.1.bb: Unable to get checksum for gstreamer1.0-rtsp-server SRC_URI =
entry 0001-introspection.m4-prefix-pkgconfig-paths-with-PKG_CON.patch:
 file could not be found<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">WARNING: /home/defense/fsl-imx-=
x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-plugins=
-good_1.8.1.bb: Unable to get checksum for gstreamer1.0-plugins-good SRC_UR=
I entry 0001-introspection.m4-prefix-pkgconfig-paths-with-PKG_CON.patch:
 file could not be found<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">WARNING: /home/defense/fsl-imx-=
x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-plugins=
-base_1.8.1.bb: Unable to get checksum for gstreamer1.0-plugins-base SRC_UR=
I entry 0001-introspection.m4-prefix-pkgconfig-paths-with-PKG_CON.patch:
 file could not be found<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">WARNING: /home/defense/fsl-imx-=
x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-plugins=
-base_1.8.1.bb: Unable to get checksum for gstreamer1.0-plugins-base SRC_UR=
I entry 0001-Makefile.am-don-t-hardcode-libtool-name-when-running.patch:
 file could not be found<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">WARNING: /home/defense/fsl-imx-=
x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-plugins=
-base_1.8.1.bb: Unable to get checksum for gstreamer1.0-plugins-base SRC_UR=
I entry 0002-Makefile.am-prefix-calls-to-pkg-config-with-PKG_CONF.patch:
 file could not be found<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">WARNING: /home/defense/fsl-imx-=
x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-plugins=
-base_1.8.1.bb: Unable to get checksum for gstreamer1.0-plugins-base SRC_UR=
I entry 0003-riff-add-missing-include-directories-when-calling-in.patch:
 file could not be found<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">WARNING: /home/defense/fsl-imx-=
x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-plugins=
-base_1.8.1.bb: Unable to get checksum for gstreamer1.0-plugins-base SRC_UR=
I entry 0004-rtsp-drop-incorrect-reference-to-gstreamer-sdp-in-Ma.patch:
 file could not be found<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">WARNING: /home/defense/fsl-imx-=
x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-plugins=
-bad_1.8.1.bb: Unable to get checksum for gstreamer1.0-plugins-bad SRC_URI =
entry 0001-introspection.m4-prefix-pkgconfig-paths-with-PKG_CON.patch:
 file could not be found<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">WARNING: /home/defense/fsl-imx-=
x11-sdk-0/layers/meta-bsp/recipes-multimedia/gstreamer/gstreamer1.0-plugins=
-bad_1.8.1.bb: Unable to get checksum for gstreamer1.0-plugins-bad SRC_URI =
entry 0001-Makefile.am-don-t-hardcode-libtool-name-when-running.patch:
 file could not be found<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">done.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Parsing of 2219 .bb files compl=
ete (0 cached, 2219 parsed). 2794 targets, 210 skipped, 5 masked, 0 errors.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">NOTE: Resolving any missing tas=
k queue dependencies<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">ERROR: Uninative selected but n=
ot configured, please set UNINATIVE_URL<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Summary: There were 13 WARNING =
messages shown.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Summary: There was 1 ERROR mess=
age shown, returning a non-zero exit code.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">I have reviewed mailing list an=
d I=E2=80=99ve found some useful information but I don=E2=80=99t understand=
 the problem.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Could you help me to solve the =
error or give me some guidelines to do it?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Thanks,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US">Juanjo.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<br>
<hr>
<font face=3D"Arial" color=3D"Gray" size=3D"1"><br>
AVISO DE CONFIDENCIALIDAD.<br>
Este correo y la informaci=C3=B3n contenida o adjunta al mismo es privada y=
 confidencial y va dirigida exclusivamente a su destinatario. everis inform=
a a quien pueda haber recibido este correo por error que contiene informaci=
=C3=B3n confidencial cuyo uso, copia, reproducci=C3=B3n
 o distribuci=C3=B3n est=C3=A1 expresamente prohibida. Si no es Vd. el dest=
inatario del mismo y recibe este correo por error, le rogamos lo ponga en c=
onocimiento del emisor y proceda a su eliminaci=C3=B3n sin copiarlo, imprim=
irlo o utilizarlo de ning=C3=BAn modo.<br>
<br>
CONFIDENTIALITY WARNING.<br>
This message and the information contained in or attached to it are private=
 and confidential and intended exclusively for the addressee. everis inform=
s to whom it may receive it in error that it contains privileged informatio=
n and its use, copy, reproduction
 or distribution is prohibited. If you are not an intended recipient of thi=
s E-mail, please notify the sender, delete it and do not read, act upon, pr=
int, disclose, copy, retain or redistribute any portion of this E-mail.<br>
</font>
</body>
</html>

--_000_AM0PR03MB414523FD870737F89E5A31538D990AM0PR03MB4145eurp_--
