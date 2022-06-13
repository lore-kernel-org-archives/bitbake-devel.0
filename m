Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC55C43334
	for <webhook@archiver.kernel.org>; Mon, 13 Jun 2022 09:03:35 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.48])
 by mx.groups.io with SMTP id smtpd.web09.3594.1655111007323414846
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 13 Jun 2022 02:03:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@armh.onmicrosoft.com
 header.s=selector2-armh-onmicrosoft-com header.b=ZoqNtGHW;
 spf=pass (domain: arm.com, ip: 40.107.20.48, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=hH6X9Uf6PEAqAe1ZUYgDz0ZOo+DfY+cjCPbHoeH75poWMazS9zrkqNUpn6HrwQFFmNyunv7RI2eKh1FCBp3EwEo5CimhamSzoFkmxi8ghAcc27qHBxkzJAwvYTF2r+v+bmuxxVO9jzcsiExkTbUGT/yx6a4Tq5G//BqvkcuvmcARg5UxpEFQPdq8p8o3mW2WTzt3v3QVdQwb0kmDrse5i2eaAf6qgikk5QG3gluuWA8MV6/PypcCHjAfim2LGPyQESpG6+7N1yhT6Hki1C4OPR/lkLcjzfD/w/6FlcUnQEg55rWBejIwYbVl+4cYUtPWKfo+Y6ruX0Ifwetq4b4eCQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69RfDk8iNEN0um7jLQDev26nsy9aLrF7cb0YDKoswYc=;
 b=AGadAPM1vF55LHOgcfpepBHQtOMAlMNPKX5KHZdFinHGyX1tX+4i/WB0jXBLz1LTnYuxZJXIJRWKTQXzzeVI7XylThFopbDjPbWGZdKZRZ3Crc25i9yYvUVlChQMLtypDOadyFCokXqjca3w19sN2TgpTAGch2m4imLcgNSMxoGBjk+5s6XN5Lyk5GrxHvelNJ4v7TtZldV6xKUJwPpdobenO5AXOaCB5AjXR+vkwS23U4UE2iPIpbeNrOMiGTow04AZghlJmEuW9HoMG84QEu+Xww4pjznCOd8/WJnEkV8p9QG/LbmhAr/+cEb3wVdBY5nC7pTorMAyTWaOQsFs7A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69RfDk8iNEN0um7jLQDev26nsy9aLrF7cb0YDKoswYc=;
 b=ZoqNtGHW2IRbHVcTVnbDDrzhyS405wGLgVAABaHRjImCR2wOJTq//POG4cey5aJWPUTmeG43yUJKBgBJw4VoncSeYG41O3dy+2G5RIKCrnGuFKIUCPCQkaeiyR7LSANfwAB5aod0b9KWkg2cFfYp/KGhLHpWLsCy6DvVwEnorW4=
Received: from DB9PR02CA0006.eurprd02.prod.outlook.com (2603:10a6:10:1d9::11)
 by PAXPR08MB7279.eurprd08.prod.outlook.com (2603:10a6:102:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 09:03:24 +0000
Received: from DBAEUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:1d9:cafe::85) by DB9PR02CA0006.outlook.office365.com
 (2603:10a6:10:1d9::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20 via Frontend
 Transport; Mon, 13 Jun 2022 09:03:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DBAEUR03FT028.mail.protection.outlook.com (100.127.142.236) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 09:03:24 +0000
Received: ("Tessian outbound e40990bc24d7:v120");
 Mon, 13 Jun 2022 09:03:24 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2d8e7bc6c4d5fb0f
X-CR-MTA-TID: 64aa7808
Received: from 3bbfdbb4df8d.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 63ECB51F-11C7-4DFE-86F9-9F672E1518C8.1;
	Mon, 13 Jun 2022 09:03:17 +0000
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id
 3bbfdbb4df8d.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 13 Jun 2022 09:03:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZSahlrl1c8iJv8kq+hNfYqtJz8kOvhruqwWaeQM3m+aH4LtUTpqivKmOwWa5XUCdOYEmVN4WgBMuXOwr5JPRtwjuk9BX5HDdzjTxp9gWTtxtGSMc5B+Rjm22v63WbWsGcWT0Dfi+X1wtGPDH/X2WmEU4XWEN5+KtpzDESLPu+65Qz6uo8X72Pud9eUK+pe9Dfj3/xZMNhmxJn/+YoMQswRqBVA3iCBIfZ5mR/Z+LRiaJb+xUyGIMIFvVo30nB6HeHjsAeLJIWTjxqEYCHYAOZZC0dbl9sXIVfCBpas0NsFXiX4TlVFi6QloqyhmXCYjErMinP4gipOV6P+0VdDsotQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=69RfDk8iNEN0um7jLQDev26nsy9aLrF7cb0YDKoswYc=;
 b=A6HkzaPqKk6Cp2D9yrQscqKcB+gPhTg86d6/z/Ww4qLIQsD26p5U5TcuiRvxliiSYP8QWA8qg5hk9ddEjq5llFafPNGJmbcCaBAbzHQwnXsp6u7zI6bEiQ08aQ+uAeLngc1LTqKyPPkwrfH83vtKyM9OplVLL247UckXT3Bb+y5LDaVGOwKzVrm0DS92IvMT3eeNG+CjPRx+8X2eHavMGYE9u32H9nU1mVujCfj8qpL4j2aiDJm6Rk/EDtei2ufFZGVR8DtHUMrXe1QZ6mfX2jMQFHkZDmkzKZmKb7kFu1nZLLm8v6kGyMZ9PanS55gSox7sJgPG0uw4Z81B4MvQkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69RfDk8iNEN0um7jLQDev26nsy9aLrF7cb0YDKoswYc=;
 b=ZoqNtGHW2IRbHVcTVnbDDrzhyS405wGLgVAABaHRjImCR2wOJTq//POG4cey5aJWPUTmeG43yUJKBgBJw4VoncSeYG41O3dy+2G5RIKCrnGuFKIUCPCQkaeiyR7LSANfwAB5aod0b9KWkg2cFfYp/KGhLHpWLsCy6DvVwEnorW4=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by PR3PR08MB5706.eurprd08.prod.outlook.com (2603:10a6:102:80::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.11; Mon, 13 Jun
 2022 09:03:15 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::6c2b:5021:db9a:bf6d]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::6c2b:5021:db9a:bf6d%8]) with mapi id 15.20.5332.019; Mon, 13 Jun 2022
 09:03:15 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: "kaustubha.s@gmail.com" <kaustubha.s@gmail.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] sha256sum and md5sum value.
Thread-Topic: [bitbake-devel] sha256sum and md5sum value.
Thread-Index: AQHYfwPknNYj/s7fJkKNvuN2gudMzK1NCpRJ
Date: Mon, 13 Jun 2022 09:03:15 +0000
Message-ID: 
 <PA4PR08MB7411EE44E738F6FB614FCDA3E8AB9@PA4PR08MB7411.eurprd08.prod.outlook.com>
References: <4RgF.1654898655633489443.g1Bs@lists.openembedded.org>
In-Reply-To: <4RgF.1654898655633489443.g1Bs@lists.openembedded.org>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-MS-Office365-Filtering-Correlation-Id: 86e53256-c24e-439a-3f20-08da4d1b9269
x-ms-traffictypediagnostic: 
	PR3PR08MB5706:EE_|DBAEUR03FT028:EE_|PAXPR08MB7279:EE_
X-Microsoft-Antispam-PRVS: 
	<PAXPR08MB7279C4F030DA613348A9C0FEE8AB9@PAXPR08MB7279.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 5a8zCugux0XiPqZzyoSbco+XYorEga+Fo8WAUE/LRb9AbwghnlPAMdTRQZLkB5BfH1DqoGTfcypIueOysDu42ncXBAgK3uIiumBtZnLRoYvwdD2gKPfgxktxIiwbHlVGcF43kxJM9FerBWwGTjwBiAVyynlwhXMIq7iluzsW+xQnpZQpRmbEk2xGeFJPu5B6GLdEizFKJI5gT/9yfbfjvjp3SXZeMppaIdMrbCTmG1SgIcAVBoGDpwib5jXJ6qmjzYskxsvjQFZooms5AztAx2zklgkqh80X0uWJGvaUTeM2kaxbe4dJ5n4jKJ+RJYsmeSWtRGvyqFO1wiMKE+ILTR2Uium5Udk8+DK7ndxklEVgGm7s6BO81hHK3zQc26Wre2kT92M8DWmDEipcqDilt8QgQOPRPSwo7/CHaup2Ze53jwdTbI99Ce3OrnarNtjyVdOWnywSb8S+bublj8sIeq/kmIOPDnbOquDfBREIQzzS1ePVnLhdec6QfjHbYJ2DK+zyk36SAzEvc9cGV2KlXk/Q37dV3RpD/pRSGlSQxhNOhfZDsV+2fgAIoXVIKSdz44jzlMAIBYjjHXp84PPhJl+g7seYKuQ5VIzMT1IuxWo3aqzicHACvmIaLwH1eY62WV273hoKNc47xOigx1YliaCXLbYhFCmv6y9TDwnOOehHbbdAsQWBM173lzHm8cp/pCqCa1pecOZXcEoVOjm3Krc5t78rWRov9tmrC7fiYj6soYj/u/k4FGQtewsGRw0axU6fwuQk1P5sCDVU11Lje+rZsAgyQSIvS5R+J00vHqk=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(186003)(2906002)(122000001)(38070700005)(316002)(7696005)(6506007)(508600001)(8676002)(71200400001)(9686003)(64756008)(8936002)(66476007)(76116006)(66556008)(26005)(66446008)(66946007)(5660300002)(38100700002)(86362001)(52536014)(33656002)(55016003)(110136005)(83380400001)(91956017)(42413004)(420554002)(32563001);DIR:OUT;SFP:1101;
Content-Type: multipart/alternative;
	boundary="_000_PA4PR08MB7411EE44E738F6FB614FCDA3E8AB9PA4PR08MB7411eurp_"
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5706
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DBAEUR03FT028.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	ed2c17b9-67d3-4b35-ea48-08da4d1b8d1c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6qGAWrj/uMpNB24JF2YHlHZtu8I++as704oylwqdYWANVt0Q4OYNBKafyT9/Klux8x01Fq9xQVz+6xI7vp12ETx/ofE9Y1RDwsPKSMZ5UHIWQ5fd2u2s/Sl+7XyKx4+B41unYmjnlxdaKNpW9xJCnAFaoPRunTfYUlrNEyq/YfzrP1Y1b5sujnjm9F4YwhBnHp8vrt5fUD8Il6UfRbQnkWv3EwQvJHpRklbwGsDRiorkJ/8G2DtBKGXhLhA9ij4yeu6W1qtORPnXIYe9HBhS9Vq7Mj/iMcZNsHM4Hwa0smzJqoHwLJ/BpoQyIRTCuaKNPpWWNgVb3cYbXVuD9Zpf2zWw81rXGW4dQG11OysiMKuUCtNM2qJyS9TcEyiqfu9jmKrxmJygYPqY8XlfPAtlmGr3+dvPjN5DzgEtAazEpIgFRxWzcAKa6qrQTEaR6p00Pz8u7gkWl1BUV3dPsb85NVJVho8CbV/EfqyC540RbYxaxbjXouxykCCh7DY2vhU/kFHd59kW6Hz/UvjkXn3Z2BdjmgfG40JY7WBd0szG54yJSFFUC8ymH5YIa87t+E6FFFPfPkoaEJoie+TI1F3YV4pcU721R46PsAwU+MWo/CSsSkZHIW/w4pQQBGFOKp68Bq5r4+wdZiz/5zE2i6M3qPKZ/Ni0OisBwLuCWcTmmgvCAGh6RFv6wUsSAWAVANiVPqRVWETqlRyXbkyMW/MxOQV1i8SbGez7zparW20KvmAkFaDzFyTKJnuEtTj5zOfB
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(26005)(40460700003)(83380400001)(9686003)(316002)(33656002)(55016003)(508600001)(5660300002)(356005)(70206006)(82310400005)(70586007)(336012)(110136005)(8676002)(81166007)(36860700001)(186003)(2906002)(8936002)(52536014)(86362001)(6506007)(7696005)(47076005)(42413004)(420554002)(32563001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 09:03:24.2173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 86e53256-c24e-439a-3f20-08da4d1b9269
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DBAEUR03FT028.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7279
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 13 Jun 2022 09:03:35 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13757

--_000_PA4PR08MB7411EE44E738F6FB614FCDA3E8AB9PA4PR08MB7411eurp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

All you need to do is d.getVarFlag("SRC_URI", =93sha256sum=94), that return=
s the value of the specified flag.

Ross

From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedde=
d.org> on behalf of kaustubha.s via lists.openembedded.org <kaustubha.s=3Dg=
mail.com@lists.openembedded.org>
Date: Monday, 13 June 2022 at 09:59
To: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedded.=
org>
Subject: [bitbake-devel] sha256sum and md5sum value.
Hi All,

I am new to bitbake, I was going through the bitbake documentation to get t=
he value of sha256sum and md5sum into the recipeinfo file from *.bb file.

for example in *.bb file:
SRC_URI[md5sum] =3D "XXXXXXXX"
SRC_URI[sha256sum] =3D "YYYYYYYY"

to recipe info file:
LICENSE: MIT
PR: r0
PV: x.x.x.x.x
SHA256SUM: XXXXXXXX
MD5SUM: YYYYYYYY

Can you someone please help me how to get this information into the recipei=
nfo file?

i tried using below instruction
    get_name =3D d.getVarFlag("SRC_URI", 'sha256sum', expand=3DTrue)
    if get_name:
        info["SHA256SUM"] =3D data.getVar("SHA256SUM", d)

but is always prints "SHA256SUM : None". i am not sure what instruction to =
use for sha256sum or md5sum to log to recipeinfo file

-Kaustubha
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.

--_000_PA4PR08MB7411EE44E738F6FB614FCDA3E8AB9PA4PR08MB7411eurp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
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
	{margin:0cm;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle18
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-GB" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">All you need to do is d.getVarFlag(&quot;SRC_URI&quot;, =93sha256su=
m=94), that returns the value of the specified flag.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US">Ross<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt;mso-fareast-language=
:EN-US"><o:p>&nbsp;</o:p></span></p>
<div style=3D"border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt 0cm =
0cm 0cm">
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><b><span style=3D"fon=
t-size:12.0pt;color:black">From:
</span></b><span style=3D"font-size:12.0pt;color:black">bitbake-devel@lists=
.openembedded.org &lt;bitbake-devel@lists.openembedded.org&gt; on behalf of=
 kaustubha.s via lists.openembedded.org &lt;kaustubha.s=3Dgmail.com@lists.o=
penembedded.org&gt;<br>
<b>Date: </b>Monday, 13 June 2022 at 09:59<br>
<b>To: </b>bitbake-devel@lists.openembedded.org &lt;bitbake-devel@lists.ope=
nembedded.org&gt;<br>
<b>Subject: </b>[bitbake-devel] sha256sum and md5sum value.<o:p></o:p></spa=
n></p>
</div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">Hi All,</span><span style=3D"font-size:=
11.0pt">
<o:p></o:p></span></p>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">I am new to bitbake, I was going throug=
h the bitbake documentation to get the value of sha256sum and md5sum into t=
he recipeinfo file from *.bb file.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">for example in *.bb file:<o:p></o:p></s=
pan></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">SRC_URI[md5sum] =3D &quot;XXXXXXXX&quot=
;<br>
SRC_URI[sha256sum] =3D &quot;YYYYYYYY&quot;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">to recipe info file:<o:p></o:p></span><=
/p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">LICENSE: MIT<br>
PR: r0<br>
PV: x.x.x.x.x<br>
SHA256SUM: XXXXXXXX<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">MD5SUM: YYYYYYYY<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">Can you someone please help me how to g=
et this information into the recipeinfo file?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">i tried using below instruction&nbsp;<o=
:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">&nbsp; &nbsp; get_name =3D d.getVarFlag=
(&quot;SRC_URI&quot;, 'sha256sum', expand=3DTrue)<br>
&nbsp; &nbsp; if get_name:<br>
&nbsp; &nbsp; &nbsp; &nbsp; info[&quot;SHA256SUM&quot;] =3D data.getVar(&qu=
ot;SHA256SUM&quot;, d)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">but is always prints &quot;SHA256SUM : =
None&quot;. i am not sure what instruction to use for sha256sum or md5sum t=
o log to recipeinfo file<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">&nbsp;<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:#222222">-Kaustubha<o:p></o:p></span></p>
</div>
</div>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose,
 or store or copy the information in any medium. Thank you.
</body>
</html>

--_000_PA4PR08MB7411EE44E738F6FB614FCDA3E8AB9PA4PR08MB7411eurp_--

