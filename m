Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.125])
 by mx.groups.io with SMTP id smtpd.web11.1947.1588578108516219905
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 04 May 2020 00:41:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axentia.se header.s=selector2 header.b=QhctQoZi;
 spf=pass (domain: axentia.se, ip: 40.107.22.125, mailfrom: du@axentia.se)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FaJmEeO4o/PO4Mik0W3FC4mLRk1KoWvZHJg1yghJyqmI3XRLJ7OU/PKnRAYdsg2n9B6MROc7CvTdG2RIdm46PHYaACQdXC8BT2ETQprhj9HbCWqeOV/STLxSDwhjNsXEl5BRl9Veu0mLfqpjh3pVukzcbyjiDj6p1sze5y0A76Q8XmpfVT+Sm+JDLUg8/6b5dpQJf0B5m6Up6gn5kJT24zwbFWUH0aBaOm2NIgOjb75SiocWllGBZqEIatAw1uwX6T86FaaFB2pyJ102tGqgI0pjVRQMalC1qDfFYp7NqGSOjdhzgB6rKOzMWuPE6fwqQx3VREk7aKkN1vmnNI3xJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2Buynrout5gdnX5Mjv6ZNKWmZSgscsbUFWiRO4ckKg=;
 b=MO2bs+Nyhg+5g33UceN/pMYfPKqY4bWUjaBTJ/vD0cMVLryeh27USV59ijBBleGnSFjaAv336RJSDVL3QtFJWdeW0dzne8E4kr7imlBojA/4dx1ORqigQU0hfKAHvGB1Inf7l0y1PFBKlBNYpcvhOG78Kjs6IP/gRBlcUY7ffnD6ELFBO62rJgBQUCdR+nKzVj1cdKRbJMvItXzQ41/CliemylivGNXruwKsyNeHQLfabOSP0sKtt4DKBulLn//KRjI2yCwKtFDRrqvrTROPBqqrT8D7O4tU3spr0ujeUC5uxZv4ZAnoVEjRFf9pLxPiILGlXqTQPv1zKVSSIrz19A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o2Buynrout5gdnX5Mjv6ZNKWmZSgscsbUFWiRO4ckKg=;
 b=QhctQoZinHw84mWUWIEA5MmPq22KhvVN9OGUcuhMWJykffla/8MJHFN6QiAEDjPdVgef6/bbhzFyEmP3jbAabOUT5zXwFQ3RjVyOkCumdB8Bt2cmztdlk3bV+zNpJrR2OgE+jJpQM6gbiH+QdvBkS4VtOlKGxZT8s7ewWUcZVdc=
Received: from HE1PR02MB3148.eurprd02.prod.outlook.com (2603:10a6:7:2b::33) by
 HE1PR02MB3068.eurprd02.prod.outlook.com (2603:10a6:7:2b::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.29; Mon, 4 May 2020 07:41:45 +0000
Received: from HE1PR02MB3148.eurprd02.prod.outlook.com
 ([fe80::2c15:a13d:12dc:e610]) by HE1PR02MB3148.eurprd02.prod.outlook.com
 ([fe80::2c15:a13d:12dc:e610%7]) with mapi id 15.20.2958.030; Mon, 4 May 2020
 07:41:44 +0000
From: "Daniels Umanovskis" <du@axentia.se>
To: Martin Jansa <Martin.Jansa@gmail.com>, akuster <akuster808@gmail.com>,
	"poky@lists.yoctoproject.org" <poky@lists.yoctoproject.org>
CC: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>, "yocto@yoctoproject.org"
	<yocto@yoctoproject.org>, "poky@yoctoproject.org" <poky@yoctoproject.org>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "poky@lists.yoctoproject.org"
	<poky@lists.yoctoproject.org>
Subject: Re: [bitbake-devel] [poky] Thud community support
Thread-Topic: [bitbake-devel] [poky] Thud community support
Thread-Index: AQHV/KDebNAhX83QJEm+TfiF9YS2EKiPF2qAgAFbLYCAB2MB5A==
Date: Mon, 4 May 2020 07:41:44 +0000
Message-ID: 
 <HE1PR02MB3148711A1896AC49344CB833BDA60@HE1PR02MB3148.eurprd02.prod.outlook.com>
References: <15FBEF1FC40D189D.8114@lists.yoctoproject.org>
 <81fb73b4-f683-5356-ff07-1ac909afb97d@gmail.com>
 <CA+chaQc8q4Nb4p76WPr=R7ocpDJ8CY3VnJ-k9W8bWW8nwMtYTw@mail.gmail.com>,<dc37c701-80de-6719-8d8b-6d8dcd1771f4@gmail.com>
In-Reply-To: <dc37c701-80de-6719-8d8b-6d8dcd1771f4@gmail.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=axentia.se;
x-originating-ip: [94.191.137.29]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 482beaf5-e9e0-4e07-1e96-08d7effe982c
x-ms-traffictypediagnostic: HE1PR02MB3068:
x-microsoft-antispam-prvs: 
 <HE1PR02MB3068ECF2164F94780C34FDB5BDA60@HE1PR02MB3068.eurprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 AB1qkxtxt1aEx1pp2zD/24ddELJAoqV08unKRNjyWGzFO0Uw6Edg74o8kSjfgT0wW21wfVpzRP5iJ7MmIoWdwTgfJ6syECQv+SmO+02yDuUPnlSexmuVjpq8qDjp1YpLTKvgxp5Ywe4KxraAsbW1Obs4b3xbrXfnstA8XE7ExB34y2sKIU8jAunizIluDgvP1voBOuCct/SjlDcG7vH6ONONKRngHjzrsnrQTT7/aepia8XXvWdAcn/NHe+RprrrTk5MP7mezIvR8mcy+u6FQK5TJynvfzEdRbZ4Wkqb232gerRIijZEyGNXrRzuw9Dv7Lrnl3SvVaPA5PyrymGb8CZUFbBTomnNnn+5mnlkKIoTGs23tAJREX0EzxMk1wM9mo1aF5/3ed8sW+fKxPYFrZesShwYr82+ZwycTREYpZmgeGnYbCi3oTpFNwwATgPKXcZpNNz8WUaJyZUUVomTfullzyH3zGrxl42D3vTrZtwo+aElxDwFU+cYNLV7Gnn/d++aP12Bg7HyuL1psA/lkw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR02MB3148.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(136003)(39830400003)(376002)(366004)(76116006)(66946007)(33656002)(55016002)(9686003)(8676002)(5660300002)(8936002)(4326008)(71200400001)(316002)(110136005)(508600001)(54906003)(86362001)(66446008)(26005)(2906002)(52536014)(64756008)(186003)(66476007)(66556008)(966005)(53546011)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 
 BX1Nao7MOakp/S6GJc3jyq6XB/IIPw1+qhxDnw6pI9OtWSwkCFR0OAX5X2ZuqWfO8t5MypEZkFTmdzUKUqlNVsiowcaIjIwdzRXfQoCL2mtrF+lkUOt2EhqAm23Mxj6/9MnC+MujC8x3jd/Ecq/1ria0k7Yn78jZkb5YVc3HZQ+3x8pGgtRUjNHarVaGYnRVC9O+OrezkXH1TZhjQyihFvbSl5s7t3tKtErHWyw+SdyC7LMGzNzjTUIiG3bae4wFpVqFQS9J3CeHOq6y5SN1kzf97cTm83nzC1E1pJryNfLmHEtV04mXcl253LALWBW+boMQFbwtkwcCi0CHzzDKjR9OuU0CqFAz7qpH3Gea/vCf2gp6DMpn6SiCAwf0fscEKaCvMQlLXQfavZw7ooRYxxt4F7qez/aezgOyyKr2W45wLa2EidvO89VbNFO+5v6psBcN308DnJ6j0kjg0hiQsLtnIWk2LTA/J/1SOrPsNwxw1XoKWHseQakBxS0tCN7ZO+cN2qJpT5R8twZuKTOx5JvNC3snWeiMEhQTNG9mmJUvQ8U18nqb8X8MeD7Xu+vWLKq0xKtdYOSlG4ExFh0HoMLOeJ8eGucmulAAMG6D2Adph/0dEjFXCtNuL9jl2oMpeHPCmhDsPo1epUqtzfgXTwUoPOo4sn1BhGBAJp1FiIs8rQnar+NGgrdFU2e1L+mWW79kgEmuebTPx9E1O/a+tlbgXRVIhgtlurndpHhAhHVZk/ZwddLDemVsKdEnMSBy0UipTvdijmXbfq6Y4UKGpVlPaz8HS9IgUb6YCuAkKlY=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: 482beaf5-e9e0-4e07-1e96-08d7effe982c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 07:41:44.6966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kn7fsaKeYenUurJ5bq83SjoiVnM0fMucIfPsa6sDe29wjNInMSZMlIThFPB+bq7r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR02MB3068
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_HE1PR02MB3148711A1896AC49344CB833BDA60HE1PR02MB3148eurp_"

--_000_HE1PR02MB3148711A1896AC49344CB833BDA60HE1PR02MB3148eurp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



________________________________
From: poky@lists.yoctoproject.org <poky@lists.yoctoproject.org> on behalf o=
f akuster via lists.yoctoproject.org <akuster808=3Dgmail.com@lists.yoctopro=
ject.org>
Sent: Wednesday, April 29, 2020 4:53:21 PM
To: Martin Jansa <Martin.Jansa@gmail.com>; akuster <akuster808@gmail.com>
Cc: Patches and discussions about the oe-core layer <openembedded-core@list=
s.openembedded.org>; yocto@yoctoproject.org <yocto@yoctoproject.org>; poky@=
yoctoproject.org <poky@yoctoproject.org>; bitbake-devel@lists.openembedded.=
org <bitbake-devel@lists.openembedded.org>; poky@lists.yoctoproject.org <po=
ky@lists.yoctoproject.org>
Subject: Re: [bitbake-devel] [poky] Thud community support



On 4/28/20 11:10 AM, Martin Jansa wrote:
Is Thud EOL now?
Go question.


Or did someone volunteer off-list and now it waits for Maintainer selection=
 process to be defined?
I received two inquires privately and forwarded them to Richard. I have not=
 had time to document the community maintainer selection process. The ultim=
ate decision will always be on the Repo maintainer which in this case is Ri=
chard.

- armin

https://wiki.yoctoproject.org/wiki/Releases still says Community support.

Thanks

On Tue, Mar 17, 2020 at 10:13 PM akuster <akuster808@gmail.com<mailto:akust=
er808@gmail.com>> wrote:


On 3/13/20 11:03 AM, akuster via Lists.Yoctoproject.Org<http://Lists.Yoctop=
roject.Org> wrote:

The Poky thud branch is now under 'Community support' and is seeking a
maintainer to continue supporting the following repos for the thud release:

bitbake, core, meta-yocto and yocto-docs.


There will be no more point releases.

see
https://wiki.yoctoproject.org/wiki/Stable_Release_and_LTS#Maintainer_Proced=
ures
to get an idea on what is expected.

The one thing we (YP) don't know is if there will be AutoBuilder
resources available.  Please contact me or Richard regarding that statement=
.

If no one steps up by April 24th (six weeks -ish from now), Thud will be
moved to EOL status.


It was pointed out to me that there is no Maintainer selection process or c=
riteria defined.  This  will have to be sorted out before we move forward o=
n this transition.


- armin


- Armin















--_000_HE1PR02MB3148711A1896AC49344CB833BDA60HE1PR02MB3148eurp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<div dir=3D"auto" style=3D"direction: ltr; margin: 0; padding: 0; font-fami=
ly: sans-serif; font-size: 11pt; color: black; ">
<br>
<br>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> poky@lists.yoctoproje=
ct.org &lt;poky@lists.yoctoproject.org&gt; on behalf of akuster via lists.y=
octoproject.org &lt;akuster808=3Dgmail.com@lists.yoctoproject.org&gt;<br>
<b>Sent:</b> Wednesday, April 29, 2020 4:53:21 PM<br>
<b>To:</b> Martin Jansa &lt;Martin.Jansa@gmail.com&gt;; akuster &lt;akuster=
808@gmail.com&gt;<br>
<b>Cc:</b> Patches and discussions about the oe-core layer &lt;openembedded=
-core@lists.openembedded.org&gt;; yocto@yoctoproject.org &lt;yocto@yoctopro=
ject.org&gt;; poky@yoctoproject.org &lt;poky@yoctoproject.org&gt;; bitbake-=
devel@lists.openembedded.org &lt;bitbake-devel@lists.openembedded.org&gt;;
 poky@lists.yoctoproject.org &lt;poky@lists.yoctoproject.org&gt;<br>
<b>Subject:</b> Re: [bitbake-devel] [poky] Thud community support</font>
<div>&nbsp;</div>
</div>
<div><br>
<br>
<div class=3D"x_moz-cite-prefix">On 4/28/20 11:10 AM, Martin Jansa wrote:<b=
r>
</div>
<blockquote type=3D"cite">
<div dir=3D"ltr">Is Thud EOL now?</div>
</blockquote>
Go question.<br>
<br>
<blockquote type=3D"cite">
<div dir=3D"ltr">
<div><br>
</div>
<div>Or did someone volunteer off-list and now it waits for Maintainer sele=
ction process to be defined?</div>
</div>
</blockquote>
I received two inquires privately and forwarded them to Richard. I have not=
 had time to document the community maintainer selection process. The ultim=
ate decision will always be on the Repo maintainer which in this case is Ri=
chard.<br>
<br>
- armin<br>
<br>
<blockquote type=3D"cite">
<div dir=3D"ltr">
<div><a href=3D"https://wiki.yoctoproject.org/wiki/Releases">https://wiki.y=
octoproject.org/wiki/Releases</a>&nbsp;still says Community support.<br>
</div>
<div><br>
</div>
<div>Thanks</div>
</div>
<br>
<div class=3D"x_gmail_quote">
<div dir=3D"ltr" class=3D"x_gmail_attr">On Tue, Mar 17, 2020 at 10:13 PM ak=
uster &lt;<a href=3D"mailto:akuster808@gmail.com">akuster808@gmail.com</a>&=
gt; wrote:<br>
</div>
<blockquote class=3D"x_gmail_quote" style=3D"margin:0px 0px 0px
          0.8ex; border-left:1px solid rgb(204,204,204); padding-left:1ex">
<div><br>
<br>
<div>On 3/13/20 11:03 AM, akuster via <a href=3D"http://Lists.Yoctoproject.=
Org" target=3D"_blank">
Lists.Yoctoproject.Org</a> wrote:<br>
</div>
<blockquote type=3D"cite">
<pre>The Poky thud branch is now under 'Community support' and is seeking a
maintainer to continue supporting the following repos for the thud release:

bitbake, core, meta-yocto and yocto-docs.


There will be no more point releases.

see
<a href=3D"https://wiki.yoctoproject.org/wiki/Stable_Release_and_LTS#Mainta=
iner_Procedures" target=3D"_blank">https://wiki.yoctoproject.org/wiki/Stabl=
e_Release_and_LTS#Maintainer_Procedures</a>&nbsp;
to get an idea on what is expected.

The one thing we (YP) don't know is if there will be AutoBuilder
resources available.&nbsp; Please contact me or Richard regarding that stat=
ement.

If no one steps up by April 24th (six weeks -ish from now), Thud will be
moved to EOL status.
</pre>
</blockquote>
<br>
It was pointed out to me that there is no Maintainer selection process or c=
riteria defined.&nbsp; This&nbsp; will have to be sorted out before we move=
 forward on this transition.<br>
<br>
<br>
- armin<br>
<br>
<blockquote type=3D"cite">
<pre>- Armin



</pre>
<br>
<fieldset></fieldset> </blockquote>
<br>
</div>
<br>
</blockquote>
</div>
<br>
<fieldset class=3D"x_mimeAttachmentHeader"></fieldset>
<pre class=3D"x_moz-quote-pre">
</pre>
</blockquote>
<br>
</div>
</body>
</html>

--_000_HE1PR02MB3148711A1896AC49344CB833BDA60HE1PR02MB3148eurp_--
