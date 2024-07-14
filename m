Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A67C3DA42
	for <webhook@archiver.kernel.org>; Sun, 14 Jul 2024 13:03:49 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.15877.1720962221411486254
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 14 Jul 2024 06:03:41 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=79255a1817=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46ECYGSa002225
	for <bitbake-devel@lists.openembedded.org>; Sun, 14 Jul 2024 06:03:41 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40bs3frpkf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sun, 14 Jul 2024 06:03:40 -0700 (PDT)
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46ED3ebT011814;
	Sun, 14 Jul 2024 06:03:40 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 40bs3frpke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jul 2024 06:03:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVjzAglJp5+4iX3cdKXgGjhDqYYLmqJi1SzL4hfs4tAWTW+HIdWxqPjnZ1KAGVlwQ/gKN4ZWQ0CIpaHvxgQC19vOJjnZdgyR3D+XK+8jyBBh68GK2gdtqvWgFUWgvJd7FJBVbxiIjO1hQeqmsq4Hhc38irA5YBfZ4CZiPdFsMfEorm+IwH/CNd7GZM3Ge09keOeUDm2PtTnEUJJAffp5hjEsayHQviF3w/xkzxFYzxukufE7tTXsZXsMcm7yjw+wg+0DZz7gr2pSPqU+slulE4zLKmTRTxP7z45dHQoFttlTzwWfnqZP+ecPWnXpcUMVUImq7oAsTjsr8kwynDVaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ydRK4wQiSTL97jRtTfQ8gLyEliRaAEJrJjrEZix6+wk=;
 b=FE/VeEyCxnBmWyLuXbtKoN1MWkoE2JOz/mSCRMdxoadNUUMwkSY2/S4HjOLw09Is3UlV0iMdRMKSYlKQ4J/NunrQ+6dJkf3wV4arGEr7aNBzhX6BWGUXElyD1xOVPIou9NNrpgIsiRdCJzdk8lSYXB9WTgLEoq1+AxE7B/PJbOz5qkdrSOmXprFOTReDTLzt50TOkfMnXgrfB6EHE7OFCpsyAbwO3CwTMQsgLGmgPy34X16F3mZCfi/Rcn6ZlGblkMDFbKPoek4bsNE5LjnXNyVKs0B8pzhFtHjXHC/eY5tft+KgVBHoOLnFRIC5X70dR1ghAkTbmL1Csz9D7d8ZEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by MN6PR11MB8104.namprd11.prod.outlook.com (2603:10b6:208:46c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.24; Sun, 14 Jul
 2024 13:03:35 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d%7]) with mapi id 15.20.7762.025; Sun, 14 Jul 2024
 13:03:33 +0000
Message-ID: <6b671da0-070e-4f1c-a7cb-a3331f363a05@windriver.com>
Date: Sun, 14 Jul 2024 21:03:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 1/1] fetch2/git: Use basename for
 gitsrcname when ud.proto is file
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
References: <cover.1719033434.git.liezhi.yang@windriver.com>
 <8121be4437aeae47c5b1d6870e1561b2b088198f.1719033434.git.liezhi.yang@windriver.com>
 <96618974b45a07b06a312079646c6bf49c1474d8.camel@linuxfoundation.org>
Content-Language: en-US
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <96618974b45a07b06a312079646c6bf49c1474d8.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: TY2PR01CA0002.jpnprd01.prod.outlook.com
 (2603:1096:404:a::14) To LV3PR11MB8531.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|MN6PR11MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: 931cdb6b-2046-4252-2b87-08dca4055deb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y1hGZCs4cnltS253em8vTGo4TmZQditHTG01OWxjTkNPQit5dW9rVlp5bEpn?=
 =?utf-8?B?a1gwNzhrSStFSWFPU3hOd3ZvZHdTcnRYYmgvM3NxSEdsSEhzM2RVSVVrVkIy?=
 =?utf-8?B?ajhlR3RTS0s2cWJGYS9yRFVadWFwSndtK0I5R1hVcXpwTk1Mc3o1OWU2eW5k?=
 =?utf-8?B?U2g3TElvMjVTK2M5RUs2UGc1MFBwWjM0d25qY1p2dTJLaDlsTlpFejF1OVdj?=
 =?utf-8?B?cEVrZkNGSDAzTmg3MzdFVlY5bS9KK3VVdHhGTXZndytqeWkxNVh5OFU5cTRw?=
 =?utf-8?B?NEdXTVNHRDdGZTgvaUJPNkRDdnVkOTJIV3pLM1JnYmRuKy9BUkdUWDRxTHEw?=
 =?utf-8?B?bDZmNlhlZE1QREZveGkwVjhRbTl6TlpBb1ZhNy9YRFUzWks4dHB1Sy9KendU?=
 =?utf-8?B?UFdKYTg2SDRoNkl4MEZUN3hVSHFqSmIwbUQvSFA4YlRWc0dycTJWcFlSMjcx?=
 =?utf-8?B?eWxiaGpGQmRQeVM2SHUwZWs5a2FlTjZCUVI4MXgxeW10UU9mYUVwWXQ2N1Ra?=
 =?utf-8?B?ZW9sVHhvQjVGaXJyMEl0cjRMdGhsZEZraGNETlpLMmJNTGhkdDhmY2ErNElR?=
 =?utf-8?B?Yys0TmE1QUMxRnNITjZBbXM1elZCcVlMNHhlRFFPNDNseWVYZGNZSWE2aVN4?=
 =?utf-8?B?MzhuaFErY1lyRzZvemZmV3JwU3RGd2JJaTZaVkRaYmhCTEwzMHdvNmFHWEU3?=
 =?utf-8?B?U1hwWEI1QVR4bEFuUzJiWkd0VkxQdWMrUmRUVFlPNTNsbzU2Y0lSb0w1cUpV?=
 =?utf-8?B?Z1J0UGw2SkNReEdmWTUzcFBnTmhkbDg4VVRvVEZzclEwMHc4RUFRUjhucVZp?=
 =?utf-8?B?MUptdURHNEhadWp5NDlqdFVTck1OMXorTFBva08yNnFJT3hBeUFxVTVrWFZQ?=
 =?utf-8?B?aTVaSERObWM3TkV3dWNwQ3k4ZTRSYVNpSUt3eFVlZW5memN0ZVQ1eWhCVjli?=
 =?utf-8?B?WUdSNkM3djRTTkc5aVgwUDJNT3FkL2dMbXFXS095c3JiNlhTQW5GVUh1RFI0?=
 =?utf-8?B?NnZCK3lwR3RuenBoNnpEbjA3MkFRQ3pUakF1L2grQVN2d3crU2hhaTBrRkhS?=
 =?utf-8?B?TmpoaDBEcllGWXBCNjVRRnR6SXprWGE5M3cyeTBnK3dSN0duY2xrM2FGWXFP?=
 =?utf-8?B?UkpibExrMlRTU04wUUtBZk45Z1VvUkJtNmdqZGljbFlEVjRkaWNTUGp2NHhX?=
 =?utf-8?B?OXNKT0tNQXdvdEFjeStjeWp4MnFjWFlYV1RTYkdaNlRpUjdjaEcydVFHdHAw?=
 =?utf-8?B?d1VNSkZ3TGY2R1B1Q2lMMjZvdER1cUZoZzdSUjhKc2phYTVNNFUyYlExeWVQ?=
 =?utf-8?B?MTNQV2xyellNbFVPNWFkSlRaYWM3NStMZ1Q3a2pKUkVla3E5R3Fxb2xzVURm?=
 =?utf-8?B?ZHM4Q0xObXRhVTZmcjFja2l5SEo1STlsYUZOV2VFeUJUdEJDMC9wYVhNcVVx?=
 =?utf-8?B?a1lJZG4xTkN3T2l1bjR2VkNNWjJqcFBzNGhNeTFmNStweW1qRWZ2VVFGK1Z6?=
 =?utf-8?B?enQ0UXB4b2VHSmd1M1ZjZ1VBOFJ6WUpCYUhCdFNOdkR2NGVVR0lTTUFZbFNp?=
 =?utf-8?B?Rjg2TlpxOXlaNXhBQzRVVGRsNXp2MEVqakxnNmt5am9DM1M0ZmlONkE4YktY?=
 =?utf-8?B?Vmp4cVRBRERHd0FwOFMwNmVCUDBRSFB6SWxjeWxzQlRSdnl0M1FwQy9lN3l3?=
 =?utf-8?B?dFRkZFNqVjFaTnF3VXBFOS9Bc1NkeGpOd3BhZW1zUGVma1dKREd5Y2RhY1Fq?=
 =?utf-8?B?MWNMZ2JTdnBuVXFTUUNoZHQ3dmRWeDU3TEs0OUZxN3VxZGgxZlorQWZzOUZ2?=
 =?utf-8?B?T2RTSW1zNFptSlNrWjFrdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d3V5aWQ1cWVnb0xBREVKR0RCMEFXUHQzR3BpbnhEWUg5ODE2aU5QR0NJam8z?=
 =?utf-8?B?bzZxaFM4aW8vNjVlMlNPN00yWVBrQnpHNGNJWFV6SkFOemZCVmJtK2ZhbThD?=
 =?utf-8?B?WFg5STdBV1hHUHd6OElpQ0pHdlVGREJqU2p0NDBWekpCVWdyMFFDSmdpUjlZ?=
 =?utf-8?B?L2h2cXBMSnNhRytOWDJEZHlFU21KZzB3SERqdCtnN09HaXZENjlJc0ErSFFr?=
 =?utf-8?B?ZjJmN0hqdys5Mm1YaTRPelVINlpUeldpUHRsTUxJT2pVTXZLdGF3SXZlbkcx?=
 =?utf-8?B?VHQ5bDF0d2tEV3dEckpOSkpCZiszdElrTVhJL3JxS3QzZlI3ZDFudC9aMjMw?=
 =?utf-8?B?cW5RbUx0a0R6aGpvWE1lM04wSWlqL2o3cjNNcXVqa2Z2TnVxQXNVZElMR1lh?=
 =?utf-8?B?V0VZakZ2aUQvTWx5RlNFcHgzQSs5WXJnTk5SOE1pc2U0L3g2OVQwV2NJS2Fs?=
 =?utf-8?B?cW5ZSFRIbTVNbDdTSjZlazlZT3dKZ3UxdVFpSVZIRmpDNzY3VWhVd1UvYm90?=
 =?utf-8?B?bnhIYlJxVnN5VG9vZjF5eHZJOThzL3BaQXpDcnkxRFNBR1daczBEbVExZ3Jo?=
 =?utf-8?B?RkRNODR2OFRxeDgrZm5FaGc0Tlp0MmNKanIrb1A2ck04bnRDSUFxbjlMaEY0?=
 =?utf-8?B?dFlkK0VySlNyQzZvaU1Ka1hTNDFXaktBZFlYa3c3RStGQ2FYaGtqL0RZU3Qz?=
 =?utf-8?B?RWZsNkJKdVMwQ1laM3p0OWR4WFpJcVhuOFhreEdhU2pTTWoxaWd0OVM2Ukw5?=
 =?utf-8?B?T2Fvd3ZDUGhZMmxqRzh2UElIa1htbXVGTmF6K2ZIWG45NkNaVzJJN093Rlk0?=
 =?utf-8?B?b1IreHJWKzAzRElaUDg0ZHJ2Si9SSVlxS1NTaTV2dW5jNFl4TXc0VmdpZzVw?=
 =?utf-8?B?TWxoaWR0Z2N4cHBZcUxXc3FVVmNqYWcrREpyMVYySVVXc1FXNHVsY3htamlu?=
 =?utf-8?B?cW8vSmhtcnRvN3d1RDE0NVBJY3QrL1Noa3FWRkt3akhqMkFBR1FnK2czYWlI?=
 =?utf-8?B?TlY1dndLdkduby9SVU1yR3dZNk5lOFpVY0VKOVdQSk1mTHE1RDRzUHkxcXUv?=
 =?utf-8?B?cFR4a24wbEJXVVNRODJTOE13K1VGYkh6N1lHTjVLdXlRL0VDMlJUaUZ0R3lP?=
 =?utf-8?B?SkFNbmhNdW00RXlnMmNkSnZteDR0MWVhRnNSWGZpdHp5dUtMMnFqcDlCMUZG?=
 =?utf-8?B?M3VhQ0xIaG1ja2FPeGozRmVpaExQbFBNd3Y3SVZGaDF5Vml1TnRvQkh1eWlB?=
 =?utf-8?B?a1NqOEhBYjE1eklwMTVoWVZQQ1NBYTYxVWpBcENxalV4ZlRPb0h2Zi95eXIz?=
 =?utf-8?B?dWY5cWovalNHd3hJV1A0NGNtZ1dzNlcwc1pGczJidnBMK0FOeTNtTW5HWDNz?=
 =?utf-8?B?b095dG03akNxYmhwNTU2V05rWUFxSGtVOGRrZDVrRWFrVElCUVZ2emtvdkZV?=
 =?utf-8?B?RVZuM2doenBuaG5JTzZuNFd6TE45azhiYUhQM2s0bjQwYzQ2Q214dmNkb0FR?=
 =?utf-8?B?d0UvbGhEQVFKVVMzUFlscFBXRGFOMzhrOU12Z0dCUE1YeDdNMjYySXVUTkNN?=
 =?utf-8?B?R1VhSVBhQ0ZsRDJVeTgyejF0ZkJ4cXUrY2dSYmVKU0JuVXVMMnJkM0hDb0Yv?=
 =?utf-8?B?Zm1HbUJmTGhnRFp4Y1lOKzBDRENxYjIvNHdYRXlBWnNWL1RSeXF6QXR4aU1L?=
 =?utf-8?B?cVpKYWdZWll6a2FKem5hZ1JDSVgzVCt1U0wzTjh4YTlPODUydFRRTkJWU2x0?=
 =?utf-8?B?dmcrek1ybHNJNnVnaFQyRkFlQXBod0JuanFiMWJ2ampxOHdEREhaallBc2o4?=
 =?utf-8?B?VXZSaDB6Rjd3ZUlPSlQ4WStRanVYdURrZXFpTERkTWR6ak1seFBkVzVaR1JT?=
 =?utf-8?B?UWt5L3dacmxVZW5mTUdpWStPcnRwZ0NGYU84eDdicTVUbVQwbVR1QWhLcjBG?=
 =?utf-8?B?dmNxK0xsMVNsN3NvREFxNjlSRmthaUNkVng5bFhvYklOTW1LU2tYZWJMYXdM?=
 =?utf-8?B?eXllWnJ0Yk5QVkRlcHpweXd2bTdrc2J0MGd3NXdZTXBWQ21hYjRiZk4yRnpx?=
 =?utf-8?B?UzlUZENBS1k2VG55YzUwSUZweXQ2bS9IaFVwV1NhZk4yNDBHYVE1bFYzY3hC?=
 =?utf-8?B?d05kOUlTOUgwVWJTcXVya1J2ZVhidkZkVEV5SEZUcTBzKy9GZnZvUnpEeGV6?=
 =?utf-8?B?aFE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 931cdb6b-2046-4252-2b87-08dca4055deb
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2024 13:03:33.7927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JS+U+4Gg/nyQnP/bRDuswzd5MORsUM+/CiqvipIA3faNJ+/tZ87cl2kcjT4v0tFk3ETtsAvGGT7Oz/nVGmFxgK+26IV+xA/I91W36n153WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8104
X-Proofpoint-GUID: nrehekGBAtO1S1mHt6FjPSQRliTP69Yg
X-Proofpoint-ORIG-GUID: o5Y1O3AX-_bshK6ovmjVWi_GAieBlwPD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-14_11,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2407140104
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 46ECYGSa002225
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 14 Jul 2024 13:03:49 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16420

Hi RP,

On 7/14/24 19:17, Richard Purdie wrote:
> On Fri, 2024-06-21 at 22:20 -0700, Robert Yang via lists.openembedded.o=
rg wrote:
>> From: Robert Yang <liezhi.yang@windriver.com>
>>
>> The previous code added local path to generated mirror tarball name wh=
ich had
>> two potential issues when fetch from local PREMIRROR, for exapmle:
>>
>> Add github.com.lsof-org.lsof to /path/to/local/PREMIRROR/
>> $ bitbake lsof -cfetch
>>
>> * There might be "Fix File name too long error" when the local path is=
 long
>>  =C2=A0 since the path is translated to filename and added to download=
s/git2/ as:
>>  =C2=A0 path.to.local.PREMIRROR.github.com.lsof-org.lsof
>>
>> * When enable BB_GENERATE_MIRROR_TARBALLS:
>>  =C2=A0 The tarball name will be:
>>  =C2=A0 git2_path.to.local.PREMIRROR.github.com.lsof-org.lsof.tar.gz
>>
>>  =C2=A0 The above tarball can't be re-used by do_fetch since bitbake l=
ooks for
>>  =C2=A0 'git2_github.com.lsof-org.lsof.tar.gz', but the 'path.to.local=
.PREMIRROR' in
>>  =C2=A0 the file name breaks the match.
>>
>> Use os.path.basename(ud.path) as gitsrcname when ud.proto is file can =
fix the
>> the above two issues, now the file name in downloads/git2/ is:
>> github.com.lsof-org.lsof
>>
>> And the generated tarball is:
>> git2_github.com.lsof-org.lsof.tar.gz
>>
>> Or when BB_GIT_SHALLOW is enabled:
>> gitshallow_github.com.lsof-org.lsof_2e4c7a1-1_master.tar.gz
>>
>> And the tarballs can be re-used by do_fetch.
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>>  =C2=A0bitbake/lib/bb/fetch2/git.py | 5 ++++-
>>  =C2=A01 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.=
py
>> index c7ff769fdf..89d3268f7f 100644
>> --- a/bitbake/lib/bb/fetch2/git.py
>> +++ b/bitbake/lib/bb/fetch2/git.py
>> @@ -277,7 +277,10 @@ class Git(FetchMethod):
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ud.unresolvedrev[name=
] =3D ud.revisions[name]
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 ud.revisions[name] =3D self.latest_revision(u=
d, d, name)
>>  =20
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gitsrcname =3D '%s%s' % (u=
d.host.replace(':', '.'), ud.path.replace('/', '.').replace('*', '.').rep=
lace(' ','_').replace('(', '_').replace(')', '_'))
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ud.proto =3D=3D "file":
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gi=
tsrcname =3D '%s' % os.path.basename(ud.path)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gi=
tsrcname =3D '%s%s' % (ud.host.replace(':', '.'), ud.path.replace('/', '.=
').replace('*', '.').replace(' ','_').replace('(', '_').replace(')', '_')=
)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if gitsrcname.starts=
with('.'):
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 gitsrcname =3D gitsrcname[1:]
>>  =20
>=20
> I started to review this, then I started wondering why we have mirror
> tarballs being created for local file:// urls? Does that make sense?

This patch fixed two issues:

1) "File name too long error" when fetch from PREMIRROR
2) Git mirror tarball contains local path when file://

Create git mirror tarball for file:// doesn't make much sense, but the pr=
oblem
is the first issue, there would be the error when len(path) > 255 (The NA=
ME_MAX).

// Robert

>=20
> Cheers,
>=20
> Richard

