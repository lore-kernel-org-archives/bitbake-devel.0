Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38AF2CDE00F
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 06:20:57 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.12052.1763101254133522277
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Nov 2025 22:20:54 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=KsKBbhKS;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=3413a291a4=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AE1KkSR3041859
	for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 06:20:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=DuWqJoNvHO887f7DoOUCZv
	4EMDk9AQ2PsQh9jwCvFOw=; b=KsKBbhKSLPJx+DUpM77oAOMrVyrb5sz4UkbLpK
	vJ/DkZu+VRfOgtYVTTc4R0Bjb2auEf9js5K46VJD48MR4Y1HHTs+PYy55Dy1AUMi
	Ih8OcOaPWcrheazASrJDC0eY91DtcQZ4vpwxLX/ESs4XsnrNj1hkHoPhQEkt+y8p
	y0tctILuJ7zPv+U5XuqrVUWPqWuVDlI7//n3+aSeeAK4C1NRG0/VrJ6tmY7yz3o5
	n+6rjshioANExhNLXyJmyoz7ot/i/LinW4+X2s9gbRjl3RdF+bDGQHGC+pWDbWE7
	gSlmGpOCF3rri93F/k+/zuWAxCcPVtASP2mZ2o747q6Q4Gag==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010003.outbound.protection.outlook.com [52.101.201.3])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4adtmc86tr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 14 Nov 2025 06:20:52 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7GnWaEpEKthL0N/a8Jt/RZ+2EBYVb90iIscTpHeMKNft8rDlPZnSpwLDfSRw9MpcyUaI3FAjf6HoR/kdWcTiepIrSsK4pyu9QuFic5tdkWFOI8ZD1W5uGxWacMLH1eooob/U/+INu1xJUcb899zLWfhqupsyChGxWRz3XtHOWj+DoRa6VM+glnCV3pk79qa9fdsNQ1xnMneL9HpzfzEYmmmqRr4UwyyPwmoppd8MC//c8uhlEedYHgZh2udeMExkfoWD95JhnAJWuJ4bPhm70gzNKnX+RG7ituOLfP59AGsOn08icFeUDRilYFch3x1w+bctg5s/P08MaRxyoZpPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuWqJoNvHO887f7DoOUCZv4EMDk9AQ2PsQh9jwCvFOw=;
 b=h326BCLbfqvcdZjUL9Iw+XsTiSegLoWso3PQmIkhsgXaqimooAOKvplnhsIP+8dIwM4mp3RhBhUT45tCv08/C4clIeFfp+NFpNjYUFWsJ3uXNJpOXzw8wsYFr3+k+9Cqnyg+KWm34y31Y2dN4MWLXjPoToRPTq2luimjxkPlp9c16XtpfAOSp9f9mDEdkL34URh6wTn25A78/8D0mSlOpRCfU3jzIO2Wv8UUnbpZYzKAOaLx6v7GjDHgCDdanlLAI5lw/E7kvX/n3H8ztnPiQ8XVi0PsXyM7/aBRyYeDJa5m/QE2l+Xrm8cUO6i4BOBTH0lxmJ3YRMyQMtMqprxVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by PH8PR11MB6854.namprd11.prod.outlook.com (2603:10b6:510:22d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 06:20:50 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::5ad6:8f90:b01d:2c62%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 06:20:50 +0000
Content-Type: multipart/alternative;
 boundary="------------Ek1hTC2SgYKN9y0jgnFfDa8Y"
Message-ID: <a0e64b88-cb5b-4dcc-8b6f-147765f373e0@windriver.com>
Date: Fri, 14 Nov 2025 14:20:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel][PATCH V2] lib/bb/parse/ast.py: error out for
 internal fragment in case of a previous value
To: Alexander Kanavin <alex.kanavin@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, richard.purdie@linuxfoundation.org
References: <20251114060211.1742728-1-Qi.Chen@windriver.com>
 <CANNYZj_J6oJOpdYsX7Rnz8ViL4==q4ktLhfx5MZHQNe1s9SF-g@mail.gmail.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <CANNYZj_J6oJOpdYsX7Rnz8ViL4==q4ktLhfx5MZHQNe1s9SF-g@mail.gmail.com>
X-ClientProxiedBy: TY4P286CA0072.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::11) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|PH8PR11MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: fa0df426-c175-4cdc-7c7b-08de2345f4c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cU9TaGxYMjduUDdEd2MzL3BRUUNnSHZFcEpqVHo3WW1IYUxrOTVDUjRrN3JR?=
 =?utf-8?B?YmNoRFZBbTNRdTlHYzhGV3pDNk01YVNnVy9RVFNJTEQxTHMrbGFsUnZ4QTBN?=
 =?utf-8?B?VnZxZmJ1OFIza2pqeGw3cXZzOFdVMCtIcmdhWEgvakF3MUQzTFZrajRRaHpy?=
 =?utf-8?B?N2t2Q2xOeUp5dU1aczg4Q0VUR29Pd2NldGlDL2swbVZZLzY0UTV3SVM3aGtj?=
 =?utf-8?B?WHJBaVRsQ1JxaVp6dTI3ODIyeE0zNWRFTmRRem5QQi9vUW9TQU9WS1Z4VlNX?=
 =?utf-8?B?RjA3Tzg4RkNpcWNZWWpTZktmUVc1a1FORyt6b1ZtZ25NOTFvNGczL0JNeC9E?=
 =?utf-8?B?U2Y3Mkx4RllJbVd4b01kZGc0Y09jdkVFMnZLNTNCTlRSS1RpQ3V0YU1oUUpH?=
 =?utf-8?B?bjBpOFhjRkYrTUV2Tk1EU3djS2NtMnlBS0loc0tvN29iQXEvcmgrR3h2amJ1?=
 =?utf-8?B?N0p1NCtmMS9aU055UkpKb25jNDAveU9aZnNOTTg4RFMwNThRc3dNeklqdHps?=
 =?utf-8?B?OUViVkxWZVFMelFKNU5BTFEzYnVSOW5WRkxUdjI0b2xQcm50UmVsR3B1ZEZo?=
 =?utf-8?B?WHJzNFJ0YzZwcWZoNlZmeXdmTXBrcERhR0lXUVlBTHQ0NHJHWERXYzN0emxo?=
 =?utf-8?B?RnJlcWpXUmxjNWhDRHBKVTZ6QjVmeGJhcVQxeFpMeU9scTJxdy9oMnEvSW5s?=
 =?utf-8?B?clJKU2thZjEwSEQ0YXhlZ3B5MytNSHZxaTBzK3NuQjJwSm85eElHRHF3YzMx?=
 =?utf-8?B?eVlwSGJvai94aVB2THZBamREU0F2cE42Q01KUHFnQXZZb09JeTBNVmNaRTlD?=
 =?utf-8?B?TU9LMktFd0VZaUIvWXNkTVVTUmVWSk16UWd5ZWxJbnNlWk1jYTZtOXRLbmkr?=
 =?utf-8?B?WjFtdmQ0RExoSC9WV2IybXZWY3h6bURvWGxsV3pWS240VHBreXZjMHE0M0RI?=
 =?utf-8?B?YW9CMUJvNThBSVhEdDVocEs0cTRaSnltVFc3a1JqSFYvSjRiRE9hSVBJUEpw?=
 =?utf-8?B?WWhBOVhsQ0dtL2RBYUx0Z0xnUHFmNVpqMW9JQ0VMSDVESEZjVHJkV3BMSXBh?=
 =?utf-8?B?YmhrNmlZSlp3VHphN01Jbjl1cjB4b2ROR0Zxa0JucjNjT09yOEttaFJlV1Nt?=
 =?utf-8?B?SlJWaHdMM0gzN2VMTFNIMGFtZHBBUmoyNTJnMVpaWDRyTUZIT0tEY1Bpakpy?=
 =?utf-8?B?WkVGK1JPSHJGdktqZjZYMm5hK0g3YXZaZzVnU1hoVmQ2dHI2ckJ0YmFOdFVM?=
 =?utf-8?B?dFdOR1VkLzJvVjBTNk82aHpja3hGK1ZKbjhLYUREVmN2UmNsTGthTnRzaVJP?=
 =?utf-8?B?V1Rqd2w0YXYrVzZrRWFEWTloWXNQVEVmbFp4NXJSbE9iSkV3VmZjS1V3UHBs?=
 =?utf-8?B?SXY5THpGT1hhTXFOR0c0NEpUaTV2WkhnZmh2NUNscWtic0VqZkZCZWorcHRk?=
 =?utf-8?B?YUZteUQzV1ZUUWhKTldjREtMVmNRc1h4SUZ0STk5dW5VTHZOdWs1WE1neXAx?=
 =?utf-8?B?MkNnWmVwTmN0NG1zYzlQVy82TzJpZ3lEdVU5L0dhekEyWjExTjZ4SGgrM2pv?=
 =?utf-8?B?NEpUa1Q2L25iN2NsRUtaS2FMVllpUWtMaTUyODdXeUdMdHRoa3pVLzArMWJX?=
 =?utf-8?B?VFA1aXZ6VUs0amVwMll2dDR6dU4wdGdtUXpXeDBQWDJwaXViMEtHZmxnaUZN?=
 =?utf-8?B?SjVVcTdNbTFzQnZCZmR2dXRHOVRwcndSdjB2ODhTVXVSSU15d3NZc3NGZDVD?=
 =?utf-8?B?RGNnZHhSSXdhSWZwb3BWOHcxVFJueE5yZ0RXb3JteXhTU0RFNTBZTFhTaFVM?=
 =?utf-8?B?M3haS1IwK2VjbHNUMWNabTNHaXpjU0lnOFZ2Z0Rxb1E1WlNIREdpYktINGRv?=
 =?utf-8?B?L25ZYmQ0cEo0Q1lZekNlMkk3by8rQXROQjNvRVB2aHZRWnc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UlhiNy83YWI3TUc1MllOQWdqRFJhbTgrd3VvZEtPYXZJL3B4ZUJVN3B5OFVB?=
 =?utf-8?B?ZDh2czRmTTZVcGhOS0lGL3djNFpSRE1kR2VVeFpKaWUyNGV2UUVsL2dEK3F0?=
 =?utf-8?B?SFlUNm9vcXYxT0tXREEvUmpGUUpFOHhrV0ZuSTRPakNwUVcxL0phMjFEYzda?=
 =?utf-8?B?aW9TUGdTVW90THliZlJ2ZVEzNW5WRHl5OC81S21RWkxla3BtV3ljcDRneFlw?=
 =?utf-8?B?RXQwNDhTUnoxODFsZWUzZmFzcWpySUp6cWkwaVVxVnBLZ3hsazNGdWhWMzh5?=
 =?utf-8?B?ZTJ0ZWo3dUVaVzF1U3ViVVY0a1NkcFROZnRsb3YreGovNEVmOGgxUTE0SG1B?=
 =?utf-8?B?RXJUbE56Tm5pekNaOW1tcTcwRmlKSFFYU2NPK2VuelZVK0p3dEFBdEk4MDM5?=
 =?utf-8?B?Nm1yMWVjRjJzYUZGZzFqOUlNZStLdFRyUzZKNXl5eFdkeVBCTlBXckZYejc3?=
 =?utf-8?B?d0RxaThLYXBNMFlPZTM4SG5sSHYxdFAwZkNpUVAwOWttSTZQTUJwTnBxTFlH?=
 =?utf-8?B?aE1HNm9leDRKU1k1UGF1ZmtqZTQ2R3JUNDJ3Ny84Z3o3VHFlSmxPSnJuWnBK?=
 =?utf-8?B?RnVnWnpKOHFlUVptdXE4b21vZTg3OWRVSWlQVVVqR2U3RjdTd1UrVkRMdDhG?=
 =?utf-8?B?RXFWTDBVQkM5TmNQQzJQSVNxd1ptRGZ3RnJHTm9aVEhKbmRINW5MODZuMzVm?=
 =?utf-8?B?Y09GcDh4UHBHRFBLWkNvVlZ3WENkMXZrUDVxcDVvaVV5SmxSUDVicHJJR1FY?=
 =?utf-8?B?aXNPQW4wY2E2RnhxdWZ0WURSQ2NIK0FyMkpYZHVXY3Fnczg5OGhlVUROWjY0?=
 =?utf-8?B?T0pIQVo2Q244Z1daRkEwQmZJYWxqUm5FcEh6amxCQ1U2TDgyL0hQZHhLbndK?=
 =?utf-8?B?a3IrMHZDUldGNW0vZEpYMFUvcTFTd1BBMFU0cjluOWd5WlllQXVQTW1VZ3dC?=
 =?utf-8?B?UEcwVkRrQVd5YWNYOTkzWC9tZzdYOUZNYWx1S3FzR2Q0Sk5rSTMyNlRlK0Rp?=
 =?utf-8?B?SWhHWDN2YnFyd3ZpWXBTYzZBL1krNXNNN2FNMWkwSEVrQWZ1K3QwWGR0dnJL?=
 =?utf-8?B?SFpNWXpPM2VWVVN6dWpzNlFLK0cyNEFnTlpYdmU4Ui8rRzVva3l2eE1GTnZN?=
 =?utf-8?B?aWNWQURwVEVkQk13NWJvSHE4Q2xHVmM5WHYvSFBtZ0NvZTlSZ2lFRW5UUU5Q?=
 =?utf-8?B?ajNSMnE4bDFjeDg2WWFtZ0VjQWVaNWNESnFrVld3ZGh6VjVjcHZFU3k0c1BQ?=
 =?utf-8?B?cU1jSVphSERNMXV2M0MvT25lNmYvalMxREYxdHI3MnFEdTVGc212RHpkbHYz?=
 =?utf-8?B?MmE2RFFGRmxYbzFIbWVPZk85V0hDMVpJWTVraGkydHVNZU5La2NndlhrUm0r?=
 =?utf-8?B?SEtPeXZCUlVjblRhSVJncjNxblZNL2VuTVVXMzBGUmNnbDcxSitlYjBJK3Ny?=
 =?utf-8?B?VjRRcEp3eThwYTNIVUdldkdxNE1PVHR5eFcyMnJaRmZ2elk3TXVveENuMURL?=
 =?utf-8?B?WDNFekxDUTZqT0dhQ05kUkd4VnYvdDdUYW9ialZ3TVMwaStkMlQ5UG92aWpa?=
 =?utf-8?B?a0JWSUlVRllReE5QdVNHVkZtRVFCWDRyY1BkWmNpekZmcnMrQ1lyOVUwV05m?=
 =?utf-8?B?K1kyeGR1MmcrQ3lmbVRraVVLTGFpMEdIakFlVVU3N25JYkQySFNqaU1sRDBy?=
 =?utf-8?B?U1RvRjBwbGQ3VmdLYWxMdFRhemNDaHk2SEg4ckhubWJ6ZTUyNE1OWU5kNUxK?=
 =?utf-8?B?eDhVbzFTYXAwSVZpVUVRNVpiZzlKWWlnR1l2TTBLWXZDa2s1Z0pvREJhay9m?=
 =?utf-8?B?RTc3Sk5FMFp2eXNxblNkZk9GZWVsR1R3TWJtWmIyQUtOMStQaWxlZUt5Mmtw?=
 =?utf-8?B?eG5zZllmeVlSOWE3clZTZFY0dVNENTA3c0tQUFNsWGI0cWZDdVFjd2tMNzU0?=
 =?utf-8?B?LzdPand4ajFFTFoveVBQYys4MGpBMnlnUk1ONStuTUpJZlo2dzJSZnBVeC9Z?=
 =?utf-8?B?SitRbWhRQTZFUXlibUl6NThsN1I5QjArVVpuenZtYXRzOVhqb1hRM2dHaVds?=
 =?utf-8?B?VTRMZUluSjJwU3dNUnY4bCt0UU9JaDdxU2R6M2lMQlQ0cm4rZzgyOGlwVEFX?=
 =?utf-8?Q?ibzpQVNxGEwgfP02dnO+eV2Yz?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa0df426-c175-4cdc-7c7b-08de2345f4c3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 06:20:50.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhLdOrNIbcAQc2FE8VQDV/9THwJsWl59JL9B8eJ0XMImbfnrVcE2tUFuGd1p/EyDPveZo/vK+gm2NXQPGgjR1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6854
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=B460EetM c=1 sm=1 tr=0 ts=6916ca44 cx=c_pps
 a=LQDsqUhXq6x2TIKBD9Oruw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=HvlrrJGs30CXpD3u:21 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iGHA9ds3AAAA:8 a=k0wvXewPAAAA:8 a=t7CeM3EgAAAA:8
 a=JEW1LvZNjkcRTJCIWMoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pGLkceISAAAA:8
 a=0Zo-RuAMZ0HEviyFyyEA:9 a=4A1Io2IM8-uDh6a-:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10 a=nM-MV4yxpKKO9kiQg6Ot:22 a=jFALn0oBPV-PiFRDdw-s:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDA0OCBTYWx0ZWRfXwSPiX0H1Wsyr
 uPoxOH0/mDSQyt15z2fq1UJoB0tgz6kvwz1clf9UwcbhKyWO5vQFH5h6mhySb+9LH5VeIe7k+e4
 JLe6idINbjZb8+JhUd+qlgwWQuRRU1oP5khEwwrzb9UB9mqVynJviHBDgFBhPTRcjW+wSeXbLuI
 L5fG9aYo9SC9bPr/8huRndr9XDOWvQIP3RQjzbvf4G5zJCkbgIzOVJqEKDfBY/OY3IM95JQYEzC
 +ynnV9PkhO6mAzciJQ53JFPKPmNAy1WNKET1Wfi+8Af8pACj0EiJclIvPE5gJjBMI5iMuRZhltb
 c0HeZRJDDI3QtyEvAbMKkmiZpNDmKRsU9QWS2XU+dzZoBMHmvnRH7JqIO3cv+UZJlCRDJcsPOiW
 gzD9Ce/Pasuj2cC28/KNI9CcU6kopg==
X-Proofpoint-ORIG-GUID: w8QDgcPryUoekpYb36nxjV9eUfg-RFHB
X-Proofpoint-GUID: LOo469eh4XwdBSoUDR7_UyeIJG3bzzZp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_01,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 phishscore=0 priorityscore=1501 suspectscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140048
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 06:20:57 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18383

--------------Ek1hTC2SgYKN9y0jgnFfDa8Y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5AE1KkSR3041859

On 11/14/25 14:15, Alexander Kanavin wrote:
> You need to explain the difference between v1 and v2 and why v2 is=20
> needed. What was wrong with v1?
>
> The environment pass through hack is horrible.
>
> Alex

Hi Alex,

V1 to fix YOCTO #16060 is to use default value for internal fragment.

V2 is to error out in case of a previous value. See Richard's comments=20
in https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D16060

I know that the env method is a horrible hack. I looked around but could=20
not find any other choice. Do you have any suggestion?

Regards,
Qi

>
> On Fri 14. Nov 2025 at 7.02, <Qi.Chen@windriver.com> wrote:
>
>     From: Chen Qi <Qi.Chen@windriver.com>
>
>     When an internal fragment is enabled, and there's already a value
>     for the corresponding variable, we should error out to avoid any
>     confusion.
>
>     For example, when 'machine/qemux86-64' fragement is enabled, and
>     we get some "MACHINE =3D xxx" in local.conf or env, we should error
>     out and recomment users to use 'bitbake-config-build
>     disable-fragment'.
>
>     We should be tolerating weak assignments. For example, DISTRO defau=
lts
>     to "nodistro", and when 'distro/poky" fragment is enabled, there
>     should
>     be no confusion.
>
>     The implementation hacks the environment variable as a way to tell
>     bitbake that we're using 'bitbake-config-build'. Because we recomme=
nd
>     users to use bitbake-config-build, then it should not error out.
>
>     Fixes [YOCTO #16060]
>
>     Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
>     ---
>     =C2=A0bin/bitbake-layers=C2=A0 | 3 +++
>     =C2=A0lib/bb/parse/ast.py
>     <https://urldefense.com/v3/__http://ast.py__;!!AjveYdw8EvQ!ZSR5THHx=
swHSbWGyBGxON8N8yJ_VhCA5M36eDazemj6ot6xLm281YkTXH7rtSU6j-Jad4Pl6r20d3jZ-l=
xN1l8c$>
>     | 7 +++++++
>     =C2=A02 files changed, 10 insertions(+)
>
>     diff --git a/bin/bitbake-layers b/bin/bitbake-layers
>     index 341ecbcd9..c4569c6c3 100755
>     --- a/bin/bitbake-layers
>     +++ b/bin/bitbake-layers
>     @@ -64,6 +64,9 @@ def main():
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if global_args.force > 1:
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bbpaths =3D []
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if toolname =3D=3D "bitb=
ake-config-build":
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.environ=
["BB_ENV_PASSTHROUGH_ADDITIONS"] =3D
>     os.getenv("BB_ENV_PASSTHROUGH_ADDITIONS") + "
>     _BB_INTERNAL_RUN_BITBAKE_CONFIG_BUILD_"
>     + os.environ["_BB_INTERNAL_RUN_BITBAKE_CONFIG_BUILD_"] =3D "1"
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tinfoil.prepare(Tru=
e)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bbpaths =3D tinfoil=
.config_data.getVar('BBPATH').split(':')
>
>     diff --git a/lib/bb/parse/ast.py
>     <https://urldefense.com/v3/__http://ast.py__;!!AjveYdw8EvQ!ZSR5THHx=
swHSbWGyBGxON8N8yJ_VhCA5M36eDazemj6ot6xLm281YkTXH7rtSU6j-Jad4Pl6r20d3jZ-l=
xN1l8c$>
>     b/lib/bb/parse/ast.py
>     <https://urldefense.com/v3/__http://ast.py__;!!AjveYdw8EvQ!ZSR5THHx=
swHSbWGyBGxON8N8yJ_VhCA5M36eDazemj6ot6xLm281YkTXH7rtSU6j-Jad4Pl6r20d3jZ-l=
xN1l8c$>
>     index e6ff1ff76..70a2a37a6 100644
>     --- a/lib/bb/parse/ast.py
>     <https://urldefense.com/v3/__http://ast.py__;!!AjveYdw8EvQ!ZSR5THHx=
swHSbWGyBGxON8N8yJ_VhCA5M36eDazemj6ot6xLm281YkTXH7rtSU6j-Jad4Pl6r20d3jZ-l=
xN1l8c$>
>     +++ b/lib/bb/parse/ast.py
>     <https://urldefense.com/v3/__http://ast.py__;!!AjveYdw8EvQ!ZSR5THHx=
swHSbWGyBGxON8N8yJ_VhCA5M36eDazemj6ot6xLm281YkTXH7rtSU6j-Jad4Pl6r20d3jZ-l=
xN1l8c$>
>     @@ -364,6 +364,13 @@ class AddFragmentsNode(AstNode):
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0def check_and_set_builtin_fragmen=
t(fragment, data,
>     builtin_fragments):
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0prefix, value =3D f=
ragment.split('/', 1)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if prefix in builti=
n_fragments.keys():
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if data.ge=
tVar(builtin_fragments[prefix],
>     noweakdefault=3DTrue) !=3D None:
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if not
>     os.getenv("_BB_INTERNAL_RUN_BITBAKE_CONFIG_BUILD_"):
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 bb.fatal(
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ("A builtin fragment '%s' is used
>     while %s has already got an assignment.\n"
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"Please either disable the fragment
>     or remove the value assignment.\n"
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"To disable the fragment, use
>     'bitbake-config-build disable-fragment %s'."
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0) % (fragment,
>     builtin_fragments[prefix], fragment))
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fragm=
ent_history =3D
>     data.varhistory.variable(self.fragments_variable)
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0login=
fo=3D{}
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for f=
h in fragment_history[::-1]:
>     --=20
>     2.34.1
>

--------------Ek1hTC2SgYKN9y0jgnFfDa8Y
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 11/14/25 14:15, Alexander Kanavin
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CANNYZj_J6oJOpdYsX7Rnz8ViL4==q4ktLhfx5MZHQNe1s9SF-g@mail.gmail.com">
      
      <div dir="auto">You need to explain the difference between v1 and
        v2 and why v2 is needed. What was wrong with v1?</div>
      <div dir="auto"><br>
      </div>
      <div dir="auto">The environment pass through hack is horrible.</div>
      <div dir="auto"><br>
      </div>
      <div dir="auto">Alex</div>
    </blockquote>
    <p>Hi Alex,</p>
    <p>V1 to fix YOCTO #16060 is to use default value for internal
      fragment.</p>
    <p>V2 is to error out in case of a previous value. See Richard's
      comments in
      <a class="moz-txt-link-freetext" href="https://bugzilla.yoctoproject.org/show_bug.cgi?id=16060">https://bugzilla.yoctoproject.org/show_bug.cgi?id=16060</a></p>
    <p>I know that the env method is a horrible hack. I looked around
      but could not find any other choice. Do you have any suggestion?</p>
    <p>Regards,<br>
      Qi<br>
    </p>
    <blockquote type="cite" cite="mid:CANNYZj_J6oJOpdYsX7Rnz8ViL4==q4ktLhfx5MZHQNe1s9SF-g@mail.gmail.com">
      <div><br>
        <div class="gmail_quote gmail_quote_container">
          <div dir="ltr" class="gmail_attr">On Fri 14. Nov 2025 at 7.02,
            &lt;<a href="mailto:Qi.Chen@windriver.com" moz-do-not-send="true" class="moz-txt-link-freetext">Qi.Chen@windriver.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class="gmail_quote" style="margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;padding-left:1ex;border-left-color:rgb(204,204,204)">From:
            Chen Qi &lt;<a href="mailto:Qi.Chen@windriver.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">Qi.Chen@windriver.com</a>&gt;<br>
            <br>
            When an internal fragment is enabled, and there's already a
            value<br>
            for the corresponding variable, we should error out to avoid
            any<br>
            confusion.<br>
            <br>
            For example, when 'machine/qemux86-64' fragement is enabled,
            and<br>
            we get some &quot;MACHINE = xxx&quot; in local.conf or env, we should
            error<br>
            out and recomment users to use 'bitbake-config-build
            disable-fragment'.<br>
            <br>
            We should be tolerating weak assignments. For example,
            DISTRO defaults<br>
            to &quot;nodistro&quot;, and when 'distro/poky&quot; fragment is enabled,
            there should<br>
            be no confusion.<br>
            <br>
            The implementation hacks the environment variable as a way
            to tell<br>
            bitbake that we're using 'bitbake-config-build'. Because we
            recommend<br>
            users to use bitbake-config-build, then it should not error
            out.<br>
            <br>
            Fixes [YOCTO #16060]<br>
            <br>
            Signed-off-by: Chen Qi &lt;<a href="mailto:Qi.Chen@windriver.com" target="_blank" moz-do-not-send="true" class="moz-txt-link-freetext">Qi.Chen@windriver.com</a>&gt;<br>
            ---<br>
            &nbsp;bin/bitbake-layers&nbsp; | 3 +++<br>
            &nbsp;lib/bb/parse/<a href="https://urldefense.com/v3/__http://ast.py__;!!AjveYdw8EvQ!ZSR5THHxswHSbWGyBGxON8N8yJ_VhCA5M36eDazemj6ot6xLm281YkTXH7rtSU6j-Jad4Pl6r20d3jZ-lxN1l8c$" moz-do-not-send="true">ast.py</a> | 7 +++++++<br>
            &nbsp;2 files changed, 10 insertions(+)<br>
            <br>
            diff --git a/bin/bitbake-layers b/bin/bitbake-layers<br>
            index 341ecbcd9..c4569c6c3 100755<br>
            --- a/bin/bitbake-layers<br>
            +++ b/bin/bitbake-layers<br>
            @@ -64,6 +64,9 @@ def main():<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if global_args.force &gt; 1:<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bbpaths = []<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;else:<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if toolname == &quot;bitbake-config-build&quot;:<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; os.environ[&quot;BB_ENV_PASSTHROUGH_ADDITIONS&quot;]
            = os.getenv(&quot;BB_ENV_PASSTHROUGH_ADDITIONS&quot;) + &quot;
            _BB_INTERNAL_RUN_BITBAKE_CONFIG_BUILD_&quot;<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
            os.environ[&quot;_BB_INTERNAL_RUN_BITBAKE_CONFIG_BUILD_&quot;] = &quot;1&quot;<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;tinfoil.prepare(True)<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;bbpaths =
            tinfoil.config_data.getVar('BBPATH').split(':')<br>
            <br>
            diff --git a/lib/bb/parse/<a href="https://urldefense.com/v3/__http://ast.py__;!!AjveYdw8EvQ!ZSR5THHxswHSbWGyBGxON8N8yJ_VhCA5M36eDazemj6ot6xLm281YkTXH7rtSU6j-Jad4Pl6r20d3jZ-lxN1l8c$" moz-do-not-send="true">ast.py</a> b/lib/bb/parse/<a href="https://urldefense.com/v3/__http://ast.py__;!!AjveYdw8EvQ!ZSR5THHxswHSbWGyBGxON8N8yJ_VhCA5M36eDazemj6ot6xLm281YkTXH7rtSU6j-Jad4Pl6r20d3jZ-lxN1l8c$" moz-do-not-send="true">ast.py</a><br>
            index e6ff1ff76..70a2a37a6 100644<br>
            --- a/lib/bb/parse/<a href="https://urldefense.com/v3/__http://ast.py__;!!AjveYdw8EvQ!ZSR5THHxswHSbWGyBGxON8N8yJ_VhCA5M36eDazemj6ot6xLm281YkTXH7rtSU6j-Jad4Pl6r20d3jZ-lxN1l8c$" moz-do-not-send="true">ast.py</a><br>
            +++ b/lib/bb/parse/<a href="https://urldefense.com/v3/__http://ast.py__;!!AjveYdw8EvQ!ZSR5THHxswHSbWGyBGxON8N8yJ_VhCA5M36eDazemj6ot6xLm281YkTXH7rtSU6j-Jad4Pl6r20d3jZ-lxN1l8c$" moz-do-not-send="true">ast.py</a><br>
            @@ -364,6 +364,13 @@ class AddFragmentsNode(AstNode):<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;def check_and_set_builtin_fragment(fragment, data,
            builtin_fragments):<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;prefix, value = fragment.split('/', 1)<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;if prefix in builtin_fragments.keys():<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if data.getVar(builtin_fragments[prefix],
            noweakdefault=True) != None:<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if not
            os.getenv(&quot;_BB_INTERNAL_RUN_BITBAKE_CONFIG_BUILD_&quot;):<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; bb.fatal(<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; (&quot;A builtin fragment '%s' is
            used while %s has already got an assignment.\n&quot;<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;Please either disable the
            fragment or remove the value assignment.\n&quot;<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;To disable the fragment, use
            'bitbake-config-build disable-fragment %s'.&quot;<br>
            +&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;) % (fragment,
            builtin_fragments[prefix], fragment))<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;fragment_history =
            data.varhistory.variable(self.fragments_variable)<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;loginfo={}<br>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;for fh in fragment_history[::-1]:<br>
            -- <br>
            2.34.1<br>
            <br>
          </blockquote>
        </div>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------Ek1hTC2SgYKN9y0jgnFfDa8Y--

