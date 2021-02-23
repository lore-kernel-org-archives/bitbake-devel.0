Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.75])
 by mx.groups.io with SMTP id smtpd.web09.5110.1614050249196225631
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Feb 2021 19:17:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=hqYnWGG2;
 spf=pass (domain: windriver.com, ip: 40.107.236.75, mailfrom: qi.chen@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lff8LNffPk6RObyt97dCssrVZcs+FZy9ADLByCo7AU1xYLjLcSeCOKyU4eXAb7Ky07lkwUDYtkt0r/EQGNxyrPGpXBTdKPZgN5iM9Z3hsfMWglrpCaoN+ZQRXovUj3S2d7NbWcXn7XtJJ74/2KffaRFz788R1SfVWP+Dj+HJgypqV1vk77Kpga9GtbXAxrlWK3RSBz6IbY7Ap+bcaO4UjY4/GWsj+BbbVwCmYUFeAhN4nhkdtF24mMg/tIZrI72F0vTPdhux9oXlurJ/k0TexjkqLA2k3loR896KVJTlmP9p0k2M2uekzkdLwTcEh9VBlspMzqYZhYHxwK73KCSq7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dv/NUmKDy9nhwMSPHVJkUnxIjiBavW6c8EhJVPiGDFQ=;
 b=oRvlAWk0YGc0UtAX0G69FULL3eKXE1MiBHHlCQESV4GVmtDozEsqxnbmQy8aRzaRG7WsK6vGDk0vpN1MhNYQ1fI7vEM3csCfJWGgjn+qv5F8h2ExNvDR0Kpj03VifEjeYEAGoR1kWg9A7D6/ws9uYDQresgNSKdXrV5ABdazfvIsnKB//TEW1bjql2NN3bwVlfVQ/bFHynT0GaC8vwhAaTgrMF/cOzK1x0fmIJGtjpyLWJdObY1oTeGjpC/g2LGznXrrtAIp6yUZqAoQV1r0oAz5gRbcN0F53eaqSpr5qIAVzpQHM/R+bE1rr47Wynh6Hc1WT0VOttr3CL4B27R4TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dv/NUmKDy9nhwMSPHVJkUnxIjiBavW6c8EhJVPiGDFQ=;
 b=hqYnWGG2fkO6Z7xiioG28nIDeqeXZRJjen6W8DcV/4T21uzqAlQg4ePcsYJnB3WwfR7nz+cZy2hM09f7PwFXt9wBELh69uH/CYUCX2VQNilkSktYStGld6sf5AzAjjTiei56dELzRxZni2unQXEnANDW+seBRhRhp1oXlQXyxWQ=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BYAPR11MB3480.namprd11.prod.outlook.com (2603:10b6:a03:79::27)
 by BY5PR11MB4226.namprd11.prod.outlook.com (2603:10b6:a03:1bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 03:17:27 +0000
Received: from BYAPR11MB3480.namprd11.prod.outlook.com
 ([fe80::d9b:3f7c:136d:e60]) by BYAPR11MB3480.namprd11.prod.outlook.com
 ([fe80::d9b:3f7c:136d:e60%7]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 03:17:27 +0000
Subject: Re: [bitbake-devel] [PATCH] event.py: fix regression about INVALIDCONF
To: bitbake-devel@lists.openembedded.org
References: <1666403215D2AF83.6890@lists.openembedded.org>
From: "Chen Qi" <Qi.Chen@windriver.com>
Message-ID: <69e9fb21-53a4-9acd-dfde-a9b74426bef7@windriver.com>
Date: Tue, 23 Feb 2021 11:27:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
In-Reply-To: <1666403215D2AF83.6890@lists.openembedded.org>
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:202:16::12) To BYAPR11MB3480.namprd11.prod.outlook.com
 (2603:10b6:a03:79::27)
Return-Path: Qi.Chen@windriver.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.161] (60.247.85.82) by HK2PR02CA0128.apcprd02.prod.outlook.com (2603:1096:202:16::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 03:17:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb23c698-8716-4434-9229-08d8d7a98bb0
X-MS-TrafficTypeDiagnostic: BY5PR11MB4226:
X-Microsoft-Antispam-PRVS: 
	<BY5PR11MB4226DD641E79217166075FD0ED809@BY5PR11MB4226.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:210;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0b2Vy1sflybfEZm3hvVeASn2st5eisfW/sERMX2wdfd6+lsFqldel6liV5rW4BHj5Ldg4I59q88uEjhJXVDbTw8w44V0ZUIt4iGgYhsqsQbbuAxy8SuUP7lIokIh8JOlfTDC1KIjmBHfAaho7YbNkB4N17Av53AMn6/7sBXRuRfyMsX91RYIYbh+LeaLpI3+qYEy7iDLNa193h0TrAyDIM3g9gT1nJmYgGEUGE+tOjMjXUNJyDGHvHooi244/KXkdNBflJKByCS2uiANadrcyQ5YfdNuQeKmKcThiAbjSWt7bgzrpU/H2/w6xQrmt71QItMmREqoYjXCkChmQTHko92hwCuHpNa1AcsEbXGXYA85LBcTlGaSegNHId0wOhovppUXHy9IKq5JbAdJr4XBebwlK7hNC3ehd3Br/s7ikxRS6dDTx8RQqPbfsFpQvSWRcPCd0aayPCtSI8sAxO3aEd5SG2+PZ1q5Pwz60cVs5aDJDANAvck34zEhordpEiI4qCFFrsOMeDRXqJPHXl5AWbgtza8clFsXYymIlZxkOIhU1EKtSOdHva9qBWoU2z6ZYgARpfXjF1ikoqjUZp+OOiYLjlICpY2l4oWc52TIo6+P/XAVXAATCUKLghaGeoPw
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3480.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(366004)(376002)(39850400004)(6916009)(478600001)(186003)(16526019)(6706004)(2616005)(26005)(316002)(6666004)(31686004)(5660300002)(16576012)(4744005)(66556008)(53546011)(66946007)(8676002)(956004)(2906002)(52116002)(6486002)(86362001)(66476007)(31696002)(36756003)(8936002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?utf-8?B?c1VCZXBCdTdERXpNNlpjYUM2T0lOSnZERUpETzJVMndzNHVpRUs0K2U2aTJH?=
 =?utf-8?B?VU5Wa3hCelBtN0hNOWU0TE00UEdycTR2bXlIOTlKVG1ORUFFN0gxRHVpdWVF?=
 =?utf-8?B?dGl1QUxReVpWUFJZRWpxelBZcjJTbFQ1MUMxNmtGcGNlU2kxSU9TeW9IZ2tm?=
 =?utf-8?B?OFlGUGYvRmtiNXlYRmFpVmllWFRITWNuMXF5TCtLZzUzRGQ0eHF0Z01tczFI?=
 =?utf-8?B?M3JkemFLSmF4dkVTaEFyMGhZcjRYYXg2K2ZWWWxMclBSeHVqbzRFMFVlcVZ2?=
 =?utf-8?B?dVpFWlVZcVJjZnM3V245SXdLZnJrR0M4QlJadjUwNFF3SzA0QjdRSUVFTmFm?=
 =?utf-8?B?UDA2amFZNlVSYlRuOUNWK1NmTjZUSFVmc0JRalBzSVNKSlVSUWhQaTVRMEpk?=
 =?utf-8?B?M3lJcVluRHJSQzJaSUpLWUdueDNOb1lBMm5jRWk0MnF1d0g0U0lGWGwvWTlw?=
 =?utf-8?B?M2FOVTYxMWtkZGZkcTU4QWR3akdTYkRCYUNCT25SalBEb0w3SGt1VGVhc09o?=
 =?utf-8?B?S0t5VC8wVjM4dVl4ajVGdlU0UFd2alB6eGVvV0pHY3FvN0hNYkozbUFUTjg4?=
 =?utf-8?B?U2hRTm9HcGhEZm9yVWZzUmsxNFU2RGhYR0lDQ3NxcWx4SHE5M0pGVlUxSGhK?=
 =?utf-8?B?a2JEU1NNY3hFYWFWaThucGtmN3JnL3RZZW81T3IwUWE0Qm5yMkF0dFBIVWJ5?=
 =?utf-8?B?blVFWUtBZkhZbEJJS2F1ZnFTcVFQejZNRi81S1FTMkZhaENRSzMrVGxIR01t?=
 =?utf-8?B?TjV5QllTVlJaQ01CUEh1Q205aThSRGJjSG5DVXdWUUZSdHQxVGliTXBlTUtt?=
 =?utf-8?B?cE1FdFF4ZHpVNUpJTGlqRnE3OUcwTm5qNm45TGR3ZVRTZ1l1LzM5eHVyRjh6?=
 =?utf-8?B?d1h3T0p4QldobUVFZVRjbTgxaGdKNUFJemlBaE5hbWlVZTQ5ejdCNHhPaGsw?=
 =?utf-8?B?SHdEWVJpdWJadjZqS25EWDhnT0JLeVA4M0x6aWtRSXhYRnRMY3d6WXJWRUFO?=
 =?utf-8?B?TVBOSUZLWkF4YW1Uc0RtaTRSWFV0WTczYUl6NTkwUVdPb3FNWWhnWFhCbkZB?=
 =?utf-8?B?RTRKYlUwYXNwdllYdjlYWHJ4RmhEME9iOW1WTnZuNDUwL2JLMk1MNDZHalJG?=
 =?utf-8?B?dG83YWlFdERYTXdoMjY5SU0zYkUySm0xWkxiS052MHBQMitlVm5LWTBtU3k5?=
 =?utf-8?B?dUFFY3ZSdGg3VFlCVWVNZkN6K1AxaWkrcEU2djB5VUplUXpuZzlaT21BaGEx?=
 =?utf-8?B?ajdRQ2E5N1pHZDhrLzhNQXlhNWIwQXlwTVJBVjNBcDJPYWtOZTRtOUc3SGJK?=
 =?utf-8?B?UjhyRUR4MXRkaUloR2p0OHpQeURBSW15N0o4OU84bW5sK2x1VG9uRzU0WEs2?=
 =?utf-8?B?dFhtaUN3Q1FMZDN6R1pXdDB6Z2FSRnpyMXRHeElSR3g2enhONFBsSWNOVDR5?=
 =?utf-8?B?YnNiMHZOVTZPQmlIbll1ZldvbzFJVjcxUUJWSjVLMUsvcXQ3ak1xRnNJN04y?=
 =?utf-8?B?UVRpMnN6V2tTSTE5M3RnWW1IS2NodnEzbU5XRFpiMzJvLysvanlvRUdOcjEw?=
 =?utf-8?B?bDVvbVFDOFFOMEluT0dHU1NEY09Na0o3L2VDL1pydmVvdlFUSW5sYitUUGhE?=
 =?utf-8?B?ZzlvRUs2SHQwaU56MFdOSUhKb2doWndGbnBzVlJkUktjRm5mSDNlTWJLbGNp?=
 =?utf-8?B?WlRrS0htRmVoZXRIeVpuQStEKzFRZnpFRWRoUTZJZjlwbjF2MUZpNi82TUVv?=
 =?utf-8?Q?NysZZornhKobwKAod7nrfaygnaaC2cl/MX3Na81?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb23c698-8716-4434-9229-08d8d7a98bb0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3480.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 03:17:26.9952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUWYGPhsNPuAR63ZsPgrVhPoEaaMadKkShEb/kbSjs6nKM11cS1ORAULLEZ5ablM5xPHcrEBQ/fSLPd0ExVRwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4226
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/23/2021 10:41 AM, Chen Qi wrote:
> A previous commit uses __BBHANDLERS_MC to record all handlers, but
> it does not take into consideration of INVALIDCONF, thus causing regression.
>
> We need to record the name before returned AlreadyRegistered, otherwise, when
> reparsing due to INVALIDCONF, bascially all handlers are not called.

Please ignore this patch.

It's sent from poky repo. I'll clone a bitbake repo and send out V2.

Regards,

Chen Qi

