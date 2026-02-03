Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F945E87854
	for <webhook@archiver.kernel.org>; Tue,  3 Feb 2026 18:12:50 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.30])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.216.1770142364492272226
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 03 Feb 2026 10:12:45 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@cherry.de header.s=selector1 header.b=TOnBXCNt;
 spf=pass (domain: cherry.de, ip: 40.107.162.30, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CEi1NUlkLlGeUjcR/6FnoKTIUslfIraeGwvDmh41Y2TTQsWrYZQVTu/sKBHgEycZTpVkcCRgK/mbF/Nw000kDiSKBNQgczZICb+oCi6GXWgAW/dzTnbwfJDj7K3atqLkAU3X48CASZLn5qMkEyAEOHRBG/uUXdC1GmGiQxdXzRVU2kujaiaOus30R9KwZ4sJuiLpA76enG67ztIOdr15jGd4Bg/kh0UPoyXmtCdua7rv09xMblMhgx+8zqjnhnubVRH50XQybe99KHT+j1hDksuTedTi1hWuZlZvOJidxzIpZaLeCMBBcQ+tmpcAeO2VFzcunA2fnT8qcjD98jH4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSWVeLnLFVkhJnaVcp2DK/IxFAYKwuTFIrlLNu2NUaA=;
 b=ndh7K7KOwLbRQeuosb0XMR6RKVQwrtRL5KVbNnPAkfi8quUjKI/pcjljkR64lZPhV4PQBlrzoLQgzjqxdcjHyp5vJ+w/y5xKOf8+paUeDEbawZEUd1KbJxXLqE2MJPfaWXtCiud+IiDWQSF1E1VJ54AJEt4o4U3915knBEKWMzitJekrK6UYxNAcRW3VR3Web00TirHBtB0TAriNgi+zaGAq4NlIEs946KR4AxMdTTGKGZMeQd3undPXSnG2NRDPEdoQ7TT42KT0IZ/01yIvP3Bk6nemiT1Lxn3qK09EE0hUQzsySQysr5jrWeH9j2sFawxmpJMnVlJmFa30e5+VMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSWVeLnLFVkhJnaVcp2DK/IxFAYKwuTFIrlLNu2NUaA=;
 b=TOnBXCNt5Aoo2XyyRgwWClm/jiJMXtRtGMOMOatEJ6d+R5JmhsDb95oqC/SwwaOenge6gXIaX4aF2cBM2R6VvgOScCV47/agZxncoH+E7MBpl/N7hm4Nj79TmEdvO42jER4wMCu79Iazym4lT7S1+KoOdm7TiWwRdUofcuWX+Jc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI0PR04MB12006.eurprd04.prod.outlook.com (2603:10a6:800:312::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 18:12:39 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 18:12:39 +0000
Message-ID: <35455cbe-dfa3-4050-82d1-8c13439b0473@cherry.de>
Date: Tue, 3 Feb 2026 19:12:35 +0100
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
Cc: Antonin Godard <antonin.godard@bootlin.com>
From: Quentin Schulz <quentin.schulz@cherry.de>
Subject: Why does bitbake-setup force a machine config fragment?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::14) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI0PR04MB12006:EE_
X-MS-Office365-Filtering-Correlation-Id: 238025b6-94bc-4fa5-66cb-08de634fd06d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cVZRdTFLOFJaMEZJVTZ0bXZKN0JoNWp6ZDcvemxCb0NNVFQ1R28va1BKS2RX?=
 =?utf-8?B?REVoU2tlZnIrbXEvcjJ6ajJ4Rnl0RWljOVNCUTgrZUh6TWgzK2FMbng4c3Z4?=
 =?utf-8?B?NzZ0QWd5NHlYUDhsN3E0MWVWeENYTHFSZmhhK3grVHB2eGRBb2FHSFhBM3l5?=
 =?utf-8?B?TklxR3lWOTZWOUhUTnpnZHFCU2xOb1llbW9qSk90UjFLTTNSTmFITUd6cGZU?=
 =?utf-8?B?b2pKSmpDRUhBL3RWV1FMdWh6Tkg2aTROcWxHYUt3SUdxaG91NDkrRlpvL0p5?=
 =?utf-8?B?U2Rtb2NJOUlNcjVMelNHZ2h1RG91amlpT3NlZjRTN2VDdVIva1JuT1RVWTBa?=
 =?utf-8?B?L1hRaVlmM3NvWFVTNWJjQjZJQkIyREpiVXhaM0l0eUZvR1F2ektCTEpqVmh4?=
 =?utf-8?B?ZGRJbjdnU0pTZmErVEJIWTRoSEN3TG1RS3JnTXEzK1RPUDBHY0JVQjI3L3R4?=
 =?utf-8?B?U3RXS0ZYT1dtVnpwWXRJQ3l0MCs1aWlnaCszcnBCUWVFNFNOMjdhWEp3NVFn?=
 =?utf-8?B?SWUrL0xYSHFia1VKNnJhQkJiWTVBRVRuRkJRcUp1RDdBelh6UTFUblROeS96?=
 =?utf-8?B?WGJWYWx3UGhwME0vRUVWVmV5bHZJREdTLzU5YkMyRXA3emVKUVVhdDNNenlF?=
 =?utf-8?B?MmVURm5UYStxN0tFc2VZQ3FlVjAySGhrNEFtZEgzT1J1TVhrSUVPYnBleEx1?=
 =?utf-8?B?NURNd0t5clVZeFRlY0lrKzlWblpOYjEzZTVld2FwMmxBeHVvT01YRUo2Q08y?=
 =?utf-8?B?djJjZ0ZhVmEwam40blJtZ1lCWkdPVzllaFVPV21ML0dBZDJ5Ym94cjgxd1FC?=
 =?utf-8?B?QzdURmhIZkNSemVGbllzd1pMdnFLb1dDTTdjVnVpbTJzRFZEbEd1UWRpckhF?=
 =?utf-8?B?ZGxWWEFZZFZVMVM2SHUxejQzbEQ0Mmc4WTVQTXJaMHdJdk4yenpmb2Q5Q0c5?=
 =?utf-8?B?ZkpWd1NwYlFqVGhidERpQmhwQ0NnOUhRZzg5UEpSNy94YjQvMDhRSkU1Nndx?=
 =?utf-8?B?Q3YranhxZXZzUlRyckxVL1pjK0pxMlFES0wydHg4UkVQZDVOeWdobXpWUmph?=
 =?utf-8?B?RTJmdlpnVXBWdk9NMURTdVB2djNyTzJTOFh4a0d4WVdGc2JwM0xJZDZvcjBL?=
 =?utf-8?B?SytzalUrZnkwVnkzQUo1Z0FTS2xFVGNhbWJRZktwZnRrVk1QWU9ZSlVKT21G?=
 =?utf-8?B?UnlYWGowL05lT09uOURBYW5jRCt6SXVhdENCMkh2SGVFTWRxMXFKTFdZTzdR?=
 =?utf-8?B?dVcwZ21JMWxUcnk0N01HTUhlbkFmU2dFalRCamhNYlRBQWtlVFYzRmk4U0xD?=
 =?utf-8?B?UU53cGlRMDBkTkp2MEFoOTU1M0RxNks5bGVrZ2hVdW9FWUVlc3kwa3p4TzdD?=
 =?utf-8?B?WG5Qck5UcU9GUzZPeElublFuN2NHVnI5RlZKK1B1RDVpZ3NFU2E1VXROZVJM?=
 =?utf-8?B?UUQybVhaQytpUDBNOHBzaThlMVBOVVBZVk14bGJYekFQdktkVm1PckpkRXUz?=
 =?utf-8?B?QmNyOUUzRW8rMkJ2SkxWNkM2SkZZWjQzK3pWejl3bFpaUFZjRzJGUEhSNWVo?=
 =?utf-8?B?OTluU2Q3Sk5YUFpHdGp2OTl0WVVqdUluVFk4NER0U0sxSmF4Z3hEZUlreURS?=
 =?utf-8?B?VFNiQzNFN3l0bjB5aGRFZG10ckpGUkdRYmc4aVBZU09HOWVSZ0QzcjduYkQ1?=
 =?utf-8?B?d2c2U3Y3bHJrNFBrQkpQdzBnaGN2SlQ0ekNXckZPQ2dQOE1QZzI0ekpTbUtp?=
 =?utf-8?B?VFIvU1BsejJyQkpjQjU5UGtoMno5bzlCMndsVENRdzgrdmpiN1pRWFJRQkVW?=
 =?utf-8?B?RjR2U1VBekozOGY1QS9lK2pXazNTM213eWRvaU1rcXptaGFQZHppSG9Xa05F?=
 =?utf-8?B?ZUE5RjI3SUdWSGt2bURYUGZoOW9EdWVxcnhqWTU0dUtWUmdCaGU3M2trMk1G?=
 =?utf-8?B?cUY3Rzd0bC9mK3ovNVh3Wnp5NVhLVEYwemtRb09YVVZBYllYN1RQdTBpQWF4?=
 =?utf-8?B?VjZtaDM2UHZuSjRZK3VpeWRWaTVCd2lhU3lzZ0I2dFlMTmJDV1hqTXA5WXdD?=
 =?utf-8?B?Y0M3VXllQjhJdkxzT1QzNytnY2hXSHNDQitOSy8waUJxSmlWWVpma2x2YjVa?=
 =?utf-8?Q?0kTs=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GVXPR04MB12038.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L2JoZjlKU1Vrc2FHZzY0OVNqWHJJNnNzVnlMTlVaUkNkMzNlUTFYU0FvTTZU?=
 =?utf-8?B?THVOL0ZkR1lMRlBMWTZPZHR5NlRGd3BRYmZzWnJPUkNCcEgxOW5SajJ1UUtp?=
 =?utf-8?B?a2grSjZrN3R3QVY2MS9KM2xKOHBRb2t0cHVMbkVXQzg5NVFlakU1S0pvekQ0?=
 =?utf-8?B?R3A0d2FodEtWdVlwMTFmMHA5dFNlWkZma3dwMUxrM013RERpcVozTU5lSWpJ?=
 =?utf-8?B?L2EyVXRrUXJ5M3h3VDdpNjdkZ3pIM0ZYb2NsUTF6d0FoVEIzSFV6ZkNYRk5Z?=
 =?utf-8?B?WmZ4VzhHVUtCT3R0aGlqRURxVWhMQklIT1RqMTdrOEFTNml0R1N4SkppMFNK?=
 =?utf-8?B?MndVdmlaWUlVSGF2bjlKVVh0aUYvN2w5K0FjY3lkbEh0VlovdHNCQTZNcU5N?=
 =?utf-8?B?V1dudlp5TitETHFsVEZLSUlOQStZUXlnU3JFdjdOamlnV0xzN1ZyMWRKaEhp?=
 =?utf-8?B?S1RDZU5OL25FaXRTODg3ZHZFRzU4ZWVvZGl1YzNYdUduL2FiMzBLdHZ1YktW?=
 =?utf-8?B?dGU4bk56TEsxQjJLQVNJR2xWKzd6eFQzVUF1U0w0T0dCbjQ2MWVYVnVWOUFH?=
 =?utf-8?B?VmNtdkd5MkVTc3BiaFgvOGlsbTh3R3BYR0IvcnJiOWZaUTFmb0tGVVNDK1B0?=
 =?utf-8?B?RHM3WG9Gek1PZ2hmay9hVUNMNy83eHkxeVdQcXg2YlNXODM2L1dITzM1RUNk?=
 =?utf-8?B?Sk9uZzRvY3JPRzNOTG8ydk1taEcxdUl3MGhWcG9aTmt3YU43a1V2UEk4N0xI?=
 =?utf-8?B?d3p1M2xva0RtZEVGQU5XTzJqVFpFZzJtbGRZcWc4S0RadUwwSFR2U1l5OENK?=
 =?utf-8?B?VUE2NDBjeXRZaDIvWlY0QWRkTzBBTDk4b2JYY25GdTBoTDdmRFk5elhpMTJk?=
 =?utf-8?B?anZHODdPSjVoUlNWL1VBTkl1SjRwcjI4bFUwaEJjTENmMy9kbExhc1JOQTVv?=
 =?utf-8?B?aXJBQVpOUlNZRGNUYXFPblJCQTRQTERkemJoclpWbzEvMCtsdjlXOUxOS1dI?=
 =?utf-8?B?K0RuSE5EMlFaK3IxNmkwUldkZlNScnRUVmZyamUrR2FXL3pPMzlEd25LRGZC?=
 =?utf-8?B?K1c2RkJGRmtoUmtvdVlRdzR0SnNjTGl0UUFReFFKbkNkUFRTK3k5NWdOejEz?=
 =?utf-8?B?K00xRXU2bDVkNnZvc0tGa1diL0gwRlR2UDlFMmQ5WTAwOWwvU1B1NWJHZDV3?=
 =?utf-8?B?NWhtWXkvK3hWS1M1eW01THRpT0pOM21KQ3JocWN2VXFKb25DTG5aMXpSU2ZQ?=
 =?utf-8?B?NUxGZml4QXFkMlpHT3lnSGF4dElxL0VGTXVFS0NQZXdKOVZld2xiZ0tGb0xE?=
 =?utf-8?B?cWJRajlWbG8xYlBpOWVBNzUySkV6TUV4UVFvamx6c3duTFd3R0FPQlVDVE5K?=
 =?utf-8?B?UDlNaXVLT2F3Z2pCNXVSdDcvb3hPY3Z1OGdEV3dsMGFEdDBxVFdoUWlYdmdI?=
 =?utf-8?B?L0MzS0xaNkRadWdzcEVWckpVc1JScWs1amRHcEtESkVxNnpnL3IrbkcxNTd3?=
 =?utf-8?B?YkNpVmF2TGpUVVFEUnZ6bFcvVW9iS3VMRVBrbnh6a3BGYmYraE9kM1RFQ21j?=
 =?utf-8?B?UTgwSmZmMWZsN3dScTc3VCs1Y3FnUGNLQTREZEphM1hkN2UzaVk1VWRvTTZN?=
 =?utf-8?B?L0FaYzR5MUY5eDhUbGNqT2NrUmNWZWhaUDdXTVlxdXl0RmZKN2xBZHlWYXJS?=
 =?utf-8?B?L3l0bU92K1oyQ0dJSzJhZFRkZEtCN09wRGRBTFNyNENicGZNellQcjgwZjYx?=
 =?utf-8?B?SDhoSDV6alJGMGNvVlo0ODBRYjVRWUd0NVZpanV5SlczNEh6elk4emE2SVZz?=
 =?utf-8?B?QmdOcWVtaDQrcUYxQlF5QkpuTmJWL21aOG9nZTM4TTRxTmkxQmQ3amxUMmdZ?=
 =?utf-8?B?NGtCallhQzZPRy9PY3RCU0hrTXpva0JOQ3U4cTNlcnhscktMaHc5dXJVN3Fy?=
 =?utf-8?B?VWcxK2Q0ektXdDZ6KzF1T21KVHJVTWVMQmNkc3F6YkFRTUhIbzZKK0gvZ0tt?=
 =?utf-8?B?UjBlS2dwYVpWVHRoeXhQY3lPMExOTjQ3b1dva3JJdkJNYUVoWGxqMW9kaW95?=
 =?utf-8?B?dng2T3hkampDZEFONS9TbU5tNXE1ZnlPWG5mMnlHcHM3UDRlQ0lIdEtKNFFE?=
 =?utf-8?B?VnFEcUdQMjVKeFZVSUlFMkZTanhFWVRBNWd5TjFGcitjTThZNWtHVklQeW1N?=
 =?utf-8?B?MWZqbXg5M0wwWXpBZEg1WklvcXhteDRiZFRyWm01a1FlZWJkMjJ5RjhCaWxK?=
 =?utf-8?B?a1BWM2RiUmFQYVhwZWxxK2RpRnZCTHU0cHRPSm1LTTBRVDBtRHlaUWZkMEtO?=
 =?utf-8?B?cVVUbFFOZmhmY21UempIQUFYTFZWUE9TeFNrdktBSFIwdHlIRG8vOUYxSCtO?=
 =?utf-8?Q?RhYmMchb6RDZJkb8EwJtAUbu/uYFTnCfh7yIY?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 238025b6-94bc-4fa5-66cb-08de634fd06d
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 18:12:38.4612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gd6srx6Z+K2xezzjKjtNgJopW1GUJSusHLz7l7r356MXqoUIHu0s1YTdzZ9NGrxTR/uBGuoSfjILWsy2ZNRDsKPby7AW6huyAyPEtOeh2yk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12006
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 03 Feb 2026 18:12:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18944

Hi all,

I've started using bitbake-setup a while ago and I keep hitting the same 
"issue".

I follow the setup and then I want to build images for multiple machines 
from my BSP and I cannot right out of the box because we're forced to 
select a default machine and it cannot be overridden from the local 
environment. Yes, it only takes a few seconds to do the thing. But it 
*feels* "wrong".

I believe this is not great user experience as it'll lead to people 
thinking they need separate build directories for each machine they 
build for, which is definitely not the case.

Also, would anyone actually build for any of the machines specified in 
bitbake-setup? (aside from our autobuilders of course)

In short, I'm wondering if we shouldn't have an additional option in the 
list for machine targets which would be something along the lines of: 
"None: I'll set the MACHINE variable from the environment or local.conf 
myself".

Or maybe we should NOT forbid the user to pass a MACHINE env variable 
when there already is a config fragment for a MACHINE? What was the 
rationale behind this?

What do you think? I know it seemed odd to Antonin as well but maybe 
we're the only ones and we just need to adapt :)

N.B.: same remark for DISTRO (I happen to only develop BSP layers for 
now so poky as forced default DISTRO is fine but I could imagine other 
people having the same issue with this one).

Cheers,
Quentin

