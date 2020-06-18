Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.92.89.36])
 by mx.groups.io with SMTP id smtpd.web11.1547.1592507777851638360
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 18 Jun 2020 12:16:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=IMZhZ1/I;
 spf=pass (domain: outlook.com, ip: 40.92.89.36, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z2vnvVQMrZOCe2ilMDjZLwAu4fNszvhB3mwkxqYe5Je+fVGqSbDeL5ZTxQVOo1GUZ+TrAebYcg6FiABxBgtG1rmYCnpb0Mpw8c9jbRz8qKntGPZ375XD878gmYGsoWFBVRW+DZs4FJKue9bIt5XZ8fKrX/rdrMOXPyd2p+S5b0cLMO9cVpxi2+3Cm7J1tvHWkXjTqAYus2fZNpcjDOQZDhZf+ThxIYAo1DyvUg1kZrz+xGrqUogl6x5eYTq+ZTKfCVynz+sgaNpyl0XXuQy7+J0rVoiNCoZdz4v85yzuwWZbF+j7VEnGNjVsZwxMBAZBzk++1NDfIYyeQTW3mDaipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZYNbpdx3Z53iaeweeQw5XahNQJm4cgkEnTgpS0Tjhg=;
 b=GMzxQEzZoCgRmaHDJ+gYexCic6wtzPgIBq3O+jv18AOzZTBhnj1GsPA5nH8boSD5ncUscpxg+kixj+flPKG1hFt7mzdblzOtn5Di+pxJhvML+UbelhFs02+coNa0Dsq0d/oh3i+r0UDrEtV0GAdYOoEcD4M68bjKGA1TvgXLdn6E45Ij1z9oAvORO7fz2AEG1zjrUdHxZ1lrYRet8MbuGhXKNR+QPBxNBTiPdFYbCJQTqv3IvXaK81Oy/Db4IklGyL3EQLtxsP9CBkTeEzPduqGDTgxrDwWeUosjRXx5Fb9nLHsr8tiITjXvkcv2Z9AAkEOXThe1HmAFK1833fUiGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZYNbpdx3Z53iaeweeQw5XahNQJm4cgkEnTgpS0Tjhg=;
 b=IMZhZ1/IKSTzhvPO0R/+daoFHWEsiNnu0VTKR3j33mZR1tkmdGsHB95kS8sAmZ9ksJdA7Ra1pOCD7UjyhLlBn4HudDm0vvKtWPFJ4z+K5F3iGt5Bf+lB6slX6tYPzqH5DtaQRJ8a2sDTgPk01zVcs5kA4jr9O7AxaLiCmK71OeQsWYbNypAnT4FedGMhDfZZY7UfhOy47knSkQFKWkn9yNDq7LvIEEny0YqJ+d/ZlpoXUEh8wDhHxdZnqLHDK5n9q65TgndWzeDIJ0fIQfuS+Ml/tPguC5YRsP1wb/xi8jTKPHFV1P7RprvD2zTd7DfMRpLvMXex7wwhe0h6buhQCw==
Received: from VI1EUR05FT043.eop-eur05.prod.protection.outlook.com
 (2a01:111:e400:fc12::44) by
 VI1EUR05HT239.eop-eur05.prod.protection.outlook.com (2a01:111:e400:fc12::403)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 19:16:16 +0000
Received: from AM7PR05MB6881.eurprd05.prod.outlook.com
 (2a01:111:e400:fc12::4f) by VI1EUR05FT043.mail.protection.outlook.com
 (2a01:111:e400:fc12::351) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend
 Transport; Thu, 18 Jun 2020 19:16:15 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:3AA845F866201F88B2351F6FC87310F40D00A499DC4E809760FB67F368037259;UpperCasedChecksum:97739C7D2A0A091F2920C4764DDA50B9C3589E88854DAE3DC8620EB1668DE19A;SizeAsReceived:7396;Count:47
Received: from AM7PR05MB6881.eurprd05.prod.outlook.com
 ([fe80::2c81:794e:63ae:e722]) by AM7PR05MB6881.eurprd05.prod.outlook.com
 ([fe80::2c81:794e:63ae:e722%5]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 19:16:15 +0000
From: "Konrad Weihmann" <kweihmann@outlook.com>
To: bitbake-devel@lists.openembedded.org
CC: Konrad Weihmann <kweihmann@outlook.com>
Subject: [PATCH v3 1/2] BBFILES_DYNAMIC: add inverse mode
Date: Thu, 18 Jun 2020 21:15:52 +0200
Message-ID: <AM7PR05MB6881D835D29A7B7865623184A89B0@AM7PR05MB6881.eurprd05.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
X-ClientProxiedBy: AM6P194CA0066.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:209:84::43) To AM7PR05MB6881.eurprd05.prod.outlook.com
 (2603:10a6:20b:1a9::19)
Return-Path: kweihmann@outlook.com
X-Microsoft-Original-Message-ID: <20200618191553.32023-1-kweihmann@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ICKE-EDGE.fritz.box (79.215.3.204) by AM6P194CA0066.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22 via Frontend Transport; Thu, 18 Jun 2020 19:16:15 +0000
X-Mailer: git-send-email 2.20.1
X-Microsoft-Original-Message-ID: <20200618191553.32023-1-kweihmann@outlook.com>
X-TMN: [qUrdJwgD0tqGo3aSTLEBbbJskSscT/8q]
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 47
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 58bd7809-2683-48da-65d2-08d813bc126a
X-MS-Exchange-SLBlob-MailProps: 
	7MJMDUNTCtzjSmZ5upJ6l0701n3hlJ1PrAlp1hzUAyY1p55j+iuTXmRMvRjsyfYWJ1U+yD3UhD8aLkSi7vT+hc5LBSbdj7Ph5+nJMFsfKkHoYbQzPN5ziIVVsGqiEHonCydGuZ3Vm9GtAruPeS9Vj4QkbCw/p12+51WjV1+kqnXaM9G/7TvuQLbeNirvuKNbNzFmNzqCyLOeHyN/sfT/GK6/58zwfNvzqP190QQCwQkMw/YcKxc9fcnluBZuo4Voglg6oSKRWod4zSXYlVKWv3yxHfiFFfwCPG+y5XdPhtRnJ6d3y8ZRQBAmYN49WCp8BAJiTPGdZYBBHeM/NvJ1UW/PIXkHll8+X3D6au6Nwu7It4ahAC69OcfLE9Cz/zvppgT1Pj3wHvpFCgyBMejsz9dOHTGfUGcilHPo7nb6O7FryRW3gbrDxxk2Z71+GnxphtmDk0ac3fAsn9egIKxNQZ2Ep+9ghhMUgg4wxK1XMFG+eruqF8OzNW+Tin/AwYUTZoHSM3HtZMyUZW5INaf2fAtpyzeTVilWwKUwbWnBtVCQcQbfaDCCt6Wc4BHE+JEztInDnMpXwg3NcwfENGXBohKT0InXrD5sWREhRxFbUFN9xDAjqA9kGylBTf0v3YPdEReSzsFJCIfOsGA7xXjKDael9qJ99Ku1+kExgUJac82a/er8D8ALHMi5nCbuU9VXSUHxb7RDkYRXs7BFDS3RkCJ56HVuWqTuDjtDPfsYbOauxH8aG6xing==
X-MS-TrafficTypeDiagnostic: VI1EUR05HT239:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	FhOMKqZF0h8Bu4HoVG5ARiwx2lMZ6i4hWrRVwJz+oB0kqUpEkb/xOh0t/Huev3U5k6vK93BNY2oXti54fdc6h9rORBepnW1pdXzaKmHBSSzZaDwCQtpRdbDrb2nkFXWl+6SXI7Kq/4k9bFJcTAoK5lreCoiuvogTquCHwpyylvtp0bnl4YNpX4bCVV+EQvPEKxcnsiifGbgGowD+KXCk5g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR05MB6881.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
X-MS-Exchange-AntiSpam-MessageData: 
	6RZtdS7GDCOMyE9Vob8mSnyIwFx6XJmZuypluuJxnR3ARVQDSJmGuFqt19RTemZjczE2Ea3IfwodAgLAs5eXCP1SHgTDYsW0l9ko9iWSv0mHO93fBhjwzoEzMi2tiD38IehAEG90XaCJyhHKBuPqcw==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58bd7809-2683-48da-65d2-08d813bc126a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2020 19:16:15.9166
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1EUR05HT239
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

Add an inverse mode for BBFILES_DYNAMIC.
Entries where the layername is prefix with '!' will act in inverted mode
including given glob mask in absence of the referenced layer.
This is useful to backfill recipes from potentially missing layer.

Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
---
 lib/bb/cookerdata.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/lib/bb/cookerdata.py b/lib/bb/cookerdata.py
index 472423fd..24bf09c5 100644
--- a/lib/bb/cookerdata.py
+++ b/lib/bb/cookerdata.py
@@ -387,10 +387,13 @@ class CookerDataBuilder(object):
                     invalid.append(entry)
                     continue
                 l, f =3D parts
-                if l in collections:
+                invert =3D l[0] =3D=3D "!"
+                if invert:
+                    l =3D l[1:]
+                if (l in collections and not invert) or (l not in collecti=
ons and invert):
                     data.appendVar("BBFILES", " " + f)
             if invalid:
-                bb.fatal("BBFILES_DYNAMIC entries must be of the form <col=
lection name>:<filename pattern>, not:\n    %s" % "\n    ".join(invalid))
+                bb.fatal("BBFILES_DYNAMIC entries must be of the form {!}<=
collection name>:<filename pattern>, not:\n    %s" % "\n    ".join(invalid)=
)
=20
             layerseries =3D set((data.getVar("LAYERSERIES_CORENAMES") or "=
").split())
             collections_tmp =3D collections[:]
--=20
2.20.1

