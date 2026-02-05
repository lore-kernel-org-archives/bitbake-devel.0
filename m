Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A51EC1EB6
	for <webhook@archiver.kernel.org>; Thu,  5 Feb 2026 13:08:41 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.41])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.20267.1770296915803852805
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 05 Feb 2026 05:08:36 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=V0RN+3rf;
 spf=pass (domain: cherry.de, ip: 40.107.130.41, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KE+6PBWAm0eiFUsXq7pqSnswUGu9KSIR107GzVM22dRefQ0WZopk1lxs7YqQ+kRhi5jhvcHOKeU6jLmTcSK1cLAl3feiciAt0vvZ/9qACe5TF32JGvqIfl1jxxuHBnjtM5siIW48bQqeUeNOaFi2o1bmrFyI94R8ZhlY0PrDHIPLSzADqbEt7qg2HiuRDRWDOr9LOHnqZnWcuS6osUZ1UGd52De8J+Ik5/LxrCz6QKJOpXwAFe0p8C3H3b631R4YzHvLuJrIW8dot35f/hr76zQqF4KTp6wZg6jwuS0CX510IXLIstU0wrUAj445DRDfS6LjbUXPrerjbHz+DSSsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGnc3LxUxqSGxsD3gtO0Y4UOHSBASDbvejcGYYMC3j8=;
 b=aAPkjTSYUwjyY+uyNM0DaQEdBhWGhNikNtFudghnntiToJ3wvk7QNIR1tCJsXrZfMiLKydTRCgkREzPH6NoX2xQ6wEDmayozjO9NiV2Bc/pJYC1NfDKWl/Ebko8Y6gDYOB/FAIG6Cb09HTqhgqnu0vB7WrUW+PNFjFNvZgILvuFywnnoUja1c8FFfwQPDEG14cGM6uE1yt9bzUbQkEI/U9zJQNd0rPP5yUauaaA/0xf61l86/lmiTafahn3JkBu6BuAETfdfFRCpTICJVJ9TalaN2jPuKkn7UXJfI0sFhMXiIQXh8227pAgY0i1EY/02qpCpizZq4rR/YY+4uHEM5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGnc3LxUxqSGxsD3gtO0Y4UOHSBASDbvejcGYYMC3j8=;
 b=V0RN+3rfSi2T/g/ViCWhtnY50JdAjBtlfmONKL5/6uwvwXubfpSTCOa4Rso4Vjo5jSbmUGu2NQ6F/DDYZ5aMco64r6QsgjKEnJJ95MlecQ8S8Opp1RBiAwoqNz5QOu18Q7NatYT+Ml13I91F6uvLG6b7sWn/4wMOUf2SrMkkrFU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GVXPR04MB10183.eurprd04.prod.outlook.com (2603:10a6:150:1c1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 13:08:29 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 13:08:29 +0000
Message-ID: <a6c85602-e566-419b-8a76-0dec0085b92b@cherry.de>
Date: Thu, 5 Feb 2026 14:08:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH v2] doc: fix the switchers menu
To: Antonin Godard <antonin.godard@bootlin.com>,
 bitbake-devel@lists.openembedded.org
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 docs@lists.yoctoproject.org
References: <20260204-fix-switchers-js-v2-1-ea80107eff85@bootlin.com>
 <f9a1db09-bf8d-4f29-b2a7-567f97ce0532@cherry.de>
 <DG6ZW1HMRGQY.2QNTJC8SOYOCP@bootlin.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DG6ZW1HMRGQY.2QNTJC8SOYOCP@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: GV0P278CA0013.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::23) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GVXPR04MB10183:EE_
X-MS-Office365-Filtering-Correlation-Id: 490e2906-861c-49cb-ee7a-08de64b7a7e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7142099003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?c1NIQVFNaXR6U3Qza2VxMVpUU05aYmtZL2taajg2ZWJRQ2dJWkgweFp5VVdm?=
 =?utf-8?B?cjFWdHBjb1IzRjVGL2VLVlZnQUpmaDZZb3VGU1NKTldlNFBUV1FGWXg2NlZs?=
 =?utf-8?B?VXdEYUJKNk9JVmY5b2lsWVNOWHBvYTlHbU9LUVI2RE1ob0ExclJ2OTJ0ZlIr?=
 =?utf-8?B?VTZIREtCMEkzWVA0T2NLSUtsSDhtZDBPWjZiMkl6Z3cvRHhtcEdWM3RTUHQy?=
 =?utf-8?B?eVBHQXhyR0dOSisxSUN4M0xaWEhEbmpnUC9QaU1aM2p6dWIzSy95Nnk4bFhX?=
 =?utf-8?B?SEdnYWpJeFVoOGwxeThoK3VKWHVYRVRPMGEveTlrdDlRTlREYmdpNW9EWm51?=
 =?utf-8?B?NEh5Y2d0Z3NES05SWmZIei9ZSkhVT0VGV3FmUkQ3NEZYZWNZVzdQMVg1Sldm?=
 =?utf-8?B?TEpZYUFoTkVKcGlOUzhieWtKdk9VcXlOb1N4QkFsNFRQTDRUUllsMzRjK2N0?=
 =?utf-8?B?K2J3NGxxc3lTbGRUQ2luTnQrT0p3RFZxM25QVVVybHFtRVFqOXVLM2NmdjNh?=
 =?utf-8?B?QTR3ME5tQXUrK3hGMlFVd2F4bnROOEV4UnBTSU15NGNvd0xBcnd4SU1VNXpB?=
 =?utf-8?B?Q3dWZzVlZTFqbW9yME1uaXNHWi9DWjZKK1B4K3V0aFFPckJQOEVENUFnUzVr?=
 =?utf-8?B?WFVHUG9VM3RITWo0MW01QXZ0KzFnYXFncFllUG1CMVo0VEFwVGpFd29xYlpv?=
 =?utf-8?B?aXJXTjYxODRGVFZwNkFxVXdTbHhFMjB2MktRbXllSEp0K2x5SzU3RVMrY2xD?=
 =?utf-8?B?NFltc2lVTU9vVmpiclltWmluWTdsZkNZQmdQQ2hWRWhldTNTZmNYeHJZa1NZ?=
 =?utf-8?B?bEdXZFpvRWdUY1RMZS9nSVZ1QWxTcVNtcTVDd09uY0w3ODVobGdtY3BPU21u?=
 =?utf-8?B?LzNqdkVqcGhqRDdmZVg4aWRiNmk2MWlObllRMmJnQVBIRXdOVXVNR3doTXJT?=
 =?utf-8?B?eFN2ZitJT2dHMm1QRGhyNUNSM0d1a3NYamc1dG1xQUc0eVdacUx3dDE2Y1Bn?=
 =?utf-8?B?T0oybXVLenNpUWp0Z05Id2tZbnlraTN1Z25PcUM5N0RTU0d5Z0RMQnVXTHY2?=
 =?utf-8?B?enZQMUQwWEZ4Y2ZMNlVjWUtIRDJVQnluVHpyaWFkYVpTYzcwWkFLeFY5dFpm?=
 =?utf-8?B?cFN4alF3U2JQU3h6R2RiQWxrSytVdmFheGdPVFdQNHBuQmhBeFY0eG1nYlFW?=
 =?utf-8?B?RHN5VUQ1MDJCdEMvWHMxUmlwcXJEbWk3QTRXZ1VoT0pBcjlyRUYyV0FleHVh?=
 =?utf-8?B?aHdMdjc1YlRMc2IxbTlkZnRhd1UycE9DeTNISjFhbFpmMEdxR25rVit5c3dY?=
 =?utf-8?B?RjlOYktCRTNSMWpSVk9MTEc1bHU2YjBCc0F5c2xqdmF2Vm1Td0xtNFQ2UUVp?=
 =?utf-8?B?MFIxN1BubmRGbzU4czFsVkpIVmQwdktiOWozcUgyUXQ3QkUyOE1BQitBajV3?=
 =?utf-8?B?WUdaTmlNRk4vRjN3QnZTZlRnbUIwUFNvRVZCTklSanFIdktVVTBkWkdyNklt?=
 =?utf-8?B?T0xoMXcxTnZtcXBoN3hwK1hqQXZlcmo0N2p1bkYvWWxZeVpmM1o0ZW5QSU9Y?=
 =?utf-8?B?YkJTNyticW5JUWlKdmNadWdKdzN0Y0pKRHJGMFA3enRiT3RmK1pLVWgwM3pz?=
 =?utf-8?B?N0t4bU9lcnhOelFRTlRWRXROcmNoRllWbmdiYThlRWRBNGRvTE5ROGpjNUZo?=
 =?utf-8?B?MHVhMnFRY21KUVJpQTlIeThXZjBwa1JBWjZpeURTUXJVRi9FWXhvSG9vK3cx?=
 =?utf-8?B?Mk5qZ2prdkZkb3VYL3NDMUh5MWM0TVUrRjZuNEUzU3FHenM1MnE3NEhxamZN?=
 =?utf-8?B?bjlwNWhNWjRGQU9PK1VRa0kwSHRSOXpucklUZk5MRkppYWJqMTB0dWtwUmEz?=
 =?utf-8?B?VlFCKzc3UHkvbk1odSthNy9aVkZtMW5BdUx1cWRKTWwwckl5VFlCL2FrUjFj?=
 =?utf-8?B?WjhVVUUzdXE1U3J6OFN0SWtIMzdhVEdGUVZIOWdaZTA4ZXo0SWpwTmh3c2h0?=
 =?utf-8?B?OGUvQ3pUR0JJWE9iR2M3b0J6dTIxWGI3YXJXai9pOUlPZWtLbURPVFlKTmRN?=
 =?utf-8?Q?vYE8EP?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7142099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TkI2bXdnRCt2d3h0QTRQaGJCRGtMSGFnV2xTMWtBNVMydTVYSDJ0aDdnOUFt?=
 =?utf-8?B?elRWOWNDRmJNdXBJMHpMTjMrQzFBZzBPZGt5UlJUYllQUDhYR0Myc28xS3p3?=
 =?utf-8?B?dnYvUEJzWkJoUkRPNXdKaDB6eDhMUkNKamY3bVRVRTlhb3BieTVsQklqaEdr?=
 =?utf-8?B?UUw4d2lXUGw1emJ2ZGY2VEdKNzNzdWoyMU1RVjZYb1M3b1N0NDJUUDZoUXov?=
 =?utf-8?B?YzFPb2dleHpxckRLVXMzVWo1NmhrdUU0eHh2RmlQRWx5dWw3NG1pWkZ3bVBp?=
 =?utf-8?B?MTJkN05PWnJmRzhrTmtKUGszQk9obDdqM3F1REVwZ1VWVFlOTVpodWtVMzBE?=
 =?utf-8?B?ZlFIekVOT3dMUmFZQVdWT0R2UElWWVZhQ1kxbDY1TElUL05raXNPNStLdmY3?=
 =?utf-8?B?bXJaUURWNzRZQk4xTk1RenA0Wnp1WlFUUDJYM29xQWgvcjFLZjY0ZHhaWUVH?=
 =?utf-8?B?SjI4c1pyVXRLVnlya2EwY05JMGpwZ0JhcDZBSStqd3BDTjlSK2JOWG12YWs4?=
 =?utf-8?B?eWl6S1A0cGpOTTZMTWRwcGFpcjhvUXgvRG9WM1kxYXdINHBHajcvWWJjYUpN?=
 =?utf-8?B?bHczMTdkaDlUSmhmYWorYm5FaDZYZVd5YzhBSGtBYmlnKzFEdUgrSEJXK0g3?=
 =?utf-8?B?aWdEaERWNE1zVzZzbEh1NlorWFZ4WHkybndkZCtTUTRQTG10ZjV5YzhacCsw?=
 =?utf-8?B?d3FIZkppZERpVTVZQzVia1k1S2U5bTl2eVFEeDZxazdmRmRvOFBOQVc2U2Nq?=
 =?utf-8?B?M3RnZTkyRDVtQWs4NWRQZHkvK2tJQm1XYW5ySFZwMWpWWnhleUNIY00rSXFv?=
 =?utf-8?B?Zm1ieUk3TFlzL2lYczd1RjZldzVvNG5XaThpalBLUkt1RkFUY0VtV2FYR0xq?=
 =?utf-8?B?blYwK2c3c2RJN3NrNEI5T05GbDAreWlUbVJZelRxanRrdVJjdm5wdE9iZm9L?=
 =?utf-8?B?ZFhpR2xqYVk0UEpsNzZUdHRjcW9JdmVDTUhIOFRtaVJtRzZRL2s2OXEwNE1J?=
 =?utf-8?B?ZTg0bGkzd1FSN3VRUGZTc25GQ1h4M3AvWmxHTHhwR2dTTllwOEVXZGlRaXJQ?=
 =?utf-8?B?Y1pSSEdsd1ZJN1dCeUcrNTlPbG1JeVd2MDZmMzNBMUpWcmF1a3l2a2c1VEVI?=
 =?utf-8?B?NStDVk1PMFFXbnY0VFcrcjBVaHVDQnlLZGNOaGVNZWJHWkd2ejV3RFRzbElE?=
 =?utf-8?B?Sm5kVzFodGNhei9jQTBldGlXQllndCs0bi9qZjB6bCtDbFlFQ3EzM3A4MGF3?=
 =?utf-8?B?aDZXZ3UyellqL0NvaXloRXNzUE9XZzZXaXJPc1Vqb0V4Q1lLUnVqY0RMWjk2?=
 =?utf-8?B?UVlsZVcxVWRYVjVRakEyenBtdVRrNGFhdG9Da3hrWlRsRTVxdXpmYUp0R0JP?=
 =?utf-8?B?Mm5YbFhXeFZDZHFudmJoMUNvOUN6cEI2MElkY3Z5TDAwbXpCMFM0T1NHclJh?=
 =?utf-8?B?Y2JYUXF1a0lXd3RkdzdHMndTVDJERjJZV04xKytaWnZ2emZMOTVGeVE5ak02?=
 =?utf-8?B?dUljb0hhNXdwVkdXd01RZWdJNDMrRG5ub1BWRGh5YWg3aHFZK08xeVpndlcx?=
 =?utf-8?B?bFlPMXQ2YkpuUCtzeldRZEFtMGxJZXVqWmZRanVJUi9ZNUM2WDdUdTErMlZR?=
 =?utf-8?B?NGlhZEZYdjY4U0t0WGZKZ3BTdktPYnZ6MW05OVpobXFVLzlFeUxta1R6ZlJX?=
 =?utf-8?B?TUE4WG9PT09kTjZRV0FYK0xsOTBaNEdpYjNSV2pRWGpETnlyZFpWeWVIZ2g3?=
 =?utf-8?B?TG5nZFJMMVRBMHZGMU13YzJEdTBwdC9CREdrdUM3eHlsRG5KL3NzZVNWQ0xS?=
 =?utf-8?B?eFhNVSs3YkYxekQ1VXRJdlF4OTRuUGM4dDZZR2pHR3VTVHBmN25PaDVqZU5X?=
 =?utf-8?B?clgwRWZPVTlvejI2SmFyb3JGb2VmRmtBQzlIS1RSY09IV3RBS0NrcnZBL0hN?=
 =?utf-8?B?NTE3c1REekxKUWNDRFRHWW5VbERmVWdRcXdBVENncFl0d0kzSGQ4Slh2dmZL?=
 =?utf-8?B?UHRMaEZVd3pyQUVQY25tQ2NzSlNVZHltdEtCTTlYTXFHdklDUlhUVjlXbFlx?=
 =?utf-8?B?QmFwYS9yb1ZDNnFuelB4MHBBbnhMRFR0aVhUUU92S1lEQVdHTThkNExPRkxJ?=
 =?utf-8?B?dnlsQlZtRkZQVHR0RitWTHFEY3ZqRmtEUE0yYTBKeDQwK1UzNHR0UnF4enN5?=
 =?utf-8?B?cXpYaWRCODNneGRHMW9zWWhtUlFyWThubGhEcFREVzRpQnRPMnBoUjdRL3ZZ?=
 =?utf-8?B?QXNpbzkxK0hEcml6Vnc0TWpGTDErVWx3allUNjBkZUxKNi9zMGVibkNDNWxv?=
 =?utf-8?B?TGU0TUtrd1pseU1McE8zQS9sVng4cHVxclhtNjNaT3Y2NFpxOXBHUT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 490e2906-861c-49cb-ee7a-08de64b7a7e4
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 13:08:29.2835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSxdJu6Gc5p5hMk+EB1Ze9FF65wPkV+j4crLwyvrhCnbH7Yf632776jQEUhz1kyqw3NG7VNBs9v5xHcZxQR7zLiVA8urFlUUb/tjK6xCQFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10183
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 05 Feb 2026 13:08:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18967

Hi Antonin,

On 2/5/26 12:34 PM, Antonin Godard wrote:
> Hi,
> 
> On Wed Feb 4, 2026 at 4:01 PM CET, Quentin Schulz via lists.yoctoproject.org wrote:
> [...]
>>> +with open("sphinx-static/switchers.js.in", "r") as r, \
>>> +     open("sphinx-static/switchers.js", "w") as w:
>>> +    lines = r.readlines()
>>> +    for line in lines:
>>> +        if "VERSIONS_PLACEHOLDER" in line:
>>> +            if ourversion != "dev":
>>> +                w.write(f"    'dev': 'Unstable (dev)',\n")
>>> +            for series in activereleases:
>>> +                w.write(f"    '{series}': '{series} ({yocto_mapping[series]})',\n")
>>
>> Why is this different from yp-docs? We don't handle showing the current
>> series (ourseries)/version (ourversion) if it's outdated anymore?
> 
> We do, but from switchers.js, where in build_version_select we push the current
> version of the document last:
> 
>      buf.push(
>        '<option value="' +
>          current_version +
>          '" selected="selected">' +
>          current_title +
>          "</option>",
>      );
> 
> So the version from our branch gets displayed.
> 
> (trust me, I've had a hard time locating and understanding how all of this
> worked :))
> 

Yeah set_versions.py and the switchers aren't the nicest things to dig 
into :/

Is the above mechanism something we could migrate yp-docs switcher to to 
simplify it a bit?

> However, you made me realize that due to our branch the abbrev hash, it would
> always appear as outdated. I fixed that for v2.
> 
>> To answer Richard on the other thread, we use YAML because JSON doesn't
>> allow comments. Also, because we used to want multiline variables (see
>> https://yaml-multiline.info/) which aren't supported in JSON, but those
>> are gone since 8d993022c2ae ("docs: use literalinclude for system
>> requirements"). Not sure we can get rid of it for yp-docs as we only
>> override *some* variables in this file by set_versions.py so the
>> autobuilder won't replace poky.yaml.in, and the YAML is consumed by
>> sphinx/yocto-vars.py.
>>
>> If we don't plan on having comments in this file *ever*, then the YAML
>> dependency isn't necessary.
>>
>> Another option is INI and use configparser, c.f.
>> https://docs.python.org/3/library/configparser.html
>>
>> It seems that INI supports the ':' as key-value delimiter as well as
>> multiline strings (but not the way we used it for YAML!), so it could be
>> a drop-in replacement. We could even simply write to the file with
>> configparser.write() (though that will drop the in-file comments).
> 
> If we directly write the ini file with configparser.write(), maybe we can just
> maintain the list of variable as Python instead, instead of a separate ".in"
> file?
> 

The benefit of having a .in file is that it's explicit what the user can 
use in the docs (if we have yocto-vars.py! which we don't (yet?) in 
BitBake).

What's the usecase for DOCCONF_VERSION BTW? We only use it for setting 
the current version (always "dev") but we never override it? Either in 
release branches, in the autobuilder, only from set_versions.py do we 
read it and override it. But then it's nowhere to be found in the docs 
either so we don't use. Do we actually need this for BitBake?

We could push this even further if we wanted to and have a bitbake.py 
instead? In some internal Sphinx project, we provide a skeleton with 
options to provide (Python) variables through another file we then include:

exec(open('variables.py').read())

is what we use. This would support f-strings (can easily reference a 
variable from another one), multiline strings, etc. No need to parse 
anything, it just needs to be valid Python variable assignment.

Cheers,
Quentin

