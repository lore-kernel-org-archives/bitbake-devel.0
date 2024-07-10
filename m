Return-Path: <changqing.li@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D37B6C3DA41
	for <webhook@archiver.kernel.org>; Wed, 10 Jul 2024 03:28:26 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.5941.1720582102064948141
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 09 Jul 2024 20:28:22 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=79218d4b95=changqing.li@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A2frfk015723
	for <bitbake-devel@lists.openembedded.org>; Tue, 9 Jul 2024 20:28:21 -0700
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 407170k7ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Tue, 09 Jul 2024 20:28:21 -0700 (PDT)
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 46A3SLfd014931;
	Tue, 9 Jul 2024 20:28:21 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2045.outbound.protection.outlook.com [104.47.74.45])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 407170k7ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 20:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFVrBQr2MVZKGs7Fya9dH49POuVDuG78IVMzcuBOt62i+lsSiOYTf87uZPzCR5ld021p3bapTDL2YsEqULDzjuhH8+Y/nintQrPqHBKxkOdzmYMSKht8TnqA2AxwtAMGHSgzBrDc+2FEu7uYI25RrPgEScly8rgtH/2IBzkO5gFEIwm2PswdGpebLLPhBtt57ElxaFBkY1nNiJ2bApHB0tFI9mwoHSqlO/KmH7c5ONdRY9mDDgziQQUXq6utygmcXpWDbk+UOpOQnUzlvz08I55bNkQWCYiq/IMlBqWJr+6yIMmyIK62S27+aFNwNQUOVhSF4oq3L7AjiJwByo9TAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pLKUN6un28TL48qoQwf7Ch4aC2nOB98kMvMDS94t5wA=;
 b=eG8xQQJKcmxY51j93k1gsyRa32uhhxlTu4T4Nc76PtSnVi2MWcXPSSfAukx/HoGMhZbQEakh9D/2f8oDqzWOS37Zk1LCZZaLL8E3S8+ZtPjpSEi/8IxENoeFmaHLB/QqFPAjRwAXmKnIUcDkTrNMmw6AjZsvDWm3SwYpEHVYKz07YUEpCab9DC0bylHXKj1Gd2H4N7lAC4DuC2FN+UViMr1mw4gJpYOtZFI3gdCNjm3r/x4vVkwrzI2eLGs7y9p3UZOSnLa/ztZs81iOhsV9EzVG1LJ5FgnDFyeHchYd+MM2rGnoW1/rdeMZTMy+G69Jc00y89u6jsp19Xai/NLyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS0PR11MB7312.namprd11.prod.outlook.com (2603:10b6:8:11f::18)
 by PH7PR11MB6930.namprd11.prod.outlook.com (2603:10b6:510:205::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 03:28:15 +0000
Received: from DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c]) by DS0PR11MB7312.namprd11.prod.outlook.com
 ([fe80::8436:b2d3:31a9:1c8c%4]) with mapi id 15.20.7762.016; Wed, 10 Jul 2024
 03:28:15 +0000
Content-Type: multipart/alternative;
 boundary="------------RZajq0G3S6yGCj8Z4Ga7Ehc3"
Message-ID: <4f80eadd-a1f5-4b4e-99a9-e0340b466088@windriver.com>
Date: Wed, 10 Jul 2024 11:28:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] bitbake-worker: skipping disable network
 when unprivileged userns is restricted
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        Alexander Kanavin <alex.kanavin@gmail.com>,
        ChenQi <Qi.Chen@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
References: <20240708081034.1474312-1-changqing.li@windriver.com>
 <CANNYZj9+c=BQ_zH5vXM35s2Sw=KTRiieprn4TNcWvOXY4xXV4Q@mail.gmail.com>
 <0032b64c-7e46-dc46-d6e1-143ae3fef03b@windriver.com>
 <CANNYZj-VrBHoqGK3fzTxZLwPB3CiuhQT4azQrt=Wcw=qRsnO-Q@mail.gmail.com>
 <5a5820df-602f-4e9c-a0f4-a7982cf76927@windriver.com>
 <ef64c37a7fa679d58d34dc3fa31020788bc308f2.camel@linuxfoundation.org>
Content-Language: en-US
From: Changqing Li <changqing.li@windriver.com>
In-Reply-To: <ef64c37a7fa679d58d34dc3fa31020788bc308f2.camel@linuxfoundation.org>
X-ClientProxiedBy: SI1PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::10) To DS0PR11MB7312.namprd11.prod.outlook.com
 (2603:10b6:8:11f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7312:EE_|PH7PR11MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 975d7af5-d2b1-4173-d181-08dca09055e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y0piL2phNTFBNXo5YzhzcUIyMjRyQ2RlNjZmeC9Lc2hyQUhMUjR4RDN0RkxL?=
 =?utf-8?B?REd0MFA4bkY5UmYxVE5IcFN6WnpaM3hJUjhUS29xZ3oxVFdrT0tPT3NuZW1n?=
 =?utf-8?B?aXVSZXVKbEhxWThaUWxOaXV5SFM3S2xrRDc2OUVRL3dUbGpvRGx6QkNTMFFZ?=
 =?utf-8?B?VkNBdEJybUtMVGRtVmF3QkEzUXJUQW5pZ3VXdXZnMFdmSHNKNmZJNnB2V25T?=
 =?utf-8?B?SVJab0FYaDhESVVaWGNmSUdMT1dSTFhaQlRVMzNaNHM1eVRBSXJLUk1RVGdM?=
 =?utf-8?B?SUMyc3NYQ2RlY2RYbXJoV2VnYnhnTENNV1lDWFhpZVc5K2J0QzQ2cG9RK0Vk?=
 =?utf-8?B?QU9IUXFSOHhBWUlBS08zMHFza29YOHBCamc4WEJIU1E0LzRqOENQNUMydWdZ?=
 =?utf-8?B?RnFZUGpRak9oeWY2QXY3ckcvSTdRLzBOemxGWisxRkM5bGcvbWpYTDJjdFM2?=
 =?utf-8?B?UmdEYUlZdCtyNXFuOWVlc0NJMmVZK2FGWkVEcHVWNWp0Z0FoY2F4cW1TZnZJ?=
 =?utf-8?B?czBtRlBJeHBpNzNpMmhuRmdUMk5KZFpVelEvb2dWa1dNVHkrRnlJaFExeVZZ?=
 =?utf-8?B?UjRwZklqODhKbDBhU2JGWUd1S09VMTArOTVESHZSSU9ZaklKTDY5M2dEd1Bv?=
 =?utf-8?B?WWZrL1p5VzRGc0s5OWNNdkQwWHFma25iSk42NnN4cy9CUUptVlhUUUZ4NHBn?=
 =?utf-8?B?eFY4RFBaSmtTeEE2cUdyKy9KdTFEOWlNVFdOazBvc1lpbXhDNTdoS0VtV1NK?=
 =?utf-8?B?Y0ZRNjRxSCtxdFR4eHNWWDJqSkNnTExQTy9HN3Z3UEdWbDlIV0Y3QUtyRFlJ?=
 =?utf-8?B?KzJhQXB5cjY5Rmw0cU95TEJ0RWM4ZFRvTTdsWGt5NmZYV0h4UXBLTHFUOWV3?=
 =?utf-8?B?bjV2MkM5Z0p5MWZWVlhJMnI5SzZiRzJCcFhEZzBCVlQ4N3dpaWxsTGcwTnRp?=
 =?utf-8?B?V1U5UWQyeDVUbGFzcDdxUTdRdDBzM1gyNmFHWkdYVlBqam5MUU1nL0JtbXJL?=
 =?utf-8?B?RDdDaFBaemZCbVRpeStUckovVVVuTXZRbkd3RjBNMVF3M3R4SmI3WGtDTTRo?=
 =?utf-8?B?dlRhanY5cXNFVXBDTDUyZ1NOQlZkcDR3dnNjbmhFb29RN1Y4T1NKRm9zRE5L?=
 =?utf-8?B?cW8rQWlyUEZKT1lJNC9KYldiMmp6Uk5JNnFLZGF4QkV5cFVxRStRYmRFbDBl?=
 =?utf-8?B?VHMvUVNIZkVqN0hVcXhKWHJFakFORy9YVmxRaG9wTzVORzJoSmdkZGorN1ZC?=
 =?utf-8?B?emZPcHV3SjNBbUx0eFh4ZHJ5ZzZmS3pDcTV0RjFRcDdpc3Fjcm9lai9Ed2Jn?=
 =?utf-8?B?ajZCbUFpazZSRUtlMjdnUmpVNklnOXhEZ1JQMms0dEFwUFFtNFh5Z0ZxT3Jw?=
 =?utf-8?B?dFZEZisrZDVhZUFuZXZFOUFka3FLaE9jZmFPdWhRUHpEZ1c4VnYzbGtZS1pP?=
 =?utf-8?B?a3NoRkVqOEIvNDUwRkFrUkgxV3hidGtCdm1vRnpEbW5mMThLRDR2ZWpFYTl3?=
 =?utf-8?B?Mjd3UEFkbGgybkpEWkJ2a3dXKzd5YmZEK0RzUG9vbzlrUDdKMlVKb21pUmtN?=
 =?utf-8?B?bDlZMmFvZjk4N3kxRms5cDA0YjdHZFJYdmZIN2VVbXRaZmlpaEVoOURhMG5B?=
 =?utf-8?B?Y010eFhhREloaStSdGVaaGR3bzgxM3JobFBTTlkwQUl2UHM2bzBQMjZrMmtG?=
 =?utf-8?B?ZmxJS2JFWWJrRk5SaDNwWEQ3SDJ5SlZwQWlQaW5oK2tlOHpaVXdyNTI2cWhr?=
 =?utf-8?Q?lZj2T+AJkiVxAhZWD8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7312.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R3VBVGFseHRuZk13VmNRRko5Z1JWUzhtZXhkUVlMWnRwMXVQcUJhM25HbHB1?=
 =?utf-8?B?VTAzMkNvdk1kNXEzNnhXUGVOb0IyVUNybGRMTjVxYkxKM2tGS0NFZ25GR1RU?=
 =?utf-8?B?dWE4T2w4Ymt3TlFybmpzTzZBNDBzOXRZcmh1NUFHTHdicVRUUFFzdm1IeDhB?=
 =?utf-8?B?VmJ5WVVRWjAzTTRTcHpHbkZnNUV0Q3VKcEtQM2xRNTRRZ0xLZVZRb25KU1BE?=
 =?utf-8?B?cWllYzMySDFSTHRsM3Q3dFd1OEp6b2JIV1FUTVE0d25md0d4ZXcxNm82My8y?=
 =?utf-8?B?TjNXeDVDVXV2RndrSGJLL3NVYnJaZXFBWEtPVFhLWGVQell6N0Q1bjdtTTNQ?=
 =?utf-8?B?VEJITHhhSk5wdnhSS1c3dmt2T1hBb2N3MSs3ZHJ0akNiMDByUU5nOTBWQkY5?=
 =?utf-8?B?RWFYNC9WaUNSQjR4aVEwOHNGUnpVV1NBL0RpbFlTOENUNjlaNkhDUGRwQ2xy?=
 =?utf-8?B?UkRhcVpIOXp0VnlqYTdPR3BPWC9RbTZOaVJTMUxnQ2lxRjA3YVZIU0dsK1FH?=
 =?utf-8?B?SU84V2d4QUVzQTNIaTdWYmNRTWNHamt5MHU3QzUrNVB5c1ZBOGJYd2J3TytG?=
 =?utf-8?B?cHM2Z0VMYmxlZ25WVXlXdDI3TVppQU9leWVzM1JnRXhXOWpGeWJqekhUbEtu?=
 =?utf-8?B?NW84ZTY0blptaDRSdGVFbzIxYUdmL2VqOUltVU1Ndk4zVzJETjB4ZnA5d3E3?=
 =?utf-8?B?WS80ZEVuMTl0V1dtelNTN29FeE5BUlN0cjNkT2htVEpqWWV0U05Rdk50ZHdk?=
 =?utf-8?B?Q091RGhKRUpFcDNIQkJtQlMrMmFXNkt1OHNYNnliU0R1b1RZYkJNSzZqWHF0?=
 =?utf-8?B?SEtaVGZiV1B6UWVtVWc3djJDWVNWdDkvZHFiZEVnL0RwMkRLNVoyem44WWZp?=
 =?utf-8?B?SHd6TUdFb3VaMndmQ3ZNVEhUb1RvZWtwTDdFd1pFN00zZEZvZmRsdWdYdjhL?=
 =?utf-8?B?d3ZMc2tpRTdOakRVZzFEOXBaeWJYb3J1SFVyWHdiVHdwRVRRZ05LS1BkazB5?=
 =?utf-8?B?Ti9KZHcxQ0NScWp2MHBIOHRrcFByMTlNdjZielJITTJJVFVmMk5vRnVRdWdM?=
 =?utf-8?B?VTdFZUM4K3BHamNldFpBOU5qVC9xWVIrMXRLOWhCVlN6WkFBTXpmaHQzMndB?=
 =?utf-8?B?MWt4bGlSQVBoa1ZtR2Q3enB5aXZ5VHYxOHJxVHVhMGllQWJUemZCalhKcDlr?=
 =?utf-8?B?R0ZBU2Y3alFrSGtRcnVUZndwZ1l1cHl2RGdTeVBPc0I5VVdrdXVuaGhzbFFQ?=
 =?utf-8?B?SDdiUVdCWnhuRWkwUEYwMzAvTnhtLzdYRUpWeHFYakxGWmppbDJtY0duRzgw?=
 =?utf-8?B?bm5veWVaNlRqTjhWTXo4dG1Qbk1xd2VaVysyK3UvNFEzL0FEL1NIdEx1OU50?=
 =?utf-8?B?VUJNbXVVK3FoMmMzanYvTEdjLzI1QjZMQkhHN0JZakxUT01DWHA5TGUybGs2?=
 =?utf-8?B?dFpqZjFCbVJWWWx6dmx2Tm9tVjhscTFoNS92dFExMURGK2JETU9qZVBlVEtO?=
 =?utf-8?B?N3NZMDYzV2ZNRjJDVzFzSEhkdHFuM2dTRFhwWnZaKytZL2poODFlRmZMN2dL?=
 =?utf-8?B?NSsraGUyaDNQSHJ5eGUrcE9aeXRJN2pVZTNzN1d3U2svSXJZY0FoTEVHNlZi?=
 =?utf-8?B?aFFrOVN2Q0JpZnRIWTNvZzZ0MmxaWXAyRnJJNEx4bnBscDJBbWZVOUFFQ0lt?=
 =?utf-8?B?OTdxVmhSVmFVM1UxOVRpcjJmcXhyU1E3RFNva1UrT1dOclNqZStSV294SGJ6?=
 =?utf-8?B?S3puQklwNkVFSU51b3NPMXkwZUlqdXEvT2tOYUJBeUZVcmx4emE5NjNBbVpW?=
 =?utf-8?B?cnNKeVlWSTkvZnUrSWhTeldyVTlNMVpjWjl6MVAvK3JIWUs3SXVQeHo5WDA2?=
 =?utf-8?B?ZGFsN2VtSHVXdjRDdWkzNDNxRE5MUVdseE5BTXJhTUVaUkdidXFlOUxBd3hX?=
 =?utf-8?B?QW1TUU52TENYb1dMT2RmWGtycnFxTTJpaVJzcHlFZnAwL04rRU8vMnpDWmRS?=
 =?utf-8?B?eHRIalJ0a254bUpEOEs5dmFPR0JOR05UY0hoQmFacnZ1SFdORm5DbWI3VGdn?=
 =?utf-8?B?bm1tMi80aDM2SDVhOEN6U2oxTnJrV2s3dXEyNXVCZDRDK1hrbFJ3OTFBZ1BQ?=
 =?utf-8?B?RTZzOGJyZjhHTVNHWE1nVVRhdDFHRzAwR0JDVEJKMG55RXJtMTRubTgzck9v?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975d7af5-d2b1-4173-d181-08dca09055e5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7312.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 03:28:15.7508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: js5rkslh3m3pt1PRryIXGd6edHrz8ybarfltaRBwtv2XAW8fM3ZJHYJaQ4e4TdK2zVYzCgVpckLrpkaRVHYCGF/6xKy0ATkVqE4sNuWLzPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6930
X-Proofpoint-GUID: 7X_KuNNmT_4uIHOSFho6iu9AtLhF5eCZ
X-Proofpoint-ORIG-GUID: guQ0bjJIyK3mxKn07p0hx4EogNfZ14i2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_12,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 bulkscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2407100026
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jul 2024 03:28:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16414

--------------RZajq0G3S6yGCj8Z4Ga7Ehc3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 46A2frfk015723


On 7/9/24 18:58, Richard Purdie wrote:
> CAUTION: This email comes from a non Wind River email account!
> Do not click links or open attachments unless you recognize the sender =
and know the content is safe.
>
> On Tue, 2024-07-09 at 10:41 +0800, Changqing Li via lists.openembedded.=
org wrote:
>> On 7/8/24 17:25, Alexander Kanavin wrote:
>>> On Mon, 8 Jul 2024 at 11:12, ChenQi<Qi.Chen@windriver.com>  wrote:
>>>> This problem has reported to Ubuntu for 4 months. It was discussed o=
n
>>>> the Yocto mailing list. People seem to be waiting for Ubuntu. I'm no=
t
>>>> very optimistic about getting a solution from Ubuntu.
>>>>  =C2=A0I do not agree. The last comment  (#10, added two weeks ago) =
in
>>> https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2056555  show=
s
>>> how to create an apparmor profile specifically for bitbake, so once
>>> this is added to apparmor upstream and makes its way into Ubuntu the
>>> problem will be solved. At that point the forced network disabling
>>> will become unnecessary and damaging. Ubuntu release notes imply
>>> they've done it for things like Chrome and Discord, but they expect
>>> more to be added:
>>>
>>> https://discourse.ubuntu.com/t/ubuntu-24-04-lts-noble-numbat-release-=
notes/39890#security-improvements
>>>
>> I think applications like Chrome, thunderbird etc are commonly used ap=
plications by user, so they are might in
>> ubuntu's package repo,  so they will support it and add profile for it=
 by default.  But for bitbake,  it is mostly
>> for developer and and not support by ubuntu.  And considering  there m=
ight be many other softwares meet this issue,
>> so I am not optimistic that ubuntu will add default profile for all th=
ese softwares.  so maybe we are still on our own.
>> One option is using this patch,  so users don't have to struggle on th=
is problem, don't need sudo, don't need an apparmor profile etc,
>> but have the side effect that skip disable network,  we need to balanc=
e which to choose.
>> One option is document or  notice message in oe-init-build-env,  sugge=
st user to disable unprivileged_userns or write a profile for bitbake.
> I do not want to just stop disabling the network silently so the patch
> as written isn't an option.
>
> I'm also not keen to make oe-init-build-env too complex, it is meant to
> be just enough to get us into bitbake, nothing more. Adding sanity
> checks there is the wrong place. This could happen in the normal
> sanity.bbclass code but we need to make sure it triggers when a user
> upgrades their existing distro.
>
> I think we should open a new ticket with ubuntu specifically about
> adding a profile for bitbake and see if we can get a definitive answer
> on whether we can add a profile for it or not. I'd suggest a new ticket
> so we don't get confused with the comments in the one linked above.

file a new ticket=20
https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2072615

let's wait to see if the recommended profile can be acceptted.

Regards

Changqing

>
> Cheers,
>
> Richard
>
>
>
--------------RZajq0G3S6yGCj8Z4Ga7Ehc3
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#cceed0">
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 7/9/24 18:58, Richard Purdie wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:ef64c37a7fa679d58d34dc3fa31020788bc308f2.camel@linuxfoundation.org">
      <pre class="moz-quote-pre" wrap="">CAUTION: This email comes from a non Wind River email account!
Do not click links or open attachments unless you recognize the sender and know the content is safe.

On Tue, 2024-07-09 at 10:41 +0800, Changqing Li via lists.openembedded.org wrote:
</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">
On 7/8/24 17:25, Alexander Kanavin wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">On Mon, 8 Jul 2024 at 11:12, ChenQi <a class="moz-txt-link-rfc2396E" href="mailto:Qi.Chen@windriver.com">&lt;Qi.Chen@windriver.com&gt;</a> wrote:
</pre>
          <blockquote type="cite">
            <pre class="moz-quote-pre" wrap="">
This problem has reported to Ubuntu for 4 months. It was discussed on
the Yocto mailing list. People seem to be waiting for Ubuntu. I'm not
very optimistic about getting a solution from Ubuntu.
&nbsp;I do not agree. The last comment  (#10, added two weeks ago) in
</pre>
          </blockquote>
          <pre class="moz-quote-pre" wrap=""><a class="moz-txt-link-freetext" href="https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2056555">https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2056555</a> shows
how to create an apparmor profile specifically for bitbake, so once
this is added to apparmor upstream and makes its way into Ubuntu the
problem will be solved. At that point the forced network disabling
will become unnecessary and damaging. Ubuntu release notes imply
they've done it for things like Chrome and Discord, but they expect
more to be added:

<a class="moz-txt-link-freetext" href="https://discourse.ubuntu.com/t/ubuntu-24-04-lts-noble-numbat-release-notes/39890#security-improvements">https://discourse.ubuntu.com/t/ubuntu-24-04-lts-noble-numbat-release-notes/39890#security-improvements</a>

</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">I think applications like Chrome, thunderbird etc are commonly used applications by user, so they are might in
ubuntu's package repo,  so they will support it and add profile for it by default.  But for bitbake,  it is mostly
for developer and and not support by ubuntu.  And considering  there might be many other softwares meet this issue,
so I am not optimistic that ubuntu will add default profile for all these softwares.  so maybe we are still on our own.
One option is using this patch,  so users don't have to struggle on this problem, don't need sudo, don't need an apparmor profile etc,
but have the side effect that skip disable network,  we need to balance which to choose.
One option is document or  notice message in oe-init-build-env,  suggest user to disable unprivileged_userns or write a profile for bitbake.
</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
I do not want to just stop disabling the network silently so the patch
as written isn't an option.

I'm also not keen to make oe-init-build-env too complex, it is meant to
be just enough to get us into bitbake, nothing more. Adding sanity
checks there is the wrong place. This could happen in the normal
sanity.bbclass code but we need to make sure it triggers when a user
upgrades their existing distro.

I think we should open a new ticket with ubuntu specifically about
adding a profile for bitbake and see if we can get a definitive answer
on whether we can add a profile for it or not. I'd suggest a new ticket
so we don't get confused with the comments in the one linked above.</pre>
    </blockquote>
    <p>file a new ticket
      <a class="moz-txt-link-freetext" href="https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2072615">https://bugs.launchpad.net/ubuntu/+source/apparmor/+bug/2072615</a></p>
    <p>let's wait to see if the recommended profile can be acceptted.</p>
    <p>Regards</p>
    <p>Changqing<br>
    </p>
    <blockquote type="cite" cite="mid:ef64c37a7fa679d58d34dc3fa31020788bc308f2.camel@linuxfoundation.org">
      <pre class="moz-quote-pre" wrap="">

Cheers,

Richard



</pre>
    </blockquote>
  </body>
</html>

--------------RZajq0G3S6yGCj8Z4Ga7Ehc3--

