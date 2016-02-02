Return-Path: <Diego.SantaCruz@spinetix.com>
X-Greylist: delayed 401 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 02 Feb 2016 14:52:47 UTC
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
	(mail-db5eur01on0076.outbound.protection.outlook.com [104.47.2.76])
	by mail.openembedded.org (Postfix) with ESMTP id 2F5E3771A9
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Feb 2016 14:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=SpinetiX.onmicrosoft.com; s=selector1-spinetix-com;
	h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
	bh=Zue6TDQDoLXgHGwxm7JN8IDYj78qnDHLaqEdRyltWyI=;
	b=o1Bm9+BSleFMMJ992DFzqj+9FqmxJBhyrh5KspP4sge5jqIvXUdeNhlfUl7qtfE9bDgBVCB0UQ5BBe2/kYnrlkSmC5n9mE5/cSGAZJj3akI4zVZ1EV1m1ihH1MaUkVC+XF01irXB1K19tgEiJzLX+OcXiq6T5rRrGe4D+hHw7+w=
Received: from AM3PR01MB1057.eurprd01.prod.exchangelabs.com
	(2a01:111:e400:5874::11) by
	AM3PR01MB1060.eurprd01.prod.exchangelabs.com
	(2a01:111:e400:5875::11) with Microsoft SMTP Server (TLS) id
	15.1.396.15; Tue, 2 Feb 2016 14:37:18 +0000
Received: from AM3PR01MB1057.eurprd01.prod.exchangelabs.com
	([fe80::70ce:60:6ef3:7524]) by
	AM3PR01MB1057.eurprd01.prod.exchangelabs.com
	([fe80::70ce:60:6ef3:7524%15]) with mapi id 15.01.0396.020;
	Tue, 2 Feb 2016 14:37:17 +0000
From: Diego Santa Cruz <Diego.SantaCruz@spinetix.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: bitbake-prserv should not force umask in daemon mode
Thread-Index: AdFdxq6y/cWq5LgMRJ6D7BI5OtrAVg==
Date: Tue, 2 Feb 2016 14:37:17 +0000
Message-ID: <AM3PR01MB10570F1A5431FFE827FAA6C588DF0@AM3PR01MB1057.eurprd01.prod.exchangelabs.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: lists.openembedded.org; dkim=none (message not signed)
	header.d=none; lists.openembedded.org;
	dmarc=none action=none header.from=spinetix.com;
x-originating-ip: [212.147.27.179]
x-microsoft-exchange-diagnostics: 1; AM3PR01MB1060;
	5:n2LriKPgJhKulvRIIEfLt20om2ouBXtkr4Iib1xkSNgmNEnSbKAzHIWiZm/VKFNW8SrGHOvJIiV6/y6AB8/wnrtLffNfdKjR6sx/ml0Kh614P2vP9D9sFH5L4B5Wp0ZwhtocvhC9NTZQBvXYLDbXnw==;
	24:O4inImOrRCE70NXdlfEQV8u7Gn19NqoAtuYCASpKESOcgNGvhiASZdS516/kSI9zrFL6JDdYmm3HuTRJw8umZIsIeAcHabjPofEBuHgFsXU=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:AM3PR01MB1060;
x-ms-office365-filtering-correlation-id: d459d8cb-b4a6-4f2e-ed60-08d32bde59da
x-microsoft-antispam-prvs: <AM3PR01MB1060D2233D4A48E842392A0688DF0@AM3PR01MB1060.eurprd01.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(102415267)(102615245)(601004)(2401047)(8121501046)(5005006)(10201501046)(3002001);
	SRVR:AM3PR01MB1060; BCL:0; PCL:0; RULEID:; SRVR:AM3PR01MB1060; 
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(6009001)(450100001)(16236675004)(6116002)(102836003)(74316001)(790700001)(1220700001)(229853001)(2501003)(2351001)(15975445007)(5250100002)(5890100001)(19300405004)(40100003)(19625215002)(5004730100002)(5008740100001)(5002640100001)(3660700001)(586003)(33656002)(2906002)(66066001)(5003600100002)(5001960100002)(110136002)(107886002)(92566002)(50986999)(54356999)(1096002)(2900100001)(189998001)(3280700002)(86362001)(19580405001)(19580395003)(87936001)(99936001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM3PR01MB1060;
	H:AM3PR01MB1057.eurprd01.prod.exchangelabs.com; FPR:; SPF:None;
	MLV:sfv; LANG:en; 
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: spinetix.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2016 14:37:17.8219 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5f4034fa-ed2d-4840-a93f-acb1e9633b93
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR01MB1060
Subject: bitbake-prserv should not force umask in daemon mode
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
X-List-Received-Date: Tue, 02 Feb 2016 14:52:51 -0000
X-Groupsio-MsgNum: 6966
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_AM3PR01MB10570F1A5431FFE827FAA6C588DF0AM3PR01MB1057eurp_"

--_004_AM3PR01MB10570F1A5431FFE827FAA6C588DF0AM3PR01MB1057eurp_
Content-Type: multipart/alternative;
	boundary="_000_AM3PR01MB10570F1A5431FFE827FAA6C588DF0AM3PR01MB1057eurp_"

--_000_AM3PR01MB10570F1A5431FFE827FAA6C588DF0AM3PR01MB1057eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi there,

And yet one more fix for the PR Service, this is the last one I've found :)=
 For the record I stumbled across this series of issues (this and past e-ma=
ils from today) while setting up a shared PR Service for our internal build=
s.

As reported in bug #9036 [1] clearing the umask when daemonizing the PR Ser=
vice is not a good idea. The attached patch removes this from the daemonize=
 code.

The description I entered in the bug report is the following.

The current bitbake-prserv forces the umask to 0 when daemonizing.

I think his should not be done, as it will make all files be created with p=
ermissions 0777 (world writable!) by default.

For instance, the PID file (/tmp/PRServer_*.pid) is created with permission=
s 0777 on my system (CentOS 7.2.1511).

It would be better to leave the umask unchanged, so whoever is starting bit=
bake-preserv gets to choose the umask it wants to use.

The attached patch does exactly this.

Best regards,

Diego

[1] https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D9036
--
Diego Santa Cruz, PhD
Technology Architect
T +41 21 341 15 50
diego.santacruz@spinetix.com
spinetix.com


--_000_AM3PR01MB10570F1A5431FFE827FAA6C588DF0AM3PR01MB1057eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi there,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">And yet one more fix for the PR Service, this is the=
 last one I&#8217;ve found
<span style=3D"font-family:Wingdings">J</span> For the record I stumbled ac=
ross this series of issues (this and past e-mails from today) while setting=
 up a shared PR Service for our internal builds.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As reported in bug #9036 [1] clearing the umask when=
 daemonizing the PR Service is not a good idea. The attached patch removes =
this from the daemonize code.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The description I entered in the bug report is the f=
ollowing.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The current bitbake-prserv forces the umask to 0 whe=
n daemonizing.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I think his should not be done, as it will make all =
files be created with permissions 0777 (world writable!) by default.<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">For instance, the PID file (/tmp/PRServer_*.pid) is =
created with permissions 0777 on my system (CentOS 7.2.1511).<o:p></o:p></p=
>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">It would be better to leave the umask unchanged, so =
whoever is starting bitbake-preserv gets to choose the umask it wants to us=
e.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The attached patch does exactly this.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best regards,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Diego<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[1] https://bugzilla.yoctoproject.org/show_bug.cgi?i=
d=3D9036<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"mso-margin-top-alt:auto;mso-margin-bottom-a=
lt:auto"><span style=3D"font-size:9.0pt;font-family:&quot;Arial&quot;,sans-=
serif">--<br>
<b>Diego Santa Cruz, PhD</b><br>
Technology Architect<br>
<span style=3D"color:gray">T &#43;41 21 341 15 50<br>
diego.santacruz@spinetix.com</span></span><span style=3D"font-size:9.0pt;fo=
nt-family:&quot;Times New Roman&quot;,serif;color:gray"><br>
</span><span style=3D"font-size:9.0pt;font-family:&quot;Arial&quot;,sans-se=
rif">spinetix.com</span><span style=3D"font-size:12.0pt;font-family:&quot;T=
imes New Roman&quot;,serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_AM3PR01MB10570F1A5431FFE827FAA6C588DF0AM3PR01MB1057eurp_--

--_004_AM3PR01MB10570F1A5431FFE827FAA6C588DF0AM3PR01MB1057eurp_
Content-Type: application/octet-stream;
	name="0001-bitbake-prserv-do-not-clear-umask-when-daemonizing.patch"
Content-Description: 0001-bitbake-prserv-do-not-clear-umask-when-daemonizing.patch
Content-Disposition: attachment;
	filename="0001-bitbake-prserv-do-not-clear-umask-when-daemonizing.patch";
	size=1115; creation-date="Tue, 02 Feb 2016 14:35:19 GMT";
	modification-date="Tue, 02 Feb 2016 13:42:32 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyNGY2NTEwOTVhZWIzMDA3OGVjZWRiNmI2MWViMTdiMDhkYjhhMzM4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEaWVnbyBTYW50YSBDcnV6IDxEaWVnby5TYW50YUNydXpAc3Bp
bmV0aXguY29tPgpEYXRlOiBUdWUsIDIgRmViIDIwMTYgMTM6MDg6MDUgKzAxMDAKU3ViamVjdDog
W1BBVENIXSBiaXRiYWtlOiBwcnNlcnY6IGRvIG5vdCBjbGVhciB1bWFzayB3aGVuIGRhZW1vbml6
aW5nCgpDbGVhcmluZyB0aGUgdW1hc2sgd2hlbiBkYWVtb25pemluZyBpcyBub3QgdGhlIGNvcnJl
Y3QgdGhpbmcKdG8gZG8sIGFzIGl0IHdpbGwgY3JlYXRlIGZpbGVzIHdyaXRhYmxlIGJ5IGFueW9u
ZSBieSBkZWZhdWx0LgpGb3IgaW5zdGFuY2UgdGhlIHBpZCBmaWxlIHdhcyBiZWluZyBjcmVhdGVk
IHdpdGggbW9kZSA3NzcuClRoaXMgY291bGQgYWxzbyBwb3RlbnRpYWxseSBhZmZlY3QgdGhlIHNx
bGl0ZSBkYXRhYmFzZS4KQmV0dGVyIGxldCB0aGUgY2FsbGluZyBwcm9jZXNzIGRlY2lkZSBvbiB0
aGUgdW1hc2suCgpTaWduZWQtb2ZmLWJ5OiBEaWVnbyBTYW50YSBDcnV6IDxEaWVnby5TYW50YUNy
dXpAc3BpbmV0aXguY29tPgotLS0KIGJpdGJha2UvbGliL3Byc2Vydi9zZXJ2LnB5IHwgMSAtCiAx
IGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2JpdGJha2UvbGliL3By
c2Vydi9zZXJ2LnB5IGIvYml0YmFrZS9saWIvcHJzZXJ2L3NlcnYucHkKaW5kZXggMWRlMzdjZi4u
ZjZmNTBlZSAxMDA2NDQKLS0tIGEvYml0YmFrZS9saWIvcHJzZXJ2L3NlcnYucHkKKysrIGIvYml0
YmFrZS9saWIvcHJzZXJ2L3NlcnYucHkKQEAgLTIxMiw3ICsyMTIsNiBAQCBjbGFzcyBQUlNlcnZl
cihTaW1wbGVYTUxSUENTZXJ2ZXIpOgogICAgIGRlZiBjbGVhbnVwX2hhbmRsZXMoc2VsZik6CiAg
ICAgICAgIHNpZ25hbC5zaWduYWwoc2lnbmFsLlNJR0lOVCwgc2VsZi5zaWdpbnRfaGFuZGxlcikK
ICAgICAgICAgc2lnbmFsLnNpZ25hbChzaWduYWwuU0lHVEVSTSwgc2VsZi5zaWd0ZXJtX2hhbmRs
ZXIpCi0gICAgICAgIG9zLnVtYXNrKDApCiAgICAgICAgIG9zLmNoZGlyKCIvIikKIAogICAgICAg
ICBzeXMuc3Rkb3V0LmZsdXNoKCkKLS0gCjEuOS40Cgo=

--_004_AM3PR01MB10570F1A5431FFE827FAA6C588DF0AM3PR01MB1057eurp_--
