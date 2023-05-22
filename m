Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DFDC77B73
	for <webhook@archiver.kernel.org>; Mon, 22 May 2023 15:09:20 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.65])
 by mx.groups.io with SMTP id smtpd.web10.24511.1684768155689867297
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 May 2023 08:09:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=eDFlbCJG;
 spf=pass (domain: siemens.com, ip: 40.107.249.65, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbMvaoFPlI/bmRNfzNzYEx1b4GmWXt352S1AAg76tH90YX3/wzi1NRGD4qq+cBiHC7QH946yupGu740MIx4qgsQhGfUgRIeyLDrZwrPiT2PH65d0I3+26Q9D41SVIORH8JDuwCPBCwqwgXHwwxfE0ma7FJZ55DNrvU2n9SPRrh/B2QeasDTtOss3ZLW84Mm1w2RyAPV5N8I0elNOkLeYnKPgrhxRdoZ2T3KYoO0/D8IDyt79wchJ2BReLo8eYRX3nSfRPcZTxMilrzPZa9jIdvBmDWEcrORiqKk0uElLyP60SGmvtG2zYrTyk7si9Wtk/K6ZbbNUIEbdPE/XJj3Bug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9jaLerF638UHyn3Xhgt4+JPWZAmp3CYjksSgPUl5RV8=;
 b=g/G/GUspjSAsYi4RQOPN3Rq7VrvWZ7eeRQVsm2E1a13WNhPqIEvseujIJD/XGpEtWvy9lj8VTl9Fij19ShdnU9yoxIuoSr5f/7XVJd2sW4NHTv75sZeIJ/5R6nNl8lZZd2ewFeIpnZRvfVj3YWUo0dAY+uAU2vOQG+7LGX9dHuQ7x+O3T3yWJqxz6wJ/ATvCO0Vhvw9Du7tRpEcwo+uhRgcnJZhxL6eXDkDPz7d3hANdzT/YgnrFAJzTdtJe3WbizIkr+tsQdiSms7WMA1NzfxcEFxP/FYZFPB9HttEAckmJvk8TOm++OLV9vBjQvwoiIxEIaYY95/4fo1+djMESbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9jaLerF638UHyn3Xhgt4+JPWZAmp3CYjksSgPUl5RV8=;
 b=eDFlbCJGrOmInCNvLu9Zr26SoeB2IT1QULgpuPyLJ7ZrteK3JhwQ0+tpMzQUlOdwlgfNhY0xlz2//fWPOuzMYVdGgq1zZvCAnP7a82iwrcVEbp3c+mNu7PjwG9WAWtMXMMhuFxSztxHIJx71s5bSYMr1URZ7qHkhweIuckEixG/b3pfezMD4LQ/QRE10QDDZBDG+Aav1qdzxXsGEBqBHJ6C/U7hEbn15S+Y2kKCKRHnDXGcpOJeQiL8b4Ub7kRTTUpo5hsc6PQQQas8tHpaW7zCwnhCsUBC/uJcmetrXhoe7crt0UT4YbT1Tu7KhUp8oaxBgb7w8bHz3X5pSHxz3Tg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAXPR10MB5407.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:284::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.27; Mon, 22 May
 2023 15:09:13 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f6d9:8120:2524:5b06]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f6d9:8120:2524:5b06%4]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 15:09:13 +0000
Message-ID: <498156ab-3d9b-2d80-d9b0-18145b07cf77@siemens.com>
Date: Mon, 22 May 2023 17:09:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US, de-DE
To: bitbake-devel@lists.openembedded.org
Cc: "Moessbauer, Felix (T RDA IOT SES-DE)" <felix.moessbauer@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Subject: Question related to MIRRORs with downloadfilename
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:610:e6::27) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAXPR10MB5407:EE_
X-MS-Office365-Filtering-Correlation-Id: cd2fe8cf-5324-4a6c-98ed-08db5ad6807b
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	r/knWY+CrIjRTcNKJ4+uukuY5b747uxFxZEcepPNntQXTZjo4RHYucSEOc6cdi0l95vTIxlHof6BeX1Dkcu8aNYm8hpEYkEcPipq4busDB7ffvfZYdZigU/I/zoNGPnhZXV99XKTdpN4RJae/JglgHgV/8Efu/W9AIKpVsVECqPB0DIHksO12kVUGGeaC5lexQ1yur/kUQdN1+dS9Us7z7DnkNN1WSG7AVSc05PjJqVbXTHmjQF3kFTOyRZ9No+lCZPYBdxEntSyOvvne1iJUCKNtEAHql/8IeoG6CzmyR2lMJxKGCnFF2adUqejJkCIVyszay1Fr/ikrKGzNDwLoH8m9H1WMZCmfClcoflvL57WAaV348tfwcMXAed7+730IL2I+krmzoIpOAXbRlZkE74Bath44yQxYZOAI4YzZ95mr0/pXp1rvo+LLgS1QxHEwEaeJF95cHzY8pLpWm1iY1s+Wd7Zi/V6xLpouWkTLkK2O7j6TVZGrCRj7I/nIwd18f1tqyl46povUqkfjK3xtawaNNwgN+YlsTIgHVFSvAXCdc4Iu3sKHVnFIjuYYXIcPFxsLIHrIIVEMlbY5XgajrP+Rv9A2ztN+XHQRiT7MVQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(366004)(346002)(376002)(451199021)(2616005)(83380400001)(186003)(2906002)(4744005)(41300700001)(6916009)(4326008)(66556008)(66946007)(6486002)(66476007)(6666004)(316002)(478600001)(26005)(6512007)(6506007)(107886003)(5660300002)(8676002)(8936002)(31696002)(38100700002)(82960400001)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bEJObk9VNFdFU201WERKTEMrN2FhRlZ2WXpHUzhDN3FnYk94VkQrRzFpTGRK?=
 =?utf-8?B?cXBpd3NPYkxHMXpNSjZMdktSSDV3VkdkZWdJQU9IU1dLV1lJNG5HbnU5b21o?=
 =?utf-8?B?L3ZPYUFXR3pjNEhLK0VXZGpWN1FZU0h3L3hIMjNyKzZ0Wi94R0tRYWlZZWpm?=
 =?utf-8?B?eVVzRUZnbTZkclpZbkg0ZWVYRUI2M3VYMVJsbWg4UkFibkFpc3hRdG8wcVZa?=
 =?utf-8?B?NW1tVDRFT0xvRUFmaEVkUHVXOXd5cEdaRmhGa3RGR3lBa09KaWVMcHRkS2gv?=
 =?utf-8?B?ajNjVTEvRWMzNnQ2Zm9BWFl0d1JVZEtUK1lEWFhlWjdjeEFwQWw4QVdHWC9a?=
 =?utf-8?B?UDNWa1lQdFE3T25Ja3ZTY0NMbm9PcWZndlpUMDlRNWsxUnRyakFEUHJxZHR0?=
 =?utf-8?B?TGVWNVNaMW1XRzZUWkJLaUVFMkUxczhTMW9VeFhQM1lQUC9SQjYvYTZDbkZP?=
 =?utf-8?B?dXd5TkJacmJSVE5qR1NYWlRMSTNlYkZBSnF2L0c1MHl2RlJaeTFDU1ZYU2w1?=
 =?utf-8?B?dzNudWJwdlJ1S1dUUFdCeUZwRTQyTjRNNHpOeTlmU1kxcHY0ZTlaUU82bFJ0?=
 =?utf-8?B?SndVWHptVEhONy9oeFpmS0FWQU1Oa3E3T09HdDBQOGhKaUNDaHo4azROVlZF?=
 =?utf-8?B?RFBoMzJ6WmxDZU92L0loVVdlTTc0bk1GOHJTSWZRWEdYdUVkU2ozeVRJbzlz?=
 =?utf-8?B?Q2IyYzIxOVVoSnBMUjNWT3FaYkVEdXBsOXFOTWhtKzVWRkdoay9NNlRDa3ZD?=
 =?utf-8?B?dHdBUDhXdEF4QU8wNGc5aGVDTUFxQ052Wm9JWHFXVTY1K2VtNWRaR1BrV0xW?=
 =?utf-8?B?VldtQ0FPMk5JOFlUN0MySkRNL25vWkJZclNobE55NUkwTWdzRTUwZk8xblBY?=
 =?utf-8?B?MkRoQXhnMElTcTl0V0llQVo5TWc1NTA0Tmw2TDIydlJxQTF3WjR3Ym9Bb2I1?=
 =?utf-8?B?Q3IxS3VhQjluY2ViVlVLZnFremFsSys3bGVoZ2FuWnI1NWRVSTUxUUx2dEM4?=
 =?utf-8?B?Y1VRT3ltMUdiWGFQSGFCNXRHUkRMTW5lZjY3UExMUWNGMG82dEVobVBCWDFB?=
 =?utf-8?B?NmplYmFGVHp6Q1J5OExnci9mM3VQZy9OeGFjK3lHdkN0VkFpNTJXOW9KY3gr?=
 =?utf-8?B?b3BVMEIyYVN6RTBoVXhLYjJOT3RvRXhGNGxVcFR3WkNkL25mYWtHd3pDZ041?=
 =?utf-8?B?Y1VPbzhnaXBlUkNqc2NaVmdWUHhVUlBzdmxwWlZlMHlxNXI4ME4xTWFxUjg5?=
 =?utf-8?B?K2s4L2c4d0gyUHR0L2ZWNWtoampDalBjU2ZSTmc2U1VvSEpoTGdXSkIxditT?=
 =?utf-8?B?Unp5eGFMN1YyazR3TGIybW1aVE1ER2EranBOY3k4eXFuVm1KbUEwaGcwNGZL?=
 =?utf-8?B?cmNZek9IejhzWkR6LzFOcXoxYUNlTGlrM2lZSm5NL2xRTitLMVNCdmhBUk0y?=
 =?utf-8?B?dnBVdVZpVzRLeisvN0JrRDNGY1c5ZEtvZWpjWXh6ckRRMS9LY1RzS0UvaEd5?=
 =?utf-8?B?RFgxelBKQm1kbUZ6NzlpVTFJNGU0ajBOeUNSK1hCWVpZdGJ2SHFMZklIeTM1?=
 =?utf-8?B?emk2SkNBektKbDdvWTZTMW9tRlRGUDVlQ2JVaU9nTXk2ajFiL3pPak5QcHZT?=
 =?utf-8?B?a2YzOFpJbGw4RlppejJ2MHprbzJJeGJ3QWdteXFkcC96Z1dJWHlxRTM1bGVt?=
 =?utf-8?B?REdUYmIxejJBZHRXaThBWTFCM2FrTFJGek5uNVprV2tZTFFENGswU1l5Uk5F?=
 =?utf-8?B?b3R2Uit5eklhcHR5NTVOdG1VMlNmeTNqNkhGZ3hvdndJWW5nNktiVkd1UHhN?=
 =?utf-8?B?amx1WmpMcVBRYjdCb0NHWnFsL0R3UmRnZEdrK0lHQnh5Y3p2OXBZZUhEUkVT?=
 =?utf-8?B?NEdmK3JzMDd0eXVLUnowcHlXQk94MEJzMWdZN2NOQ09FTGJmU1pwdjRyVThu?=
 =?utf-8?B?UzI2Qk0zL01Vclg4M2d4ak5rVTV5cVcyeVRZQ28yNDYvdGJVL21kbEtvNHZE?=
 =?utf-8?B?dFFKNUY5T1p1K3ROVkVYZzRyM3J6OFU2R2dTQUl0UUdNcDQzajdXN1pQbVJo?=
 =?utf-8?B?VjBCV01jeHcrWUdyeVdFZS91b2lPd05Nb0E3UmdEMC9DVWpoSWtEbStyNjBD?=
 =?utf-8?B?VUpVRjBXM0VoU0pGQTVIajEwMkF2cWlVTkdNbWJ4YlBoSzI0SnJUTEFrVit6?=
 =?utf-8?B?S2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2fe8cf-5324-4a6c-98ed-08db5ad6807b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 15:09:13.0924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/DAut7i3Hijjs9bgwCaDG53fGqFxf0KML/oIFXajKxP/3knGg2V7WdM2xO9yBGrNvnfg/qTkMm1tWOnxZebdhHli4Uv6IuFiOM8peJ5vjk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5407
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 22 May 2023 15:09:20 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14796

Dear subscribers,

we found the following behavior after using MIRRORS together with 
DownloadfileName.

If you set a MIRROR the replaced URL will contain the downloadfilename 
instead of original filename.

E.g.

SRC_URI = 
"https://somewhere.org/example-1.0.0.tgz;downloadfilename=some-example-1.0.0.tgz"

MIRROR = "https://.*/.*", "https://somemirror/.*"

Will try to download

"https://somemirror/some-example-1.0.0.tgz;downloadfilename=some-example-1.0.0.tgz"

instead of

"https://somemirror/example-1.0.0.tgz;downloadfilename=some-example-1.0.0.tgz"

Is this behavior expected?

Best regards,
Quirin Gylstorff
Siemens AG


