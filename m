Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C80C61DB9
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 19:34:24 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com (PH0PR06CU001.outbound.protection.outlook.com [40.107.208.35])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2651.1787859263137971501
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 27 Aug 2026 12:34:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=T+mxkN8K;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.208.35, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqwmDy7bTwBzGST3bxqw5JjtwsoQ5fzhhKJVM+YH4YVLHS7ttwYvgeKv9M53xE1Il+flX9nZ69ZOT7nLmlM/DK71yZP6/HvYeFBdbEsnPjb3JSaK6HboaWUKJhnXv4BRYOW0UEfDjbWuAncGPBNwiK8C7D+l4RNrqrYGc3z0S6F5Mvt191fCPLehMoU//t4CbXdxs+RLojxkwsq7gboec1hmsAcc3NzFfO0OgmYqOucsxuSeWKG1mpDDHJUnB+Xa/Qozul2fTTjiS3nmX96VQw/dDAz/8n2t7km2H8HUO3QXQ4h1b9MiSuN6YBkxf0ZXkGtl00JRsqUeTG+K0VpoEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=062Pk7xg5H2/BbmjfKRv+qvd32qvTIAWinJu8cGG+0Q=;
 b=QPRVF0y+TPgptmlei9j6sjbQ6qzTOHeNZqdMfAmc/FfiP2rkxPnREAMF+WPILUjn+OarPk5Evc7NlY0TOeYJ2gViLfzG7CJjxSlFnFmcIFtqByH+qOy5vm/1AzcWkhsmvV60vS8FGBKh0zFEHkfKZVypUBak3cUOkh7Mg5PdkvdVC7TsYy9uyP5OG9MQzbqVfS/wYuoOtKCeSgYyxRjTvc6vzpmhAt6FoHwOh5bgjSOMCnUtMp4PiPBRxKkWhBwCqq3w1dnz8QMnhCTDbVZtbaxdtKaXKbVwVPD/Y1VE3Ey5f+KAfI3n5SDSdc/UAgD43ckMbc3PCAIj0cBM3wIhXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=062Pk7xg5H2/BbmjfKRv+qvd32qvTIAWinJu8cGG+0Q=;
 b=T+mxkN8KSatgP8rSYVkn2x+s9hwC/20PJFZ3+1+sVAmxx8ug5Uvf+T2w9EcAB+rqIi9q47wnJf6NDa1szz+SpY2EwxZfSLdH0sL4c5Z8BZHHCdCNtJLHrNNqGFUI+Tpdn+P9E8Mb0uuWQQkaL1vwc65UuqXL0nOcSbNDRaMoLQc7Go4/i1BZIdWGx2EfCmpEjLrES1wd+j2sByIbLDvgnA097veY8ewnGL9hJTxYNy3jtnsc0rgVYw9arxMDK35o7lUT9aQwO6iV6e9lWpBDc9rc1lv9cS7FOIW9U85H1hlj/kzHNdtTJJfGPw7UHS5xhVBWmHXd3odQPdzy59wjyQ==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 MN0PR12MB5979.namprd12.prod.outlook.com (2603:10b6:208:37e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Thu, 27 Aug
 2026 19:34:16 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::152b:7346:321d:4a2%6]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 19:34:16 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: RE: [bitbake-devel] [PATCH] runqueue: fix bad check in
 process_possible_migrations
Thread-Topic: [bitbake-devel] [PATCH] runqueue: fix bad check in
 process_possible_migrations
Thread-Index: AQHdM+B8SR9mJdw0WkSij6NUZ7iQ1LayTfPw
Date: Thu, 27 Aug 2026 19:34:16 +0000
Message-ID: 
 <DM8PR12MB54301C10EA72237DC33132FB8BAD2@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <18CEC8A22D50C1A6.557595@lists.openembedded.org>
In-Reply-To: <18CEC8A22D50C1A6.557595@lists.openembedded.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=ec96bcfa-1ab7-4436-bd79-9bba310f1c67;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2026-08-27T19:32:52Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|MN0PR12MB5979:EE_
x-ms-office365-filtering-correlation-id: acc30905-efb0-4334-c1d8-08df04722ea4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 
 O/HORF/s2ru5uRX3O49OuR29jhBa1j1zDPlHOqfOs40F6WfDkLTog+UM0v1Yh38ik/dgkfqHvffuaJZwbciApAjJa6GbKsH6qhmlFbXjiO9G4wUCnIbuIoulthfhyOpJU46Z0Hrrw1SWwa7kL5vTPJe2MWw0kNlwmk5hx9mmruIAHCSM9V7cmP7zwFKvtOCvnz1KB+GskOHgxbxz+yHuqJDJV33FEzEFFMeiP3zEfsKWvppaKGQqqR9YbTF5g+70A66Lt6lqpJBNTX+8KrNR10zb65JpL8gaCAs3vze1RIOxZMuQPb7jKSgLkoZtX+Ob5e6t7VdBPSU0qTCCK3f+QtmnWMf/osezTQ7nvEwQ2gIu1CtaKMwBNDvvS8XQ1AHu1BIwqt8+yn6IFTzkmX/53Skjw02FOPaxxKaPMF7t/kfKxxmUV8+xCwY8Qd4CFSgvXZkOxwfO3/GTxrg1HIw0qrmQuv1w79c8v5aBHyjbilAIrwdR3eV47Zt5Yjoqw03mT7BBsHSnL2bZaDlQw32ukv+VAZUl3psYPkyO0/fbdoB92dkxuQRXRzW/I+TJ6QAhcmweQtL7olxlhmWV0LSdCEvyIsoAr3dkugPg9Vy6RaDkP6QiVFcH5YKDV5y7ynA+2aJ0do/LKnvMnG1qsUQdGC/NH9MZE5xWvN0o3Bj73HhNJOICHA2a4Hh9QyTPTsmNzc5cpuPUFgmEBPJIbYTQuXSsyumiMV6sRvZXTQSBmbc=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?pLYbQ25bRsjBXURRnibuhlEoqCTj4Hkclepdq5aPU3klyRcGj/f/+r7aL1wV?=
 =?us-ascii?Q?JLj3TAWnX9A3dID0KHUPhMJ5ydZMJz6CSsxtLNr6E1V3TkqxilaeBKMhDxFT?=
 =?us-ascii?Q?0Z7PS3QhJiU5Ksy5zBCpdizN9FEe4W6fRbuy/Z6kV2ZsI/LBQJBj9aPA3C8F?=
 =?us-ascii?Q?3SUzudiYyqVzRbGBagFPJB+ZolY0hexjgcg9kIzZUihTctXSkiNafs+GyWVZ?=
 =?us-ascii?Q?iXr0dMX74RGcTPGcMYTUBKvkQPo8kLUZg2jiOhzwW5HD38uyRzGPPnHIzldF?=
 =?us-ascii?Q?p/oV+81neptUPLf6NmPDkvOI248pRwK/I3DDrAmyx2rgMtDkfHxPnkd6ST4o?=
 =?us-ascii?Q?dwLs6yeUf2a0BF5AA/oaEEoQhZdQoLcJ525xha1jFhmT+8SFLpvMLsMMNyq1?=
 =?us-ascii?Q?2k3rcwtviBGu+H8ptVm5QPkn/OEOfgKdBytqBfP5Q1iYTPzBn5AGTl2ZrPL3?=
 =?us-ascii?Q?7+jaDyHeziR6325fL0HawVKZ0lS4F9utXoFBHHaPQJTtJtkixyqw81wqRFcK?=
 =?us-ascii?Q?GmDvxaXZEyu+uC1TLuVz69xhudCkwbfC442+6QlSX9OOfOToi4I3DHlG4UXK?=
 =?us-ascii?Q?elONNm9OkuAniqCDVxhVsbfEX7iweL6xqAx6YXi3YW22rhveoJYxKOszjw8h?=
 =?us-ascii?Q?VC9UQg03TcWxRmuBZhjmWqssPlo3Zw2xRUi0L7r3ltTt7dfnxD7C+u+rq3PU?=
 =?us-ascii?Q?WGIdBN8xINR6Hw9l/eaA9COOuq75gxcjEQkh5nPAKmyyuZf0n8FTjBAkfMHU?=
 =?us-ascii?Q?9edLEYpdQ0JAgF6I1mux2VYdufMxwEtn3QQ3gKBpEe+fwYHidEMOH6e4KNrS?=
 =?us-ascii?Q?XP4HRUQfLJX8TFiJVau402nFiGrzYyIwEX3XMdsKnpGfyiGUAHGfL1A3uMoA?=
 =?us-ascii?Q?2L8gklDHrv7CrG7mQxSXpRWfvvoZ3mKMOupVZDXB5wOtvcOlCT9ZLxxmyvHO?=
 =?us-ascii?Q?OJatd6Pj6Qrbwns/9cAaEvuJkgtoVVw7Mt/eZvookfa5AUceOEZ6EKZHsgr4?=
 =?us-ascii?Q?kzXCbHrqmyo97RYIxNTFMMqDLVrURBUO2Pj1bz0LJZiTnS5EruTEMms/cTrH?=
 =?us-ascii?Q?RIoIxf/BcsGVKwse59RP9m3AKYMVwAU0iC/nsMmoqJjRy4nA2o9vntDEJBVi?=
 =?us-ascii?Q?opezcKTZZWVpfQgoi/jPWO1L/E/nPOErnSK5mlnpWw6Bcn3lPVuu0gEXvmeB?=
 =?us-ascii?Q?zHxrxA/4RvxkBpkvXhka0IIe847qFxhfqPk4WDyQHN+pe1ytuwhJ6wbBAE6c?=
 =?us-ascii?Q?DDifzzXC2uqGWRsXdFmY8KnIqpf/Sf4hpH/ldiOLyiGv6UhMJL8C9V9HqZNy?=
 =?us-ascii?Q?m/b4TjpA384zFST4DSYhSOZVuo7mZIkogx2aVVSV3PEf2dEcBtGKuVMRSyOw?=
 =?us-ascii?Q?QO7hkdrtPyy2Ey3RHsje+Qmah6baRNE5lR6uiXR0UWi4kQ2whVVOvR6Pw5hv?=
 =?us-ascii?Q?Gjtcwl4uTSxdxz8ub3Adl254cIHJphND7TmeGGeZ4K5QE/tOr3TT536a3veg?=
 =?us-ascii?Q?mp2DrAAKMUc7fu1YGt9xpGRJjrGXqXhSLl+e48vUFqbi6qL/0kTbjmrYEDgk?=
 =?us-ascii?Q?5wlvCo0rLPlNbGRaky2gpsBYGF+2fBLF3PgBFDW7cgDAh3M7g7vzAUY7ZYKg?=
 =?us-ascii?Q?Pey8GwhagRXflID5sphRiNgw/yfFuUI9Agh9kzYPBC4jcUi0+JDb0FOke/ei?=
 =?us-ascii?Q?Q7sQDaiDUAobvgAw8zsDLmEcSVwQRNJsSuiWgA91K+9hfoh3JndoptXmLNDY?=
 =?us-ascii?Q?LHigvGfIRg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acc30905-efb0-4334-c1d8-08df04722ea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2026 19:34:16.4808
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oaNqeFF9kR1feuP6jc+RDZeE37vQsSTC/STQBOYF096nBj/ZnNCvrNcDmKVt2f2qBxln/QUi7r9eM/ptzZOqSk2kaiTULTFW+Xuwpwz+pKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5979
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 27 Aug 2026 19:34:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20074

> From: Chris Laplante <chris.laplante@agilent.com>
>=20
> This was probably a copy-paste error from above. Detected by PyCharm's co=
de
> analysis (Local variable p might be referenced before assignment).
>=20
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> ---
>  lib/bb/runqueue.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/bb/runqueue.py b/lib/bb/runqueue.py index
> a4689e134..ca0fd2945 100644
> --- a/lib/bb/runqueue.py
> +++ b/lib/bb/runqueue.py
> @@ -2610,7 +2610,7 @@ class RunQueueExecute:
>              next =3D set()
>              ready =3D {}
>              for tid in current:
> -                if self.rqdata.runtaskentries[p].depends and not
> self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
> +                if self.rqdata.runtaskentries[tid].depends and not
> self.rqdata.runtaskentries[tid].depends.isdisjoint(total):
>                      continue
>                  # get_taskhash for a given tid *must* be called before g=
et_unihash*
> below
>                  ready[tid] =3D bb.parse.siggen.get_taskhash(tid,
> self.rqdata.runtaskentries[tid].depends, self.rqdata.dataCaches)
> --
> 2.43.0


Gentle ping - I think this patch got lost.=20

Thanks,
Chris

