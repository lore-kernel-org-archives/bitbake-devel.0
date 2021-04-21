Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.40])
 by mx.groups.io with SMTP id smtpd.web11.8864.1618990439403131675
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 21 Apr 2021 00:33:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@armh.onmicrosoft.com header.s=selector2-armh-onmicrosoft-com header.b=ICzIiGIN;
 spf=pass (domain: arm.com, ip: 40.107.6.40, mailfrom: diego.sueiro@arm.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ0yWc+FC3JlwO5AqXSlUKYaWPHGDtGb1oMDwfXSUzA=;
 b=ICzIiGIN1agaKpV0SrZg6Ok2lQG63SOB0FOa0ecXC6ddfx2bN4ChvNl3e/HUSJjWfWM0RVUn8KfUIHxK8FFP5GRA0Kp9FrYEMx+ab8wJtHmIel4eNCkq/SxUTM4IQyHArhjpA/J8PnQsXIIUNGFpmH9wlZis/nsc+KAOr5rB1D0=
Received: from AM7PR02CA0007.eurprd02.prod.outlook.com (2603:10a6:20b:100::17)
 by AS8PR08MB6758.eurprd08.prod.outlook.com (2603:10a6:20b:39a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 21 Apr
 2021 07:33:54 +0000
Received: from AM5EUR03FT041.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:100:cafe::dc) by AM7PR02CA0007.outlook.office365.com
 (2603:10a6:20b:100::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Wed, 21 Apr 2021 07:33:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; lists.openembedded.org; dkim=pass (signature was
 verified) header.d=armh.onmicrosoft.com;lists.openembedded.org; dmarc=pass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT041.mail.protection.outlook.com (10.152.17.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Wed, 21 Apr 2021 07:33:53 +0000
Received: ("Tessian outbound 4ee49f77c636:v90"); Wed, 21 Apr 2021 07:33:53 +0000
X-CR-MTA-TID: 64aa7808
Received: from ab4c0c8ef8f4.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2BC7576A-2209-4B1C-9EB5-7912967F10A2.1;
	Wed, 21 Apr 2021 07:33:46 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ab4c0c8ef8f4.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 21 Apr 2021 07:33:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPHDcvUEewoybnNznH3fMXjh1noj4UmT+jpsYvOD7aXBDTMvKrEOZoWIM55IuyOV+hOjqYgGyPp4VHkLkNmw8AK1RkwfAv5NYDGSfp7Xy9YEu6uZeGpnwDFNquek92XI0WJduI7VyH53xY2gccXRzuZCcvtZVDFn/KN0bySEzrPiweCanfz4QzoByKiz0omZdk4zdJvRWNQ8/p4Dt46whmgL0cmTV8vxW9dKYvrXFLcEZaQ/yDCmd+v3FmTuRWpnQbBiberIwGthXeU108agXV/XHkZEKTNMcXAI16P45g8CYijnubaSjdyzZKxiODCe0u9G/uW7uwpXsw7csVHclg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ0yWc+FC3JlwO5AqXSlUKYaWPHGDtGb1oMDwfXSUzA=;
 b=k73/7ZfGvvSuqezcAE+AeA5aYrI0gjHasWCLUGE996FiNc/X5gK/yBFSlt9XV0wjm65bkdgCl1dfuspUS87BRtlk8QyUt0ozeQgVVecZ420ClFF+urE6XMyWYfqUyYrqhU5kOH3vo18xC8RlA4vvCJje+DGrrjrOuEoZk+tFMWauz7ypE9EUqJvR1gagOEihzyhhFAD3eWpuJSYaT9yzfCDVsAtDjch1FXQPuRtuAdHWmwDTSNkevybemzCscrKQ08+gcf8natKZQG/d3x+9Hk2LDUgz1vcqrCpVBhk/zUW5XcAF54xd0rRAUM20kM1vr21kuA/Yh6l/J6jPVM0MAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZ0yWc+FC3JlwO5AqXSlUKYaWPHGDtGb1oMDwfXSUzA=;
 b=ICzIiGIN1agaKpV0SrZg6Ok2lQG63SOB0FOa0ecXC6ddfx2bN4ChvNl3e/HUSJjWfWM0RVUn8KfUIHxK8FFP5GRA0Kp9FrYEMx+ab8wJtHmIel4eNCkq/SxUTM4IQyHArhjpA/J8PnQsXIIUNGFpmH9wlZis/nsc+KAOr5rB1D0=
Received: from AM6PR08MB3461.eurprd08.prod.outlook.com (2603:10a6:20b:47::28)
 by AM6PR08MB4965.eurprd08.prod.outlook.com (2603:10a6:20b:e5::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 21 Apr
 2021 07:33:44 +0000
Received: from AM6PR08MB3461.eurprd08.prod.outlook.com
 ([fe80::185d:c3b0:a5c8:de4b]) by AM6PR08MB3461.eurprd08.prod.outlook.com
 ([fe80::185d:c3b0:a5c8:de4b%4]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 07:33:44 +0000
From: "Diego Sueiro" <diego.sueiro@arm.com>
To: "bluelightning@bluelightning.org" <bluelightning@bluelightning.org>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, nd <nd@arm.com>
Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake: layerindex: Fix bitbake-layers layerindex-show-depends command
Thread-Topic: [bitbake-devel] [PATCH 1/2] bitbake: layerindex: Fix
 bitbake-layers layerindex-show-depends command
Thread-Index: AQHXMtqb2UJ3k8OXDEKRG+oyjV5fTaq+BB+AgACXUIA=
Date: Wed, 21 Apr 2021 07:33:44 +0000
Message-ID: 
 <AM6PR08MB34611718184875EE9A5A920692479@AM6PR08MB3461.eurprd08.prod.outlook.com>
References: 
 <e810a80d2aa60cbfbca64abd52101a8c856c80c5.1618588951.git.diego.sueiro@arm.com>
 <2160210.tdWV9SEqCh@linc>
In-Reply-To: <2160210.tdWV9SEqCh@linc>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: 062552A293E7A846824992F307253A91.0
x-checkrecipientchecked: true
Authentication-Results-Original: bluelightning.org; dkim=none (message not
 signed) header.d=none;bluelightning.org; dmarc=none action=none
 header.from=arm.com;
x-originating-ip: [217.140.99.251]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-Correlation-Id: ee708c50-a5ec-45ef-c78c-08d90497d0bb
x-ms-traffictypediagnostic: AM6PR08MB4965:|AS8PR08MB6758:
X-Microsoft-Antispam-PRVS: 
	<AS8PR08MB6758319BC1850C2DB35AD23892479@AS8PR08MB6758.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:8273;OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 N5rkh254r6FBoR6lALZiV8qDqHugildJtZRpPDPRnYrH8Cjpyod3+uHmiJ0yCjul6UV9jDSB0bcrEG9nqnvNKtjur9oKfppHMJhv/T+Wh7AeY8mebR3DWnLSY0H8yBOUe7EjQUobPU/hE5CdiAsKLvDWEKlY1g2ZYY050lGj3DXpwXhpk5f6w62M+OP4PoLwED6GOXlluRgyfFAK5TdhLdQq4uhskDjCABG7wZ8uPXsFXBvF0vqg+lbPEcn4y/Xr1qIq09HtYrmvKUH/wuLvJtGrAxt2zIWFDGgxNT0BnsXUJFXGVh9OY9n/swYS56Swgr8woX6Fw2zQt+ZBiCSxQDf9qqSoKcQ6sQq05FJBHCMUsCbkKvpBYgkY//SUJdvfGEW2u9xl8MI+SF/B6mrKG2eqlxy6Nl8zMICf7e4FBBd0xRnnf5BXiRunKtUi5gFunHppRClyzrOtB8B/E7+Ig6gv5PNSo1A4E1nhw/Fkyo1QLPtXUvEbmOzrN3XDX8gQt2Ou+JQPJJ5e1g9ODFMx+9oi2hUEpG8EZJzzFoaGqpM6QJXSE8JVT+0Y3hsslwxsqpLd/fGCU1+78sfful5keZIYbrNuYgQMks6ZhIsTYyc=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3461.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(366004)(346002)(136003)(39860400002)(83380400001)(38100700002)(122000001)(86362001)(52536014)(8936002)(71200400001)(66556008)(66476007)(76116006)(66946007)(66446008)(64756008)(55016002)(9686003)(7696005)(6506007)(316002)(33656002)(8676002)(4326008)(54906003)(26005)(478600001)(186003)(6916009)(5660300002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 
 =?us-ascii?Q?+v4VPc1ksAkl5oPbX4yIMOiJecwVTxVDYrGJ4t/CrUh8nE/I/A5HHYUXgDSD?=
 =?us-ascii?Q?BA3z+Y60i9Pb34eVK/tLOfjsiUl8nIlr5z23Nhb2E3M0JyUsxle+yIwTg3EE?=
 =?us-ascii?Q?blkhxSLHAolaXhTpD/JwKUTrQaXPe8692OVOaJYd8huOjTgV3mHdBmsxs4rt?=
 =?us-ascii?Q?bTQiZNhBn1+Ww3AGZKqnrE21UdNgvcRbZaJP7VKmlw78vA0DQv8MWpFdYPGW?=
 =?us-ascii?Q?IMvsPvCzI8JLvvfVXBdplRvddubD1OGWcarykC39DlvHSftlwOzQbZ+s/nTw?=
 =?us-ascii?Q?lWrYsQBek8M+xNpgtMchkR0jcMUIxMaFQFEGLOPl84vjoMSoJJ5TIxSCZC9q?=
 =?us-ascii?Q?3OQcwa4zt/bd+EbjA1zoeRUamvkBA4F7qohOZffmQy10L0FPTBgNxPLkikN6?=
 =?us-ascii?Q?DL1H880jDihjwIk9ELeQc/XQ3oONQiFScuu0CiK6p73VTIpKQMtJBJpkjIvi?=
 =?us-ascii?Q?i/bwGz+Y4HOP6W/g+hrjVfc6qdDMM1L+ifP/G4/F/HvK+tIuPWSHvRMUz5gR?=
 =?us-ascii?Q?NcuEEqliGsluejQA1ixYm3thJwKrBtscLXMbTVzRaI7HedDHE+36DnC6f8XN?=
 =?us-ascii?Q?1m6V6Wpm75DdsBg0Pc4eod9+IU5VN2sLYC5fnK1xLJxec5tJHcxDljZa0zOG?=
 =?us-ascii?Q?gDxZhr+Ceb0+75qUUotzvWtBWEl6QlNIeU5QiBkBnzsp2XW6gZQS2fWldSDd?=
 =?us-ascii?Q?sDQZwjlebuy6/Bs4wTCAwRgZ4RH6wQayHqlVGLXavY1+kldzEawogGC2nVUz?=
 =?us-ascii?Q?Vc2FfQX1oJwiT6pGnocsOn4UOwm5vv/xHAizW7DRlWR/hlORVdnwvc/JixxY?=
 =?us-ascii?Q?WvLlVvfGbiPsIPdArGgOXrLe1S3r8g9mqFiZrr37BQS00NJ0X8UBu9p+EtoB?=
 =?us-ascii?Q?vo+sk4gSo9Aac0GKGZvK5G0wF0t9yq+mTVtMxE7/btKHI5cQTfPGQtkDjFdP?=
 =?us-ascii?Q?WQhwn6kPCnrM/rBTkl06Jk7kwugJ1FUbEWTs7CG/T9BHRBJHrZcml35xGWBU?=
 =?us-ascii?Q?Ed0Of5E7JH5nJ1RSotK4sRTCfkhIvgTmTupeV+8oaF8NUdw2uXe8HM7C3cT+?=
 =?us-ascii?Q?QJCHgctqrGvFbzSVTbSxWbNqLkjQX0tDCm+yq5aPzKTqCeEhDFongTkhad12?=
 =?us-ascii?Q?ik6IhvKJrdOdwOvE47fN6QSoXu5fPfgZ2j9Lxe1wKbr906lgMPLlpk8a/P0F?=
 =?us-ascii?Q?AzGUwgEVXGh3tfuHetGcsYyitcit3XR9rG2CEdsRvqLVnKZnQ9mJeUIe/xEe?=
 =?us-ascii?Q?agzGO++9L2A+V1FJYo5iICYCbtQ2+2znh/o4PnixHh2WHgFpahgbMsZnkJ6+?=
 =?us-ascii?Q?OQfuKYsRQQ0O3IY+b6uNPkKX?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4965
Original-Authentication-Results: bluelightning.org; dkim=none (message not signed)
 header.d=none;bluelightning.org; dmarc=none action=none header.from=arm.com;
Return-Path: Diego.Sueiro@arm.com
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 AM5EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	a3035178-22eb-4e01-8da3-08d90497cb2a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TR5dsbK/OqBat2YFWtG/Ym5kDNi+1Bf6xCUHqxrkCa9yGWVZaJar6DJD+5u1vNN0bX0x0jc27tamgc1Yi84qMTmVnvnfBaEyQL1WwbBDgf+3PPgzg1dPeFZgQhNYhHTNZdnDUadsp4W6j0Ykr0idRI99f58Z32h5J43w9LUpCMcgE7WB8d7J2evkBiEhi1nIX4y1URZHECI0vstUaoEuDzkAKqU/QH2GCS+mLZ8mhknojKLKq/3iQVgcb2kwZNQX8BSNZTzZdQ5CNzwT4Sc9eTs8eYFL8GsUHwD5zlsqFYSP5JYGOFGOPCFagMdjvHkYiYciUo7wh3RSbdaIuHH+e6D+ogrSQBl3qzMpiwW2ypi/C/Ov2rzFBqNO5LXsZoF78tGFYgetYB+t9gAO3szvj0nv20uXFL15zJQtmerFmqw/qlK3pmFJxqLWgAj113G6mHz6o4c+FhEYOyF4Ib64OXSjpMo5MZLdrg/6YDJoYIVkp2Y8qwQQXqzpweZrYmW9OtgMKM4uBH/Esu+JhmI6z1Z6xbqT6ZD27/m97KD/0KSoLIGCoQe2wQxZezFcIr1flCu4sBhCdlCTAlgIYroDeCv+BD0ZsAGc/VHt1kUCSNSbNTw3is4w9KlbT89bgSFR25i6nXYtp9IWhaFbP66hGLA8/RYChSJzl372NktFfGM=
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39860400002)(46966006)(36840700001)(26005)(2906002)(316002)(356005)(186003)(55016002)(82740400003)(54906003)(478600001)(8936002)(82310400003)(7696005)(5660300002)(6506007)(70206006)(6862004)(4326008)(9686003)(70586007)(52536014)(8676002)(33656002)(36860700001)(81166007)(86362001)(83380400001)(336012)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 07:33:53.7576
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee708c50-a5ec-45ef-c78c-08d90497d0bb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	AM5EUR03FT041.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6758
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>-----Original Message-----
>From: bitbake-devel@lists.openembedded.org <bitbake-
>devel@lists.openembedded.org> On Behalf Of Paul Eggleton via
>lists.openembedded.org
>Sent: 20 April 2021 23:32
>To: Diego Sueiro <Diego.Sueiro@arm.com>
>Cc: bitbake-devel@lists.openembedded.org
>Subject: Re: [bitbake-devel] [PATCH 1/2] bitbake: layerindex: Fix bitbake-
>layers layerindex-show-depends command
>
>Hi Diego
>
>On Saturday, 17 April 2021 04:07:10 NZST Diego Sueiro wrote:
>> Running 'bitbake-layers layerindex-show-depends meta-filesystems'
>> fails
>> with: ```
>> Traceback (most recent call last):
>>   File "<...>/poky/bitbake/bin/bitbake-layers", line 93, in <module>
>>     ret =3D main()
>>   File "<...>/poky/bitbake/bin/bitbake-layers", line 86, in main
>>     return args.func(args)
>>   File "<...>/poky/bitbake/lib/bblayers/layerindex.py", line 209, in
>> do_layerindex_show_depends self.do_layerindex_fetch(args)
>>   File "<...>/poky/bitbake/lib/bblayers/layerindex.py", line 182, in
>> do_layerindex_fetch args.shallow)
>> AttributeError: 'Namespace' object has no attribute 'shallow'
>> ```
>>
>> Initialize the shallow attribute to fix it.
>>
>> Signed-off-by: Diego Sueiro <diego.sueiro@arm.com>
>> ---
>>  bitbake/lib/bblayers/layerindex.py | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/bitbake/lib/bblayers/layerindex.py
>> b/bitbake/lib/bblayers/layerindex.py index b2f27b21ee..17dfc9874d
>> 100644
>> --- a/bitbake/lib/bblayers/layerindex.py
>> +++ b/bitbake/lib/bblayers/layerindex.py
>> @@ -206,6 +206,7 @@ class LayerIndexPlugin(ActionPlugin):
>>  """
>>          args.show_only =3D True
>>          args.ignore =3D []
>> +        args.shallow =3D True
>
>Hmm, yes. We could probably use a test that ensures this doesn't regress
>again. Is that something you would be able to look at?
>

Sure, I'll prepare a patch.

Cheers,
Diego Sueiro

>Thanks
>Paul
>
>

