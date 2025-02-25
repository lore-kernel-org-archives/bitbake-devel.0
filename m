Return-Path: <Alexandre.Marques@criticaltechworks.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DDDC021B2
	for <webhook@archiver.kernel.org>; Tue, 25 Feb 2025 18:44:09 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.53])
 by mx.groups.io with SMTP id smtpd.web11.16818.1740509047464990559
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Feb 2025 10:44:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@criticaltechworks.com header.s=selector1 header.b=lVRM60TS;
 spf=pass (domain: criticaltechworks.com, ip: 40.107.20.53, mailfrom: alexandre.marques@criticaltechworks.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQK83G6ht6YBaq7J5rrC248zx77cxJlweT9o/6XfT4XVL69F1LF2t3pPsvpxA+xsBMT9n6STCZNFXi1XCupoJqN2Mucs9+jSdvC/Te96R6/ttg0j2GiR1o0RW0h14unHEwHlaZ0agXWxHY8s0bn/pW6TnhdYL7crVyL8WHfEpBYHAoQ8/TP2SVrvQjB4QXT/MsVDhqKA7Ezle3kQccB16PQSUkqk/1oTjTjx0oUUlqyxBxNfHmy77vCWPVo1lwtxV9+myGqcGnmSPXwbbOO+/3U8VTZ4K/aCW4Cr2xYM7tPfPTN46jEgkq48LxEkPfQI9yQF6gJR3YWYZmgziwx8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMK9tEat/E72Jnwu4RvABIaz6ghjTQElHYZDK5x3VQw=;
 b=gjTtsWBnd6n7Shngfltl8Btd7lGSQ6hlNMf7mHpGjgguadcAkTpWrkw+Ks7MPFYBHSBtovqODXL3mcFV8XQBLFVMeSofTx93X4T9UR5tI0o0KFdsHkCrvXHtG7A1FTeDxn3ikqYyG3voU4d6vZMrjDrEzoYLQkEJKG/oxzLudMchTiESqB4AkJURr9jwDUFr84lQkpKazAaNxme99veyEcnnqqCcghx3wrzDme6jl4T7aYaIkRo0Uydkd202IhEe0lyCG3BgLd7woY+uV8B6upnkDn/vZx0uERd7oJoaK+USk1r9fmEPPLoWQbZ9q7WCQhSh95WGMlPb5oMdF/2NeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=criticaltechworks.com; dmarc=pass action=none
 header.from=criticaltechworks.com; dkim=pass header.d=criticaltechworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=criticaltechworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMK9tEat/E72Jnwu4RvABIaz6ghjTQElHYZDK5x3VQw=;
 b=lVRM60TSiT8q9wF5hiiEtr74SclO7EUAf/YUbmbIiZDznKGpqsDpkUeHAtFQGx3XbJBDEL+3PvapalZTNvHAGbEvoEgyrL01HuzXi2cIsEoB6EpecwMEBVXZkGrRXBblDUFT+3dPodXLAFVkt6oX32ZycrqJ6YcB2pP3uVbh7A3ePJn+k5qC2L+GDj1kVBh+Zo3YrGy+5BImSnl8ZXxco0mIqkQQF9ih/vf7enxXnvnYnWDGdHb6BvFhYW+ZmH/jNiC7q1aG28LOXgBsLuVWBqecEpANSWnh57+C+QpG+v1F95UoYkJ1BUBeI0AzoM3fCgVdZLKBSz6u58G4PH5q/Q==
Received: from GV1P193MB2055.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:28::21)
 by PAXP193MB2379.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:226::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.15; Tue, 25 Feb
 2025 18:44:03 +0000
Received: from GV1P193MB2055.EURP193.PROD.OUTLOOK.COM
 ([fe80::5d91:f670:adc6:52f3]) by GV1P193MB2055.EURP193.PROD.OUTLOOK.COM
 ([fe80::5d91:f670:adc6:52f3%6]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 18:44:02 +0000
From: Alexandre Marques <Alexandre.Marques@criticaltechworks.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: Helios <Helios@criticaltechworks.com>,
	"node0-integration-build@list.bmw.com" <node0-integration-build@list.bmw.com>
Subject: Clarification on Cleaning Up a Remote Hash Equivalence DB
Thread-Topic: Clarification on Cleaning Up a Remote Hash Equivalence DB
Thread-Index: AQHbh7MRukJI83hF8UOuOwNqyjIprg==
Date: Tue, 25 Feb 2025 18:44:02 +0000
Message-ID: 
 <GV1P193MB2055A662964438F153F844E5F8C32@GV1P193MB2055.EURP193.PROD.OUTLOOK.COM>
Accept-Language: pt-PT, en-US, en-150
Content-Language: pt-PT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=criticaltechworks.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GV1P193MB2055:EE_|PAXP193MB2379:EE_
x-ms-office365-filtering-correlation-id: 0654b644-734c-4d9c-421d-08dd55cc5fde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|8096899003;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?qnU49QUUWuEI63KB5+9Qmoi8fllDiMDC8kFtz6P6L9r93N8zZK1Cy4oTwQ?=
 =?iso-8859-1?Q?WlaJicndbZlnrIxgjSlv7Q36gY7mKqgyRERG07Z2q/kBcNZxRTeSwBrsh/?=
 =?iso-8859-1?Q?qaKLMC4oll92kQRjsQR7TPzDRlkGh5/hiHBDYb/brLDCh9TGwdT9l8FdJA?=
 =?iso-8859-1?Q?VhzWlxs+pr3JA/cEQggrFGC1R0tjJ02ftUcVDNm2S6POC1R2OiubcPLxIy?=
 =?iso-8859-1?Q?+nOkwarDGZlylHhS1RI1FQpPwfSGiEkYeI8p6VmvWfUw/5oy1qtMCvdGBZ?=
 =?iso-8859-1?Q?ity2lN3YSMAfRUZz83eMcUK5RJTTEO8s3725YPLng7Nd9/cjKvmTZPa08N?=
 =?iso-8859-1?Q?FB7m1bb5SxUgm6IGMPLLNRjL60uQQ5UNfWsE8mHy6dOD/j966vtfio1/Iq?=
 =?iso-8859-1?Q?Gx5Y4vIelQbu6sugBhQQ1j8UyQM32bpySh1rtumUNNLtTzd84Ew6D2o/xV?=
 =?iso-8859-1?Q?5fgnjfYMANgEAxz6WQoa19DqmLsGED58U4+v4e51KqvwV8/MqsLaoEUdaI?=
 =?iso-8859-1?Q?fHQIihdW1yaw2yVqvaEu5cwO020Wrqp+Lhw8FwMLfgtsx5rawIjE/LzB1m?=
 =?iso-8859-1?Q?d3EdUukECxTaUhQo1yncAc+qdEnusuKfDHy73IneLp1IiErq6BBZBYN73j?=
 =?iso-8859-1?Q?OGu7qBF4I2kL9DOY1tOFrvcPt4Vw6cf0cRPgJ1K8IqNdL441Z0ekSGh9au?=
 =?iso-8859-1?Q?rafxdFI5M9aya1FkkJoq/wGVqiEfJ8eRmhjtVdc9m/6idCKHc5NMt1qnhC?=
 =?iso-8859-1?Q?nFieRcd7BbDhcFjzOA6R145oxbgBZoErQqE0LEsvTcbkQesJpkIn5naHGg?=
 =?iso-8859-1?Q?tAZ5VsbXZLaLI5edMNX0wa0MJn5yRaaNTe1PUI7Jm5ji1TtlqtNk7fetE+?=
 =?iso-8859-1?Q?uyxZwQtKTJh8yAvC0A7us67E6e4H1Ifl3S6bressFYRYU3vljItiqcNowr?=
 =?iso-8859-1?Q?Vk+Nsp00H77HCnHinbxaVMvtL/c/ppuuUWkwTlCzuwNxk9dGx4gncQ84iy?=
 =?iso-8859-1?Q?aE3Q/uvVenLMxSZHydxikKWbikEUj+t+WLVAXyI1xkAqvY1QCculcrvRSq?=
 =?iso-8859-1?Q?Iq78tqRzFbTdCYW9iwrK0vJKgKt1U5l6Sb3IXp9gq5J6IOVorXutcwEDB2?=
 =?iso-8859-1?Q?grZnBJO1dlxIIPG/TbQtMFe6Z2i9M2xZoGud/BVp5SLPKc13fFpt9c3kge?=
 =?iso-8859-1?Q?IGeOk+2Wtvj3G3dfS7WtZfjt3n5I9c6rIOGYHqYKcKMAjqJMpsDGFdCzlZ?=
 =?iso-8859-1?Q?DwWHiInw9Vaw5G1T7CCQ6tROD4nz7+e9RV8ngDdRjEjCURRcUHhZyzG+hW?=
 =?iso-8859-1?Q?M3TPCuZrhfIYSAJ+XstrgtsrjtnxZeAzcuqJo1z2P56VyeGxnF0sbxbqXV?=
 =?iso-8859-1?Q?J0a6Xt3oPbLAN7uzoPibbjVBy5ufXbePIxCaNXc2DUnfjYByOVohiU2JAJ?=
 =?iso-8859-1?Q?L9hCVxTyuv2iaLtofy7tZT07WDZ77Xd5HpC7fEEqTjOnk0NQ/3vBaRha8V?=
 =?iso-8859-1?Q?T+CKuGMWB7rXBKHlskZ6Gy?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1P193MB2055.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(8096899003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?9OXSS3N4rc1r4I5wDtplh2mFY6tRFpXQKyEC6oYcOhyUKZ1kI7lYe/4TsG?=
 =?iso-8859-1?Q?IdT9X80rrjT7ltiqRn40QiUxe7neUhGlAPpaZ1IOOGDHSbcL96wz5hReUe?=
 =?iso-8859-1?Q?fulhEyx5S5BFF8o5xFYH6BDQEfzw7bcwCRwr4pvWBhJOyu456Qz1GY/Tua?=
 =?iso-8859-1?Q?5PvRyP0QbqChzZS2KYWtSFaKEns04mbry+1mgiG7FD/jVZOe5LjS61uPrN?=
 =?iso-8859-1?Q?WxkuFkyV4W1sgIev+W0BGVWkqZd20e8zg1x+pYzp6Z6S0sasNcFYJCr49p?=
 =?iso-8859-1?Q?fpQ/ZWYY5jomBIlR2Wtr74bNG7Q89C/JHWUPps8WzxVJrQidYQHfGv8Qrd?=
 =?iso-8859-1?Q?DmXRGc5bePrw1t91FJrwmdkfAJBmfSo5KGTIO6n+j7hUCIzZyCHjeCviI9?=
 =?iso-8859-1?Q?7xrIydKoe7CrsvVEu+9tNBPPCj3rYIRALtrz2KGQeEsVNbqHJfebqAJjJf?=
 =?iso-8859-1?Q?hBI3c48TzUGVWQTaZuou3iJQXy8Xc5i4t0SOtLievvDLIV5iwRNCrPgTNg?=
 =?iso-8859-1?Q?ESvnSJr0vd6GhFwYnU5FYQcFlqSmdQEfCcydPlcfEMnP9unTsFmhlD1fNS?=
 =?iso-8859-1?Q?VtYq+MWpdmub1XgRKPwsZf6I1yUq+hIdfdo72h6m+EOSOisgd6mFH8nk23?=
 =?iso-8859-1?Q?K8r6CppMVsidGMyIg12LBzDzmLAizfwGtteEe73SP8GmhOCx7Q0LYjuU53?=
 =?iso-8859-1?Q?pP5fsUwYxouOUKdfuOYriLbwq5ufSAh3MpS7C+aungwjn3tDvo+u211HnK?=
 =?iso-8859-1?Q?yd2cB7wKyx6S3k76uM36f/cnd1V2SQHs14ryww6QvapHU5cFc/nf8dqYgw?=
 =?iso-8859-1?Q?kGvLxSClHGODb76dqZ7KaPeRrs/oGRdi6DJZZD7hDmLqzN3xXsghG5tdk8?=
 =?iso-8859-1?Q?5nVvqPypGF3qJT6a0jtiOkGjxCh/Pket7YqdfBDbu4cnHrPl+EEhpEc9ep?=
 =?iso-8859-1?Q?s83u2DTpB/kQfSgbEHrMsLa55IRgi0fVJwbJt9ReeGAhZN8oErz6LFIadb?=
 =?iso-8859-1?Q?F3DibLEocsoYa4xyMoWMyGLZDSB0HA8GsU9X88IesOadAmZZNOyjOEB769?=
 =?iso-8859-1?Q?LHYwxz/72aSkTLs47U3bRYD6JgHNb7gN7x4kVxJlkdUMz8z7ucYyhnZnsJ?=
 =?iso-8859-1?Q?9nFAsNSch/9Xc9+51oxYseorNvO2Syti/1rZTnALiN5L35DvgOWCg6bpce?=
 =?iso-8859-1?Q?GhQW1RxMJXVF5Q+MfPpcMPr3HA0K435oJwGh7ERlv7cpw1zmjEHENDkj0J?=
 =?iso-8859-1?Q?ZUrc/M/db9ez0sp5tTBlvCAkMIX4V8diMhfSuGwDVWj+ahyfdhRRwph+0U?=
 =?iso-8859-1?Q?Jbms5l2QHKKHv3QSCO9Evk+nOYSSjrlbPL0GWhYvTPLcYsyGW8XEmwsO1C?=
 =?iso-8859-1?Q?UkmRixtk5T0QpBZTRfpT7duR09kUb4fWyDuQmqy1W1NkIeygnhrnQkcGge?=
 =?iso-8859-1?Q?JnXN+J7BRFxGNCEQipLTJjpPC32O6d5YqLdX2GZ4KYQxg8Fqqz3FDIREzF?=
 =?iso-8859-1?Q?47oOdtyTBcGDaWgsJppgjCBAHNxVu79tf8FdUsrCYcd8KsKtiROujM9IqO?=
 =?iso-8859-1?Q?l55pB8Us1V+eIRhStWGaZAFEU64Bpwl+fwTsZZF2KLhy0Bx17ktHzDiKvO?=
 =?iso-8859-1?Q?ee+BMhyfwSDIfzLtAw3OQn2JHnxr5G1I8zMsdfhfwumIAp6Df4K+/DEQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: multipart/alternative;
	boundary="_000_GV1P193MB2055A662964438F153F844E5F8C32GV1P193MB2055EURP_"
MIME-Version: 1.0
X-OriginatorOrg: criticaltechworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GV1P193MB2055.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0654b644-734c-4d9c-421d-08dd55cc5fde
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2025 18:44:02.6512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 61f30b8e-4f6b-44fe-9bc2-041e3a9f7346
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 26PyBODoWscSMmlA9xcVkbqhF9scRrMThCeZMLIOvTymUHYGAbOKeys7//ynlk/ZfPtOX/7C4Z818VDeo8tgWmZ/jyzYdT29rb7EUSupytw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB2379
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Feb 2025 18:44:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17322

--_000_GV1P193MB2055A662964438F153F844E5F8C32GV1P193MB2055EURP_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello there,

We are using a remote hash equivalence server and need to clean up irreleva=
nt hashes. Currently, we
iterate over a list of hashes, marking each as "alive" using "bitbake-hashc=
lient gc-mark", followed by
"bitbake-hashclient gc-sweep <marker>." This process is inefficient, taking=
 about 9 minutes for 12,000
hashes.

We are wondering what would be the best way to go about improving this..

We propose extending "gc-mark" to support a "bulk-mode" for efficiency.

Additionally, we obtain hashes from sstate files and were considering adapt=
ing the client to also accept
a list of files, possibly through a new command or flag. However the client=
 seems to act as a one-to-one
frontend to the server API calls. It's unclear if this is intentional or by=
 design, and if it would be of interest
adding such a feature?

Thank you,

Best regards,
Alexandre Marques


The information in this communication may contain confidential or legally p=
rivileged information. It is intended solely for the use of the individual =
or entity it addresses and others authorized to receive it. If you are not =
an intended recipient, you are hereby notified that any disclosure, copying=
, distribution or action in reliance on the contents of this information is=
 strictly prohibited and may be unlawful. If you have received this communi=
cation by error, please notify us immediately by responding to this e-mail =
and then delete it from your system. Critical TechWorks is not liable for t=
he proper and complete transmission of the information in this communicatio=
n nor for any delay in its receipt

This e-mail is environmentally friendly, just like Critical TechWorks, whic=
h lives in a paper-free atmosphere. Therefore, please consider the environm=
ent before printing it!

--_000_GV1P193MB2055A662964438F153F844E5F8C32GV1P193MB2055EURP_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hello there, &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &=
nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbs=
p; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &n=
bsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
We are using a remote hash equivalence server and need to clean up irreleva=
nt hashes. Currently, we</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
iterate over a list of hashes, marking each as &quot;alive&quot; using &quo=
t;bitbake-hashclient gc-mark&quot;, followed by</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
&quot;bitbake-hashclient gc-sweep &lt;marker&gt;.&quot; This process is ine=
fficient, taking about 9 minutes for 12,000</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
hashes.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
We are wondering what would be the best way to go about improving this..</d=
iv>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
We propose extending &quot;gc-mark&quot; to support a &quot;bulk-mode&quot;=
 for efficiency.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Additionally, we obtain hashes from sstate files and were considering adapt=
ing the client to also accept</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
a list of files, possibly through a new command or flag. However the client=
 seems to act as a one-to-one</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
frontend to the server API calls. It's unclear if this is intentional or by=
 design, and if it would be of interest</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
adding such a feature?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Thank you,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Best regards,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Alexandre Marques</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature" class=3D"elementToProof" style=3D"color: inherit;">
<div style=3D"background-color: rgb(255, 255, 255); margin: 0px;"></div>
<span style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-siz=
e: 12pt; color: rgb(0, 0, 0);"><br>
</span></div>
<div style=3D"font-size:10pt;text-align:justify; line-height:10pt; font-fam=
ily: 'Calibri';">
The information in this communication may contain confidential or legally p=
rivileged information. It is intended solely for the use of the individual =
or entity it addresses and others authorized to receive it. If you are not =
an intended recipient, you are hereby
 notified that any disclosure, copying, distribution or action in reliance =
on the contents of this information is strictly prohibited and may be unlaw=
ful. If you have received this communication by error, please notify us imm=
ediately by responding to this e-mail
 and then delete it from your system. Critical TechWorks is not liable for =
the proper and complete transmission of the information in this communicati=
on nor for any delay in its receipt
<br>
<p></p>
<p></p>
<p><span style=3D"font-size:10pt;text-align:justify; line-height:10pt; font=
-family: 'Calibri';"><i>This e-mail is environmentally friendly, just like =
Critical TechWorks, which lives in a paper-free atmosphere. Therefore, plea=
se consider the environment before
 printing it!<i> </p>
</div>
</i></i></span>
</body>
</html>

--_000_GV1P193MB2055A662964438F153F844E5F8C32GV1P193MB2055EURP_--

