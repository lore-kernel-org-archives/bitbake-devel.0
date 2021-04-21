Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.57])
 by mx.groups.io with SMTP id smtpd.web09.8927.1618990396558307097
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Apr 2021 00:33:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@armh.onmicrosoft.com header.s=selector2-armh-onmicrosoft-com header.b=PCVdax2k;
 spf=pass (domain: arm.com, ip: 40.107.7.57, mailfrom: diego.sueiro@arm.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vK34fEbJTRF8PeqgdZ55ZX6P5Wd4BXf4iGEO5eSycBo=;
 b=PCVdax2kbluChBTtudv+VvJUSNXyXUKVYdWA4Eu/QlDJ0nBzbDUIxxzohC7tXlIK1693zjAoVZR2xKZRTH6Kc8ZTqVnWjpcPDzI6NysEUnySiRnuzPTqIMoHLydhJeH2TUnUCtKWukxBQq5KPMOuQUSY3QOuWjVVQ0RGKbnYZgo=
Received: from DU2PR04CA0316.eurprd04.prod.outlook.com (2603:10a6:10:2b5::21)
 by HE1PR0802MB2619.eurprd08.prod.outlook.com (2603:10a6:3:d9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 07:33:13 +0000
Received: from DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:2b5:cafe::e1) by DU2PR04CA0316.outlook.office365.com
 (2603:10a6:10:2b5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Wed, 21 Apr 2021 07:33:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.openembedded.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.openembedded.org; dmarc=pass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT010.mail.protection.outlook.com (10.152.20.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Wed, 21 Apr 2021 07:33:12 +0000
Received: ("Tessian outbound 700fd1fc53d5:v90"); Wed, 21 Apr 2021 07:33:12 +0000
X-CR-MTA-TID: 64aa7808
Received: from c99f97ea1cc1.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 79BA3012-C983-4D06-8CE6-DC4556FAFA77.1;
	Wed, 21 Apr 2021 07:33:06 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id c99f97ea1cc1.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 21 Apr 2021 07:33:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtzDEYTj8fFF6ct/YfAmb9pouB9wDOlJspNuVYywfJWs3lVzZShVvQoviya5dNEQ+7fpcGMSV5vt7OyRJcbaOfvfUPVzkHnMW0krJk3/JWeQH9F+fJO5TwDioGTa+x6xgJTbRN6+iF2I3Q7cQKfBrYWr5ll+jRdfvVFeI2VnNp1K4pIkgbqayD9tcCFoOtovECQhiNxXEwRWNEPSXGcj5/HrRA8AM8ylkbS1rpdVQJ9T/PekH5sglGPS1YeeIsDJuBwcE7aA7FD7CwybYxtu/NvMQV1vA0I38QthjZ9ipR7FP6VE+kbELtdMPIdbAoa5sa9uCmf9WAf3nEJHxQtGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vK34fEbJTRF8PeqgdZ55ZX6P5Wd4BXf4iGEO5eSycBo=;
 b=S34yiW28otGoMyIIirDn1rqaBw2kE9Y7uC7vfl1ep4JJ4KV3qccnZSBCEPAsC3rdBX0V8OznSogECZxDCJdU//GEE4vKxxNm10CxBDVLI8fQXz1cZ09p4Vlbd3A+Of2qmCPza6NhdEDfJEolYQQlCHkEN0SqeUjGJR9ACurJzUtA1XeEqOTHMSgPPYiaBn86zNfoPQqjp5f72Kg+JGOMg0ubaeeFMKPiwwr4G+lHCk6VvZWnVXWms/y+8vJ4pOqqD5mK0ia470nsKGtDEGc01uVUq7pYv3ez/flP43skpDGz0JwSHeHfcI548hrGykg1BhNwBOVZ1QJJWAE4l4TSLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vK34fEbJTRF8PeqgdZ55ZX6P5Wd4BXf4iGEO5eSycBo=;
 b=PCVdax2kbluChBTtudv+VvJUSNXyXUKVYdWA4Eu/QlDJ0nBzbDUIxxzohC7tXlIK1693zjAoVZR2xKZRTH6Kc8ZTqVnWjpcPDzI6NysEUnySiRnuzPTqIMoHLydhJeH2TUnUCtKWukxBQq5KPMOuQUSY3QOuWjVVQ0RGKbnYZgo=
Received: from AM6PR08MB3461.eurprd08.prod.outlook.com (2603:10a6:20b:47::28)
 by AM6PR08MB4965.eurprd08.prod.outlook.com (2603:10a6:20b:e5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 21 Apr
 2021 07:33:03 +0000
Received: from AM6PR08MB3461.eurprd08.prod.outlook.com
 ([fe80::185d:c3b0:a5c8:de4b]) by AM6PR08MB3461.eurprd08.prod.outlook.com
 ([fe80::185d:c3b0:a5c8:de4b%4]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 07:33:03 +0000
From: "Diego Sueiro" <diego.sueiro@arm.com>
To: Paul Eggleton <bluelightning@bluelightning.org>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, nd <nd@arm.com>
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake: layerindex: Add --fetchdir parameter to layerindex-fetch
Thread-Topic: [bitbake-devel] [PATCH 2/2] bitbake: layerindex: Add --fetchdir
	parameter to layerindex-fetch
Thread-Index: AQHXNjTmQTpKasOSXkCA+v9/i1tOCqq+lGDw
Date: Wed, 21 Apr 2021 07:33:03 +0000
Message-ID: 
 <AM6PR08MB346134763278B59913D4C3EB92479@AM6PR08MB3461.eurprd08.prod.outlook.com>
References: 
 <e810a80d2aa60cbfbca64abd52101a8c856c80c5.1618588951.git.diego.sueiro@arm.com>
	<6b47f8915980672ba16ca0a7b40b46084457df56.1618588951.git.diego.sueiro@arm.com>
 <2573830.ElGaqSPkdT@linc>
In-Reply-To: <2573830.ElGaqSPkdT@linc>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 296FF7248B09AE4989D4CF6159B5079C.0
x-checkrecipientchecked: true
Authentication-Results-Original: bluelightning.org; dkim=none (message not
 signed) header.d=none;bluelightning.org; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [217.140.99.251]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: 098a00dd-5d98-4457-b22c-08d90497b82a
x-ms-traffictypediagnostic: AM6PR08MB4965:|HE1PR0802MB2619:
X-Microsoft-Antispam-PRVS: 
	<HE1PR0802MB2619112A34F2E476244CBF0492479@HE1PR0802MB2619.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:7691;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 Ymp1fCNamcRpAA7xRkolcReXxOdx7T1BomTPmNbfR7zEra+y4qm7sHROGYtpy8O9PO2aSbE+m87FZqkN8PZNG7kmT2B0VG6Rlc0FRb/AuxqvNl4zwDkVeePUlOK5w6iykzzY7pWuQBsebew8neDu8fnfZJz3kUxJH9uhfdZfvAaH4s6fHRyap+1Uo904YsUJyxjfGcRSpERPNPcQHcWOqdEZU1UMG24Lfd20JhWQzjKVZgYcGNwVhElPyKpl807DZNFnQ6dVx4sSVJWpsGpZEmfH/xUnJXoUfG+WgCMhjp8vX9rXxhvUVnw7T9Ib19eBElG0LE1ISTqV2LyJy2Dzgt82bdqxJ3GxRqZvPrmIl7MpVJpRdfBPsMC6JeZkkYjwqlmBr2BUtDGbK6kyf+8WvOl3RvsnT2ipFt9uQX/lzB4HR6jD8SfMZQrA6unCCPwypSns+a7vwh8QcqqnofK/1B9wLw4S1o+Ut59EgGxZMr3Ie1pDzTAjbgUwBcB9OHqrQu/KY+9b38PnIneXImch8Ln5gbf1IxjxtvVhqRd6hAjPM0PxbhF8Ey06KbLwG9tmpYBEh+8A5FhqkrYPPGt8bF6GjAgg+FFs/DbH0iDnwvo=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3461.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(83380400001)(38100700002)(122000001)(86362001)(52536014)(8936002)(71200400001)(66556008)(66476007)(76116006)(66946007)(66446008)(64756008)(55016002)(9686003)(7696005)(6506007)(316002)(33656002)(4326008)(4744005)(54906003)(26005)(478600001)(186003)(6916009)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?ykxg3qrdZusRGniBuUI+WkYTuR9ZM+9E4/rIp2COCkL+yvWcNdiPUBzMDNa2?=
 =?us-ascii?Q?3i2m7QZR8FOhtSJE+nV15GIfhjk3TbL8nLPwbSDKm+CvWzHQMe6dZtg25NGi?=
 =?us-ascii?Q?4nLatm1PKlaJF+KfO0yzCB3fkXQb+g4kax2znuIMd8EqqiYD0suza6Rkky8K?=
 =?us-ascii?Q?L0mhIda+DBF78hpqOz3QFqFnM8ImNyOUEXGbs5+u2OmkUAlhT+EjBhscspNo?=
 =?us-ascii?Q?+QhwPzAkWv0G6ggsRjbkiFZgSKxGSa9+Ii5E6G6bwzgeUgN3C5IynfTcKGlp?=
 =?us-ascii?Q?2hMS1TEd0Asoi4gkVQ5YrDRx4IQnLdpVg0phuCubjvQ+e/4jxImBD6kMfQFa?=
 =?us-ascii?Q?ubKZVZ5QlOzuFeQPgmCOXQtthIJoMmTYyADisqfImBIMr1qae5m8/4l7JsTG?=
 =?us-ascii?Q?ZW/501APxRJI7AuQwE1WLmE6QQ9kGqzN5tUjxzdBivHeIicl7ecbrlFoNn75?=
 =?us-ascii?Q?/KVycy6dNfLrP5IiVD8RWJeryT7nidGOfsKdTwn4L22NKWaUWEnuUS7o7QE/?=
 =?us-ascii?Q?y7JUFZHv5i5YXnQHd+OThWfUF8wJVmEqQ6IUgbd2Z20YBrFIcZzQMq/4cnyR?=
 =?us-ascii?Q?HpseOX5js5cB7JpScusHVipM4x2Y5NOtqtEJGxtG7gxfrKBRyGv40Qh3jYmf?=
 =?us-ascii?Q?7p1AGBIauiO3sdvDonRJOqCQTLL5uhIeAMfbn9yr10TkxH8lnYWSieMRs8K5?=
 =?us-ascii?Q?QDO/2e44CJ6LTuKb67OUXbWHc91zUBmWu6EKZfi0jBuy1PiXjGReAMWg25Uh?=
 =?us-ascii?Q?HTcZYVGIGR2BhiSP7jLdpwoLSwMBS57e6exE4IhZZMXqJSewwYLZbwFtzPh2?=
 =?us-ascii?Q?HMW6MDTpWU97f/jzShQx18RcUHgoeurc9NEnHLrUnfzaGRbOF+xy9/CYPtPG?=
 =?us-ascii?Q?ix0D5WkHlEJWLxSraFTd2HU0gNyqtEQdAek82vwkWyh5mkpdeMbuJpf4b0y9?=
 =?us-ascii?Q?jtVRn2cWNWwaSeJTN7McAe4P+Nehl21xncCHl8nVK5eMUhj6pX8qjVqJ620A?=
 =?us-ascii?Q?h8Co3i+Tyjlqdo0ZsgGrgcnJk+CLV2gL1joaONU1k85ytc5zxtAhkbNS6NkT?=
 =?us-ascii?Q?ePubR1Xe+yBGhgyq8SYcru9lxvcnMnCvH3rF/Hbl1U16ubhLYi2jaFMV3rRE?=
 =?us-ascii?Q?QH+WlyfT+jzVLfQ/geFVipIS7ZRWLa6E8rP0AKZGNMfS+ewBJuwRYmht74U8?=
 =?us-ascii?Q?rFYFbcn5NwZl7Prby4Ibbsb7I+FzP1at6fpG5nKbyDz18cOfLill4LPbMDx4?=
 =?us-ascii?Q?2gLT4d4IhQ7D8CIqVzsWUPaCoypzVqDHe930WAkBrWBBTldqMw882grNsSLf?=
 =?us-ascii?Q?KlM=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4965
Original-Authentication-Results: bluelightning.org; dkim=none (message not signed)
 header.d=none;bluelightning.org; dmarc=none action=none header.from=arm.com;
Return-Path: Diego.Sueiro@arm.com
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	98bc5da4-8641-4915-3931-08d90497b2f2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4uqcydeyC8tpHHfD2Inv7sdhegzunRMYGAk6mNwbSC7CqmUrJOkzzS+77TcnwAvZiaqU3Vkq8XOz8FdXsoMKBjNvMrwzMMc8/tjN01p+R5R+n3OkwxWWzPtcjxv1NS/0Az1Yik9pF7PcuA83l1NDME1++1Dvyshu1fpOPg1jUtNDg1OGmhEBOvSRd3Scf7Wc+g/BMcsFXIpLTk0Xbdtaa++P2L84fJe2An7J1MfDKbMYXwBIheiA7wYtS7E9JkxLaGbtjgbeZG9090RqqVxGF6W7M2Mxu8CcR9o6rO9mjqbCBLrAA6UVAaVquh1RBYqFdRlgmkAGng/Iev62ujc2iSoJ1+VGh2oBQPno3U9djfB5eJ1ak79sRB0EgyHd27P5+ZJRiVXrvs4PuMwRH7CAK2UcV34Ynv4u3OT5iHf7QabNEUvqTIyubRMdjokWspZRKd49rhBfbk1P8JWwpegnp9lK4gXt83wzumicgXMx2AnwnkmkBgXjy/EQP96kBG4eUeQar3qTT7iDIsoQkI/jmNjheQBufN1edRHX4UYS2OgCuqcz0BV2hhmMKefusFaPBhQt8VrRgZkRP3QENe4gxvl1te+uVGgHN+tsbeSnd2DuWLeo2XpRdGo3QMqbhmo1LZgeMANb0oe5nVmKYPIbXuqUzBHy6d3lHUw2WG0g95c=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(39860400002)(396003)(36840700001)(46966006)(26005)(356005)(6862004)(86362001)(83380400001)(36860700001)(9686003)(2906002)(478600001)(186003)(81166007)(5660300002)(4326008)(55016002)(52536014)(82310400003)(47076005)(33656002)(82740400003)(4744005)(8936002)(54906003)(70586007)(336012)(316002)(6506007)(7696005)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 07:33:12.5944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 098a00dd-5d98-4457-b22c-08d90497b82a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2619
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>-----Original Message-----
>From: Paul Eggleton <bluelightning@bluelightning.org>
>Sent: 20 April 2021 23:31
>To: Diego Sueiro <Diego.Sueiro@arm.com>
>Cc: bitbake-devel@lists.openembedded.org
>Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake: layerindex: Add --fetchd=
ir
>parameter to layerindex-fetch
>
>Hi Diego
>
>On Saturday, 17 April 2021 04:07:11 NZST Diego Sueiro wrote:
>> Introduce --fetchdir parameter to layerindex-fetch enabling users to
>> choose parser_layerindex_fetch.add_argument('-f', '--fetchdir',
>> help=3D'directory to fetch the layers')
>
>For the help text I would suggest "directory to fetch the layer(s) into (w=
ill be
>created if it does not exist)", but otherwise looks good.
>

Sure, I'll update the patch.

Cheers,
Diego Sueiro

>Cheers
>Paul
>
>
>

