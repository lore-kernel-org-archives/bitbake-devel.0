Return-Path: <christian.schaefer@at.abb.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E6CCD98F0
	for <webhook@archiver.kernel.org>; Wed, 17 Jun 2026 12:02:03 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.37])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13944.1781697718395838831
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 17 Jun 2026 05:01:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@at.abb.com header.s=selector2 header.b=TCeMeW9c;
 spf=pass (domain: at.abb.com, ip: 52.101.83.37, mailfrom: christian.schaefer@at.abb.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LOgOqGyrvwup1SS+7bW7LoqbGsx7WmjIdL8edtP4NtmezF3s8jwDzFNhDCwR4OF1h2pXWzOjTL/DFUqzyu1Pcgv1SCxJ1w7GL0HkiXEQFDcPqxSiJ4iWI1+jZe3pjIBL2VWiqgDeAH0YcwN8KGSuaIchNxXxya3xJJPVrVbVnxT4qZtpGKwAM1DR2WOcXsqrawVT3T+25HfzCJJeZtiF/nYqFrfH92S5/VEnZhqNUvYUWYpYZIUzkdMXneyOSl9pwnZfKSrcsWT+6rEQrDU5KKsRkG8rUeAd0f6XfWf8FlnoMfkgUAniX/D3rlskaJ/v5Hi5TXCwadPSuFKxntilYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AmhKuaZMhHtE3ws4Nz3zv77SfRxfgveiYOjA5qoRC5M=;
 b=OuARxrTerjx8KeVPhNO2ZQ+NhH7vVz1axetyyeLtIZH2qC5nDEQHfA6aqtQrRYeh7SwWn0+axL+UR0gIFYHGoWjIbq8J8F7hA7q2R9GakI5/1wf3KbMq39eCHkk1fqX605uf2Swy1d/KAA3yhzz71BlwM1d9QRz623y+eqoNS2M7lBTqLRGOu449Vc0VipIbtkiHa3dUlvY5VTJnulpL/ve1jF25C+bI//5Ut0ScXoZWuYozWz8h+GXcQ4ZAEcUsVxQpJ4J0OtEFQ2yrGRfuabTw6mStkA1NLsyqtr//Bgub4Yn2/eT+SxtUpDq1NhaOqN/lVitFUxNMliHs4WLCuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=at.abb.com; dmarc=pass action=none header.from=at.abb.com;
 dkim=pass header.d=at.abb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=at.abb.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AmhKuaZMhHtE3ws4Nz3zv77SfRxfgveiYOjA5qoRC5M=;
 b=TCeMeW9c5iifZbpPKZg/LtpzeYJy9rOLGSe6qalDWNcBRngD0jZOH67uMNoVQQjSdR3PSY2y0ZtsqvYmD6PkpZce71I29S6SI0RADgjZJmNGnElQi8QmepM3CXQIDKJMjp0xEwnwbBfuWknvmNYQVga8jieUre5/hXF3zPnnEvkTmlTL3sktgAf+oXuJUnyegsgut2hGrKbjm+U+C5S2PlmDD/w/TPBKFjUB357U6o5ZFXXj1CdjjVroGahwcIfmOzu53+2EZAqQpxiSbLqoMwsTmszpGsieNTojaksZm1X1Xj21EV46cfmTDCLnjFPXts/knCd/uj1UviqMX9dZmg==
Received: from AM7PR06MB6407.eurprd06.prod.outlook.com (2603:10a6:20b:118::18)
 by DB9PR06MB7467.eurprd06.prod.outlook.com (2603:10a6:10:262::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 12:01:53 +0000
Received: from AM7PR06MB6407.eurprd06.prod.outlook.com
 ([fe80::b96a:37fa:b16d:66bf]) by AM7PR06MB6407.eurprd06.prod.outlook.com
 ([fe80::b96a:37fa:b16d:66bf%4]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 12:01:53 +0000
From: Christian Schaefer <christian.schaefer@at.abb.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: bitbake-setup: sync layers to branch HEAD
Thread-Topic: bitbake-setup: sync layers to branch HEAD
Thread-Index: AQHc/lA36X37nSTVUEG/Q8gX1p1IbA==
Date: Wed, 17 Jun 2026 12:01:53 +0000
Message-ID: 
 <AM7PR06MB640717D4774F7C9F5CC36DACBDE42@AM7PR06MB6407.eurprd06.prod.outlook.com>
Accept-Language: en-AT, de-DE, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Enabled=True;MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SiteId=372ee9e0-9ce0-4033-a64a-c07073a91ecd;MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_SetDate=2026-06-17T12:01:53.025Z;MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Name=Internal;MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_ContentBits=1;MSIP_Label_d792d246-d363-40e2-82bc-6f0655128b68_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=at.abb.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR06MB6407:EE_|DB9PR06MB7467:EE_
x-ms-office365-filtering-correlation-id: a56e89b5-c790-4a79-72cf-08decc6838b7
x-abb-o365-outbound: ABBOUTBOUND1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|11063799006|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 45lM5Ymv56rsyxWMq+QSArmKselZPzynt2b4hWNOrcj2uFers9Ixcrq/AJzj1Nam6vZ9BYeUTiRplkQjxafMCjz6ub07duL23Dsrd6xMPyOUXJbjdHpXdik5rbVc3V6ISpbUhWPPn82HsufNoXQyZ9CYbXNpE1nvQ0A4gGi2G8J8IIwuxmEaPOahysDnFGr+Tke1+37mjh4NqZkmWUklAU+3I3ys/6mehfLHrZCSroyHSwsNN2LEmoA/62dZlZ4Hd3p4MKNlRLc0PUk7Dx481L65WT3l406E9q4MTG1dEty4jSsvoJ18xwp+gY7K0A9YAqXt0v1f2ILYKwfVvoMTL/9CYzd+r+nEJDevW/a1GhftbH1m5dwVp2JyofuBhD/h+0OLawd6j2aZE0+JeYAnYM0CtY5eSGw3xXGyLkmY8zFwJWkFz4dwu5Plz6H/tDHaZ1yVq66YtCAya8Joi1uX16irfpm/KiLaluywQEf/gOe6j6cX83YFu0+d29ByjqBaUwQ4AuQlf2jkdfl4XxaqbuaoCkIVm5lmb5t2VhR3sW6pHjv6rM7JrwGrXlxvJ15Da7gUALNFCzrv4nX9FTWfi59ln6Q5Vwz94tQs4C0yx3O5Yptm0qld5yDZUZb+61lTu7X/riFoMaoDsM7vmggYCmDXL6Ur3DOAGvivcDRHLsFRh05bOSUxxmTgsNpUdbqMQ44bEZZos1wsQYbLJd2eyGh0y1/FKyfdSSEK5tXIMPCTMyomzEshaVRPZyFvogvs
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR06MB6407.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(11063799006)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?C3sanwM1XAVTKvi2PPHDdmoTKAg2aR/18nDVgKLCxlJtt6yUgPhekurcw6az?=
 =?us-ascii?Q?QxUhfZ+HQzXlUepmZegxvIwpG81aBGPccrFkFH2Otcrqhk9q981134UVelUG?=
 =?us-ascii?Q?cTekPbToFiQX8rLtTzwXoAzU83CWOnVjuwDpn6KyfqG1YqXD7hHBV5YZU7yL?=
 =?us-ascii?Q?cNPQk/ZC41leD38CHUdQL+v05WYoguH4MHuz2y1DQYQvsBqArX+naygcDj5y?=
 =?us-ascii?Q?0X7gihowfqhaXrYCVWDK66VH2sADCi2gCR1BuuxvgKG+ihQFXeQbfjxDyiyM?=
 =?us-ascii?Q?jXto3EmfXon384HJyVPxmIUXhq/aRToVWxihztYSrJbZ9tjr4yBDqdH+2yFf?=
 =?us-ascii?Q?kdw6PfoMangrdik9MtRlw2KUYNrBrA4c/T1W4FFr9CADFq0Q7CpR8sZJA1rw?=
 =?us-ascii?Q?1i/fE/l+TK931qesxhdEaibrJit/k7F6Z/OfxZ8AaPVYcx/mNOs4PxIK6uDo?=
 =?us-ascii?Q?HVCz4grFPZZtLja/epTlSu9bTi70xDKr0YOWmVKyiHl/Nn9mlQ3GzJf0ZWIJ?=
 =?us-ascii?Q?imDyRQuYKF5ln//3gUXDy6+PAI9yxpeS9wB+sUxSxOg7o8xdaZj9z7FCb0Ft?=
 =?us-ascii?Q?HMEe0Y0yCCTrk3WCB+d6B1I+iGtnDFB36teT/jfvdV1AbdY9qY3zRf67Pybk?=
 =?us-ascii?Q?byWjhnKGALWxsWv28rFA/34g9ukIisbwNdCsajeFxi5jKk6wrjUTm59iWuy/?=
 =?us-ascii?Q?CqY0P81m3AZ+wcwR6cC9k81H5QTsLJDZWCHTNXUhdTgjqfmaAtx++nyD53z+?=
 =?us-ascii?Q?xNNNyqUa7xBinG09EPUpOkgOeJYwSQw9z/QyHmlsLj66xxJ/QqgAnBRxGC/r?=
 =?us-ascii?Q?cjOov4rS4veamXrCp5DQEy1EHkYHv20TQw4ZkaCpoV1J4QJuD217RBIOKu/r?=
 =?us-ascii?Q?s7NO1EOJ2yidD0x8/K3LaVVr5BwS5lUX05McKZ67iEYUHxccmWDhpH9rkDD2?=
 =?us-ascii?Q?nAmkAE15yuYt1Di6il7Irhnis0zFz+3TpAvrf7j7M++2/PglDzYTmG0d5ti5?=
 =?us-ascii?Q?fgNo2rlJFcPWrz5rwZLYoZOdaWqWhmS/t8lg4klsbZCMYTzkQL8jPK2M9wqQ?=
 =?us-ascii?Q?4lvVK9plsjbZogZ8/dNhmj4qRYrajWnJp1RYRI4njfRGneNbQKNOSBVG06W4?=
 =?us-ascii?Q?BWhoRb3c+dwj94wMjV/lV2HhgEJDJ+VmWhhOqmj3/+w56lnKsDMpZaemR/cW?=
 =?us-ascii?Q?N7eif3Xa5AcyOsTI64GC0gwH+e3mwpjmCDjXLbEuabrt6shGhaZeltGW6Urs?=
 =?us-ascii?Q?Q+WZmBOgRglP2Of+KUemLLUAC/grTO5nm90oXmlbV7bzTtI4L9TCxQjQSASc?=
 =?us-ascii?Q?rGibcNJ+bCWHcJDfQO2f2iPB/kY+CRMxQL35zCfN4ZI36qFBh2WrDD6DhYvV?=
 =?us-ascii?Q?xrnZZH//jdgjZHxidYLe9QrBMeYm5LEVUTmgoWPR+3+3Gigu5sWhKYcap9m1?=
 =?us-ascii?Q?akkflXrxSatwtvd2VrLe0Wxt1E/min5/QziqiFO7C4NTiP8BvcyenbhwQOMG?=
 =?us-ascii?Q?rxoYFpTAh1njPQrPkc96+bzi8G9L1gZTTWkR9B5e0vBBTnC0L7RaSJBMtVIf?=
 =?us-ascii?Q?JYs001Yjd/T/C2IpSLiIMBxjp6h+LkKoBj0lFMLxAApgXUSWf7bt7LQgcaIZ?=
 =?us-ascii?Q?sj7Kn+Q+EKSOG7oXouG6d9Y3r1MSIoh++y5PRwiaGLo68ztgdHFaIutnqbeH?=
 =?us-ascii?Q?oXaZ81TapKIQlzTCPlTP6eEgu0lK3IBEoSOEbr2nOQGUx+70Qu30u8nkPAwN?=
 =?us-ascii?Q?C94aBOQNnoL6TGBlrUf7okZ5IKC1xr0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: at.abb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR06MB6407.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a56e89b5-c790-4a79-72cf-08decc6838b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2026 12:01:53.2835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 372ee9e0-9ce0-4033-a64a-c07073a91ecd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N4PxO9zxExZAMmzH/IYHTvs8CC4+g1on7wGLb4j+t5vZ+lEDDKFUr6+WcmVcoaYgAktYu5g0usc72vp7gzxJSDZLeDlmYfmChOzuYvg8i7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7467
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 17 Jun 2026 12:02:03 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19725

Hi, I have a question regarding bitbake-setup.=0A=
=0A=
In a *.conf.json file, I can configure bitbake-setup to use the latest comm=
it=0A=
on a branch by setting `rev` to the same value as `branch`. For example:=0A=
=0A=
"sources": {=0A=
    "openembedded-core": {=0A=
        "git-remote": {=0A=
            "uri": "https://git.openembedded.org/openembedded-core",=0A=
            "branch": "wrynose",=0A=
            "rev": "wrynose"=0A=
        }=0A=
    },=0A=
    ...=0A=
}=0A=
=0A=
Over time, new commits are pushed to the upstream branch (wrynose). Is ther=
e a=0A=
way to sync my local checkout to the updated upstream branch without runnin=
g=0A=
`git pull` manually for each layer? Originally, I assumed this would be don=
e by=0A=
running `bitbake-setup update`, but no changes are detected, as the *.conf.=
json=0A=
file is still the same.=0A=
=0A=
Regards, Christian=0A=

