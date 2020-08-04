Received: from NAM10-DM6-obe.outbound.protection.outlook.com (NAM10-DM6-obe.outbound.protection.outlook.com [40.107.93.80])
 by mx.groups.io with SMTP id smtpd.web11.7958.1596555533222234906
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Aug 2020 08:38:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=m5xsMp0g;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.93.80, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkvGhYC3xlUWrKDT1Ht2Efot4+/fpGwVE5sdGIJjagF23aqkxQu2bdpe2iYvsWOlAFisD3ZyOW0Mrg8gAEamlvznDXfbYAfK9xCNBW3CE8TiZwL2h1A5c8+hR5HQhpSv5rZ2ekvGFFwW1kPM9tWXJb1OxNRhq2IHaGyW1AJQRKsaKFJs11HXczj3P2d3qBSvQpZYQMRpjBgULl97Qnm9IPzZt7CoYeZmXFXBb2Z/MhEC9MEGX2g6tLQLw5NY9ckcj0H+FD3UYCynHrPhPu3IY/FO4E+13WIjVr6E+EobboGZO6gj9x/GgLgQ05QT6/EfERIlCwvgs0NqOuYICKNZgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITBok8Nrpn174ZJy0j6uGzbb7n8CP9zqYMtjCpgB72o=;
 b=UesK3KlsE48EBG6rVHv83cOu8YB7fgr5EhnnQdFrxTAdAiloDqD9+c9XfCh5sPLtPuwr0+ljgpRH2F0bGiQiMDVaUhA+TpoJ38/Jj0XdiH1QzMCW+SoZ0WCykC4trfrmNk3GqR5vVQdSKvlu0Jn9bSI9WDbzkPct2Pr41V8ZbS/Hbbf6/y0L0+2j2n3LeIe/KnY3uKoURUHfdnJog8PuZUZZwtZkmn1BI34vDmb8T8iy0LlDzUqWTPhwaJHsr2NYt8vlFNv+Otip5C7wVX4EpTb6lg69uXDE/pR0VQBCvdcHasfwiUllviCJ6Yk0IRgmPV1nqYf1rT51N1LU3LnRLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ITBok8Nrpn174ZJy0j6uGzbb7n8CP9zqYMtjCpgB72o=;
 b=m5xsMp0gCtYiTBVLGl09iT7P+EywS7+DSXrSUxDCrrhszPrru4pKY/hRdv9z745EJEi6miliyRpOailhiLwuKlX0i8FOAmDmJYDbcQZ4mAtqNPbUDy57dAJvjHoFBslbDxb1pQiYQv5je93wK3N2+0wQvHEJF/q6iJ9Hq5ZKeUsF2v+objWFGAAHoRYx5Kh5GlzGd12SUfsuQn088gVdFk3gob0zDMEy78DIpZlnLHL0DKFcOVhbhIdd+Xad1a2IfYfwEvPnGPUslcd7u3SD7kJC20gu1PEpZuUzKOe6LlyfDmbVE3StrYiiyEiSoJi7GWYCBVEr4JuCyLFFYGZEnA==
Received: from SN1PR12MB2480.namprd12.prod.outlook.com (2603:10b6:802:22::21)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18; Tue, 4 Aug
 2020 15:38:52 +0000
Received: from SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164]) by SN1PR12MB2480.namprd12.prod.outlook.com
 ([fe80::4c4f:2633:b1bc:c164%6]) with mapi id 15.20.3239.022; Tue, 4 Aug 2020
 15:38:52 +0000
From: "Chris Laplante" <chris.laplante@agilent.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Question about git _latest_revision
Thread-Topic: Question about git _latest_revision 
Thread-Index: AdZqdSAUZ/SjBWzlTaOmTL50Pw6ddw==
Date: Tue, 4 Aug 2020 15:38:51 +0000
Message-ID: 
 <SN1PR12MB24806D95998A7DB230FA56DD8B4A0@SN1PR12MB2480.namprd12.prod.outlook.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=agilent.com;
x-originating-ip: [76.99.179.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f845310d-9663-40ac-5e2d-08d8388c7d42
x-ms-traffictypediagnostic: SA0PR12MB4397:
x-microsoft-antispam-prvs: 
 <SA0PR12MB43979DC41233095427A89D868B4A0@SA0PR12MB4397.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 do7yXVS2zrmuF7UILW3BSIY8CDUUmzXzKo3e2r3BsfRiwpLaZ5HjGRUoAPuTGOVafY0VSEQdTgn/qu88jetiQW8x8Hn9+RI0mVZT4xFs0n8Jh8/SRPHDBpQa7Wi+trw7EXYVmC/Dn/aU5L94FVXlRrk645w946RoSOU0oJm5cOY++Ffg8O9jYZ/QfZu89lgWBNDmhcnHiesnjicqh9dJo0wtUvfXPrPMqwZ0TOYqgEFThfjKWRfQZlIzGqu1vyQjQ0XB3yqs6a08cZptyXx5BA6sXXyb3T59c4CCXQu/scxykjJXtzZCjWGDXB5XnlJ5d9pZF+r1i5kUKqXglov64iLVjoeHcVRKHVEux0Y7XhB3lTChMRq/JZzXs8vVmEBj
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(366004)(136003)(396003)(376002)(346002)(29502001)(52536014)(186003)(6506007)(478600001)(7696005)(2906002)(9686003)(33656002)(4743002)(26005)(558084003)(5660300002)(55016002)(66946007)(8676002)(316002)(76116006)(8936002)(71200400001)(6916009)(66446008)(64756008)(66556008)(66476007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 hrNLKKUm0/FOwWh373SBmo/LFgaaSnfazH3oOz37SZPTGRBDHB+LQJl9HiM0HORelUEXN/IQrkM9K8BZPX8PMsFdngLXeDycjLkkeWgjt9s2736gslKdEbPLlPRlDRyue1Jr4RIsKoscj0S8rlaOY1/fibC5l7dmN5OsyWSha/iJNCoOVhubXeleaqwaa+wafVjn/uEKxQ/QvOasiVQEKXAHc+8HNiy898YClU0ojCiZ+anR0A5blAy/doBzQ19KGi2Zi5oc+2mG2z9Da5+XzwbOLOMVGAF6bLNGbvTgX04AgDUHMlivVMthsw7IxqCUVIuiVTAan/I0a01HsfCHIRCk2wdIPudeizQM2cUA5x5xT9IawI23eJraxblUHxWJ+g1WKdhrSr07BID+hWKnhPfq+CDD8yQ+1nfFt5ukFQXEsUUR4ql0oD2316IVQe2PE0Vg4/G5U367PuDqmvuo6ntgtC1oELhpEozlcdZTckxGh7I71iIur3w8r5rT0eebvpZet4j92N+Abfdo/ojD+DkfYUnei5ket4xUci1rGnDV9xgq6yw19cijM2QTTf33wcTfK9VVoDWbBOhw7faOIE/3mkzwKf5+UQoevh9ObWFz/KkRThoV2xsV+lIBrSoDRuDN03fUJkC2LKTN5QZENw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f845310d-9663-40ac-5e2d-08d8388c7d42
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2020 15:38:51.9814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TfkOy7yMU1IiHZwGubeE0cIeGjsOmFKmSa5of3iOEB5lVYcsSHKcj13SKPrhCqgVg1uC+op6OsBA+REbgFLqft5fz2ND+DLaos5++tmP7/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_SN1PR12MB24806D95998A7DB230FA56DD8B4A0SN1PR12MB2480namp_"

--_000_SN1PR12MB24806D95998A7DB230FA56DD8B4A0SN1PR12MB2480namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Question regarding the _latest_revision method in bb.fetch2.git: why do we =
do an unfiltered 'git ls-remote' and then filter the output on the client s=
ide? Wouldn't it be more efficient to just call 'git ls-remote <rev>' with =
the rev(s) that we actually care about?

Thanks,
Chris

--_000_SN1PR12MB24806D95998A7DB230FA56DD8B4A0SN1PR12MB2480namp_
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
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
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
<p class=3D"MsoNormal">Question regarding the _latest_revision method in bb=
.fetch2.git: why do we do an unfiltered &#8216;git ls-remote&#8217; and the=
n filter the output on the client side? Wouldn&#8217;t it be more efficient=
 to just call &#8216;git ls-remote &lt;rev&gt;&#8217; with the rev(s)
 that we actually care about?<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Chris<o:p></o:p></p>
</div>
</body>
</html>

--_000_SN1PR12MB24806D95998A7DB230FA56DD8B4A0SN1PR12MB2480namp_--
