Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EAACFD364
	for <webhook@archiver.kernel.org>; Tue, 25 Nov 2025 08:54:17 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13000.1764060852946893761
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Nov 2025 00:54:12 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=QA6DH2z2;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=34243e2576=changqing.li@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AP3mcfP3344169
	for <bitbake-devel@lists.openembedded.org>; Tue, 25 Nov 2025 00:54:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PPS06212021; bh=kc1YAOCkGbpsWLNHh2uqH7
	4J2IYGEE5VUoznMsE25UA=; b=QA6DH2z2WVlU/Kphxx5OCy31cBzeMNNF+c6Sif
	ZkBRy/Gbl+t9ZmgxbVcygXa1Lvi4niw3g4+bAjgPZzyn8i3u5fJmV1o1MMKeofZm
	/RKOLExvrihL18u7enR857JsoNPDkHyX0jZjfpXJ6nmOzQ1jBv+JP0+fknRpsh0v
	uLNqFI1f2IkmgK11H5ZGM0vaErOt/BdIPP2+EDJjZTyMeQnV7/TFGXhGel/L2OZp
	pFfHa+kOCSpIlvIOeiSxL7y5h3aKfbX2ETqUCOpwP9HctKslVvwYW59MincjhsMc
	pb2NKZjXS30i/Ow690hZ3kud1vMfx4ob/4xSoFeR9+GSjRzQ==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ak9b5aqb8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 00:54:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0KMXuM1EnYYtfGJT+gLSUtu/OTHiqK6z0tmTfxjlTcfd7/dNaUCLdoRGG87+v2N6w+Ygl1gqZ7H9wN0WMbFSwaooCS4xiI8eKKGom3mjjAObxnYU4hkdzl8iB/61TbRfSp+IKUfHldeBwky0b3gZ0ou8D8bQk5z9eMhcFqfZKQDk+EvWSfJgUpIrOTpoHKasdnRCfVpP/xz8TfnsTsU3yPDS7iyvDhwifIpNR7lVxRsp7mILkUfvT8OUqtSqUuJVOiRQBw2gP5sQgcWP6jgP5aJfTsG3xMKQq9POS3QW4y2qKy8kQ9RyNcI3KESTuDCLpKyfO3/5KIuAB/1+VyImA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc1YAOCkGbpsWLNHh2uqH74J2IYGEE5VUoznMsE25UA=;
 b=IZ1daNQaLnBPgDl/hSt/AwPB2HtIgL8NO3WxEIvCJufa9jPFSEdBP2rwaxvg9GWaKV0B46EAvwnuWNG6zIe9ydS9gUwI0NJvI0NI8YIrURYtDk/addd2/AmPSVhZiua29UVOSjPKYT8N8Z+aE2Xtlc3KnCIEFcAodJszKuJCzb3ytE64wqmjZ7fnc8MKMQ/guWWI9IX3RWVeTOeT19lZTMEYKT6XlPuYaCZo+uwXulD39i9slMXsuXmjqIPaTpaPbNqJeXTJI13+W4m3Yw0WACrdzKLpol5SdG2aEqiBUZpuXeRdoj093mmJo5R+Z0bXf85iauzGkXk0NMgZ7RpkTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by DS0PR11MB7214.namprd11.prod.outlook.com (2603:10b6:8:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.18; Tue, 25 Nov
 2025 08:54:09 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 08:54:09 +0000
Content-Type: multipart/alternative;
 boundary="------------IjPd00PnRIdjl14PcmWklqpD"
Message-ID: <34ab02c6-18be-418c-a265-2e431cd38bcc@windriver.com>
Date: Tue, 25 Nov 2025 16:54:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] bitbake-setup: Avoid unexpected
 positional parameter propagation when sourcing scripts
To: Yoann Congal <yoann.congal@smile.fr>
Cc: bitbake-devel@lists.openembedded.org
References: <20251125073454.1282407-1-changqing.li@windriver.com>
 <CAMSfU+5eewRwOVNLL-VmJgsAXpZUdXkoLO6FfcSizGp3vJpY6w@mail.gmail.com>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <CAMSfU+5eewRwOVNLL-VmJgsAXpZUdXkoLO6FfcSizGp3vJpY6w@mail.gmail.com>
X-ClientProxiedBy: TYCPR01CA0125.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::7) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|DS0PR11MB7214:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a5566f1-40dd-4303-e88e-08de2c00323d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|4022899009|376014|366016|1800799024|13003099007|8096899003;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?aWRzVnJkOFU1TTZaRVQ5S0hxS1hUdmJLbk82SXorTlBIOFVHVE9sYnRmdjM0?=
 =?utf-8?B?dWtNdzRxWGpXNDlQNnJEejRUMlg1dTBwWFVBTjVaTEVGYlF4SmtVU1hlbzdy?=
 =?utf-8?B?OXZ5MHVyZXJFMzgzSkV6cG1Lbmc0RHVRWGdyeEp3T3VCUERtd2xqQzZZV2RQ?=
 =?utf-8?B?SjB6cVFnbWpvT1RGWmhmQUNnQlIxVCthNzVaMjhSQ3JsaGFIdUxkejBUWUVN?=
 =?utf-8?B?Y051bkhEOVZwS2tXbk12TVByODRDelZkTzJ0S3ZHZ0s1MzdlSzlXTXlQS0hx?=
 =?utf-8?B?WllHdm4zUlg1WGhqY3VzcHRTeEhtMm5zcTJPTS9Rd2ZVSWM1SmllbVlCMW9a?=
 =?utf-8?B?ZXRSZ2dhQ0FMcTBZRTFMSGRtdVNKNExybXVoOHo4Q1VvL0F3SC9HQ0hBekhX?=
 =?utf-8?B?dmJRYW5KWGZySFhxVk1QUnJBR2hsSkt5enhRVE5QZDBBMk5ObmxNS05qVzVW?=
 =?utf-8?B?L0R1QTFLOHNvSzgwWHh5SEhacjJMSTJ6N1FzODJDUWkxdWF6YnBqNHRnUktN?=
 =?utf-8?B?SjIrYmVsTS9wWjVoV3NyTTI1MWs4azROMHJwVWpITElkU1NrOEs2KzBZSWFw?=
 =?utf-8?B?bXNINlZSdW1RQTR3M0NoRktFVXJpQnpBMWZQSXRkaVE5Q0FJZmk4WDNPOFBN?=
 =?utf-8?B?TG4zVkc4Szlqdk1tU0VOS1UxdVI1eDhVZTVBWDh5YjZGdTlJaDFGSmFKUWdm?=
 =?utf-8?B?U3hqY3MwclpsMnY4SzU2UlR4MXFTelZUZlpZeDBDai9UNmszbXVvS1VTcjBM?=
 =?utf-8?B?V1hQQWtJWGl6YW0rSmc0WWh5MFNPQ1dXVmNJOVZaOUxWODF4TmIxSE85b0Jx?=
 =?utf-8?B?cTErV0hhVFp5NHBPbjJTUkt3RUhTYkhtVjdWR1JTeVRYeFIxVDZkZjduZExL?=
 =?utf-8?B?YUxLNU9zbytMVGpMWHNVckxFbjFCVTVvS1FLWFljNGlQMGxQbGY5Slphc0ZK?=
 =?utf-8?B?c2Zhai92RHlnTkZTK1gxbXViZU9NVFhURkkzWERodkQ2Vy9Wblg5M1ZMN2Y1?=
 =?utf-8?B?YUFML0tOUHo2WTIvZTNncUZ5MHRyUWZGR09BR0EyOUJJd1YyMDFMVzFkcmVJ?=
 =?utf-8?B?QnlTcmI0TU9nRFZ6aEljc2JTa0kvQ1FJVlNCUHRBcGgzZGdNQmZ0c25MZ2RU?=
 =?utf-8?B?NUlELzRqS1A5V2t6WTZrd0lmYVZlVXRJOVQ1UC8xZXpuVUhrYzdlN21QaktL?=
 =?utf-8?B?dUw3YkxnVmFZMFlqbWpXaXVHdVVIZnBoMW4wY2hMVGpGMjNXMzdZcHBQZ28x?=
 =?utf-8?B?dlZUZ0dlVW5VTGxDbzl6djdsK2xmVlZNN0k2b0duL2drM0crY0dCVXkrdVZ3?=
 =?utf-8?B?QUt2TUEzSjV4SGNUV1VHaGplTjhweWhjanN0cFFmWXFJbTZlQmpvMEx2UFJH?=
 =?utf-8?B?VzF3VWtDZDNjUmZLR3V5cEovUEVPcERFQVl6THhtdFU2WjJ0WDhuK2FpOXIz?=
 =?utf-8?B?N0RsVHRpb2paRzQ5cHhOWGxYOWtodnlWd2RXUVB2ZFp2WHBZUGNNU3RMMnBQ?=
 =?utf-8?B?OTlGbTJxbmhlUW5FNlNERzcvaDJ6aVU5KzBWbmpYdDRpc2xJWFhVU1BNZCtQ?=
 =?utf-8?B?bENGaHBmUTgybVdoVi9SVU1aMWUzTGl6SFM2bWlKSkRmaURyaEhIUHdtV1Iw?=
 =?utf-8?B?eDdRYkx6dElwaSt3NlBCVXNtWC9GL0puSVBWMjdMNjA2NkMrRWFKT2FjR3RU?=
 =?utf-8?B?ODJ5QmFVQkpWR1ZycHpLdjZveVlob2hXYzRISldZUXBZanhpVi93MGVOeWUr?=
 =?utf-8?B?Uk9aZURZMU1BbEI0QUxHTmdTVklMazFaYXQvZjlCVW9XditYU0h2R01DMFZJ?=
 =?utf-8?B?dERLZnZoMGswcG1USlB5azF0OHRCcWY0TTVoTEg3VEUyMVBtVHlhRDVMN1Fz?=
 =?utf-8?B?RlNkZjhmdHlMbng4Z3BBMjEzWFNyREFmOG4rZVR3ZnIxaHc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(366016)(1800799024)(13003099007)(8096899003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UzFMRmFTa3YyRmxJWEg2amRyRGkwSmkwMWtJSmt5aGZ3SXpvOFRhaTMwMzlI?=
 =?utf-8?B?SStpcVg3UmtTS1pxRFdjbFR5aGlXdWxsSEt6Zk90Nm9id25TYmIwMmRROGRF?=
 =?utf-8?B?RGo2cWRYSkxZNk9ESmhiOXl2aStrVHlHRFVXS3NNRkxzbC9VN0pYbzFDelEx?=
 =?utf-8?B?RlVDWmFhT28yL3U5UXNZVDhwbk0wUVBHeXdPMitVSkRpY1BUb1RpbXppV3RV?=
 =?utf-8?B?RGs2TUEwR3FxWWNJTk5xWnJpbUFPcU1OUDhjZ0dwM0NSd1hsQzl0cm1TUVFH?=
 =?utf-8?B?NWU4QlRSRHVYR1RCMGwxcEdEQ0dJM1dNbzFKNkF1S293c3RQYll5VkxTWU16?=
 =?utf-8?B?cEVlMUVidEdlMFM2UDlKNE53WGVsd0pFdkNTNHNWZHZ0c25qamlndVRlSlNW?=
 =?utf-8?B?VjV6NnZpOGtic2FNZldNbk1LZ0ZpNHI0ZTE5NWV4cUZ5Uk5DYk1EeUpscTBz?=
 =?utf-8?B?Nk84UW5zNHlJNWh0dHU0aVo3OHY3SDVaUDdUUEw0Y1VRd0NUN01lL1hCYTZv?=
 =?utf-8?B?cVl0Ui9OMm16RVdPK1pCKzFhSkpHdHhlUi9BZEZYdkp0bHo5TndpSnEvcFQx?=
 =?utf-8?B?eWkxQ1J6RFVzTkU2V1lZUzhrc1J5TVduamRSZ2NuY0p6R1FKdk41NFVKZlpY?=
 =?utf-8?B?SnRwbW9nU0ltTFU1NnlaMzM2RzhSRm1ydm1xa0ZmS1UvajZjNFBobGludTh2?=
 =?utf-8?B?d0owUXBzLzZPcFZvRWpSaHhzR2xxY2FFWUxqUFRSNnpjck9SaGxsSGlZaWxS?=
 =?utf-8?B?TjVxYWZwczdZMjlLTGNPamFXMzRkTmpXUWJHZHlpeHZYMFJha0s3RzJhbkhQ?=
 =?utf-8?B?dXlTQmpWcXB2dnZVNW0zSlEzR3lDdnNyRTI5ZmxsSU5sRWFiVkhLSGgvWGFH?=
 =?utf-8?B?dnFzVjVyMTJtNUxmbXRUVXl4UTFLdU5sY0NicnVVMXFScWozTzlmd2FIUGdK?=
 =?utf-8?B?U0pNdEp2Q0VJbnQ1YThXdElvdFR1N0ZGMG1TYWxPRExpdWtmWDdhRTM2Zk9N?=
 =?utf-8?B?cjJWTUk5QWt4Zm1iSHV6RWpTVWpDbTE1Y1Z0cVRiTENFUzN4bXloTnF0UGNE?=
 =?utf-8?B?OHlNQktXK1VUby95RjRqamF2RU9kQm1CbllFK2pmVXNHNVBXU1R5S3MvcDQv?=
 =?utf-8?B?Q1pYRmtjUjVmaWZNcWVBTGZyWXBZRE9IbjU1allBNGpzb092TzJLRDg3SWJJ?=
 =?utf-8?B?QlRjNkxHcUZFT2k2VFJWeS9kcGpJaXNJMWR1dmpPL1RRb2IzUHRwVFJ6YVJk?=
 =?utf-8?B?cy9sN1FtR2wrZ2tuL2RkN2FJQnZUV25uVGdKbzFXSk53UzBhQ3RLcHVGV3JY?=
 =?utf-8?B?Ykl4OFcrcmRseUZxSm9hbUN1ODFqNmdtcWN2Z2ZnTXo2Z1REM0ZJTEhSYU9h?=
 =?utf-8?B?Sk1VRlR1bnM3ZjZiNW9uS2hZVXJnWHhuNXpWMDErNGVpRmQrcWFydzRJcWtS?=
 =?utf-8?B?OFpIMkhaalNSY0V6WVNDNTdYbGZUQlgyNzJDVzl5MXZrbFd2V0RTWC84bEFl?=
 =?utf-8?B?NkprK2JuVnI5aFN0NVM1WlNEaURvTjNJMmNZamNtRFRKNURvRUdpNDVubXBF?=
 =?utf-8?B?TGIvRUZNVm5QeGFTWlNEc1dRczBVbldubm9zdlNJYUd2cU9EWWtyV015M1li?=
 =?utf-8?B?dDExSG9HWUhBeGZ1Z1lYQ21xb3ZaTlpOTFFQTnpDcXE0ZkZRZmRKWDZYOXM4?=
 =?utf-8?B?UnYzL3pmSTV3czNVMXN4SGZqaDJLNGM4N1l4ZExIYzViaUtvWWI3YVhuSXJI?=
 =?utf-8?B?SnB0UCswbmpWWURJQ2p1YmlNM3dZU3NoUUh4d3NETU5jQ2JxTnBOc3FPOGg3?=
 =?utf-8?B?Sm9CZE5iZ2ZqR0dyWktBVm1vQkZWMm8yVTlGcXhCYk5Ra1FmYnh3Y0ErVnRq?=
 =?utf-8?B?RVNzeVNoSTlEbW5MTVpsRmVFejNHbHAxOGVoNjdrQzFYR2hRKzhCc1djV3Rh?=
 =?utf-8?B?QU5PZVFSSE1vWHNYa2NhdkVvbG1WZnlpZldqNEJuNGFxNjdidW5XL2NqUjRC?=
 =?utf-8?B?dWgvMWREOWFnb1UvQ2dQSkhuU0MrVmZNQVp4QnB2TTB0ZlcxdlZxVWxsNHJ3?=
 =?utf-8?B?N1E0eGdGYlRBVzczQWVsaFRPQ2gxRlczeXQ5SjRnSHZSb3owZk02Rzh0TkFu?=
 =?utf-8?B?dUJaaE5CN2hzMThyTXNMWDU0ZDBhcnJ0VzBnaGlkQUFDOE54Wko4N3VyL01E?=
 =?utf-8?B?bWc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5566f1-40dd-4303-e88e-08de2c00323d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 08:54:09.0023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LIisVPmGcvdo/gLI3uTb2PGoGMYfihiidDyo7VnEZZQldvHo5uHsMP/w115uG7CYo2Vr3oub/DWhRy6Hw/FwIiliDPS4xS5el4MCnvmZ9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7214
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fozRpV4f c=1 sm=1 tr=0 ts=69256eb4 cx=c_pps
 a=+lVouGy4Ef+S63FV+3Relw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Q4-j1AaZAAAA:8 a=ySjF6f4xAAAA:8 a=t7CeM3EgAAAA:8 a=l54NjOxupPCcHFvzIj4A:9
 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=pGLkceISAAAA:8
 a=WcV_gK_f_2R7VfBVTcUA:9 a=mwePFaAGWGZhVc_4:21 a=_W_S_7VecoQA:10
 a=9H3Qd4_ONW2Ztcrla5EB:22 a=SVe2G6S_LxxHVpu7-jkk:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDA3MSBTYWx0ZWRfX3gJlW9yT69/R
 D0/EygY48jAk6bMJ53GdgOC0vLWaSu21BKDbU51/ted5pEI5ecMwEx/4bQXpXDOBpkIrccMCEG9
 UYVYuV81+9fABK2FhX+Y3CBrHZV+7tCj45pHHkkyXcfglr0TJc7NZODs3NgdXIupYR6MCBgfWYs
 L9S7E7E7fbaU0mm/I+3FE99k0ine1pR0ekl5redMvKA77UcPlbT0BizFqeho6T32YqElk0PzsAe
 2gGcZK0OIOs74JyVfGdTUmzwPDFh5yJqk5YsGU4zHypTamz7pSlLqUzQ7tQX62Id2OpbFXWR+pQ
 l0Nvhyad+Epy9z490jIUmWr8D4JCT1r8vx51x88dOer8S3VrKu3upGH4EAMdWuMBRhwyRMVBLNI
 uEN7Ma/cCToVCJvXXfWzbonVirrHbQ==
X-Proofpoint-GUID: -uskyZn49DSGhVy3dxEoB32w0zdRaBQf
X-Proofpoint-ORIG-GUID: pkql7-Gm06cRE0Aa2JgBGfXlIVXMgSHk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511250071
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Nov 2025 08:54:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18489

--------------IjPd00PnRIdjl14PcmWklqpD
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5AP3mcfP3344169


On 11/25/25 15:49, Yoann Congal wrote:
> **
> *CAUTION: This email comes from a non Wind River email account!*
> Do not click links or open attachments unless you recognize the sender=20
> and know the content is safe.
>
>
> Le=C2=A0mar. 25 nov. 2025 =C3=A0=C2=A008:34, Changqing Li via lists.ope=
nembedded.org=20
> <https://urldefense.com/v3/__http://lists.openembedded.org__;!!AjveYdw8=
EvQ!fu8ZgVhqx6-gTH5HK3ploud4sYOeN07Y-QBQseosoDoeG7EdjNhWwwBCGKqQXh-mZhMOX=
ASG8P90qiwYdFZ_AXlO84kBcw$>=20
> <changqing.li=20
> <https://urldefense.com/v3/__http://changqing.li__;!!AjveYdw8EvQ!fu8ZgV=
hqx6-gTH5HK3ploud4sYOeN07Y-QBQseosoDoeG7EdjNhWwwBCGKqQXh-mZhMOXASG8P90qiw=
YdFZ_AXn9tMDYxw$>=3Dwindriver.com@lists.openembedded.org>=20
> a =C3=A9crit=C2=A0:
>
>     From: Changqing Li <changqing.li@windriver.com>
>
>     Using `set` to define positional parameters in the current shell
>     causes
>     those parameters to persist. When another script is sourced in the
>     same
>     shell without explicit arguments, it unexpectedly inherits these
>     positional parameters. This change prevents such unintended
>     propagation.
>
>     Signed-off-by: Changqing Li <changqing.li@windriver.com>
>     ---
>     =C2=A0bin/bitbake-setup | 2 +-
>     =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>
>     diff --git a/bin/bitbake-setup b/bin/bitbake-setup
>     index 75be90940..7f77bda55 100755
>     --- a/bin/bitbake-setup
>     +++ b/bin/bitbake-setup
>     @@ -184,7 +184,7 @@ def setup_bitbake_build(bitbake_config,
>     layerdir, setupdir, thisdir, update_bb_c
>
>     =C2=A0 =C2=A0 =C2=A0def _make_init_build_env(builddir, oeinitbuilde=
nvdir):
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0builddir =3D os.path.realpath(bui=
lddir)
>     -=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D "cd {}\nset {}\n.
>     ./oe-init-build-env\n".format(oeinitbuildenvdir, builddir)
>     +=C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D "cd {}\n. ./oe-init-build-env
>     {}\n".format(oeinitbuildenvdir, builddir)
>
>
> Sadly, dash does not support this (I used "set {}", to enable its=20
> support).
> Maybe use "set --" to remove any added positional argument? That seem=20
> to work:
> =C2=A0$ dash
> $ set A
> $ echo $1
> A
> $ set --
> $ echo $1

Thanks,=C2=A0 I will update with a V2 patch.

//Changqing

>
> $
>
> Regards,
>
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0initbuild_in_builddir =3D os.path=
.join(builddir,
>     'init-build-env')
>
>     =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0with open(initbuild_in_builddir, =
'w') as f:
>     --=20
>     2.34.1
>
>
>     -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>     Links: You receive all messages sent to this group.
>     View/Reply Online (#18487):
>     https://lists.openembedded.org/g/bitbake-devel/message/18487
>     <https://urldefense.com/v3/__https://lists.openembedded.org/g/bitba=
ke-devel/message/18487__;!!AjveYdw8EvQ!fu8ZgVhqx6-gTH5HK3ploud4sYOeN07Y-Q=
BQseosoDoeG7EdjNhWwwBCGKqQXh-mZhMOXASG8P90qiwYdFZ_AXnBZyZ1XA$>
>     Mute This Topic:
>     https://lists.openembedded.org/mt/116465767/4316185
>     <https://urldefense.com/v3/__https://lists.openembedded.org/mt/1164=
65767/4316185__;!!AjveYdw8EvQ!fu8ZgVhqx6-gTH5HK3ploud4sYOeN07Y-QBQseosoDo=
eG7EdjNhWwwBCGKqQXh-mZhMOXASG8P90qiwYdFZ_AXnpWepkjA$>
>     Group Owner: bitbake-devel+owner@lists.openembedded.org
>     <mailto:bitbake-devel%2Bowner@lists.openembedded.org>
>     Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub
>     <https://urldefense.com/v3/__https://lists.openembedded.org/g/bitba=
ke-devel/unsub__;!!AjveYdw8EvQ!fu8ZgVhqx6-gTH5HK3ploud4sYOeN07Y-QBQseosoD=
oeG7EdjNhWwwBCGKqQXh-mZhMOXASG8P90qiwYdFZ_AXkFZYk5mQ$>
>     [yoann.congal@smile.fr]
>     -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>
>
>
> --=20
> Yoann Congal
> Smile ECS
--------------IjPd00PnRIdjl14PcmWklqpD
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 5AP3mcfP3344169

<!DOCTYPE html><html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body text=3D"#000000" bgcolor=3D"#cceed0">
    <p><br>
    </p>
    <div class=3D"moz-cite-prefix">On 11/25/25 15:49, Yoann Congal wrote:=
<br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:CAMSfU+5eewRwOVNLL-VmJgsAXpZUdX=
koLO6FfcSizGp3vJpY6w@mail.gmail.com">
     =20
      <strong>
      </strong>
      <div style=3D"border:solid #9c6500 1pt;padding:2pt;background:#fcfc=
03"><strong><class=3D"msonormal" style=3D"line-height:11pt"><span style=3D=
"font-size:11pt;color:#000">CAUTION: This email
              comes from a non Wind River email account!</span></class=3D=
"msonormal"></strong><br>
        <class=3D"msonormal" style=3D"line-height:10pt3"><span style=3D"f=
ont-size:10pt;color:#000">Do not click links or open
            attachments unless you recognize the sender and know the
            content is safe.</span><br>
        </class=3D"msonormal"></div>
      <div>
        <div dir=3D"ltr">
          <div dir=3D"ltr">
            <div dir=3D"ltr"><br>
            </div>
            <br>
            <div class=3D"gmail_quote">
              <div dir=3D"ltr" class=3D"gmail_attr">Le&nbsp;mar. 25 nov. =
2025
                =C3=A0&nbsp;08:34, Changqing Li via <a href=3D"https://ur=
ldefense.com/v3/__http://lists.openembedded.org__;!!AjveYdw8EvQ!fu8ZgVhqx=
6-gTH5HK3ploud4sYOeN07Y-QBQseosoDoeG7EdjNhWwwBCGKqQXh-mZhMOXASG8P90qiwYdF=
Z_AXlO84kBcw$" target=3D"_blank" moz-do-not-send=3D"true">
                  lists.openembedded.org</a> &lt;<a href=3D"https://urlde=
fense.com/v3/__http://changqing.li__;!!AjveYdw8EvQ!fu8ZgVhqx6-gTH5HK3plou=
d4sYOeN07Y-QBQseosoDoeG7EdjNhWwwBCGKqQXh-mZhMOXASG8P90qiwYdFZ_AXn9tMDYxw$=
" target=3D"_blank" moz-do-not-send=3D"true">changqing.li</a>=3D<a href=3D=
"mailto:windriver.com@lists.openembedded.org" target=3D"_blank" moz-do-no=
t-send=3D"true" class=3D"moz-txt-link-freetext">windriver.com@lists.opene=
mbedded.org</a>&gt;
                a =C3=A9crit&nbsp;:<br>
              </div>
              <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                From: Changqing Li &lt;<a href=3D"mailto:changqing.li@win=
driver.com" target=3D"_blank" moz-do-not-send=3D"true" class=3D"moz-txt-l=
ink-freetext">changqing.li@windriver.com</a>&gt;<br>
                <br>
                Using `set` to define positional parameters in the
                current shell causes<br>
                those parameters to persist. When another script is
                sourced in the same<br>
                shell without explicit arguments, it unexpectedly
                inherits these<br>
                positional parameters. This change prevents such
                unintended propagation.<br>
                <br>
                Signed-off-by: Changqing Li &lt;<a href=3D"mailto:changqi=
ng.li@windriver.com" target=3D"_blank" moz-do-not-send=3D"true" class=3D"=
moz-txt-link-freetext">changqing.li@windriver.com</a>&gt;<br>
                ---<br>
                &nbsp;bin/bitbake-setup | 2 +-<br>
                &nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
                <br>
                diff --git a/bin/bitbake-setup b/bin/bitbake-setup<br>
                index 75be90940..7f77bda55 100755<br>
                --- a/bin/bitbake-setup<br>
                +++ b/bin/bitbake-setup<br>
                @@ -184,7 +184,7 @@ def
                setup_bitbake_build(bitbake_config, layerdir, setupdir,
                thisdir, update_bb_c<br>
                <br>
                &nbsp; &nbsp; &nbsp;def _make_init_build_env(builddir,
                oeinitbuildenvdir):<br>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;builddir =3D os.path.re=
alpath(builddir)<br>
                -&nbsp; &nbsp; &nbsp; &nbsp; cmd =3D &quot;cd {}\nset {}\=
n.
                ./oe-init-build-env\n&quot;.format(oeinitbuildenvdir,
                builddir)<br>
                +&nbsp; &nbsp; &nbsp; &nbsp; cmd =3D &quot;cd {}\n. ./oe-=
init-build-env
                {}\n&quot;.format(oeinitbuildenvdir, builddir)<br>
              </blockquote>
              <div><br>
              </div>
              <div>Sadly, dash does not support this (I used &quot;set {}=
&quot;,
                to enable its support).</div>
              <div>Maybe use &quot;set --&quot; to remove any added posit=
ional
                argument? That seem to work:</div>
              <div>&nbsp;$ dash<br>
                $ set A<br>
                $ echo $1<br>
                A<br>
                $ set --<br>
                $ echo $1 <br>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <p>Thanks,&nbsp; I will update with a V2 patch.</p>
    <p>//Changqing<br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:CAMSfU+5eewRwOVNLL-VmJgsAXpZUdX=
koLO6FfcSizGp3vJpY6w@mail.gmail.com">
      <div>
        <div dir=3D"ltr">
          <div dir=3D"ltr">
            <div class=3D"gmail_quote">
              <div>
                <br>
              </div>
              <div>$</div>
              <div><br>
              </div>
              <div>Regards,</div>
              <div>&nbsp;</div>
              <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;initbuild_in_builddir =3D=
 os.path.join(builddir,
                'init-build-env')<br>
                <br>
                &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;with open(initbuild_in_=
builddir, 'w') as f:<br>
                -- <br>
                2.34.1<br>
                <br>
                <br>
                -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
                Links: You receive all messages sent to this group.<br>
                View/Reply Online (#18487): <a href=3D"https://urldefense=
.com/v3/__https://lists.openembedded.org/g/bitbake-devel/message/18487__;=
!!AjveYdw8EvQ!fu8ZgVhqx6-gTH5HK3ploud4sYOeN07Y-QBQseosoDoeG7EdjNhWwwBCGKq=
QXh-mZhMOXASG8P90qiwYdFZ_AXnBZyZ1XA$" rel=3D"noreferrer" target=3D"_blank=
" moz-do-not-send=3D"true">
https://lists.openembedded.org/g/bitbake-devel/message/18487</a><br>
                Mute This Topic: <a href=3D"https://urldefense.com/v3/__h=
ttps://lists.openembedded.org/mt/116465767/4316185__;!!AjveYdw8EvQ!fu8ZgV=
hqx6-gTH5HK3ploud4sYOeN07Y-QBQseosoDoeG7EdjNhWwwBCGKqQXh-mZhMOXASG8P90qiw=
YdFZ_AXnpWepkjA$" rel=3D"noreferrer" target=3D"_blank" moz-do-not-send=3D=
"true">
                  https://lists.openembedded.org/mt/116465767/4316185</a>=
<br>
                Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@list=
s.openembedded.org" target=3D"_blank" moz-do-not-send=3D"true">
                  bitbake-devel+owner@lists.openembedded.org</a><br>
                Unsubscribe: <a href=3D"https://urldefense.com/v3/__https=
://lists.openembedded.org/g/bitbake-devel/unsub__;!!AjveYdw8EvQ!fu8ZgVhqx=
6-gTH5HK3ploud4sYOeN07Y-QBQseosoDoeG7EdjNhWwwBCGKqQXh-mZhMOXASG8P90qiwYdF=
Z_AXkFZYk5mQ$" rel=3D"noreferrer" target=3D"_blank" moz-do-not-send=3D"tr=
ue">
                  https://lists.openembedded.org/g/bitbake-devel/unsub</a=
>
                [<a href=3D"mailto:yoann.congal@smile.fr" target=3D"_blan=
k" moz-do-not-send=3D"true" class=3D"moz-txt-link-freetext">yoann.congal@=
smile.fr</a>]<br>
                -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
                <br>
              </blockquote>
            </div>
            <div><br clear=3D"all">
            </div>
            <br>
            <span class=3D"gmail_signature_prefix">-- </span><br>
            <div dir=3D"ltr" class=3D"gmail_signature">
              <div dir=3D"ltr"><font face=3D"Raleway, regular">Yoann Cong=
al</font>
                <div><font face=3D"Raleway, regular">Smile ECS</font></di=
v>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
  </body>
</html>

--------------IjPd00PnRIdjl14PcmWklqpD--

