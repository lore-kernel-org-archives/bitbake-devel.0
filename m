Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166AAC433EF
	for <webhook@archiver.kernel.org>; Thu, 14 Apr 2022 16:03:57 +0000 (UTC)
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (EUR03-DB5-obe.outbound.protection.outlook.com [40.107.4.69])
 by mx.groups.io with SMTP id smtpd.web11.10965.1649939353580581147
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Apr 2022 05:29:16 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=ESnJdL2L;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.4.69,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAFZG+e/6INrv2dVH3tJiazvq0rYWgzNwFwn0uyWwCJqgHdvB0YjuuSChkN3mnbs2f1K3jclDFYQvGy1NXWbyKFb5fyA9qLNEu1rVVTG6jVlYEoSIYJd8g/WYmlUu0QuDIqChXtBy6+3AhEvT93B57jiicPx1qE3rH8tgeAcp7JykIruQbZAk6xBkAu314KKm+cCIgAaaYUlKMUNC0JR1sJWTsJxY78X7YVYonCBbaf3i+a+f/oj4KwvmZX8fx+zkyNV6CzzEMzHpKvzBnbvOesDMvBSfddUfsl7wJXvFdAudF9pE5ZeVuXIH4I6x/kwkX6VvmH8+LI70JLQ4LE0EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RiGC+8cMXfBI7sHK3EHKVQZGNNR0uj8fp+5L6KC+Fsg=;
 b=OOOL6tYbvkeDjVycdQGc1N4L7fyMqCp2EwbbM7pV4U9YKjiP5qM9JeYmtkDAvOKHCDxRyjywbHGn05QLeRhsewwNy2FhNbLVru1akRr58f5IUR6qL8+fLATXvZd/BrdnoztKV8BCYX8NLRLUKei52OfAc8rvp06CCiYH98IBG3YC83pyv4RpkFZa3YbSw+Qmo7c/aL19/U2deYybrNHNVHetG2vZVxs5C9RW/J/pKuoiRm5CxzJBdE5BpQSJ0JBRJywI2iYzRarE7kJR8cOPPEbzRofOE1VJ+I1/cVCu9PvitROOXQqj8lrOou6KkJh2Tg4g1mvJKZDHNsw/O/vfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RiGC+8cMXfBI7sHK3EHKVQZGNNR0uj8fp+5L6KC+Fsg=;
 b=ESnJdL2L/+54dGeiOzxArLLthe8ha5fbakQ99X/9u0zeXafy2vsqjVw7+jwIdDHto6XSroxSd88Vx9+XjxCq7MRyM3dgaZht8f9JMC1Hk3WOtbyvBGIzgzJNCVPCZJgg/gvq7iUAtReYR1mvnBq+HoBMIP54/zBWwRPU1NWnTOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AS8PR04MB7528.eurprd04.prod.outlook.com (2603:10a6:20b:297::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Thu, 14 Apr
 2022 12:29:10 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::bd4b:4dac:7747:3093]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::bd4b:4dac:7747:3093%8]) with mapi id 15.20.5144.027; Thu, 14 Apr 2022
 12:29:10 +0000
Message-ID: <003e31eb-6963-3b8d-1547-b2c15b6d5082@theobroma-systems.com>
Date: Thu, 14 Apr 2022 14:29:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [bitbake-devel] [PATCH] scriptutils: fix style to be more PEP8
 compliant
Content-Language: en-US
To: Marius Kriegerowski <marius.kriegerowski@gmail.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: bitbake-devel@lists.openembedded.org
References: <20220413141922.41322-1-marius.kriegerowski@gmail.com>
 <YlfllwA72TEcOCPX@mail.local>
 <49046AA1-E85B-4373-9208-0016EC418B5F@gmail.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <49046AA1-E85B-4373-9208-0016EC418B5F@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM6PR0502CA0043.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::20) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f6144fa7-c69f-463f-220c-08da1e126097
X-MS-TrafficTypeDiagnostic: AS8PR04MB7528:EE_
X-Microsoft-Antispam-PRVS: 
	<AS8PR04MB7528918560434782A969536EC2EF9@AS8PR04MB7528.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nU1Sb6k8MgRcu0sq77TYjTi3tWwOnGFbqdpSeA5mI48wlhhG+nNVzEHSyRiX+EogTRk1zJP/2CeyF1y0OcuhyQERUnuNP3qSjdH8nA5xrinUbN9sfylLW6VwSZKbZ5pImyCfujaANyNfs/OAeJbVI7KwvBrvszLRMUzaAIhmWbfFc3+x0atK4yAm2ls4qt+FP1g6xcklLSTGeE8mWP4NyJBGAS3/mvXknh4hb1PJ3+b7GIHeLUZDBwMzNAnev2IBHr4DrBtF0kmuP3Komp8WosxT++Qjg4CN7ApE0rN5FXfMyNrZoflzi91gMGwxoLJcCw817ZxPer3/wU144ry84ph25TyuWSisumjd4ATFDcsOA4ENaysdasanvrdTXkjq6SBf5Qd6JXtn53auz+o664hwKOw621eZGD/4gx32u4LyF9ZDBGtTXjdmDdKr/cDrTq/JlVUqumVed7aml3Fzy8ldkWxDv/zU0iv0Vd28BPpeUxLA1Hyow5UbN6s7sU5Gv/t6qbTfB7slzbtVnA+KYOC7o+f1toe1kvdt79BZkJYPL+PzHBITQkg7cbHsZSXhC4S5n0xNVwx7Nt8j7Swf3nTFt66gLRo0wPHV1rDS/XNfXf5RTkiAXku76dCdFysmQqi9ElOhoG65h4oB0A1gwC6amG9pqHFa6B602hUqDpk48AZtkrGwYEgaEabuuwu8dXll7cjGvKKhjnC3OxhFrpRPn9pKBrL2jOdfX3dqej4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(6506007)(5660300002)(2616005)(316002)(508600001)(66556008)(66476007)(2906002)(110136005)(66946007)(8676002)(8936002)(4326008)(38100700002)(6512007)(26005)(53546011)(44832011)(186003)(4744005)(31696002)(36756003)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BtM1uQzGCamSZDSH6xFUV43k6Mg7/15cHMnmMSepUHILbiPn8619yfNbUSM9?=
 =?us-ascii?Q?9j9ei4zP2DadudzfVdoZe5omTuTflTtqjRqtPPS24QE1JnIbA2+Y1QXY6eTE?=
 =?us-ascii?Q?5tf3BU0m81qguVrfdEwphuNkYBWkIPC3L3Vt2fWzxll568Dby++2v4DLA+cq?=
 =?us-ascii?Q?0x+He9chiv128/f+had4JPtUTuQ0gmzrlZrJicka1k3oA3pOiEcv+/FiG8rg?=
 =?us-ascii?Q?QX0aaKAptsfG3KgdMOWZtPEKPi98INfZyY1IGh4iG8uVlneXgfkjhCBCITAN?=
 =?us-ascii?Q?JTfFlIwGGU1Zw0vU3Nxwt+KNNL2zC0nQcIJe5luOLv5BqGSJUnT0kuOPhGMv?=
 =?us-ascii?Q?0LnwFA4sDSWb88w6WKnlfntQbx6JUJivpOWU3YU6YAFokh0VlzSIyMgDEKTj?=
 =?us-ascii?Q?p6k73FPiYnFPGQ7TGF/1MLMSJTtpdMYRSywcn3kIGmZfXetTMmG2Ra05eGiy?=
 =?us-ascii?Q?NhHVx43m1ekTjY76JToFKQ/oAT/Idajkc6NuD6RYD9lLau4yfkpee0KTrzJP?=
 =?us-ascii?Q?402kLIlMxxahoCGoX79VgwX07VFgHdAa/dSifyKCEIq+I+OxqsoNrtdOnEgm?=
 =?us-ascii?Q?mg2Ryjg5mw7BH1zn84QpiKfLf62C/tDAUKNPZofMxxBqXloeWgqc83BxFVzR?=
 =?us-ascii?Q?F3qkvI4uxCK8P7ZHiuyvOKGdMRdCXxH/Uc9VSQ2MSVAa7/wtMWYvCfx8ES54?=
 =?us-ascii?Q?z5KfKKSSQ6K/Oz0KGzr5tgeYs+tcHydBzEO+yml6hA3hAB+FcWDWZxX8z0KZ?=
 =?us-ascii?Q?NAlAMMqBKnPB4+nV6I3UA7cSlU+jo7mGWCe/H9pVcRtiYfzlQy4kDB3kF2WL?=
 =?us-ascii?Q?fY6333Cftpeynf0hnZ4motDHQ177m03pXX1mOlvapgQt5ITu9GFb2wudoRiI?=
 =?us-ascii?Q?4Zp64j3/ZOz/IVMIBoRJh07V7bPjdAcDi++E2yTRhclCkr/t14LHOpA2jSaY?=
 =?us-ascii?Q?IH0+uQrKXfb8rGS3Nk3Yxt3d9hhiyysuToN00nrwBxo6rHcp2WBrBqczSsLr?=
 =?us-ascii?Q?jWGV2RgwLC6H+AXrUUj9ABkPiQ5/j90zmQcQEPrf9cNnTN59hFSgrbObmjza?=
 =?us-ascii?Q?BoO930rYCSF/yiiNIdQiBE+cGSChsz1fxmfVx92kjCDKW2KyXTk5xD6rG6mv?=
 =?us-ascii?Q?Ipv1FX3IbYS7R/leWdImThyjq6HcvnZpPsY+9o9PscLKGgk79NqVY7AqJ528?=
 =?us-ascii?Q?zovVOPP4Y1NdsQXkEM+3vam8pj+YiYuleXSAbLUYrBsJMNczzUDqqn4IR/Ct?=
 =?us-ascii?Q?N5KrxRuzXlqqdEavfX838uNbcUubanXsIatW+FppgIJZx+uDDL6Dk+kkSTro?=
 =?us-ascii?Q?iX4Y9T+BFcf+vMi4WX848v767iULSlPJlo5kSvthGhRXo+5/GRqGFdalQYsM?=
 =?us-ascii?Q?3XNtOhfqM8vSveiKEiVWF8dpvbn9UXUqdmgE+D3BoXj497+Q6lMAhp6AKxLC?=
 =?us-ascii?Q?mAjoXq5/EfhgZrXPWqFvfntKu4xPMvVtLniIWbLUVlG2XMpfbAYlvi7cbLOA?=
 =?us-ascii?Q?iGK6P69Z/SWlUhA31ON1AaoWDrcCh4h0MNnAkgcWyjRm/xljFjIWa5dKqSTH?=
 =?us-ascii?Q?a+cD7KcJLMx31PB3mFHTO6kJTKuWe7pKpzjYXVGYld1vnHsz3jiYxV6FCTsf?=
 =?us-ascii?Q?gr/MX012BEdmCrsF3LA656hG+kMeBUIjitBIi3L1uuQBJOPFtymcIlDyXAlF?=
 =?us-ascii?Q?OAgHrJVFfdUb3Dbyi9lVPCjelvt5/3RqzYA8Skc/XzpGEuCssbL/nugFbF59?=
 =?us-ascii?Q?yV31c9FOHt65A4P7Cg9mxLcGxg2Y+DC/9+zDEkoWhxO2cOM4V7jt?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 f6144fa7-c69f-463f-220c-08da1e126097
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2022 12:29:10.6202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 Q7+dLejtqIn0P5UJmu6BTFhtkcaqiAcs1FFe4vppoqa5lsSradBnZHNva3td7g6oG9W8tDciO2BOijdOvCxVtgjuVu1s3rFiIioI38rvJtBMcgLda5WFX2mqLDs+Ezr4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7528
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Apr 2022 16:03:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13619

Hi Marius,

On 4/14/22 13:43, Marius Kriegerowski wrote:
> Hi,
> Thanks for the reply. I rebased on master and just resent the patch. I th=
ink this procedure created a new email thread and didn=E2=80=99t attach to =
this one.
> Not sure if this is the way it=E2=80=99s supposed to be.

That's how it's supposed to be :) However you should have added v2 in=20
the patch series (git format-patch -v 2 or git send-email -v2 I think?).=20
I'll let maintainers decide but there may not be a need to resend a v2=20
for this one here (it'd be "spamming" the mailing list).

Cheers,
Quentin

