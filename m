Return-Path: <Diego.SantaCruz@spinetix.com>
Received: from emea01-am1-obe.outbound.protection.outlook.com
	(mail-am1on0079.outbound.protection.outlook.com [157.56.112.79])
	by mail.openembedded.org (Postfix) with ESMTP id 08020771B2
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Feb 2016 15:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=SpinetiX.onmicrosoft.com; s=selector1-spinetix-com;
	h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
	bh=xs4Qc84BZEAjqmCk/uzb4L2MYT5glTi/nCV4WkJX1xw=;
	b=AFEDKI5KiRgw78OgwDWJx9cDTV0O2uQwNBLhdfE7xQKvAhR/WGUYi2NmMOO77zClN2bci5bRyLr7W5nCeYD+gjuKVSnyrerjw1objyZDyvHc4FrD8E/z5sYXsyPXM964OhHfxnu2s5QlM/0H3tAC3ejqlAOzIo24rt1UCtXe87E=
Received: from AM3PR01MB1057.eurprd01.prod.exchangelabs.com
	(2a01:111:e400:5874::11) by
	AM3PR01MB1057.eurprd01.prod.exchangelabs.com
	(2a01:111:e400:5874::11) with Microsoft SMTP Server (TLS) id
	15.1.396.15; Tue, 2 Feb 2016 14:30:09 +0000
Received: from AM3PR01MB1057.eurprd01.prod.exchangelabs.com
	([fe80::70ce:60:6ef3:7524]) by
	AM3PR01MB1057.eurprd01.prod.exchangelabs.com
	([fe80::70ce:60:6ef3:7524%15]) with mapi id 15.01.0396.020;
	Tue, 2 Feb 2016 14:30:09 +0000
From: Diego Santa Cruz <Diego.SantaCruz@spinetix.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: The PR Service deletes the -wal and -shm sqlite files when
	daemonizing
Thread-Index: AdFdxiwh4M/kXFtPRDemt+gJoSZF8Q==
Date: Tue, 2 Feb 2016 14:30:09 +0000
Message-ID: <AM3PR01MB1057C9389B75469C4967537288DF0@AM3PR01MB1057.eurprd01.prod.exchangelabs.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: lists.openembedded.org; dkim=none (message not signed)
	header.d=none; lists.openembedded.org;
	dmarc=none action=none header.from=spinetix.com;
x-originating-ip: [212.147.27.179]
x-microsoft-exchange-diagnostics: 1; AM3PR01MB1057;
	5:R7HZ1ZuscPpZQ09+D3yKZka60Oa92PTRZwlxy5IzCh47eB+j18t1oT6kaUQN14sqhXaatcx7D3u1JZzwpNzVV5NQ9nRKTluZMLMpByiI9AEm3NcZvxyImcNeoU3FiQA+BJksnrUEMW8lNOc7zJCJFA==;
	24:LiAPg5NMsk3EwzXLpJ/o5bpQEMEcSNeDwFID4Y6DJ4vJPfP3eBCZvgOJ4vsDC9m7nse9dCQMun5iiX0IG+Rww3Wkq978mqN0xFHat9VlM+E=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:AM3PR01MB1057;
x-ms-office365-filtering-correlation-id: 7615d7cd-cded-498c-406a-08d32bdd5a88
x-microsoft-antispam-prvs: <AM3PR01MB105755FD2C6C15B0BEAD1C1988DF0@AM3PR01MB1057.eurprd01.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(102415267)(102615245)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046);
	SRVR:AM3PR01MB1057; BCL:0; PCL:0; RULEID:; SRVR:AM3PR01MB1057; 
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(6009001)(33656002)(54356999)(16236675004)(50986999)(99936001)(5008740100001)(1220700001)(450100001)(5003600100002)(11100500001)(92566002)(19625215002)(40100003)(66066001)(2900100001)(15975445007)(19580395003)(19580405001)(229853001)(2351001)(5002640100001)(3280700002)(110136002)(87936001)(5250100002)(19300405004)(5890100001)(2501003)(102836003)(74316001)(1096002)(3660700001)(790700001)(586003)(86362001)(107886002)(5001960100002)(189998001)(5004730100002)(2906002)(6116002);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM3PR01MB1057;
	H:AM3PR01MB1057.eurprd01.prod.exchangelabs.com; FPR:; SPF:None;
	MLV:sfv; LANG:en; 
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: spinetix.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2016 14:30:09.3048 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5f4034fa-ed2d-4840-a93f-acb1e9633b93
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR01MB1057
Subject: The PR Service deletes the -wal and -shm sqlite files when daemonizing
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
X-List-Received-Date: Tue, 02 Feb 2016 15:04:04 -0000
X-Groupsio-MsgNum: 6967
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_AM3PR01MB1057C9389B75469C4967537288DF0AM3PR01MB1057eurp_"

--_004_AM3PR01MB1057C9389B75469C4967537288DF0AM3PR01MB1057eurp_
Content-Type: multipart/alternative;
	boundary="_000_AM3PR01MB1057C9389B75469C4967537288DF0AM3PR01MB1057eurp_"

--_000_AM3PR01MB1057C9389B75469C4967537288DF0AM3PR01MB1057eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi there,

As reported in bug #9034 [1] there is an issue in the daeamon mode of the P=
R Service where the -wal and -shm sqlite files are deleted as soon as it da=
emonizes, leading to problems as described in the bug.

The description I entered in the bug report is the following (with some typ=
os removed...). The attached patch solves this problem for me.

When daemonizing the PR service the -wal and -shm sqlite files are being de=
leted, although they should never be (see https://www.sqlite.org/wal.html a=
nd https://www.sqlite.org/tempfiles.html).

While the daemonized process keeps the file descriptors open (seen from /pr=
id<pid>/fd on linux) and thus a clean exit does not lose any data, a power =
outage would lose all data in the WAL as the -wal file is unavailable when =
sqlite does its recovery, so even committed transactions would be lost.

Removing these files also breaks sqlite collaboration between processes and=
 furthermore prevents taking proper backups without stopping the PR service=
 (e.g., with sqlite3 shell's ".backup" command).

The reason the files are deleted is that the DB connection is opened in the=
 initial process, before forking for daemonization. When the DB connection =
is closed by the exiting parent processes it can delete the -wal and -shm f=
iles if it considers itself to be the last connection to the DB. This is ea=
sily fixed by opening the DB connection after all forking.

The attached patch does this (on top of jethro branch). With this I have be=
en able to start the PR Service in daemon mode and the -wal and -shm files =
do exist and I can take proper backups.

Best regards,

Diego

[1] https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D9034

--
Diego Santa Cruz, PhD
Technology Architect
T +41 21 341 15 50
diego.santacruz@spinetix.com
spinetix.com


--_000_AM3PR01MB1057C9389B75469C4967537288DF0AM3PR01MB1057eurp_
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
<p class=3D"MsoNormal">As reported in bug #9034 [1] there is an issue in th=
e daeamon mode of the PR Service where the -wal and -shm sqlite files are d=
eleted as soon as it daemonizes, leading to problems as described in the bu=
g.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The description I entered in the bug report is the f=
ollowing (with some typos removed&#8230;). The attached patch solves this p=
roblem for me.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">When daemonizing the PR service the -wal and -shm sq=
lite files are being deleted, although they should never be (see https://ww=
w.sqlite.org/wal.html and https://www.sqlite.org/tempfiles.html).<o:p></o:p=
></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">While the daemonized process keeps the file descript=
ors open (seen from /prid&lt;pid&gt;/fd on linux) and thus a clean exit doe=
s not lose any data, a power outage would lose all data in the WAL as the -=
wal file is unavailable when sqlite does
 its recovery, so even committed transactions would be lost.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Removing these files also breaks sqlite collaboratio=
n between processes and furthermore prevents taking proper backups without =
stopping the PR service (e.g., with sqlite3 shell's &quot;.backup&quot; com=
mand).<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The reason the files are deleted is that the DB conn=
ection is opened in the initial process, before forking for daemonization. =
When the DB connection is closed by the exiting parent processes it can del=
ete the -wal and -shm files if it
 considers itself to be the last connection to the DB. This is easily fixed=
 by opening the DB connection after all forking.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The attached patch does this (on top of jethro branc=
h). With this I have been able to start the PR Service in daemon mode and t=
he -wal and -shm files do exist and I can take proper backups.<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best regards,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Diego<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[1] https://bugzilla.yoctoproject.org/show_bug.cgi?i=
d=3D9034<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
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

--_000_AM3PR01MB1057C9389B75469C4967537288DF0AM3PR01MB1057eurp_--

--_004_AM3PR01MB1057C9389B75469C4967537288DF0AM3PR01MB1057eurp_
Content-Type: application/octet-stream;
	name="0001-bitbake-prserv-wal-and-shm-sqlite-lost-when-daemoniz.patch"
Content-Description: 0001-bitbake-prserv-wal-and-shm-sqlite-lost-when-daemoniz.patch
Content-Disposition: attachment;
	filename="0001-bitbake-prserv-wal-and-shm-sqlite-lost-when-daemoniz.patch";
	size=2650; creation-date="Tue, 02 Feb 2016 14:24:46 GMT";
	modification-date="Tue, 02 Feb 2016 13:21:47 GMT"
Content-Transfer-Encoding: base64

RnJvbSAyYTg2NmNmMDliZTdmNmNkMWU3ZDYxNzQxOGU4ODBlNDEwMDEzMjY3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEaWVnbyBTYW50YSBDcnV6IDxEaWVnby5TYW50YUNydXpAc3Bp
bmV0aXguY29tPgpEYXRlOiBUdWUsIDIgRmViIDIwMTYgMTM6MDQ6MjAgKzAxMDAKU3ViamVjdDog
W1BBVENIXSBiaXRiYWtlOiBwcnNlcnY6IC13YWwgYW5kIC1zaG0gc3FsaXRlIGxvc3Qgd2hlbiBk
YWVtb25pemluZwoKV2hlbiBkYWVtb25pemluZyB0aGUgUFIgc2VydmljZSB0aGUgLXdhbCBhbmQg
LXNobSBzcWxpdGUgZmlsZXMgd2VyZQpiZWluZyBkZWxldGVkLCBhbHRob3VnaCB0aGV5IHNob3Vs
ZCBuZXZlciBiZS4gV2hpbGUgdGhlIGRhZW1vbml6ZWQKcHJvY2VzcyBrZWVwcyB0aGUgZmlsZSBk
ZXNjcmlwdG9ycyBvcGVuIGFuZCB0aHVzIGEgY2xlYW4gZXhpdCBkb2VzCm5vdCBsb29zZSBhbnkg
ZGF0YSwgYSBwb3dlciBvdXRhZ2Ugd291bGQgbG9vc2UgYWxsIGRhdGEgaW4gdGhlIFdBTC4KUmVt
b3ZpbmcgdGhlc2UgZmlsZXMgYWxzbyBicmVha3Mgc3FsaXRlIGNvbGxhYm9yYXRpb24gYmV0d2Vl
bgpwcm9jZXNzZXMgYW5kIGZ1cnRoZXJtb3JlIHByZXZlbnRzIHRha2luZyBwcm9wZXIgYmFja3Vw
cyB3aXRob3V0CnN0b3BwaW5nIHRoZSBQUiBzZXJ2aWNlLgoKVGhlIHJlYXNvbiB0aGlzIGhhcHBl
bnMgaXMgdGhhdCB0aGUgREIgY29ubmVjdGlvbiBpcyBvcGVuZWQgaW4KdGhlIGluaXRpYWwgcHJv
Y2VzcywgYmVmb3JlIGZvcmtpbmcgZm9yIGRhZW1vbml6YXRpb24uIFdoZW4gdGhlCkRCIGNvbm5l
Y3Rpb24gaXMgY2xvc2VkIGJ5IHRoZSBleGl0aW5nIHBhcmVudCBwcm9jZXNzZXMgaXQgY2FuCmRl
bGV0ZSB0aGUgLXdhbCBhbmQgLXNobSBmaWxlcyBpZiBpdCBjb25zaWRlcnMgaXRzZWxmIHRvIGJl
IHRoZQpsYXN0IGNvbm5lY3Rpb24gdG8gdGhlIERCLiBUaGlzIGlzIGVhc2lseSBmaXhlZCBieSBv
cGVuaW5nIHRoZQpEQiBjb25uZWN0aW9uIGFmdGVyIGFsbCBmb3JraW5nLgoKU2lnbmVkLW9mZi1i
eTogRGllZ28gU2FudGEgQ3J1eiA8RGllZ28uU2FudGFDcnV6QHNwaW5ldGl4LmNvbT4KLS0tCiBi
aXRiYWtlL2xpYi9wcnNlcnYvc2Vydi5weSB8IDEzICsrKysrKysrLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA4IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYml0YmFr
ZS9saWIvcHJzZXJ2L3NlcnYucHkgYi9iaXRiYWtlL2xpYi9wcnNlcnYvc2Vydi5weQppbmRleCBl
YWZjM2FhLi5jNjVkZDNjIDEwMDY0NAotLS0gYS9iaXRiYWtlL2xpYi9wcnNlcnYvc2Vydi5weQor
KysgYi9iaXRiYWtlL2xpYi9wcnNlcnYvc2Vydi5weQpAQCAtNjIsOSArNjIsNiBAQCBjbGFzcyBQ
UlNlcnZlcihTaW1wbGVYTUxSUENTZXJ2ZXIpOgogICAgICAgICBzZWxmLnJlZ2lzdGVyX2Z1bmN0
aW9uKHNlbGYuaW1wb3J0b25lLCAiaW1wb3J0b25lIikKICAgICAgICAgc2VsZi5yZWdpc3Rlcl9p
bnRyb3NwZWN0aW9uX2Z1bmN0aW9ucygpCiAKLSAgICAgICAgc2VsZi5kYiA9IHByc2Vydi5kYi5Q
UkRhdGEoc2VsZi5kYmZpbGUpCi0gICAgICAgIHNlbGYudGFibGUgPSBzZWxmLmRiWyJQUk1BSU4i
XQotCiAgICAgICAgIHNlbGYucmVxdWVzdHF1ZXVlID0gUXVldWUuUXVldWUoKQogICAgICAgICBz
ZWxmLmhhbmRsZXJ0aHJlYWQgPSB0aHJlYWRpbmcuVGhyZWFkKHRhcmdldCA9IHNlbGYucHJvY2Vz
c19yZXF1ZXN0X3RocmVhZCkKICAgICAgICAgc2VsZi5oYW5kbGVydGhyZWFkLmRhZW1vbiA9IEZh
bHNlCkBAIC05OCwxMCArOTUsMTIgQEAgY2xhc3MgUFJTZXJ2ZXIoU2ltcGxlWE1MUlBDU2VydmVy
KToKICAgICAgICAgICAgIHNlbGYudGFibGUuc3luY19pZl9kaXJ0eSgpCiAKICAgICBkZWYgc2ln
aW50X2hhbmRsZXIoc2VsZiwgc2lnbnVtLCBzdGFjayk6Ci0gICAgICAgIHNlbGYudGFibGUuc3lu
YygpCisgICAgICAgIGlmIHNlbGYudGFibGU6CisgICAgICAgICAgICBzZWxmLnRhYmxlLnN5bmMo
KQogCiAgICAgZGVmIHNpZ3Rlcm1faGFuZGxlcihzZWxmLCBzaWdudW0sIHN0YWNrKToKLSAgICAg
ICAgc2VsZi50YWJsZS5zeW5jKCkKKyAgICAgICAgaWYgc2VsZi50YWJsZToKKyAgICAgICAgICAg
IHNlbGYudGFibGUuc3luYygpCiAgICAgICAgIHJhaXNlIFN5c3RlbUV4aXQKIAogICAgIGRlZiBw
cm9jZXNzX3JlcXVlc3Qoc2VsZiwgcmVxdWVzdCwgY2xpZW50X2FkZHJlc3MpOgpAQCAtMTQxLDYg
KzE0MCwxMCBAQCBjbGFzcyBQUlNlcnZlcihTaW1wbGVYTUxSUENTZXJ2ZXIpOgogICAgICAgICBz
ZWxmLnF1aXQgPSBGYWxzZQogICAgICAgICBzZWxmLnRpbWVvdXQgPSAwLjUKIAorICAgICAgICAj
IERCIGNvbm5lY3Rpb24gbXVzdCBiZSBjcmVhdGVkIGFmdGVyIGFsbCBmb3JrcworICAgICAgICBz
ZWxmLmRiID0gcHJzZXJ2LmRiLlBSRGF0YShzZWxmLmRiZmlsZSkKKyAgICAgICAgc2VsZi50YWJs
ZSA9IHNlbGYuZGJbIlBSTUFJTiJdCisKICAgICAgICAgbG9nZ2VyLmluZm8oIlN0YXJ0ZWQgUFJT
ZXJ2ZXIgd2l0aCBEQmZpbGU6ICVzLCBJUDogJXMsIFBPUlQ6ICVzLCBQSUQ6ICVzIiAlCiAgICAg
ICAgICAgICAgICAgICAgICAoc2VsZi5kYmZpbGUsIHNlbGYuaG9zdCwgc2VsZi5wb3J0LCBzdHIo
b3MuZ2V0cGlkKCkpKSkKIAotLSAKMS45LjQKCg==

--_004_AM3PR01MB1057C9389B75469C4967537288DF0AM3PR01MB1057eurp_--
