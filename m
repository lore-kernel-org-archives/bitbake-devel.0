Return-Path: <Diego.SantaCruz@spinetix.com>
X-Greylist: delayed 956 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 02 Feb 2016 14:49:10 UTC
Received: from emea01-am1-obe.outbound.protection.outlook.com
	(mail-am1on0059.outbound.protection.outlook.com [157.56.112.59])
	by mail.openembedded.org (Postfix) with ESMTP id C457F771A9
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Feb 2016 14:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=SpinetiX.onmicrosoft.com; s=selector1-spinetix-com;
	h=From:To:Date:Subject:Message-ID:Content-Type:MIME-Version;
	bh=BovKdgq1TLhteyJBp6SIphoDnN+cvmy4qBOz3H+/IOU=;
	b=jHevLDZyyO6oCXJxUyqb+ph5jqIHnaTQL0QorhL7RZu66htq2+duscCyYPpL9U2aDLilEAfXUzUFo568gV6htMJEjVMSTaxd2BYRNEnmDeIXpMDjVy3civwxedZR1tHwqLNjMYfkOQx67sVea7WXIXcy9LcYZ9k5HTP/ZBMv2uE=
Received: from AM3PR01MB1057.eurprd01.prod.exchangelabs.com
	(2a01:111:e400:5874::11) by
	AM3PR01MB1057.eurprd01.prod.exchangelabs.com
	(2a01:111:e400:5874::11) with Microsoft SMTP Server (TLS) id
	15.1.396.15; Tue, 2 Feb 2016 14:33:14 +0000
Received: from AM3PR01MB1057.eurprd01.prod.exchangelabs.com
	([fe80::70ce:60:6ef3:7524]) by
	AM3PR01MB1057.eurprd01.prod.exchangelabs.com
	([fe80::70ce:60:6ef3:7524%15]) with mapi id 15.01.0396.020;
	Tue, 2 Feb 2016 14:33:14 +0000
From: Diego Santa Cruz <Diego.SantaCruz@spinetix.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: bitbake-prserv not exiting on SIGTERM when run in daemon mode
Thread-Index: AdFdxkxEuAnwhakTTqO5khaLDB7SzQ==
Date: Tue, 2 Feb 2016 14:33:13 +0000
Message-ID: <AM3PR01MB10575432B4F0E530965B8F2E88DF0@AM3PR01MB1057.eurprd01.prod.exchangelabs.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: lists.openembedded.org; dkim=none (message not signed)
	header.d=none; lists.openembedded.org;
	dmarc=none action=none header.from=spinetix.com;
x-originating-ip: [212.147.27.179]
x-microsoft-exchange-diagnostics: 1; AM3PR01MB1057;
	5:aFDEwNUfVBCKNihVoOWpCMB/Ox7XmwNylZpjEkP63nZN9yRlbm1loXv3f85l5Nzp9FydofupAOp2h0IFe+rCGJShbMavOjsbuHeK6Wv0gjFYYIzb1S8KiyGWIcTyyg3RKok1aPtHz5Z1WvW2i9w4dQ==;
	24:CmCyRcCFH5sOFLbC1I7THR9DtHc5VGPgeTEYIunapP20xUOmt5I3zXz3iXAOEcsw/Y8GFU4z1tlvGotCPLm6r/oqX8DN634BBLaJajobq/k=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:;SRVR:AM3PR01MB1057;
x-ms-office365-filtering-correlation-id: 89dc4541-015e-4b95-3971-08d32bddc884
x-microsoft-antispam-prvs: <AM3PR01MB10578400756E30863BB5E82688DF0@AM3PR01MB1057.eurprd01.prod.exchangelabs.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
	RULEID:(102415267)(102615245)(601004)(2401047)(5005006)(8121501046)(3002001)(10201501046);
	SRVR:AM3PR01MB1057; BCL:0; PCL:0; RULEID:; SRVR:AM3PR01MB1057; 
x-forefront-prvs: 084080FC15
x-forefront-antispam-report: SFV:NSPM;
	SFS:(10009020)(6009001)(1096002)(74316001)(5890100001)(2501003)(19300405004)(110136002)(87936001)(5250100002)(102836003)(107886002)(5001960100002)(189998001)(5004730100002)(86362001)(586003)(790700001)(6116002)(2906002)(3660700001)(5003600100002)(1220700001)(450100001)(40100003)(19625215002)(11100500001)(92566002)(5008740100001)(33656002)(54356999)(50986999)(16236675004)(99936001)(2351001)(5002640100001)(3280700002)(229853001)(2900100001)(19580395003)(66066001)(15975445007)(19580405001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:AM3PR01MB1057;
	H:AM3PR01MB1057.eurprd01.prod.exchangelabs.com; FPR:; SPF:None;
	MLV:sfv; LANG:en; 
spamdiagnosticoutput: 1:23
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: spinetix.com
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2016 14:33:14.0309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5f4034fa-ed2d-4840-a93f-acb1e9633b93
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR01MB1057
Subject: bitbake-prserv not exiting on SIGTERM when run in daemon mode
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
X-List-Received-Date: Tue, 02 Feb 2016 14:49:19 -0000
X-Groupsio-MsgNum: 6964
Content-Language: en-US
Content-Type: multipart/mixed;
	boundary="_004_AM3PR01MB10575432B4F0E530965B8F2E88DF0AM3PR01MB1057eurp_"

--_004_AM3PR01MB10575432B4F0E530965B8F2E88DF0AM3PR01MB1057eurp_
Content-Type: multipart/alternative;
	boundary="_000_AM3PR01MB10575432B4F0E530965B8F2E88DF0AM3PR01MB1057eurp_"

--_000_AM3PR01MB10575432B4F0E530965B8F2E88DF0AM3PR01MB1057eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi there,

As reported in bug #9035 [1] there is an issue in the daemon mode of the PR=
 Service where it hangs when sent a SIGTERM.

The description I entered in the bug report is the following. The attached =
patch solves this problem for me.

I am running bitbake-prserv in daemon mode and noticed that it does not exi=
t when a SIGTERM is sent to it.

Using "bitbake-prserv --stop" works fine, but sending a SIGTERM to the pid =
of the daemonized bitbake-prserv hungs it and then even a "bitbake-prserv -=
-stop" is not able to stop it.

The problem seems to be that the handler thread is not signaled to quit, so=
 it stays there doing its work, as it is not a daemon thread (i.e. the pyth=
on thread is created in non-daemon mode).

The attached patch fixes this by setting the quit variable instead. The pat=
ch also does not raise the SystemExit exception any longer but instead leav=
es the quit flag to do its job and do a clean exit. This way the PID file i=
s properly removed.

Best regards,

Diego

[1] https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D9035
--
Diego Santa Cruz, PhD
Technology Architect
T +41 21 341 15 50
diego.santacruz@spinetix.com
spinetix.com


--_000_AM3PR01MB10575432B4F0E530965B8F2E88DF0AM3PR01MB1057eurp_
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
<p class=3D"MsoNormal">As reported in bug #9035 [1] there is an issue in th=
e daemon mode of the PR Service where it hangs when sent a SIGTERM.<o:p></o=
:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The description I entered in the bug report is the f=
ollowing. The attached patch solves this problem for me.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am running bitbake-prserv in daemon mode and notic=
ed that it does not exit when a SIGTERM is sent to it.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Using &quot;bitbake-prserv --stop&quot; works fine, =
but sending a SIGTERM to the pid of the daemonized bitbake-prserv hungs it =
and then even a &quot;bitbake-prserv --stop&quot; is not able to stop it.<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The problem seems to be that the handler thread is n=
ot signaled to quit, so it stays there doing its work, as it is not a daemo=
n thread (i.e. the python thread is created in non-daemon mode).<o:p></o:p>=
</p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The attached patch fixes this by setting the quit va=
riable instead. The patch also does not raise the SystemExit exception any =
longer but instead leaves the quit flag to do its job and do a clean exit. =
This way the PID file is properly
 removed.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Best regards,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Diego<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[1] https://bugzilla.yoctoproject.org/show_bug.cgi?i=
d=3D9035<o:p></o:p></p>
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

--_000_AM3PR01MB10575432B4F0E530965B8F2E88DF0AM3PR01MB1057eurp_--

--_004_AM3PR01MB10575432B4F0E530965B8F2E88DF0AM3PR01MB1057eurp_
Content-Type: application/octet-stream;
	name="0001-bitbake-prserv-SIGTERM-handling-hung-process.patch"
Content-Description: 0001-bitbake-prserv-SIGTERM-handling-hung-process.patch
Content-Disposition: attachment;
	filename="0001-bitbake-prserv-SIGTERM-handling-hung-process.patch";
	size=1289; creation-date="Tue, 02 Feb 2016 14:32:02 GMT";
	modification-date="Tue, 02 Feb 2016 13:26:43 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxOWZhNTJkNTFkYjM4MGRjNmZkNDZhMDJjZjQ0N2U2N2MwMjkxN2Y4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBEaWVnbyBTYW50YSBDcnV6IDxEaWVnby5TYW50YUNydXpAc3Bp
bmV0aXguY29tPgpEYXRlOiBUdWUsIDIgRmViIDIwMTYgMTM6MDU6NTAgKzAxMDAKU3ViamVjdDog
W1BBVENIXSBiaXRiYWtlOiBwcnNlcnY6IFNJR1RFUk0gaGFuZGxpbmcgaHVuZyBwcm9jZXNzCgpU
aGUgY3VycmVudCBTSUdURVJNIGhhbmRsZXIgaHVuZ3MgdGhlIHByb2Nlc3MgaW5zdGVhZCBvZgpt
YWtpbmcgaXQgZXhpdC4gVGhlIHByb2JsZW0gc2VlbXMgdG8gYmUgdGhhdCB0aGUgaGFuZGxlciB0
aHJlYWQKaXMgbm90IHNpZ25hbGVkIHRvIHF1aXQsIHNvIGl0IHN0YXlzIHRoZXJlIGRvaW5nIGl0
cyB3b3JrLCBhcwppdCBpcyBub3QgYSBkYWVtb24gdGhyZWFkLiBTZXR0aW5nIHRoZSBxdWl0IHZh
cmlhYmxlIGZpeGVzIHRoaXMuCgpXaGlsZSBhdCBpdCwgdG8gbm90IHVzZSB0aGUgU3lzdGVtRXhp
dCBleGNlcHRpb24gdG8gdGVybWluYXRlCnVwb24gU0lHVEVSTSBidXQgaW5zdGVhZCBsZWZ0IHRo
ZSBxdWl0IGZsYWcgZG8gaXRzIGpvYi4gVGhpcyB3YXkKdGhlIFBJRCBmaWxlIGlzIHByb3Blcmx5
IHJlbW92ZWQuCgpTaWduZWQtb2ZmLWJ5OiBEaWVnbyBTYW50YSBDcnV6IDxEaWVnby5TYW50YUNy
dXpAc3BpbmV0aXguY29tPgotLS0KIGJpdGJha2UvbGliL3Byc2Vydi9zZXJ2LnB5IHwgMiArLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvYml0YmFrZS9saWIvcHJzZXJ2L3NlcnYucHkgYi9iaXRiYWtlL2xpYi9wcnNlcnYvc2Vydi5w
eQppbmRleCBjNjVkZDNjLi4xZGUzN2NmIDEwMDY0NAotLS0gYS9iaXRiYWtlL2xpYi9wcnNlcnYv
c2Vydi5weQorKysgYi9iaXRiYWtlL2xpYi9wcnNlcnYvc2Vydi5weQpAQCAtMTAxLDcgKzEwMSw3
IEBAIGNsYXNzIFBSU2VydmVyKFNpbXBsZVhNTFJQQ1NlcnZlcik6CiAgICAgZGVmIHNpZ3Rlcm1f
aGFuZGxlcihzZWxmLCBzaWdudW0sIHN0YWNrKToKICAgICAgICAgaWYgc2VsZi50YWJsZToKICAg
ICAgICAgICAgIHNlbGYudGFibGUuc3luYygpCi0gICAgICAgIHJhaXNlIFN5c3RlbUV4aXQKKyAg
ICAgICAgc2VsZi5xdWl0PVRydWUKIAogICAgIGRlZiBwcm9jZXNzX3JlcXVlc3Qoc2VsZiwgcmVx
dWVzdCwgY2xpZW50X2FkZHJlc3MpOgogICAgICAgICBzZWxmLnJlcXVlc3RxdWV1ZS5wdXQoKHJl
cXVlc3QsIGNsaWVudF9hZGRyZXNzKSkKLS0gCjEuOS40Cgo=

--_004_AM3PR01MB10575432B4F0E530965B8F2E88DF0AM3PR01MB1057eurp_--
