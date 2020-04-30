Received: from EUR02-AM5-obe.outbound.protection.outlook.com (EUR02-AM5-obe.outbound.protection.outlook.com [40.92.67.66])
 by mx.groups.io with SMTP id smtpd.web11.913.1588272541294046258
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 30 Apr 2020 11:49:02 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=SpyLQ0Mn;
 spf=pass (domain: outlook.com, ip: 40.92.67.66, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBOG9aEMg3+x+hy6HcZoAFXOTz1qpPHMZE9vbER1q93CzXdLcPx5/Voi9fP0rSI9uDvdY9VGzIibKU6GnPgNMSlvzqlzIFWLRzmg8Wuj5bLGS4aXlzKe0UwjRXZ/nwuIE5UUMIHSZqRBoquyAfCNEiikcp54F/9GjCPdlbojAhBfCGmIgNJUWldqd1mDpeKsvDcnYhq9w9+EK71NIWmM5r5ME/FPIuLdjUh6l26htlqJvRaQS8Nn913IcnPJRNRi9veYbkL7IXG06VpEYGGbgidoNf477NPrKnqXhYLND3idqBxzl1rcNyE3akmnA1Yb/043xsNrk/WHSxTYxRdmRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG2BnUMtmJ/0x0e7dTLyY2cfdFVCMDfONz2I120IRHc=;
 b=A4dcjKoQ6lm5j+GM1P/kW90IvSyQMFp0ANJmJoQzxuY8IUx2ZqFJfP4tGnQsNRCA6Kgt3y+CSqv7UfVRBDE93yTs5tbYNHScr6u1wnNvB7GMFQo+beaBn+lUSPovZ1oIgvtxwPMJS1yxhP0anmCkybwjhWOrzFfxlNFFTyYJ8lcY2NR0LPduU4irAJ79kya51Rw0BgPKfGknRcgWSmGsoe4fzDL01DKx6aamdaKVnQLDv5xcRJo//0cWpaSq7HXbCp+XIVN0OE30tz9ej3I78WVmBHYntUUD3rQEc4a5tcvtzuxttwRIFmXKMD+4ccnOloGEu6V2pIh+uC3q24kY0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=outlook.com; dmarc=pass action=none header.from=outlook.com;
 dkim=pass header.d=outlook.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG2BnUMtmJ/0x0e7dTLyY2cfdFVCMDfONz2I120IRHc=;
 b=SpyLQ0Mnv4QqdsJHLNIGbG/EwkJjcnh2UEkXj5D94KNWp69ZT+9yQJ4DW3HlswsLXELRXZexD8tS8wb+D65qzu6pKSnllO1qs6A6svAgWf/GicrfF+6PXHc9DYvFwkXNLFPX10DlYMZTdXhLqg63x/SObsBwadXm9tzvfvZQ9BRzXb+wK5Jkbeom/iGkY5Gko/RC03TS46RrMEfMZld0CqDAmPo/fEPvVH7fqsCvYUwaY1hlfJYeNDc7TbKiBBgEsgqw9KA8R7GpLHGIatM7qkS8wnv2EA0WhAVhZxVggV3OGHxrvhaSjWU42MKn+u+TBeT8eukx6DYopJ0nWrUVDQ==
Received: from VE1EUR02FT059.eop-EUR02.prod.protection.outlook.com
 (2a01:111:e400:7e1e::41) by
 VE1EUR02HT193.eop-EUR02.prod.protection.outlook.com (2a01:111:e400:7e1e::507)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.15; Thu, 30 Apr
 2020 18:48:59 +0000
Received: from AM7PR05MB6881.eurprd05.prod.outlook.com
 (2a01:111:e400:7e1e::48) by VE1EUR02FT059.mail.protection.outlook.com
 (2a01:111:e400:7e1e::271) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19 via Frontend
 Transport; Thu, 30 Apr 2020 18:48:59 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:287058A9C9B1AA085C77C15AE0162F5D2BD28320F315C27E74235A9542A0F2C2;UpperCasedChecksum:F87EFFB69DA2DF6C3F39DCDEBE3C11013FC71E9B50BB1CDA7C92AAD26C5369EE;SizeAsReceived:7453;Count:48
Received: from AM7PR05MB6881.eurprd05.prod.outlook.com
 ([fe80::f5f1:b5e3:66d7:e590]) by AM7PR05MB6881.eurprd05.prod.outlook.com
 ([fe80::f5f1:b5e3:66d7:e590%7]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 18:48:58 +0000
From: "Konrad Weihmann" <kweihmann@outlook.com>
To: bitbake-devel@lists.openembedded.org
CC: Konrad Weihmann <kweihmann@outlook.com>
Subject: [PATCH] BBFILES_DYNAMIC: add inverse mode
Date: Thu, 30 Apr 2020 20:48:34 +0200
Message-ID: <AM7PR05MB688137517351D79158939322A8AA0@AM7PR05MB6881.eurprd05.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: AM6P192CA0031.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::44) To AM7PR05MB6881.eurprd05.prod.outlook.com
 (2603:10a6:20b:1a9::19)
Return-Path: kweihmann@outlook.com
X-Microsoft-Original-Message-ID: <20200430184834.10851-1-kweihmann@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ICKE-EDGE.fritz.box (87.141.84.123) by AM6P192CA0031.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:83::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 18:48:57 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200430184834.10851-1-kweihmann@outlook.com>
X-TMN: [DThjN6Ji2GPPkkAhOFwPlGZGlZ4enbY2]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 48
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: eb1ad353-b332-45e7-beb9-08d7ed3723d6
X-MS-Exchange-SLBlob-MailProps: 
	0RSV28T7LqS1WaFHeL7vGo9RlvU75tTpbU8w9U07PVbVMpXD4WY11bDuL4FNN1mTSCMtVzcWRWRapGJEBjv3qLAuCq9bm4QT1W2NrdLbOgJnsypAKG9lp/wj7I3vdayrjnoOEooQzIZizC+87KthmqlJoHoKWyS1ovSN5Lb/piUEENmyivxO4bGcf0Ju3LnC52nK6TbGmZU5mPLHQHj/jjEpVbFdRADyVMqKqLbBaX2Op94LWQdAhvIoG7lfZQCiKMpTEp046zy83E6yt/OU4oxl2myqrM3PKTxM32q8ulwMuj1UuYZJ15Ru2182PXIU6/Y19SZAUtaoxdmXWZtXT8XKTDTiyfUVna+0SPLppDJNwnxMwjEnYMQ5j7XgsR1rjzbYAMDw7M002sCrOuaTXXQ2G/XcujVliEH6ckv1fUHw2IyaigMgTIZ22YWGsqg/Lo2lgFaCdqXe111BJ8021ku76119VbvLL4Tkl+pzf3Z/6Pq4iqTUWLFgA8HIEYBWG7f4ROnqbfunOy/nQyQmsjWuhlVPuFsssbC5+pKBXF6Cwu5/MqQQkckOebSG8+lKNZ6iRAkv70FFuBpoiDEloOv+Ok2LTiHo4tr0zsVSFgIBNglIRELWt/7gz6zwkPxmI2/ClzaaoVlVZc3dZWuA0lCk2lj4i4mnIQTpM7HNceQGdNfpnoH5/8Nc6DIDexAo
X-MS-TrafficTypeDiagnostic: VE1EUR02HT193:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	sR9BnPbPly/DtZtpfhTJQZQQcrjUq3N/7/U/t/UnpWDidMReVw0pQO8VBQypgGD8wpk0Sbl1XwGCRhtys5EnoVFOmU3W5FLdutCr7XejuQFtOk4iyJKC9S0EkBcVeq0JQoICfFJZJGPnzYInRF9RdLT2YUysvbm6tkjSzdk5LhtAmlvqEcBHOKS7Z9TsQu4X2+Ml7M0lZDhDiN6D3dEeRA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR05MB6881.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: 
	7s3v446CqJqNw0wA5a/PaAF2EglGQKcbr//eXRWEfFS5amjIl20RijCx8b/rIKB0pD0MKvDNE3QJn902I5Q5ONpAYp8Hm+kOskvp7Xf0qQ7+ZQjmQUi5z+iXPsEGfR3gtMo2bvxE3FxpkmGAjr9gwA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1ad353-b332-45e7-beb9-08d7ed3723d6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 18:48:58.7417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT193
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

Add an inverse mode for BBFILES_DYNAMIC.
Entries where the layername is prefix with '!' will act in inverted mode
including given glob mask in absence of the referenced layer.
This is useful to backfill recipes from potentially missing layer.

Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
---
 lib/bb/cookerdata.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 472423fd..886d46f0 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -386,8 +386,10 @@ class CookerDataBuilder(object):
                 if len(parts) !=3D 2:
                     invalid.append(entry)
                     continue
-                l, f =3D parts
-                if l in collections:
+                invert =3D l[0] =3D=3D "!"
+                if invert:
+                    l =3D l[1:]
+                if (l in collections and not invert) or (l not in collecti=
ons and invert):
                     data.appendVar("BBFILES", " " + f)
             if invalid:
                 bb.fatal("BBFILES_DYNAMIC entries must be of the form <col=
lection name>:<filename pattern>, not:\n    %s" % "\n    ".join(invalid))
--=20
2.20.1

