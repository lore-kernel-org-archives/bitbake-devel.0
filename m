Return-Path: <chwprzem@amazon.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C81C6379F
	for <webhook@archiver.kernel.org>; Mon, 13 Feb 2023 14:29:28 +0000 (UTC)
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
 by mx.groups.io with SMTP id smtpd.web10.15452.1676298560935741629
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Feb 2023 06:29:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amazon.com header.s=amazon201209 header.b=Z+KKhnhL;
 spf=pass (domain: amazon.com, ip: 99.78.197.217, mailfrom: prvs=401ade437=chwprzem@amazon.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1676298561; x=1707834561;
  h=from:to:cc:date:message-id:references:in-reply-to:
   mime-version:subject;
  bh=UFtvX77fkOoDUQRdg03CLYwXDDehhZwqIwPD65VYvsk=;
  b=Z+KKhnhLRbCas1KEvuvgKHnUJEi7iZ52+I8r2UTLC8LepsO7tcD+1DgE
   HAFgKq0a0POLlprg/em2Zn+idy9QAoALoXm0AhFuL/kY4SMNHqnGCZByp
   OHj0odXRmbAy6HP7tSpNZIbH7qSLtrmdIP6uIw2q+1//SQ53PE/tTiBDk
   U=;
X-IronPort-AV: E=Sophos;i="5.97,294,1669075200"; 
   d="scan'208,217";a="181257897"
Subject: Re: [bitbake-devel] ERROR: unable to connect to bitbake server
Thread-Topic: [bitbake-devel] ERROR: unable to connect to bitbake server
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 14:29:20 +0000
Received: from EX13MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
	by email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com (Postfix) with ESMTPS id 204F040D42;
	Mon, 13 Feb 2023 14:29:20 +0000 (UTC)
Received: from EX19D004UWB001.ant.amazon.com (10.13.138.107) by
 EX13MTAUWB002.ant.amazon.com (10.43.161.202) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Mon, 13 Feb 2023 14:29:19 +0000
Received: from EX19D004UWB001.ant.amazon.com (10.13.138.107) by
 EX19D004UWB001.ant.amazon.com (10.13.138.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.24;
 Mon, 13 Feb 2023 14:29:18 +0000
Received: from EX19D004UWB001.ant.amazon.com ([fe80::a32c:93ce:c070:c2be]) by
 EX19D004UWB001.ant.amazon.com ([fe80::a32c:93ce:c070:c2be%5]) with mapi id
 15.02.1118.024; Mon, 13 Feb 2023 14:29:18 +0000
From: "Chwiala, Przemyslaw [C]" <chwprzem@amazon.com>
To: Mohammed Hassan <hassan@blazeautomation.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: Mohan Krishna Chepuri <mohan@blazeautomation.com>
Thread-Index: AQHZP7da7iSjd5HggEa35wN2qssrUq7M74rF
Date: Mon, 13 Feb 2023 14:29:18 +0000
Message-ID: <5528f6fa6355443289b3cce7519429ca@amazon.com>
References: <CAJz8rkeBnzNzKDXC82vCKZBCJpq6entnDO8cA9--N7C6S_YTXw@mail.gmail.com>
In-Reply-To: <CAJz8rkeBnzNzKDXC82vCKZBCJpq6entnDO8cA9--N7C6S_YTXw@mail.gmail.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.43.160.120]
Content-Type: multipart/alternative;
	boundary="_000_5528f6fa6355443289b3cce7519429caamazoncom_"
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Feb 2023 14:29:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14401

--_000_5528f6fa6355443289b3cce7519429caamazoncom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Try to remove .lock files (if any) from your build directory

________________________________
From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedde=
d.org> on behalf of Mohammed Hassan <hassan@blazeautomation.com>
Sent: Monday, February 13, 2023 3:26:55 PM
To: bitbake-devel@lists.openembedded.org
Cc: Mohan Krishna Chepuri
Subject: [EXTERNAL] [bitbake-devel] ERROR: unable to connect to bitbake ser=
ver


CAUTION: This email originated from outside of the organization. Do not cli=
ck links or open attachments unless you can confirm the sender and know the=
 content is safe.



Hi,

I am trying to build an image file for my project but fail at the bitbake s=
tep. but I receive the below error message.

ERROR: Unable to connect to bitbake server, or start one (server startup fa=
ilures would be in bitbake-cookerdaemon.log).

Previously my senior had built the image and he has transferred the pre bui=
lt zip file to me to make add custom packages as per our needs which i have=
 done but fail when connecting to the bitbake server.

I think it is an issue with the TOKEN that gets authenticated when connecti=
ng to the server but i get no error message regarding token mismatch.

Please guide me.

Thank you

--_000_5528f6fa6355443289b3cce7519429caamazoncom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p>Try to remove .lock files (if any) from your build directory</p>
</div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> bitbake-devel@lists.o=
penembedded.org &lt;bitbake-devel@lists.openembedded.org&gt; on behalf of M=
ohammed Hassan &lt;hassan@blazeautomation.com&gt;<br>
<b>Sent:</b> Monday, February 13, 2023 3:26:55 PM<br>
<b>To:</b> bitbake-devel@lists.openembedded.org<br>
<b>Cc:</b> Mohan Krishna Chepuri<br>
<b>Subject:</b> [EXTERNAL] [bitbake-devel] ERROR: unable to connect to bitb=
ake server</font>
<div>&nbsp;</div>
</div>
<div>
<div class=3D"WordSection1">
<table class=3D"MsoTableGrid" border=3D"1" cellspacing=3D"0" cellpadding=3D=
"0" style=3D"border-collapse:collapse;border:none">
<tbody>
<tr style=3D"height:15.25pt">
<td width=3D"711" valign=3D"top" style=3D"width:842.35pt;border:solid #ED7D=
31 1.5pt;padding:0in 5.4pt 0in 5.4pt;height:15.25pt">
<p><strong><span style=3D"background:#FFFF99">CAUTION</span></strong><span =
style=3D"background:#FFFF99">: This email originated from outside of the or=
ganization. Do not click links or open attachments unless you can confirm t=
he sender and know the content is safe.</span><o:p></o:p></p>
</td>
</tr>
</tbody>
</table>
</div>
<br>
<div>
<div dir=3D"ltr">
<p>Hi,</p>
<p>I am trying to build an image file for my project but fail at the bitbak=
e step. but I receive the below error message.</p>
<p>ERROR: Unable to connect to bitbake server, or start one (server startup=
 failures would be in bitbake-cookerdaemon.log).</p>
<p>Previously my senior had built the image and he has transferred the pre =
built zip file to me to make add custom packages as per our needs which i h=
ave done but fail when connecting to the bitbake server.</p>
<p>I think it is an issue with the TOKEN that gets authenticated when conne=
cting to the server but i get no error message regarding token mismatch.</p=
>
<p>Please guide me.</p>
<p>Thank you</p>
</div>
</div>
</div>
</body>
</html>

--_000_5528f6fa6355443289b3cce7519429caamazoncom_--

