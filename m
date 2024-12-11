Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36483E77180
	for <webhook@archiver.kernel.org>; Wed, 11 Dec 2024 03:26:12 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.2759.1733887564653321716
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 10 Dec 2024 19:26:04 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=2075e525ca=qi.chen@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BB3Iv1x029358
	for <bitbake-devel@lists.openembedded.org>; Wed, 11 Dec 2024 03:26:04 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx4xbp5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 11 Dec 2024 03:26:03 +0000 (GMT)
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4BB3Q32r008496;
	Wed, 11 Dec 2024 03:26:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2041.outbound.protection.outlook.com [104.47.58.41])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43cx4xbp5v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 11 Dec 2024 03:26:03 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RxxCglBoY4IUpqs/UKOcx2FQWSBdir5cMX4Uk2pLqmIBazKY7osxTncpKBcYSncCNrIKSZdwt1FNJAn8bHAOpACjT/wKtJd44Fg37iDuoBgQuHrz2An5OGEteYNute5O2nZjU+DnZOKXgkDB/iPdXHiBJmYQh4ff9b095gmk14UGzgLqXiz8FoB4a/xnj5jgJLuYtrzad8+o7TcuCTkv4/yr95YNmr+gLSGLlgCpCFFIHN1oLYGpusS5lJ11C56gMEMNjC4HNYQ8uns5/VSjyJhO1POfMcvdxLAlUgRBqGU7xM4Wr5xFM26xIud1dFSIBdKLDYpj4+NuyBJ0uEltCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kmfULBIB8/8RZzkJXQmzCaVk4Ky8/x6Txaofe5L5VSg=;
 b=YC8prNZjL1IZOspVdn9Q27ervhIJ+jelbDrixqxN5jNbFUsQkCQks7w17jNj0rMUdbeoDLRWxcMUBr+NUntwFVB6cwNGTa+ebGkopXRIZZmE0h7jeNJWMZjJhNmlw1ikS+xN5a1pQN5SzfhIwJq/CorVGNvLfb4/7Hm/JPbC3+62yT6LRLv/qMKKCZydgKilufpEa9sUCqvwy86Md5Y7OyPWInRRCz8euuNqSepSGwuf+NQw/9knxcvlOoEWLWdxyJTxFYxbh1dMHyMpt6E67vAJjj7A86RHpA+4PGl6FLjtcGawvEahmhybxu2DLgduSmYsbSr/GQW4KUrtEmXBCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by SA2PR11MB4908.namprd11.prod.outlook.com (2603:10b6:806:112::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.21; Wed, 11 Dec
 2024 03:25:59 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::a7e3:721d:9cec:6093%4]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 03:25:58 +0000
Message-ID: <dc3d3598-1efe-446a-bee9-81af6e934b74@windriver.com>
Date: Wed, 11 Dec 2024 11:25:53 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [scarthgap][2.8][ 2/2] siggen: Fix rare
 file-checksum hash issue
To: alban.bedel@aerq.com, bitbake-devel@lists.openembedded.org
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <20241015114515.1331555-1-alban.bedel@aerq.com>
 <20241015114515.1331555-3-alban.bedel@aerq.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <20241015114515.1331555-3-alban.bedel@aerq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0128.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::20) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|SA2PR11MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: cb058ba7-84d2-489f-f49c-08dd19938782
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aXh1N2FHRHY3N3J4eHZaMW90VlhvUWFpaEdWaVR5TEVCcXBobVRGS0NIYUFD?=
 =?utf-8?B?L2x4UXJMaW94NW1EUGU0OWVHNDltVFd0UzhaZHRHdzJsOVoyWmhKMnJiV0l0?=
 =?utf-8?B?RnVDNi9qRzJOUzNHS2FWY2x2cTUxSDg5V0xNTjZQa2hWOFEwc29KTm44Zm9R?=
 =?utf-8?B?K21WTWwveGNCcmJFZXp4aG5ycVNiODFpZnFQUEYwRzBUMlE1OGVpVEF1b1or?=
 =?utf-8?B?c3hJbTdDR3h2T3hJRUE2ME0wSkc3eUk4bmE1anAvdUxkWFowQ3luOERMOHUy?=
 =?utf-8?B?NW5PZ01IRWxWanFKWjUwRFlLN2RzR0Z0Uzl2MHp5TkhVZittOUxjYTBZc2NY?=
 =?utf-8?B?RFlHSjQyZFBLS213NTc3eitSUFk4OXdncmRoQnFra25oQWo2T1RUS0UwTlor?=
 =?utf-8?B?VTRhdHdib2FEdU85VVdCbCtrOEhvUndKMVdoZ01raDMvSFUxMlJYemVhbjA5?=
 =?utf-8?B?K1BZS2dTOGxaai9rcVRqZDdHNUtnRkpLYVhNTStWaE1CYVdKMTI5anh3SVhJ?=
 =?utf-8?B?d3hDOW5qUGN0ZTdFKzFvNnA1bmR3dW5pQnFZNXNuUFRIcGVuK05nb3pKSmJL?=
 =?utf-8?B?S2w5bG9IZWhRYUxKbWFNcWcyK0o4VXFVVGo3TjI0NlMyc1VtSFF1dUZxOVRC?=
 =?utf-8?B?MURWeFVwWDA5TnZiTi9mRzVJMUJUVHdJNWJ3QzhmaStORzQvLzZoajhRd3By?=
 =?utf-8?B?UWJ2dE9peE1TUER1elg3VGh4RFo3bmxGRVJ5OXA3NXVUR2x4YVd2VDc2MDhK?=
 =?utf-8?B?RFc1QWhuM3ZOUldXVnpja0t2NGY3VVJzVHNsUFByT05VNlhnYVFoY2hFUDZ2?=
 =?utf-8?B?RzVqYjNRVC8rdXBRdTNxWTVGaXdIbTNYdVFUVW9hbjZ0cFdxVWxEMklJeDQ5?=
 =?utf-8?B?UXJzanNPNzJ2TGtYR21KdU05Njg2QVkxSjdwUzRPU1ZUQS9Hemw4SGpiYTFk?=
 =?utf-8?B?Z0tMazdHeE91bk90cDZDdmRjUEFkVXdUM05OdThRK3Fkc1NabnkyQ0pPOUxH?=
 =?utf-8?B?QlRpSTNKYmRwdDl0SnVqbWpCd3U0ak5Sc1BrbWpCSWQvYkJoaXJsQStteDRR?=
 =?utf-8?B?WVVSMkg2OUY4cy9pM1paQVczL0hXK1V2amxoNUVCTEtEU1AvbmNKRDQzbjE2?=
 =?utf-8?B?cDZSdE4yR1RpcVpKSitIdEVFRUxRWHFnQzl1QkowbjBhMlZMVS9TTVBnV0Y1?=
 =?utf-8?B?R2wzZ0dSYUs1OXlrV3kveUI1eExWaFBjbmN2V2ZjRnNqbTY4WnJ3Qk9JMTdF?=
 =?utf-8?B?cHROVUpFVjNpKzNjNlBEcDUrSUI5Q2RacWREYzB0aTViK3QrekdsSlZweWZS?=
 =?utf-8?B?enNlWVNTVkhaanExenNqSmpUazB0blBxVlJ0Z1h1bWhFQ1NvaCtCWmNyS1lV?=
 =?utf-8?B?OUxpbWk1QjFKbkxoSFI0N2RRcVpnOVRFdHgrK1VtdEl5N0lJWlNNMkNNUm5B?=
 =?utf-8?B?NE5Ca2RwNktRM0ttd243bFNrMnFSd0NDWjJjTVYxYUFFR3NBRzJ2MnpzUHNn?=
 =?utf-8?B?Sk1XV2xnUHFJakZrUTROazY0ci9kS3JNME5GUWtGSlFvZld1dHN6Z3VCbGth?=
 =?utf-8?B?MmljKzhDM0dvNmh3T2dMMUNrYUdPbkpXYkNhc2xLUDBRQjFKQlpOVDg4bC8x?=
 =?utf-8?B?MS91cVUzemtEZVVjSEJuWXU5cVJkK1MrdjBVM0lPY3RKcElPY2xIYjd1TE5U?=
 =?utf-8?B?SkNBeEFZemNpb2xabkZVVklvTDBNV3Zqd2pRSmVsc0pBRHRyV3JidmJpK05j?=
 =?utf-8?B?alAxcjFWZnI4S2ZDSXIrb21hRnB0eFJ3TWZldi9VQ0oyVWtjbVVXZUZacEt1?=
 =?utf-8?Q?bPAUMwo66LE4/+i/6unM89KOPTmsQ+Fe7szoU=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RjRaSWFTVG1acElxV3Z2SG41RXdOOGhhVGJzUjZvckFibWJYOGJGT3dKZDA0?=
 =?utf-8?B?QkV2cWIrbjBzWVRPWHRKWmkrdEUzT2RObnNreGYrNm9QSEVCc3FMSHRjQVZ1?=
 =?utf-8?B?blpWY1R6bmJEY3h6Qml5cGxsNHJIMHJrTzlGSXZwdHE2azZ3N0dCbUtCUVZj?=
 =?utf-8?B?ZmVMNVJQc3Fvbk9IQ2kzZ29FeGN2Zm1OOEZscVZjYnpYd2pxZ3BJOEJtSUtQ?=
 =?utf-8?B?OW9BYmc5M1RSYWczVlVJenlWMkFjS09rV2VZby9STHJRV2Vwb0hXQ2lHam9W?=
 =?utf-8?B?RXozbG9Mckk3bVdjYThPZ3ZhK3c0SVRpelFPZlVMNWU3NVNLeWUvWVoyM2J4?=
 =?utf-8?B?Sk9nTkFXSzdHRG5YcnVnanhXSEs1Mzd2YkF0YVA2QTBhUE4xeFlLWldPVGtN?=
 =?utf-8?B?aVpNOEorbVRjMU9IWll6blovb05xc2xTL0NwVHRYa3VQRjVaTHZHbm9hZ3Qy?=
 =?utf-8?B?L2wrTUhqaEVPTWRWdTM3UlZFb1ZQZm1heGplY21naGpMaGE4Tk9QVEFTeWVM?=
 =?utf-8?B?Mzd6eGpHaHNVeE5HcHlIZnJOTWdOaFpqMVVkMFF2ME14Q2l1d2hqb0loMUdk?=
 =?utf-8?B?RlVUYURYbWV1MENNSkdwZGltTlJ1bmlMZWgrSDYxKzFUWTZDVzV6b09OVzdU?=
 =?utf-8?B?T2NtR2hvR3FWMk9QaEl4VVEzTjVCSW9yTThCTUZwU0Y1SHM2TGkzZmpVdGRC?=
 =?utf-8?B?K05ZQnZrU2pLbUpwTTJ1UEJ4Si9kYUJGUXlLaDZ2OGlWMG5lWW1md1hTdlQ1?=
 =?utf-8?B?Yko3b1VSTktTSGxkQk15Q0c5MFZxNzNFZEhvKzlRQTJ3WmROVzlidW53czdw?=
 =?utf-8?B?MFFWZGZPR0JaNnBkUEtjRWJGdFpTQlduYkRqeEVKWlNSM3Z4OWFqN0RuYUVX?=
 =?utf-8?B?SXFRY0lQdjJNMDRxOStEUkdRejF3ek5Xb0pzV3pVZTU3b08wbzdXTXVNWEVJ?=
 =?utf-8?B?UERkQkhlUU81N3JiYnBXaURFMUtBYnRHTWVkRVZIZzc3dlNWNTNEaU1NMGRq?=
 =?utf-8?B?bUtxV1hQUGU5SDVrb0ZLcElqaC9yMDJDOFpQblpnTWYzc3ZXaXVQQTc4R3Bj?=
 =?utf-8?B?a0hIUWdnZTZmRDV2UEFONGtPekkrSDZ2NmczNHRTcFVnQ0NVY0RCWkFrT2RJ?=
 =?utf-8?B?cjNHMzdkc3IrVWsxVUt6cVhEdnE0OXdWaG92QXgyb3BwbmJUcEcyLzV6cTVz?=
 =?utf-8?B?emJwNXVGN3JqN3RtQ0loMHZLUk1YOUdqcWVlWGljYUpYUHlrK2NET2lSVnBW?=
 =?utf-8?B?MWQ4NjNKeCtvdkJwQnVRWjdyRU4vcHgwVmRkTGJDaGQ4bjk0T1NPcjNFK3Mz?=
 =?utf-8?B?UFM5VHZkQXhvWU5WV3htMzRqdDhGOWtzSlBsSTdTcUlyZ2g2Z3hNajQzaVJU?=
 =?utf-8?B?bUQ0R1VPM2FsNklDUWhWMlAvaXdPc082QVc3MjFrdEdIakNCSmI0S2Z2Wm9J?=
 =?utf-8?B?L3d0VEN3M1BtK0xoTk9CS0h1Y051anVYSW1ILzJjUTZqL21RRlBUNk9iVXl1?=
 =?utf-8?B?TkZ5RWV6UytTdkxDQ2VWS3hCdVhTc1prSkcrcVJINHVzRGF6NE5qTjRLQWlk?=
 =?utf-8?B?WXdmREZMZWE4Qm00cWp1WGdtOGg0YS93UzNZaDdTU0NFMFFkK2kxaVBpeHFy?=
 =?utf-8?B?cmZ1VlJMdGh4SXU3TWZPVS9kVm5ObFZSdVZSenJTRHFDenhNNVpuTDk2VnBz?=
 =?utf-8?B?NkpkU1g4eXNWdUFzU0pURERHSm5kbmN6eGZaUjhpZ0JYS09UV2kzNE9wVlZ2?=
 =?utf-8?B?aGtaQnA2SnVoLzByc3dBeFl1cWFrVkdZWXp0RGhyOEd6VTB4bnY0cjVXLzcr?=
 =?utf-8?B?Q2k5ZkUxdVZXYVg4TEQ0ajZoY0VORjlTd0FFRkovNXM4SjRPaFAwNUJnZzFu?=
 =?utf-8?B?bFVOOUxZR1lsRDBhS2UyUW9lNlYreGxrUHB4SXMya05HVlNLeml6dHVOZFRw?=
 =?utf-8?B?cWFmeUYxa09HcVF3S1NRc3NJeVo1cU1MZzJvUDZNZUVZY1ZnQU90NmZBVlRU?=
 =?utf-8?B?c0ZBUE1QV3E2YXVkdFV2KzhOSHE1bHFFZWpUd3FWdnJKczFhUGdFRjJ3M0FZ?=
 =?utf-8?B?V1NVMDcydlFRaDhlLy9pblc3ZGtscTVaVWlncC9jaEh3WkxES3BNZTkxVFoy?=
 =?utf-8?Q?xhoAeDtdo2Mbd1X7JweJUvgsd?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb058ba7-84d2-489f-f49c-08dd19938782
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 03:25:58.4551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dITjEi77mYbWfqXz3l4VlbBXO/AqZKv4714SXtDag6rh1OKgSZFjJMggkuci7P8+nNpTD0ZIqJ1ru6D8i+6wuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4908
X-Proofpoint-GUID: pyGQFY-EKt60qTP5O4Y_dWOy_4u0RM3W
X-Proofpoint-ORIG-GUID: -8SX3A3RnxCCbVLUkJELaInaSFY97503
X-Authority-Analysis: v=2.4 cv=Y/UCsgeN c=1 sm=1 tr=0 ts=6759064b cx=c_pps a=OnljjeCONrlUuPUItWmgXA==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=RZcAm9yDv7YA:10 a=bRTqI5nwn0kA:10
 a=Q4-j1AaZAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=NmQ6uc3jm85YwCzI0owA:9 a=QEXdDO2ut3YA:10 a=9H3Qd4_ONW2Ztcrla5EB:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-11_02,2024-12-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 mlxscore=0 clxscore=1011 malwarescore=0 priorityscore=1501
 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=682 spamscore=0
 impostorscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2411120000 definitions=main-2412110024
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 11 Dec 2024 03:26:12 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16903

I wanted to send out a backport patch but I noticed there's already one.
Could we consider cherry-pick this patch to scarthgap?

Regards,
Qi

On 10/15/24 19:45, Alban Bedel via lists.openembedded.org wrote:
> From: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> There is a subtle issue with full pathnames being included in the
> file checksums since the sorting might be different depending upon
> how layers are being setup causing hash mismatches for recipes appeneded
> from other layers with differing directory layouts.
>
> Avoid this by filtering out to the path basename which is what is written
> into the sig data anyway later in the code.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   lib/bb/siggen.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index 65ca0811d58b..8642e07f0fa0 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -904,7 +904,7 @@ def clean_checksum_file_path(file_checksum_tuple):
>       f, cs = file_checksum_tuple
>       if "/./" in f:
>           return "./" + f.split("/./")[1]
> -    return f
> +    return os.path.basename(f)
>   
>   def dump_this_task(outfile, d):
>       import bb.parse
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#16684): https://lists.openembedded.org/g/bitbake-devel/message/16684
> Mute This Topic: https://lists.openembedded.org/mt/109020496/7304865
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [Qi.Chen@eng.windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


