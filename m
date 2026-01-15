Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4823DD44C5A
	for <webhook@archiver.kernel.org>; Thu, 15 Jan 2026 14:38:04 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.55])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.37161.1768487882971564882
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 15 Jan 2026 06:38:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=R4tYbLxp;
 spf=pass (domain: cherry.de, ip: 40.107.130.55, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DSg8QsFDoWH2fwPCdsiX4OrBiG9sg9dDjhhwRmypfoCqeJZyBJMBGJUT8Vx3wK+SVQUgAwocaLy6yyUXeAiO8RFMnOoNzMqor8CSjTP43vTU2ZvwJjRaUZOc1GcU83+Rc/t9VcFWEGlZ6hUEPh1mBZOeZ09xxaKs4xFzA4ShdIA98xBc9IuYwarB/vaLftmqD9IKUayI5z2ZvfDxMRqFgvMkSGh0StwUWvXW0M1K5Rq9VjMtUHZSz8DQAJjO4xjeJcJPo96JuMX2jdTk4aseVSZScgYznV07xzi5wwI9GfcX6fC266oXYDV3jD1qmxCXrMfwfOtuWf3FaVH7r+TcEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBfJXSzbj7QrOzVwyTjtcolmwDkgvLhf+VpEWb7zYAo=;
 b=OWe7QvzkKg8bnkeVRg2Enu0y4iTj6sIkXUL3ciOKZ+H2KFHMOGdkAEG1FJGRUCuscemAhfjIBQJxMi/7h95h7RVLNSSXkeAuDaKecmkgVBJ0m7+pHjB2I7oy+ypgPAQwk7smbFBze8shU8SXgBOt4dhrv+BmtbXhUEiSHrT7k2L1eIVi34oMKy3gUc9gtiE7hwZlU6wWdZXCkvFn80WshddmbHL9ZG/waoajQ8aqLNlEYAB+kQ7nuzJNOeVtoHAVwTXQz36eTHkihip60EN9u2xhR+pU0OZ56D5AILAcdOYctjjFtZuotbyGn2tLZ1D8ZmUA97k+eI0Pt+ADZrj5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBfJXSzbj7QrOzVwyTjtcolmwDkgvLhf+VpEWb7zYAo=;
 b=R4tYbLxpZSiJcpPbGr5M9zBQVKgI+G6xALs8V5qwaso7sk/o6SwrxW3P2XoK/MYPT9upTMAc8ETXsxrTM9/f+jI5t3DlBpmI1XdqX4QmRKhxkGQbjQeFjH5cCDVxdhIi37z09ohrxVcZb/A9qWqpgefe5gjyUKDWmY1MaDrFqcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by PA6PR04MB11778.eurprd04.prod.outlook.com (2603:10a6:102:525::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 14:37:59 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 14:37:59 +0000
Message-ID: <2623916e-0753-445d-9e1c-074680963ae5@cherry.de>
Date: Thu, 15 Jan 2026 15:37:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [docs] [PATCH] doc: use "+=" for BBFILE* assignments in
 layer.conf example
To: rpjday@crashcourse.ca, YP docs mailing list <docs@lists.yoctoproject.org>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
References: <2e02ce72-29bb-272c-fece-49be130611aa@crashcourse.ca>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <2e02ce72-29bb-272c-fece-49be130611aa@crashcourse.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::15) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|PA6PR04MB11778:EE_
X-MS-Office365-Filtering-Correlation-Id: 9544a3ca-7d51-441b-87e8-08de5443add2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eGVSRzdsdlhRWW43VjZ5UGZWRTROZGVKenMzVUFrMGhZZ2JUbWdKUy84dGRC?=
 =?utf-8?B?T1g1OERPU2FnZmVnRE5RcUJzK0Jxb3o4MEVYL1BlM3BzbXV1UCs2VCtKR2xr?=
 =?utf-8?B?dXh3NzhvRWVKSkxqUWM0cGlVcXc1VXhSSTRSc1dSV2RGaFBVdGVzS2dKNjRU?=
 =?utf-8?B?RE15UitsamN6dFNLZGNMSW9xcFg0VWkrN3NlQ1EwSkJCYkk2dG5uSU5wUFJ3?=
 =?utf-8?B?dFA2eUN4eVRwZFFDT0pqVitRS3pxQkwyNUQ2UVNuTEYvblcxQUpzbzRIaklQ?=
 =?utf-8?B?UytPaGJiL1U3NzlENXpxQkRRNTQzVk9YTy80dlV5ZmZtZ3ZrVFJRWGZvMVpa?=
 =?utf-8?B?Z0RRcXQ1aGFwUWsrNkpZdDR0NE9JaTV3Zi83QmMxVUY0cDFLU2dEaUQrZ0xz?=
 =?utf-8?B?MFdSb3RBenNJd0h6ZzFNUkNuNEY3YmUxeFFIWUdnRjlQRC9KdDF4SnFkUkgw?=
 =?utf-8?B?b3NPcVRNN3ZNWVFZRytSdExRU1N5M0NtaFpNS2tHQ0dacFlYQS9XcmdGcFQ4?=
 =?utf-8?B?emlWeEMxTTZrWkVEQ1plYzd4Q3hpbnFoU21GV05HVzZIRWo2NGJhOWhaK3ZE?=
 =?utf-8?B?czQ1ZUFRaWRqd3NHMFMvTmEvQm91Uk0wYTFTaWpONGl0MGh6OFJrVnBNNGlD?=
 =?utf-8?B?NEx2czBTVUtEcUg1cVZlZzZFZUN5VDB0NUhsaDhBTWhkM2lMalRZd1lWa05n?=
 =?utf-8?B?UXI2ZE5UdnUvMmVUTXJjVEpqb010dlJJT0o1STRNK3pyQytJOG9zMCs2eVla?=
 =?utf-8?B?RXlZdWlkYnJQNkRBZzlkSFh1Tkt0RCtNeS9xdnZTOGJ2K1VXeEVKTU9QRVhp?=
 =?utf-8?B?aVJDc3hLV2ZPbDhhMTIzVWMyVlU1QUU1OGFuUVJGOWpCeHJVcUE4MTFqU2Fx?=
 =?utf-8?B?S0lBd1dPemtJUGRwVGI3Ums2c0krenBuTndDaVI3VjlGUVhHdm5nRkpBUzN4?=
 =?utf-8?B?Sms2TVlnaWNwRTRUUFVYUzJFSCt2Nyt3MW54VTZKMW04ek9MUWRyMS9CY3lF?=
 =?utf-8?B?RitqQkpUQlQxSDJnNTlYYjZYc3ZwYlRIODB6QUFDOVpWbXF4THpjS0ZzWHlq?=
 =?utf-8?B?bkRkOStlZWtPQzBwdUpWS1hPdHJYNlVQOXFpLy9OditJSHRnd3N6am8xVDBO?=
 =?utf-8?B?ekdiclJGc2RDL0I2MU1VSmNDcGZSaElvK3RUdnVRUHRjWWNCMy9jT0FJVnpX?=
 =?utf-8?B?L3J6YXdEZkp6UHU3Q1k2aWt5Wi8rdWxsRVNNb2RDK09wZDcxNCtRTGFjaHNM?=
 =?utf-8?B?YlZXc3doWVJ4dHdUTVdibXM3WFp6R3JCMUcyZFd0MU1Gc3hKbkVCeVpZOFRT?=
 =?utf-8?B?aTNBdXFuOHFRTTlvOFU1Y0FwM3hDamE0SUdiOHNJakZ1OWZxQnl2ZVZya1Jy?=
 =?utf-8?B?Rnp1LzZTV0xJSFF1QTVIZ1NGN1J2K1lxK28zUjNLdlR1cmR6VHZRZmsxZWhs?=
 =?utf-8?B?ODdXNlZmQ3VwRkhlaC9sZVFLSVpVQ2tzU002SXlZVHNUSXpjMUxSRldjNWt4?=
 =?utf-8?B?Y2tmZ2NSRUZwV282TmNLUTRFVFg4VGwzQ2c2MzJ4aHpvbGV6Tm12SWh2UlJv?=
 =?utf-8?B?bUZrQzlkTThmeVhCaDgxTVhlbHRWSnl3WkNZN3NsbnYwY1BkcFNvb0d1Snhj?=
 =?utf-8?B?QjdEcjFCNGplNndSdlpTOTZuSjBZRHBHeXd5ZFN3R1IxOWhpYTg3U0VmVFc3?=
 =?utf-8?B?U1BWZEhkcUMrNUlrc0NuVnJNUWF6MVpQWmFWcXQvMklJVE1BYi9vV2p1cFJZ?=
 =?utf-8?B?L0dFYTdpb0tCZzAvS2Q3TUYzTmMzWDBFN0Fqc0JGcXQ2d25ieFFlcElVMlBC?=
 =?utf-8?B?N3dsTGYvZmlXZ3pXQ1NJdXhGYzJSR2VLMytqdnp4SDZiWWw0aytPYVBNNGdS?=
 =?utf-8?B?NlgxRFU4ZVZmaHU1S0NuZVZRbzNid25sOVpxeFkyd0FZVldpaHd2endodlpl?=
 =?utf-8?B?Z1RnU25hWmhDQUF2ZGUwWDlTRUN5b09EbHo5QmV0aW5JN3lkTnVrWm81OWZD?=
 =?utf-8?B?djFhRGhUd0dTbDN6SHRjY0RKK2dxVXJvRDlPVjU5RHRuY3FFNlBoR2toZnZn?=
 =?utf-8?B?TXppNm05L0hocVc2QjZyQmVyVnNCNisyMnBTUVRSMFBOOGgrMi9tVEpXMnJ3?=
 =?utf-8?Q?+hBs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WkI2NVhCRDNwMGU5c3JkeHcvbVdCZGNGcVdvdEFka0RGTWdVWG1vK2JIY3NP?=
 =?utf-8?B?SlpmQkhtcmR2cXh0UFdycmJKMm9lTDBSaGdqOThOVkVrSFgyVGh6TGh1VUly?=
 =?utf-8?B?YkUyNWl5eC85QTk4dWdxWDBxcm9zeXFpN0tBOUJ4WHF5ZzZheW1xQ2swSnda?=
 =?utf-8?B?MWpXR2xaUjNGa3hSU3owc0N0T0NaaVk4TzJFRkNCa3FlcVltUlRaWUtoYTBX?=
 =?utf-8?B?dk82TVl6MkpRbWp3MDltL3FjYWE4OWFuMVlzWHRmZ1FScVhDZEFsWElldVlP?=
 =?utf-8?B?NmU2bUFWWm1ONUZock9MY2lQVjZHdzA2SE1qTS9Wb25zNmFQdUtXb2NIaHMv?=
 =?utf-8?B?NU85cGd5V2Z3eGdqVnBRUnFJK3J2SnpMQmdLclR5cEIzNC9qWnBrZlZralM2?=
 =?utf-8?B?dkZoSUhJd2c2enRkZU9sS0RZQ2t4Y2dHdDcweWJsVkY3MHpyNXlHL3ZtYlRX?=
 =?utf-8?B?Wklub1hxVjZzQ2JTVDFyY0YrbTZ6YjlmZUkvUkx3aWZiM0thbFRZTnhXMjBo?=
 =?utf-8?B?SjA0ZDQralJkY1laRC9sNC81ZEdvUERlclhGV05MM292YWNSbnNjdUtoYU15?=
 =?utf-8?B?azJPYjNBbnVuMFNLeGEzTnVab0tic1FWazRNTmJ2ZVBkUElXeGRzS0RtWDN0?=
 =?utf-8?B?UzUzUnZmNG9DSWZleDJOeDB3YlN4bzV0dFpOV04xUyt5TWdqK0E3QktUbWwx?=
 =?utf-8?B?R0lhcE5EeExDNGlpdXU2dEU3bGNlYmJuQUt6RzBYZVhuTko2TUFxUndPTFcv?=
 =?utf-8?B?Tkk2WTY1MWxpUzZ4VHlheGR0RS9nak1JclJNSW5MSkhxZWovUGo2OVBTalBv?=
 =?utf-8?B?N0JWSWkzOGFxRXdIZEZVOWVQZ2JvSXdRdUdMM1dkbnAzeUhxV1JtbVhRNGFp?=
 =?utf-8?B?a2JhM0FwNzkwKzFwUW9nRVZiK3VVSmI1a05wQlMyeTZxNzZvR05HbE9kNnVy?=
 =?utf-8?B?NmNrdEVYbkdWaXlmM2tGZHBRRS9Ra2g0SXM5NC9jM09JTFBRZDZ5Qm1NMW1D?=
 =?utf-8?B?a0dWZW9FbGlaT2pvYStsajRtNHIvMkgxTkk5R2JEdjB5dE9mY2JVL0xFaHlM?=
 =?utf-8?B?ZHRFck1WaTdSTnlrYk1VOWJBVlZST1dWRjk1WHV6V0JmVStUMlJXdDVaUXht?=
 =?utf-8?B?RDAyWDE5bmJHaUVVOGRvejJUaXovMFR3cDZXVWRXa2QxeE8zVnAvdmsxaXFi?=
 =?utf-8?B?ZmIyWmhZdnc5eTVncUpXWVZEVjJDcE1VQVlsUW5GYUNJL093dVhaS3lnejVM?=
 =?utf-8?B?Q0NkYVVhRnFJS2JuK1dlNUdLbDMrOWtBbFEyeFdnMG5zWGc5a0tPMHFtSnJ4?=
 =?utf-8?B?NVFQc0NMVlV2QWhvOGdIMHZ0enkzODRrVHlDWEpOSnI1YWFGSllpVzJSUGhR?=
 =?utf-8?B?OERVdmJjbVZaaVptSXNoRUowaHVNZFpmUldkL21kQzMyRzM5THJvbzBwTHJJ?=
 =?utf-8?B?NWZNdmw0d1UrL0lTcUgxU044d2ZQZlQwR0ZqcEw0UUtCNXZsTDU5Mnp4dUJr?=
 =?utf-8?B?REVxeGFGRFhoREJBS0xmSUtjRy9hVnIvUmNBRHRIN2VoYkRKMHY3dlZnR1l2?=
 =?utf-8?B?aWlXdHBnV0t1WDBsZ0Rubk9XTmN5cmE0RHczRlV0Mjd4cXg2K2l3aFRpK3kz?=
 =?utf-8?B?UXI2b3pORG1GeEZBRC9kY2EvNVNiRDl6cVN3QkMxeUVFNjI1ak1ybEZnakpM?=
 =?utf-8?B?aTZTWFVBdWhJQlIrUHd6S2VyYVdsenZTVHYvTmVzbjZ0TmhnTFBWVUN1YjJV?=
 =?utf-8?B?M3Bjcll0T1lwd2Q2OFU5OWlWRjc4VUdlREFhVkE5eVJPZHJTaGU4d3FkRWhX?=
 =?utf-8?B?aWlUcGZ2a0xVT0lzZ0RkdEEySTFXTDdzOVhUZ21CYm1DeGxudHAwZzhPTXpO?=
 =?utf-8?B?dTNobXNHMGVLSmQwMWhSM0tMc2VpOUs1ckVES25iTm1ubmpwbEN1N3VrUlly?=
 =?utf-8?B?YkZPcUw0Ykh3RVZZdFZEMDVGRnl4T1JzL1FhNzA3K3JtZTUvYkFXWkpHOG5P?=
 =?utf-8?B?WFpWSWVzSHNidVA5dVVTVnpLamp0QkVYN243RnZtMG91VG1XU1hrL2wwMkda?=
 =?utf-8?B?WjAwSEFEcW5SUGFOYmRWMkoyTFgzSkF4cTYxSVUweHA0TG1ramZORnhqNlBm?=
 =?utf-8?B?azhxOUg3dWZUQmpFZ2ZHdUcyUU9UREdOS3gyMFNWYUd0TlFEQ25nU0s2UGd1?=
 =?utf-8?B?bnlUWlRPS3ZqR3kwUVcvR3ZwNnNNeGE1VUlSRXRYUGpTbkZBYk9BUVlIcE9n?=
 =?utf-8?B?dG5ZUVpsTER4cU8wLzFDM0dMUytMaWdLbCswZEVObmQ3THZDNFVVaU9EdVVa?=
 =?utf-8?B?UmwzeFhvdFR5YS8xVVhRdE5iM2ZKYTBCUE83ak1OcGNzRFdRVjE2UT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9544a3ca-7d51-441b-87e8-08de5443add2
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 14:37:59.0409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9U6HqBRYrqle03dutUrw1B5Ayh7DrrdPbplB0Umnudr68B9n0QSSwAKuAA6yJtGFqHnP89y1ZNN0b84j+XO3FNQkfU4pSWWa7oOERXIRG7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11778
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 15 Jan 2026 14:38:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18780

Hi Robert,

On 1/15/26 10:11 AM, Robert P. J. Day via lists.yoctoproject.org wrote:
> 
> In a layer.conf file, assignments to BBFILES and BBFILE_COLLECTIONS
> should use "+=", not just "=".  Even though this is just an example,
> it should still be correct.
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin

