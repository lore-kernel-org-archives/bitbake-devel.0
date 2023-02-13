Return-Path: <chwprzem@amazon.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF21C636D4
	for <webhook@archiver.kernel.org>; Mon, 13 Feb 2023 14:13:38 +0000 (UTC)
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
 by mx.groups.io with SMTP id smtpd.web10.15038.1676297609956700743
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Feb 2023 06:13:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@amazon.com header.s=amazon201209 header.b=rwDwYr2c;
 spf=pass (domain: amazon.com, ip: 99.78.197.217, mailfrom: prvs=401ade437=chwprzem@amazon.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1676297610; x=1707833610;
  h=from:to:subject:date:message-id:mime-version;
  bh=7w/bef044lorrhxKpJl6zITpeIRqdU3y3g6P3JoKjRQ=;
  b=rwDwYr2c9ZjSUKMh9umCXiED27ZAupsFG5IxztbJM1+TDQQcF993iKgp
   bBTipzXQIrTMKG/1b/6YlpFaij32T+hOkhKG/3aVUtwwhNKesvPsHlFnX
   ffHeRpRmNjn4wcKyrYdpHV2HMf0PtrZ0ROr2CNAh5nzMbX5j/UO5FU36L
   Q=;
X-IronPort-AV: E=Sophos;i="5.97,294,1669075200"; 
   d="scan'208,217";a="181252245"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 14:13:26 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
	by email-inbound-relay-iad-1e-m6i4x-a65ebc6e.us-east-1.amazon.com (Postfix) with ESMTPS id 49BCD63F02
	for <bitbake-devel@lists.openembedded.org>; Mon, 13 Feb 2023 14:13:24 +0000 (UTC)
Received: from EX19D004UWB001.ant.amazon.com (10.13.138.107) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.45; Mon, 13 Feb 2023 14:13:24 +0000
Received: from EX19D004UWB001.ant.amazon.com (10.13.138.107) by
 EX19D004UWB001.ant.amazon.com (10.13.138.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.24;
 Mon, 13 Feb 2023 14:13:24 +0000
Received: from EX19D004UWB001.ant.amazon.com ([fe80::a32c:93ce:c070:c2be]) by
 EX19D004UWB001.ant.amazon.com ([fe80::a32c:93ce:c070:c2be%5]) with mapi id
 15.02.1118.024; Mon, 13 Feb 2023 14:13:24 +0000
From: "Chwiala, Przemyslaw [C]" <chwprzem@amazon.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Custom event handler does not work
Thread-Topic: Custom event handler does not work
Thread-Index: AQHZP7RYyoxRvoWPbU626qqFDdT3lA==
Date: Mon, 13 Feb 2023 14:13:23 +0000
Message-ID: <1dd67709f24d4a02b9597a7c7ef30b49@amazon.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.43.160.120]
Content-Type: multipart/alternative;
	boundary="_000_1dd67709f24d4a02b9597a7c7ef30b49amazoncom_"
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Feb 2023 14:13:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14399

--_000_1dd67709f24d4a02b9597a7c7ef30b49amazoncom_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,


I'm working on Yocto image based on Kirkstone relese. I'm trying to add a c=
ustom event handler to my image, to be able to catch BuildCompleted or Cook=
erExit event. Unfortunately I'm not able to catch those events as well as a=
ny other event from list in the documentation https://docs.yoctoproject.org=
/bitbake/2.2/bitbake-user-manual/bitbake-user-manual-metadata.html#events


When I do not pass eventmask to catch all events, all I can see are those t=
hree events:

- RecipeTaskPreProcess

- RecipePreFinalise

- RecipePostKeyExpansion


I've been trying example from documentation above, with the same result. I =
tried it in both bb and bbclass files.


Is it something wrong with my implementation, or there is some bug/issue in=
 event handlers?


Thanks

Przemek

--_000_1dd67709f24d4a02b9597a7c7ef30b49amazoncom_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size:12pt;color:#000000;font=
-family:Calibri,Helvetica,sans-serif;" dir=3D"ltr">
<p>Hello,&nbsp;</p>
<p><br>
</p>
<p>I'm working on Yocto image based on&nbsp;<span>Kirkstone relese. I'm&nbs=
p;</span>trying to add a custom event handler to my image, to be able to ca=
tch&nbsp;<span>BuildCompleted or&nbsp;<span>CookerExit event. Unfortunately=
 I'm not able to catch those events as well as any other
 event from list in the&nbsp;documentation&nbsp;<a href=3D"https://docs.yoc=
toproject.org/bitbake/2.2/bitbake-user-manual/bitbake-user-manual-metadata.=
html#events" class=3D"OWAAutoLink" id=3D"LPlnk475410">https://docs.yoctopro=
ject.org/bitbake/2.2/bitbake-user-manual/bitbake-user-manual-metadata.html#=
events</a></span></span></p>
<p><span><br>
</span></p>
<p><span>When I do not pass&nbsp;eventmask to catch all events, all I can s=
ee are those three events:</span></p>
<p><span>-&nbsp;<span>RecipeTaskPreProcess</span></span></p>
<p><span><span>-&nbsp;<span>RecipePreFinalise</span></span></span></p>
<p><span><span><span><span>-&nbsp;RecipePostKeyExpansion</span><br>
</span></span></span></p>
<p><br>
</p>
<p>I've been trying example from documentation above, with the same result.=
 I tried it in both bb and bbclass files.</p>
<p><br>
</p>
<p>Is it something wrong with my implementation, or there is some bug/issue=
 in&nbsp;event handlers?</p>
<p><br>
</p>
<p>Thanks</p>
<p>Przemek</p>
</div>
</body>
</html>

--_000_1dd67709f24d4a02b9597a7c7ef30b49amazoncom_--

