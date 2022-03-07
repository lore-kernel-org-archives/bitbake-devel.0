Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AFC0C433EF
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 09:37:42 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.73])
 by mx.groups.io with SMTP id smtpd.web08.24751.1646645860249005210
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 07 Mar 2022 01:37:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=JmOgJpqj;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.6.73,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtfZiTMIxt9Kwu4xTuEFlFFtPdtdvLLSkNXI/JHCEjys/TNq7TacMiTizK/fb3Wv6rAq/OMxqaAme8sjJNJ9DPrpH0qndQJodBdZczWE19W3WoLrzFiBr6H2Rxo/AIl93d5hKp2rYQ28EhLvfmPUdL6yyWyWrhC4xjlRhoSmksKK3Wi5FMgf+0PttJKwvkcL6Y3UWQfL9NWwM3c3+70Rl+mNbwjDQgLDnKsyv3Xqtuu4T/5B/2XOKyj5cf0cGSdaiOQpw+zqHrcCEWns48XWiYMeNR0pdEGOpRqdLWfU9UzKh1ol8lySth2ycRTDfS8R0DTgqvtnSAcTVqbpON/Nkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMrr9zmh8GCLRm76eqiESovnuCDS3JydA9gOGBA/+I0=;
 b=IR6MGi0x7ja9mekz4JE98iVdYDb6g6sEpKo+TiQ3bNzZrPQn0bqi1RIqIRn0y7nNDU3xh8E1CdJwt9YP4rXHHKpvGSb4hKbUJbuShYO/bpGEAGtM03/b75U06qIVSCdC6P74ZmVg8jXvQ+6AqGqi0zJv8RxSYGtG61nH6tTXpTt6CrMbieMgndDvyPIKVuvjg9xDf+TRW/tHVQFI88142AnSW2jHsJi4ooOJ5Knp7FKqFx73tv4yUNl9ZgfKQNZAl/anpQhz+1FXaKppl5P+6ojJGD1MVYsT2L6Y6/+PDNWJYqiQ2Rc29nV9o1m4y3GLwUKkWO0nmaji6QUgAk095A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMrr9zmh8GCLRm76eqiESovnuCDS3JydA9gOGBA/+I0=;
 b=JmOgJpqjWQ/mJICAFPOHzCU+D1wmB6EIgoe0qOqR0Gapzaq46/Ar5Cm6OE3JmYjM66O/AhwABIN290yACI+gXoAqBoFZZnD+kZQ3UDYlrFEUvFhydJaDyxYHZfXccxu1TsEgVIUzoLzRYt9rc1wA31MVot0Jn+HVxlewSA9hvqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AM6PR04MB4904.eurprd04.prod.outlook.com (2603:10a6:20b:c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.19; Mon, 7 Mar
 2022 09:37:37 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::ecac:a35b:6947:e7f3]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::ecac:a35b:6947:e7f3%9]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 09:37:37 +0000
Message-ID: <aece6598-6fef-0d61-abe1-fdc80d01e39e@theobroma-systems.com>
Date: Mon, 7 Mar 2022 10:37:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bitbake-devel] [PATCH] bitbake-user-manual: further override
 syntax updates
Content-Language: en-US
To: michael.opdenacker@bootlin.com, bitbake-devel@lists.openembedded.org
Cc: docs@lists.yoctoproject.org
References: <20220304201150.418001-1-michael.opdenacker@bootlin.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20220304201150.418001-1-michael.opdenacker@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0401CA0013.eurprd04.prod.outlook.com
 (2603:10a6:800:4a::23) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 777197a3-b1db-4ba8-9975-08da001e1d84
X-MS-TrafficTypeDiagnostic: AM6PR04MB4904:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR04MB4904C8B4A71D7B9FA47D1498C2089@AM6PR04MB4904.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	/YTPt6FE6S32OX9H2HVCUJSP6O8NxF7I3nIzZIsFKiBUK63D1nrHOGTUsVhQCsWCqK2E6rWqua1r8XCaWR9kWA7oTp2SjOHdJ0/qr8SpNMgFNj117XIb2vJotJAb5esAPf0xTxCC5SvguWeWIZiqfS4DFPAW4OoGYnQIVCRoXL5ctBw2UXnjiMjecOi0vNZeqmMtb0NKBUlioHGUPd3f6jTHAQFdYlWyMf1ynO0AwTBOYuRVpOIsraU5UcapahZtQgFHXVyQuKYOvY7Ekc7Z1aGVQ4KBBrVaFdZcfViMr6gi0k+IIw2u3DYxQynyRQzi2kWoXc7lsjO57ta/R3uDtqwFnXRNs66ntmP3YLGyUnL502sH0UhdOKqJ+SY7RtZkWkGSflnnv6NWmmvrYd+4tR73JEOHFqSMQ+o2AWf9ROy6sVxfwBM+3XRDS6jk7cVAts3ca/IrSyCVGJeF1nFpo7ccBTUFiacI4BJ3B4pK2sfk0gXgjMQ9G9YUu7wsdU0WLCSIcGWWUhUQbmVBFcZpmdsB62OxiWcWJWnczB09+m1nOdgTbeCERuI+quAkS+JsN+SX0FuVNxLQwnZndDW4FQG2ns+mJT1h91Lfs2KAXies7cSk6K7T+tsz8fTd3J8rYvyFKfK6NNhIn/I1xxnaSAd+QWVnWBt8SPIuqnziSSx627WzFnbzRV4hXqc0C4h7Ls0Vpz1GvEFWY4Ubp/EWbCNrH2j6MNKkPUt8WoLR2oA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(86362001)(8936002)(44832011)(53546011)(6506007)(6512007)(4326008)(31686004)(66946007)(8676002)(31696002)(2906002)(66556008)(5660300002)(66476007)(15650500001)(186003)(26005)(2616005)(508600001)(6486002)(38100700002)(36756003)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aStRRmwycUpKNGo5T2RXMm5rNU5Dc2dXanFWRG82UmQyVTg3dVJoZFpLcnFM?=
 =?utf-8?B?bFlFN3JuSGUxOHpFdUxxYkFtRXdSWWwyamc4d1ozbjNZZFJ6QkVzRUthRHpi?=
 =?utf-8?B?QkE5eTZiWkk0RzU2c1RlRHE2L1BsWVlRWkFqYVc5VUpIWkVOeGE5bWlWLzNi?=
 =?utf-8?B?RnRRVjBna1BmR2tlUk9jNFFKYldONngwMHVjcDBkMTJmcmM4cjRIWmtjYmVS?=
 =?utf-8?B?VGFkQkxncVFEOXlucjlXbUNWRy9JdWUrcGFOOTZMdXJJeUdDVGdKNDVCUjJZ?=
 =?utf-8?B?SW05d2MrcEVoQTdxSnV1VU85Ujc3UWxxZnJyV05NWDgyN0twRG5GdGNvSHJ4?=
 =?utf-8?B?eTFDdlZlTWV3aXJxejVldWlqNWltZzhlRjZGTllrUmhnVHlGb3hlR0JEcVVk?=
 =?utf-8?B?QUZSOFpHVnB6M0VIRGR5czJNalk2VUZueDlyV0Vac1craHQ1b0lCNFczVnh5?=
 =?utf-8?B?d2VzVkpVSHBLQzB0M0dKMWVXNlMwa0k4VTZ2UkZ3Z3lIU1pBV0RoTDdYOHZZ?=
 =?utf-8?B?dmNQdmk2c3JDUGRkdXRocU9GVi83U2dST0RIUGU2N0N5Z09XUmo1OXVTTHFX?=
 =?utf-8?B?NEdFUXFzWFpBRlAybXZLbmtkR0J4cklKRXF0U3puZXlhaDJEWUlsanJQOFc1?=
 =?utf-8?B?SEtZSUNKM1lOMFIrMTNmNmZDYmExREVZeTdhVVhtM2ZwUksyQkM0MnlQdU5m?=
 =?utf-8?B?QWU3cU9LYjE3ZTV2bUF3MklJcCtQUDVMZFVVMTZCNVRmeVFXd1BnMmR1dVFX?=
 =?utf-8?B?TGZEb3NIWG5vQVMycitNZHNNaWM1TDNMUWs3d0JEMFAyTTB3SnIwWEtZM2hx?=
 =?utf-8?B?MG0wMFRVSzZPK280OThTb0krTXFaeHN6MmhqUEh1WjlnbE1CUld6ZnI0TTh1?=
 =?utf-8?B?UlA0S1U3RlpFVXhBY1BHQVRURXkzUVkrYWppVWRKNk1KYm1qZ2l4SWhlalpL?=
 =?utf-8?B?RkNEcmRBeXFkaW9oTFdIYW9UNTdZTXcxcXNvczYvMVRLdkJzaGVqaDZSSTNC?=
 =?utf-8?B?aHpnandyblVvaU5KQzE4RXEvOVp1WmRFWGdEYndXak0wVExLc3JtTEpYRzlU?=
 =?utf-8?B?QU1MSGpXL0pqU1FTZUpIU0VtRWl2TGRWa1ZCa0JJZmRFS0xuZnZGNGlJMFo4?=
 =?utf-8?B?aVB1T1RnV1FXSlEwV0hTaUNvOCtHTllNUzlseHpNSHZudEd3bTY4dlVLUVV4?=
 =?utf-8?B?VDg4UStvLzUrS1JjV3M1L0FNR3VzNWFYdlNEeCtMWjAvT2ZpRFpZNG15MmRu?=
 =?utf-8?B?OGhrWnJPWEkyL081Uno3TGNTdFBUUHhMa0c2UlQ5UXBGdWNwYUNpaGk2MXdG?=
 =?utf-8?B?Z1Q2azVaRE54L0x4dTRaUnZacXN4Mk5GL3ZQMmJLSTYxMjVFaTRRMG51ZGJ6?=
 =?utf-8?B?dVY1MUQwN1N4REpXbnlBdXVub05rZytxU0VrRVFrWk9MK1FScDZFM1Y3NDlw?=
 =?utf-8?B?V0RoSlNaUldNMEFqd3orUnBUVGg5Y0w2Y3dUTzJwTWxtOEtsRGcvUG90aGFu?=
 =?utf-8?B?QnlQam9ibkRQZzB3bWhOMFd5WEtOSGsyVXBmc1FNQThPV0xncGNTVWowQlNW?=
 =?utf-8?B?YkZlVk9NYmVsNE9GVWNZV1JkTG81V2xteVE4RFp2Ym54eFpsdW5ucEg2bGNB?=
 =?utf-8?B?eFR3WlFPNkZUQjlNODFHVngyekVIWnkwbUFMU3NJVC9wQXFGS3lHSWkwcG8x?=
 =?utf-8?B?a1ExZXlTY0x6VTR6OEVUd3I5cFdaNFZQQzk0YURmaW96Tksvakd3bHFteTN0?=
 =?utf-8?B?Yk5VM1BoNS9CRWtrbnhjTGsyVDJWWVJuaUh2dTdQdWtCeFlXZmhYejRqZXlD?=
 =?utf-8?B?ZWdXVS81M0ZhSVNERzdtdElTRkdkTEJqMnpqUlQwM2tadHlNRXlNNWdWMFp2?=
 =?utf-8?B?VlZudktrSGFOYWpVMEpqUFF5V1pyRnJlRDIzNlpVNncrMUxLb3UydHdTN0Vw?=
 =?utf-8?B?ZTIvVDZyOGRWZDBmS1Z1c2hzeWR0S29HZUs4K01RRHhhbXIvOG1DWVVhUGRZ?=
 =?utf-8?B?OWVIdFBHUWVnaGxiVno1dzlzT2toSFUvanE1TGhSWXIwMVhuZmpHL1F1MGVx?=
 =?utf-8?B?ZjNqVmxLcmVLYXJsbTdyRUtCYnU1OEhOQVZrNVJvd1pLaFc3dXNJTkVvcGp4?=
 =?utf-8?B?T2Jja1p4OXdENWJBbmZxdC85QTdMNXlrTDRCSVZiMVZZbjFkOUx4RHQ0amZ2?=
 =?utf-8?B?Q1VIS1ZoK09UN2Mwa0xLWnI5T0lhSFliOEtzSUJRSi9iUldnQ0JwUVBVMEpn?=
 =?utf-8?B?RURQMEJFQUo1S0toZ0tPRW9qU3hoR0VkRlBYNVIzZzNDZWpoN0FocW9HN1hR?=
 =?utf-8?B?eXpZQ3RYYzhxU0pySjFnUXRjTWdaWTI1RUk5b015eEovZS8xV0oxUT09?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 777197a3-b1db-4ba8-9975-08da001e1d84
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 09:37:37.2469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 noMiUmMdk1zcnHS7sk8MNwiNr/Htj84Qhwfvc4BgUGKSaUxLpd16ID+PBFHwHSn9eK//zYp4ve0z++r7sGvjIg8KyCCga/QCirdmZCUxeOQwsDgSigRGY0nPMqFw54eT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4904
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 07 Mar 2022 09:37:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13418

Hi Michael,

On 3/4/22 21:11, Michael Opdenacker via lists.openembedded.org wrote:
> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
> 
> ---
> I think I found some missing updates for the overrides syntax,
> but I'm not sure, so please review carefully!
> ---
>   doc/bitbake-user-manual/bitbake-user-manual-metadata.rst | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 174cac78..b90e5cf0 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -511,7 +511,7 @@ variable.
>   .. note::
>   
>      Overrides can only use lower-case characters. Additionally,
> -   underscores are not permitted in override names as they are used to
> +   colons are not permitted in override names as they are used to
>      separate overrides from each other and from the variable name.
>   

I think we can now safely say that overrides can have underscores, 
dashes and digits in addition to lowercase characters? I don't know if a 
variable can start with an underscore, dash or digit but we do have 
x86_64 and qemux86-64 which are overrides AFAICT? This should show we 
properly support those "special" characters. Probably would be better in 
its own commit.

Otherwise, for this commit:

Reviewed-by: Quentin Schulz <foss+yocto@0leil.net>

Thanks!
Quentin

