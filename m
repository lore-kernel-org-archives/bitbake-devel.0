Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B82CCD19A
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 02:37:59 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7581.1763347069227747848
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 16 Nov 2025 18:37:51 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=KNNi0EKU;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=34164b58b4=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AH10WWB943608
	for <bitbake-devel@lists.openembedded.org>; Sun, 16 Nov 2025 18:37:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=Q8KjQpboeVnGN9xMwnl3F3gwYw3OJj0hD0XaExmpT6w=; b=
	KNNi0EKUB9F9LCqkitIGj50V2IQ+g8w9iYOufG76QNKTVJBi1JTj45vAmyvKMuZo
	ZTzc59NVLl4tdLQQMqV1drrCf2YqKmIbq103X7mjR6z/+Twj4i9jqDHjNociUKG/
	6437AIOgkIwS8sJ2aJN1G3HJJ1Gl/TnFwFrdVOvrKbpah5n2717KvLbJb/n9ry7O
	T0ej4qF/bf6wfuLRfsOFHj4Ovipr626SnlXgcqppVWxbFPc4SZu+9UDHSmC4H7S0
	ClKVjqHUsnmNeurJ0XY/sRXuPORHdPZ85ZeTG8u3MuD9zpp3IdSllNQFhcCuRe6D
	wOChHlQmOGejcrFFUyZ2Tg==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4aenp2sak1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 16 Nov 2025 18:37:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wG8hKjJmrajQgc/JFp7v8GghTkGXG9ZTr6iZDez8omWgolqY5IyPiCl1tvFvf3PU/eexKzXeAY+mL6mPCUKERHIU1j1MI78StcBArygRs575c4ohXjDGHafCw1aXY5htokfWHmuRoZeHVJBNrv2jf3PJ8ziAoktDweoz7Mo/Mg/3yeTXmpVwNAITs/JSvG8sa98PrmZHVUGANQkxVC6p03L6/X8RL9PGe5t4o7ql84hODDwZ+FQGo1nr+FOPM5+663YP7tN56WI7mI9wGjVodwHmvebWeZyszFqGMCa80TOS5Pym0Rql81dvebDLC4iVGdQewFcl6t0NY0en7Mn4GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8KjQpboeVnGN9xMwnl3F3gwYw3OJj0hD0XaExmpT6w=;
 b=HmKm8CwnMBXvLBTttbI2hJs2YFEIQ0uPD+kZ/EKkBNVsheH3wJk+ZSKdrpDgEOF/Wjq4YVzyLJwlFPPwQehQ56YTlZTPzf+0LTiRhFoSBvSp3OCRy05yX1PwB1oS7hYUhONwCtRENvr3fx2MLur+ZD+Kw3u0nAuiJp4RAFoHe7x+nhEfpzI1uev88X7YJzujtEPy1ta/7qif8R+B5uOkbDQ12AuHuu30oWbVMH9JatQpBJmCnHGuhXoT0ZAaZq8Osio69uhSKfGW10gtqRLl50qHGsO8Cmmdld3UFQ0Sp/F7bDb3UC7w1Wqv/kkOWrHdPLah7Hm0iRH7QCscEZ90Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by IA4PR11MB9131.namprd11.prod.outlook.com (2603:10b6:208:55c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 02:37:45 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 02:37:45 +0000
Message-ID: <a8b73202-be3c-4970-8ad6-b8e99e791a59@windriver.com>
Date: Mon, 17 Nov 2025 10:37:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH V2] lib/bb/parse/ast.py: error out for
 internal fragment in case of a previous value
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
Cc: alex.kanavin@gmail.com
References: <20251114060211.1742728-1-Qi.Chen@windriver.com>
 <1877DE8BA2A633E6.930811@lists.openembedded.org>
 <ff4f9fa86f6db5966b40c8169131c13cbf404994.camel@linuxfoundation.org>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <ff4f9fa86f6db5966b40c8169131c13cbf404994.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: TYCP301CA0090.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::17) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|IA4PR11MB9131:EE_
X-MS-Office365-Filtering-Correlation-Id: 890f23b6-a20f-4f0f-45ed-08de25824a0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OEV2UUR0RFh4MWhtSVZBRG1IOHB2eDA2dVNFV2JvUlczLzV4eXpJY2VHeHRz?=
 =?utf-8?B?ZHNBRGVTL0hlRmpDb2ZqbVV3NXI5QU1MVncrU1I5ZXdEV1ZKMk9KSjg5SE1B?=
 =?utf-8?B?eFFzeHBEalpLMklnRmhnQ2tCS2I2WmVyMmh3ZXM2QnpHWVd3K2o0VzVpbXNj?=
 =?utf-8?B?TjBwcmpBZVZCNDMzaUhaVXZIMmdkWU1CRHJCdGFQUEoxeCtpdnRxRmUyT0dB?=
 =?utf-8?B?Rm5pUlJHdDNPQjd2cHlXakNwOGFaeVVHbnVVZUZxSzRyNnBCb2F6aUhSb0hS?=
 =?utf-8?B?RS95ak1pczNSa0dkRWx3bUhvZ2RRRVc4Tk4wT2pqNzh0ZVEvYi9hdTdaa0NT?=
 =?utf-8?B?RW84TC9uSDVINlY4NUFVNGM4QWZBMzdEMU5aTXd6Vjk5S3c5UkNOZUIrdUUz?=
 =?utf-8?B?aldDejN2aDA2VTF5WmR4ZjNIdndMSGRqbGxaY25ZZGFlVVhPYWlQcUFpV01a?=
 =?utf-8?B?OTBXZXFGSW1pMFByUW1heFpFSlN4dzhiaGd0M1UvcDVSMi95Mi9oUHpIZW5B?=
 =?utf-8?B?TTFzNEowVUs5OVRHZkRjTlUwNmdnM1QvWjZqaVpTa2p6VzRBSTVpdXJCb2Q5?=
 =?utf-8?B?Rlp0aFhuUWFIOUtyVzVBZGM2bUM5Rzc5azNjaHZ2d3BTSVhhTjhwaEdIS0lU?=
 =?utf-8?B?REpjVHlqd2VBRThydko5TUEvWTBkUHZOS1dzdzBObDZsb2lXajRueEpPUVlk?=
 =?utf-8?B?dUU1cTFFU0d4T2p1TFJBUVhGNUxQUDlZeEVvVDBkVkVST2hzdDMyNmorQTNj?=
 =?utf-8?B?K2JVQTNjaGQwZmRLdC82OEF3SnU1c0pkUTJSMGpYWHdEZHNKVThadnpDOVRF?=
 =?utf-8?B?VFJiUDJRb3JrQ0U5dFpqY1Q3RGhCNXdUZkJIMDhabFpta1lGdEROYzg1NGp6?=
 =?utf-8?B?M3ZNQWV5ZDhseW8rQTBEM0tnanl5YmN2eVQ3R0kzWkZFdXo1cCtaZ2NsbEZz?=
 =?utf-8?B?L3ZwT2JCMlRGc3FhQ3NuTWRtQSs2aW4yaFNwSk02a0hhMHR5V2RvY0lvZGU4?=
 =?utf-8?B?Y1kweHA4a051WUM1RVBpWjI4K2Fua3Nab01BN3hhKzZ6dXE5cURZRUlQQWs1?=
 =?utf-8?B?OHhRVml4VmxRQVNHUG9SeHFnVlZKb1Zvd3FNSEF1RjRaWXFhcWU0bXB1Tk5t?=
 =?utf-8?B?MGg4QTZlZmRyVFF6eGpoTERoM2NWeW5GWGZaNmdTQXJRWTQ2anp1Wk9pN1Iv?=
 =?utf-8?B?RmJnZkN0UnF5eEEvYWw0SGQ3Z2xrdUlhbUZua0dhS1hudjdLTVRhU3ZxdDR3?=
 =?utf-8?B?U3NFa0pDbjVTQWgvaklxSzJjQTd1enMzSUFEYlAxaXdQUlpMK0xEZUNBeVlv?=
 =?utf-8?B?Y2dlbytDZ2lpRzdha0NVY01iMHZ6WXZqNGMxYTdRMjhjVkpHU0l6dmpSTmda?=
 =?utf-8?B?TldlajNwUVZqSGRiU09VM2VWVmd4b0Q5YXNGQnRhdFNzaE9jalFQMStHbTBa?=
 =?utf-8?B?dTlTRzZVOXlHQW1TRjVkYm9jclo4NDlZQjBIM2NuaTZ5c1pHVUU1ZGNMWDhO?=
 =?utf-8?B?bEpSQWRSdVMyM050ZktON3JzVzhCVkl4T3I5SHZmNG81dHdqOUloOXhMWE5J?=
 =?utf-8?B?bWptUUVXWEs2V1BudG8ra1k4TUpyMXRiTFZDMm0xUyt0cnN4OUF1eHM3NUNP?=
 =?utf-8?B?UHJCaFJ1OHAxRW9VcjJCWlpwb2lDenlvSW50STVnRGdnYm9YWS9oSHZDNERT?=
 =?utf-8?B?V25iOGtaZzlvU0l1SDR3NG13dEhkR3NoQmh3bVVhcS9lZG9QeFBtMWxvQkVt?=
 =?utf-8?B?cHI2OUxFdkV4dUFDeTM0L2FDK3BRQnM3Z0NGSE5nYUp2WU93YVhJdmhVRXhP?=
 =?utf-8?B?TWp0V3ZFeitQT08rVGRPdHNBNHpRd2dxMFlBQTBIMndad2trK0dOTG9lZE5O?=
 =?utf-8?B?L296TEV6a2pVdzZYdkIxTjh2eUxwU2wzbDBLYVdyaUdSem1Mb1pHdjhMcW1X?=
 =?utf-8?Q?m6Svx/08UKTl42gFXLAlWVmhcRSM123J?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YzM4czhNVnFrbXB5WmtNZEVrWU94VWhSaFgwOGFqNHlVbDdyaUVQanJleW5y?=
 =?utf-8?B?RFRtNlhHL2hEZGlDQTVuTnlKMllwZnVIZFpKMG40KzB3U3Y0S2hOdm9ZaUJD?=
 =?utf-8?B?YXUvcDhEaVRoYnVVN0UwK0hoVWY4akw0R2lKMkZSZE5wSFBVVTBpSVFvNFBD?=
 =?utf-8?B?MUVLQUVNaE96NXdrR2tvZ2o3T2p2OXNQU2FYeEx0L3g5YWhEWlhpQ3FXQ3FW?=
 =?utf-8?B?d1V1YkY5bkZVeS80Q0srL2RIZmtubm55S2pSRzFMbmZFTHBPRG1YUWEwREtB?=
 =?utf-8?B?U0s4cDJmUUxCWlFpOVdtcndVam1ENzBaeEhIVW9wNFNWUGQreXBGNWx4aUFI?=
 =?utf-8?B?dmhTL21YTWtnLzdNaER6Zmk5czNIdTVWWHdGbGxOenNQcVNxNmdDTnEvbzAv?=
 =?utf-8?B?T3lHc0ttQUg0RnRTd1VsSGlacVRMVTZrWnM0UGhHblRjOTkxemFHaGRhU1h2?=
 =?utf-8?B?K2xQZzVoS0xxS3djK3R6ajYxMmlZK3dJK05pYWNUeUVlVTU0YmxsVmw0cDlR?=
 =?utf-8?B?ZDRHUUdCd0lVMXlFbk9iTzhIUFA3Zk9CY3hUYldSc2tldFhsUERUbGlySEZD?=
 =?utf-8?B?SjcxZkRLblJlWnJEVmZ0cEtoMzBVTkJHV0VYNEdjQVdHKzJjQXg5NXlpRTB6?=
 =?utf-8?B?WnlrQllLbUdEa2ZKNEw1UVlsVEpWVWlYdlRsNm8rMlN5NVVxS0hYbVR5ZjZ4?=
 =?utf-8?B?YzBLdmRaL0lUeXJ5SFFkRFZ3YmhRMHJLdmxSNmVQWVZXU0ViQXkrdUk0WGhZ?=
 =?utf-8?B?V0k0VzZuTFpaR0tkbUlpNWtvakI3Y2RqbmpsR091NjJCWHN4VnFQRGRZZlRZ?=
 =?utf-8?B?RmVjaGRoeHpXdVNLdGNzZVg0ejVsVEIycmRFcXExRTlRVjRRNkZnNi9NTzVD?=
 =?utf-8?B?bVJXOGl3cWd3VEx0UEo1d3BpZEVncDNlNExjTWljbFRhYStUKzZjS2FzYldp?=
 =?utf-8?B?Q3ZMK3lIbmpHN3N3ZEU2aHdyOFdPa000T1R5M0RQc2hTczlSL2cwazRvTkla?=
 =?utf-8?B?VUNVbXQxK2tnbXJTWmN0RFJjWC9UNU5vVGlNRUl6MUF3VDRGU1ZJU2w3VHNi?=
 =?utf-8?B?SWpEWjF5ZzEvVk5EUFUrTE9LYnpUT0NCRnV6RVJGaG5xZk1wL2NwUXZabDZu?=
 =?utf-8?B?S3M1a1lNejRmTHVlVmlicHk3N3RKZlJxbkJYb05RL0o2d01raElyRzg0dWYy?=
 =?utf-8?B?UXAvQjFib2pKTXl0dXZ0cXdNRUFCL0pTaDBNcFZ5Y1pRN3NhcFZ2WnpMeFd5?=
 =?utf-8?B?NjY5bmg0SXlPazYyK1hyQlZ1VWlIaUwxQmFrcDhpYUFDR1V1bXlWYmxnVUpK?=
 =?utf-8?B?OVVZMFMvTmZwNWpEeWt6ajNwN2Z5L0xiTmZ3akhkK2F1NGZ3UXVWeVo2OThC?=
 =?utf-8?B?NzYrTE4wT05CM2dwdy9wU1RIRjM5cU8vYUZtYWZoNndkMlg4Q25aaXk2RU1n?=
 =?utf-8?B?VTR0OGJoZ1ZQeUNsQ2VEVWVNeFhUcnEvaXBMbFo3T2h4d0dXNnEra01QUEM1?=
 =?utf-8?B?eFFOVVBlL2dHOXB6bXlTVlB5UC9kdFoyM0dtdW9pQzFqR3Bucy96WlY2OS9u?=
 =?utf-8?B?SHRzVHV3NHpqQWI0N2M5eFdJNG1VS2lsOHpveHNXR1B5dFhuQkozY2V5OHNs?=
 =?utf-8?B?cm9IalJyWVF5K3pJMmFQQjk0bTkzTmhxclkxMGZTNTV2Um1OditRQ2JNekp4?=
 =?utf-8?B?eXNGMDI5UkxIR0xTdHBmMnRjTXpqY08xeUp0NG1yWmZqQ3FFMnNtSitTWG8r?=
 =?utf-8?B?c0JxV3gwakorRklDVHFmMG9TaGs4ZXd2c0Q5YjEyNEJiSVNDV1FPcVc2YUJJ?=
 =?utf-8?B?TXgwNmVjN0JFcFZmTE9hQWRmeGMvZU1yQzh3N1NaL2EyMVM1ci92Z3EvOFg1?=
 =?utf-8?B?OSt4MWhCNlRYTlV6a2JyZVN5enZGM2pqOXRyMGpGS2poMjNnbEJvcE0ydGJn?=
 =?utf-8?B?cnViRUlwQm5BOHdhUExHMmdvWUdGY0pOWHVsb281ZVM0Vlc4N0JiZ3lVNzY0?=
 =?utf-8?B?RGFsVHVIZ2J4dEJRM0RLWEFEZHpxcHpUS1ExQjBqQVJ6VDBBd25iRzdVUmxE?=
 =?utf-8?B?YUFlOXVrUWJGWmRYc09kQXBha0oyUS8wSlMyRG0yN2Q3bWtGcHd6WjB5Y0lP?=
 =?utf-8?Q?GupgErgeJLUUKpZedPjkGtIFE?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890f23b6-a20f-4f0f-45ed-08de25824a0f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 02:37:45.2904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvhcQDKUuH3W3OG4stx0ZMiXoYpZcOVVxjFYHo3gw2td3t5mhuOdTImfOadAp0I/QM6x8zLa4ZX3IpzWatsRKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9131
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDAxOSBTYWx0ZWRfX2cOxQX9PH4d3
 AgkMPq/dch6esaPqz93CNkglYE5NEXxdTpqoTwkWc3YMlrN3ch9XnGE07rj0tu5Ng4xjJoCXPLF
 v+vsjX6MQ33N8oVYGq/BJyaMjSlWp8OqK9GzFacUc8i2pELQ47Vt9J4PqeT27GWfWKVugo8Obp0
 z61wmGbZYJaB1k7Hx9lNNMv8ojkPiRDHLkv9ir2zOR7pQOvyHG9HscihVXvjmf1+UCA9iwMMldJ
 D77Hy6w/gaFQZcHgkaKo7Emfz9HAns9wjGfWu5mw/euw/ZrKbme4XAjdcrs6HCQA3XGHeh1zUcI
 4KVkUWmu8VzCDKioFAZ5WSSgqjN/aT+V28SiJRWYGa6ELlNTX2lnYySDoq4dg4uJ8v4SVKbWThW
 9uRqpsfjK+WVMRVi9HPHvzLbeHFDuA==
X-Proofpoint-ORIG-GUID: jIScg05LfS376FWHakHdHXc1TsjvLNWX
X-Proofpoint-GUID: IIFg-EyAUPWKeVrF-2Fjd-86sLBWEUpp
X-Authority-Analysis: v=2.4 cv=Z6Xh3XRA c=1 sm=1 tr=0 ts=691a8a7c cx=c_pps
 a=XYxO6LlR7Df2C67LKP0s0A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=HvlrrJGs30CXpD3u:21 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Q4-j1AaZAAAA:8 a=t7CeM3EgAAAA:8
 a=Rv1RU0O98DUiCpw31-UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511170019
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5AH10WWB943608
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 17 Nov 2025 02:37:59 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18414

On 11/14/25 20:17, Richard Purdie wrote:
> On Fri, 2025-11-14 at 12:14 +0000, Richard Purdie via lists.openembedde=
d.org wrote:
>> On Fri, 2025-11-14 at 14:02 +0800, Qi.Chen@windriver.com=C2=A0wrote:
>>> From: Chen Qi <Qi.Chen@windriver.com>
>>>
>>> When an internal fragment is enabled, and there's already a value
>>> for the corresponding variable, we should error out to avoid any
>>> confusion.
>>>
>>> For example, when 'machine/qemux86-64' fragement is enabled, and
>>> we get some "MACHINE =3D xxx" in local.conf or env, we should error
>>> out and recomment users to use 'bitbake-config-build disable-fragment=
'.
>>>
>>> We should be tolerating weak assignments. For example, DISTRO default=
s
>>> to "nodistro", and when 'distro/poky" fragment is enabled, there shou=
ld
>>> be no confusion.
>>>
>>> The implementation hacks the environment variable as a way to tell
>>> bitbake that we're using 'bitbake-config-build'. Because we recommend
>>> users to use bitbake-config-build, then it should not error out.
>>>
>>> Fixes [YOCTO #16060]
>>>
>>> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
>>> ---
>>>  =C2=A0bin/bitbake-layers=C2=A0 | 3 +++
>>>  =C2=A0lib/bb/parse/ast.py | 7 +++++++
>>>  =C2=A02 files changed, 10 insertions(+)
>> Thanks, I think this is a step in the right direction but I can see th=
e
>> challenge you're facing with the parsing. There are probably other bug=
s
>> in this area, for example what if there is an invalid fragment set (yo=
u
>> delete a fragment file, then try to disable it with bitbake-build-
>> config?).
>>
>> What might be a slightly "nicer" approach would be to pass the toolnam=
e
>> into the bitbake datastore as some variable (BB_TOOLNAME?) from
>> tinfoil, then we might want to skip all of the fragment code if
>> bitbake-config-build is in use?
>>
>> We'd have to check what other implications that might have, for
>> example, does bitbake-build-config need a full datastore? What are the
>> implications for bitbake's cache files and cache file hashes?
> I did have a couple of other ideas:
>
> a) we could pass in options to tinfoil. We could have a
> fragements=3DTrue/False parameter and allow this tool to disable those.
>
> b) we could add a new CookerFeatures option to disable fragments.
>
>
> I'm kind of leaning to b) since this was the existing designed in
> mechanism to change things like this.
>
> Cheers,
>
> Richard

Hi Richard,

Thanks for your review and suggestion. I'll work on option b).

Regards,
Qi


