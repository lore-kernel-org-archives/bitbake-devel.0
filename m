Return-Path: <chwprzem@amazon.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A9FC636D4
	for <webhook@archiver.kernel.org>; Wed, 15 Feb 2023 06:46:05 +0000 (UTC)
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
 by mx.groups.io with SMTP id smtpd.web10.9665.1676443556093127526
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 14 Feb 2023 22:45:56 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amazon.com header.s=amazon201209 header.b=rCDJZwyl;
 spf=pass (domain: amazon.com, ip: 207.171.184.29, mailfrom: prvs=403dbe870=chwprzem@amazon.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1676443557; x=1707979557;
  h=from:to:date:message-id:references:in-reply-to:
   mime-version:subject;
  bh=LrKU9we8CZ2Zc6jHcWjKWGU8EWmhkCmEDdQIUfR/1eE=;
  b=rCDJZwylGKRkeeo3Tb2eUNDsbGSk0YBMl366v1KHTinznbUtvJserePg
   GPD9B0ooUEWcnnHC+laKdhpJdhY7VmEg0nFFLB1yn7YFLQLaTYkNvjKlN
   oYw63wtBF83f4uG9gb7BAa6Rq4tfKYbBoTrxEkIswQkYmfbUlvTrf9yR1
   g=;
X-IronPort-AV: E=Sophos;i="5.97,299,1669075200"; 
   d="scan'208,217";a="311068272"
Subject: Re: Custom event handler does not work
Thread-Topic: Custom event handler does not work
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2023 06:45:56 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
	by email-inbound-relay-iad-1e-m6i4x-7dc0ecf1.us-east-1.amazon.com (Postfix) with ESMTPS id 100BF81B44;
	Wed, 15 Feb 2023 06:45:53 +0000 (UTC)
Received: from EX19D004UWB003.ant.amazon.com (10.13.138.103) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Wed, 15 Feb 2023 06:45:52 +0000
Received: from EX19D004UWB001.ant.amazon.com (10.13.138.107) by
 EX19D004UWB003.ant.amazon.com (10.13.138.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.24;
 Wed, 15 Feb 2023 06:45:52 +0000
Received: from EX19D004UWB001.ant.amazon.com ([fe80::a32c:93ce:c070:c2be]) by
 EX19D004UWB001.ant.amazon.com ([fe80::a32c:93ce:c070:c2be%5]) with mapi id
 15.02.1118.024; Wed, 15 Feb 2023 06:45:52 +0000
From: "Chwiala, Przemyslaw [C]" <chwprzem@amazon.com>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Thread-Index: AQHZP7RYyoxRvoWPbU626qqFDdT3lK7NBfOwgAKMYxw=
Date: Wed, 15 Feb 2023 06:45:52 +0000
Message-ID: <08027d0314824c54a623c387fe082174@amazon.com>
References: <1dd67709f24d4a02b9597a7c7ef30b49@amazon.com>,<DM8PR12MB543087393CEA69A61F5860CA8BDD9@DM8PR12MB5430.namprd12.prod.outlook.com>
In-Reply-To: <DM8PR12MB543087393CEA69A61F5860CA8BDD9@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.212.21]
Content-Type: multipart/alternative;
	boundary="_000_08027d0314824c54a623c387fe082174amazoncom_"
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 15 Feb 2023 06:46:05 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14420

--_000_08027d0314824c54a623c387fe082174amazoncom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Chris,


it was a good thought. Now all events I need are visible.


Thank you for your help

Przemek

________________________________
From: chris.laplante@agilent.com <chris.laplante@agilent.com>
Sent: Monday, February 13, 2023 4:49:58 PM
To: Chwiala, Przemyslaw [C]; bitbake-devel@lists.openembedded.org
Subject: RE: [EXTERNAL]Custom event handler does not work

CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you can confirm the sender and know the=
 content is safe.



> I'm working on Yocto image based on Kirkstone relese. I'm trying to add a
> custom event handler to my image, to be able to catch BuildCompleted
> or CookerExit event. Unfortunately I'm not able to catch those events as =
well
> as any other event from list in
> the documentation https://nam12.safelinks.protection.outlook.com/?url=3Dh=
tt
> ps%3A%2F%2Fdocs.yoctoproject.org%2Fbitbake%2F2.2%2Fbitbake-user-
> manual%2Fbitbake-user-manual-
> metadata.html%23events&data=3D05%7C01%7Cchris.laplante%40agilent.com%
> 7C54cb5a85a0a141a4ce2d08db0dcc7ca0%7Ca9c0bc098b46420693512ba12f
> b4a5c0%7C0%7C0%7C638118945468553260%7CUnknown%7CTWFpbGZsb3
> d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> %3D%7C3000%7C%7C%7C&sdata=3DlAYX30mAIMLWWaPWINyzQBDF%2FJ4SjB
> EWpfeaqHF7oB8%3D&reserved=3D0

IIRC those events need to be caught in a bbclass that you install globally =
(e.g. using INHERIT in local.conf). They won't work at a per-recipe level.

Thanks,
Chris

--_000_08027d0314824c54a623c387fe082174amazoncom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<meta content=3D"text/html; charset=3DUTF-8">
<style type=3D"text/css" style=3D"">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<div id=3D"x_divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; col=
or:#000000; font-family:Calibri,Helvetica,sans-serif">
<p><span>Hello Chris,</span></p>
<p><span><br>
</span></p>
<p><span>it was a good thought. Now all events I need are visible.</span></=
p>
<p><span><br>
</span></p>
<p><span>Thank you for your help</span></p>
<p><span>Przemek</span></p>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> chris.laplante@agil=
ent.com &lt;chris.laplante@agilent.com&gt;<br>
<b>Sent:</b> Monday, February 13, 2023 4:49:58 PM<br>
<b>To:</b> Chwiala, Przemyslaw [C]; bitbake-devel@lists.openembedded.org<br=
>
<b>Subject:</b> RE: [EXTERNAL]Custom event handler does not work</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:10pt;">
<div class=3D"PlainText">CAUTION: This email originated from outside of the=
 organization. Do not click links or open attachments unless you can confir=
m the sender and know the content is safe.<br>
<br>
<br>
<br>
&gt; I'm working on Yocto image based on Kirkstone relese. I'm trying to ad=
d a<br>
&gt; custom event handler to my image, to be able to catch BuildCompleted<b=
r>
&gt; or CookerExit event. Unfortunately I'm not able to catch those events =
as well<br>
&gt; as any other event from list in<br>
&gt; the documentation <a href=3D"https://nam12.safelinks.protection.outloo=
k.com/?url=3Dhtt">
https://nam12.safelinks.protection.outlook.com/?url=3Dhtt</a><br>
&gt; ps%3A%2F%2Fdocs.yoctoproject.org%2Fbitbake%2F2.2%2Fbitbake-user-<br>
&gt; manual%2Fbitbake-user-manual-<br>
&gt; metadata.html%23events&amp;data=3D05%7C01%7Cchris.laplante%40agilent.c=
om%<br>
&gt; 7C54cb5a85a0a141a4ce2d08db0dcc7ca0%7Ca9c0bc098b46420693512ba12f<br>
&gt; b4a5c0%7C0%7C0%7C638118945468553260%7CUnknown%7CTWFpbGZsb3<br>
&gt; d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0<br>
&gt; %3D%7C3000%7C%7C%7C&amp;sdata=3DlAYX30mAIMLWWaPWINyzQBDF%2FJ4SjB<br>
&gt; EWpfeaqHF7oB8%3D&amp;reserved=3D0<br>
<br>
IIRC those events need to be caught in a bbclass that you install globally =
(e.g. using INHERIT in local.conf). They won't work at a per-recipe level.<=
br>
<br>
Thanks,<br>
Chris<br>
</div>
</span></font>
</body>
</html>

--_000_08027d0314824c54a623c387fe082174amazoncom_--

