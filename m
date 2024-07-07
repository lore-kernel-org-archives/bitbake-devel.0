Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF48C30653
	for <webhook@archiver.kernel.org>; Sun,  7 Jul 2024 07:12:09 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.53941.1720336320018983607
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 07 Jul 2024 00:12:00 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=7918799487=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4676qoIc008772
	for <bitbake-devel@lists.openembedded.org>; Sun, 7 Jul 2024 07:11:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 406vw60r1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sun, 07 Jul 2024 07:11:58 +0000 (GMT)
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4677BwTR002144;
	Sun, 7 Jul 2024 07:11:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 406vw60r19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Jul 2024 07:11:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M5kdWw0AHM29GpxCtMBDl8YIfa1NtQfYOFtI9T9+0Ba2N7aGkJ7fyxUNFa92ezxyL9nZ7pMdZN5IwcId8oxRnVKAGI1pvlXHbFo0fzfnuch06b6PUKezF2r6GQxlW6pFYmZrSixPKz3dp9Om5NsMx+i91PJkZJCO+C8zM76lcf0ss2+iomwRcnz8eE1tmnlRktWQngcUcuZV9UMT3aB1R1aDm2ZiA+C1kPYcZKvbYLlE7KLTyPtyqPYm9fjpsSf2qrGhzIvOrJr/JmkPexRGku4OvG46XNSmXC6imt6FIxm0ASBdMEQfxaUFuzFm1hI/MObUyVUBOJKROaxVXAgyhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ia5hAHLEkSHp3VMpbqZ+siKDw8NzVX+zktwiS799zM4=;
 b=MXgMHPAE6mRUhJm50d9YpF21uYkS4KatqZ8A151hc31UGGd+1vNeHsTYBJY+iz6KwHSUwQCVjJ+WgSf+e+gOG8DhiYdE1FDzeOuhxvcyYrEmASoxm91bSy3aDgpamj0OdEYDiT+zQXEgyxW8KwsrF5wvsxx43mzFGwoTeWVZl/utXDja29oOkhSBAwhpjt4LxN0cDxBdf0k1A3WBWBhGgcebin95FJwP1Ap7cvo6j0DUpiSW2qZ+fLhmE+EqKTHg4hhsD+UWySKoz5uQgB5iUS6P1/iBbrNBNTI5r+hJGWLiksWwFDNoEPQSeLhCOeGvJxpIpYEU2LTztPOG0ysowA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by DM4PR11MB6360.namprd11.prod.outlook.com (2603:10b6:8:bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.33; Sun, 7 Jul
 2024 07:11:55 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::d341:6ff5:fce1:c6d%6]) with mapi id 15.20.7741.033; Sun, 7 Jul 2024
 07:11:55 +0000
Message-ID: <fb0a5c12-0ef2-487b-acec-41ae7c94407f@windriver.com>
Date: Sun, 7 Jul 2024 15:11:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH 0/2] fetch2/git: Use git shallow fetch to
 implement clone_shallow_local()
From: Robert Yang <liezhi.yang@windriver.com>
To: alexandre.belloni@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, andre.draszik@linaro.org,
        kergoth@gmail.com
References: <cover.1718886475.git.liezhi.yang@windriver.com>
 <2024070122132747f143a4@mail.local>
 <afe47796-7e3d-4666-8bda-c6c0e6486c02@windriver.com>
Content-Language: en-US
In-Reply-To: <afe47796-7e3d-4666-8bda-c6c0e6486c02@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SG2PR02CA0127.apcprd02.prod.outlook.com
 (2603:1096:4:188::7) To LV3PR11MB8531.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|DM4PR11MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 84647f92-86bd-4b7a-a9dd-08dc9e541510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|4022899009|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SHRhd0c3UnM1N1Uyd2lEQ0Y5YmtVdFpSS3dwVWpPWUJzQUxCNGV3RnN3aGc4?=
 =?utf-8?B?c0hXazRiVjlkcVp0MHBIY2hHZm00YVNwN2JmdjFUMmxsK3A2TjdDZ0ZvaU5W?=
 =?utf-8?B?WUY3eGl2dm9JblBYcUsrZSt6Z3owODI0QkR6bm9ON1J3N2dZZ3pqdFdPcERq?=
 =?utf-8?B?cGplTUdWZWlIWU0rUjFQc3UwejNORmhpdWlFZW5TRngxc1Q0emVkVVVpc0dt?=
 =?utf-8?B?ZFRzR1M4S0Y1MlZzcXliNDZsYzdJcS85ZEtDemlPK0RxTEdWeUx5SmZoZ0Rr?=
 =?utf-8?B?empBQmkxbjV0YklIL1lIeDZqWTVzWnAxR0l6ZGcrRVVCbTBCTGFKaW1VTG5R?=
 =?utf-8?B?N0hCekpqVVFtOWRRdTBwcE0zYkpyeVE1OGwzU0o2TXZCdG5HY09lYWhWem1q?=
 =?utf-8?B?WGQvb0U5WWFIYnVLZ2Q3b1laQ1lUZWg4VVhzdGJYaXJmZWczMjNFRGpDbnFE?=
 =?utf-8?B?ZWpFNzVRVzNFSjArQ2xaY1l2U2FqQ3p5YWJDa3dSdTJTbVArdit2cFJDcG1F?=
 =?utf-8?B?U1FhSTNCUnY4ZktEdjlMK0dXTzRLdmwveFFieVFValBkR2xCWUp4ZytNZStV?=
 =?utf-8?B?T0dJZGhVVXhwOGtDSWZsV2laNUxnZG1BbW40eU1oYVRxTjhHMGN2Yng4aW12?=
 =?utf-8?B?NERmZWRnaStPdGxZdTBHV2NZTGY0RTVwNWRCOHN6QlVKVXFiU2J5ZFRrU2dD?=
 =?utf-8?B?ditWV2JNWEZNbVltU2hVK1IyTkRXR2JpRlZXd1orS0JLNi9BaFlCbjJhdXhk?=
 =?utf-8?B?Mm9ZWkg3VXlZejg0RXE4ajhvMUovQ25XdURLY0pxSVpmY0dUMkhIKzJBYk0r?=
 =?utf-8?B?MEVTTTMzTTRBZ2lJeXkza0UwUmo0VzcvTzhPM1V4V1dtU3hVQk9oNXRNRFRS?=
 =?utf-8?B?ZEVFYlBMTmxpS1dXTjBxSSt1MFFiUU1FSUVwVUJSMVd1elpmZmFFd3hLSVpk?=
 =?utf-8?B?RGREVjlIb0hxcTh2RVBzdHY5a2tqeVdWWUtQRmhjSVBRTFlWdG9TMEg3Rkox?=
 =?utf-8?B?bDBRUEZwTUhuc3BuQXhBU1lKK1dFY2U5ZExLL0Vyb2lqZTM4SDF0L1lGZyt1?=
 =?utf-8?B?cXFkQTJVdTYyK2hBWEpIUDVyZGtsWlVzaHE4alg0M3VPbUpINXMvRDl6UHkr?=
 =?utf-8?B?aXhQRXRoTkJ0QmZhMC94Nnl1aFJQL05Eb0MvUXBGVnlBSmo4N2kxNzNZZlR6?=
 =?utf-8?B?bFRHR2VyUGV6K2RUVXBkZTVhV1liYmFuUStmQ0lVR1QxMjJ0bitKQ1E4aHpz?=
 =?utf-8?B?VnF6TDZYWm1CVWQyTlhpQmhib1FrY2pPcnVlcVU0VDI0YXp4b1JqZzRnd1Uw?=
 =?utf-8?B?ZWQzdHEwOUUwSFJaUURpY0JXMzYySThZVEtjUzZubFNFUEdGSFNuMjNXWnBL?=
 =?utf-8?B?MDZoelVFWGZHVnBxZHZzZ0FHYk9QQVhMQ0xua0FaVnpuT2p5YWM3Rkh4c3Ro?=
 =?utf-8?B?M2tjeWFNNWZDRVVUVnUyWllPNDhIbDBqM0F0Mi9oS3Bxa2dlK29vMjJGdXRM?=
 =?utf-8?B?VlhxNDZtTVdRSzFaekR6OWRGUko1MGdpT2RPNXg5MG52U3IyU1Y2Z3BsWjNt?=
 =?utf-8?B?U20wcGx1ZkhQY3orOEFHSy9IQzVPbWM1ZmFuam44Q1JKSldzUDd1YjJ0YjNj?=
 =?utf-8?B?WGJEVDdONk5oVHlqVTJ6NTNuR3N3QzIxVGUzSHZWYkpKUlNWbnJuK2M4OGNG?=
 =?utf-8?B?bm1yWFFGNEhEb3JZeVVFaXFQRVRtWEtFc0VRTVBJcjAyWmRrT1hXOWNJYkpP?=
 =?utf-8?Q?dxxXCkPWgj9BAxP+kI=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(4022899009)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M1lndENqQWhUckRQWGVTY2k5elZEVEVFYm1QVHlpNmw0Z1lDU09ocXEzRWZU?=
 =?utf-8?B?UzMrU3pLYjQra3hQeGR1QVh0eit4bVBNQjBWVWZ5eG0yUWgrZEppMnhoSk5N?=
 =?utf-8?B?WHBYR24yQ2FiSDZFZCtOVC9GdmdTYTA4SHRrRlYvVnE5KzFvTXltdmZMMDd1?=
 =?utf-8?B?c0pYdDd3c2gwNWhDQmlTbnJTdCs5QzFuMDQ4RnJOSHVQb0YwR01RTGhKS1RD?=
 =?utf-8?B?UVVBblpDamtTNHpTVHJhdktRTThxV2NJcWtuRThxdmYvWWJPcWJXMUYwR2kx?=
 =?utf-8?B?aFU1Y0JrOUhvd29wVWJWUnd0VjdveFJVa3M5OWhIdEpTTXJGQmY2UjJsdzZ2?=
 =?utf-8?B?WTRYSTVxREhUdEw1YTR2Y0hhU3VuMHIvMmVubTVxWjN0T1ZFMm80T01oa015?=
 =?utf-8?B?cFMzSVNFMjNYc2oyVHR3VER2YjdwL1I5ZGoycUtIUlRUemhQR3FCb0d5MEp5?=
 =?utf-8?B?ZGhNYVRSZXhWOEo2ZUFlZ1ZiVHp0NVRmV0ZZZHF6bTVzeUY4NGM1Y1lWd2xW?=
 =?utf-8?B?Z2FQUFB0SXZuNG5ueTIrQ1Q5UFNxMTN4UTFtdWtlNjFDWVRNbSsyMkNkQzVB?=
 =?utf-8?B?MFBzVjdQSVU3ZkxocTNpaDRwbk5oWk05enpBRWRiU1REWHRpUmdXSnBQRlhM?=
 =?utf-8?B?NVJxQUxMbnROa2VseXRJN08wWXdiWFFLa2ZWU1dNVXAxeWUzYnpVczdQZ1Nw?=
 =?utf-8?B?WTVkdXBQWURSWktVTjd6Q1hCU01yYlFyTFl2Z0dZaFBZU1E2c2REYUVpOFNa?=
 =?utf-8?B?VlhCckVJSW4yaFh3NWxDalRlMm9nQWdUbFEvUUduakN4b3g5U2ZqQzJLWWtZ?=
 =?utf-8?B?WmlSOVNKN1Axejc0ZFZSaVN5dCtGa1RyMkRrVUxOSHdIdnJLZU5seCt5S0hG?=
 =?utf-8?B?TWJNaXYxZ2RJNUpUeUZMWWUyYmtNcWkyQzhOR3J0bm9mQ2RvbVQ3OFNaUmZi?=
 =?utf-8?B?aTVyNnRqRFdCcUFiUkFKR3VDRzJnNzR4czJnZHdSYkFkYUNFS3NaRmhuQWVC?=
 =?utf-8?B?OVdueTNlTEpZdzU0aFkxSFNkZ1NkZGI2d1JQTHRtVVE4b2hkcmIxVUFsbGV2?=
 =?utf-8?B?aGxsVlduakdwaENzNlQ0YjI1bDd5MjFta1l1VHo0dFdCcEYvWFlDdHVLUkJQ?=
 =?utf-8?B?eTRGTTdTOFJYTnpjSzRXaEQrSHQvd0UrN2Z0OU5hei9DMGpPWEM5RWpzYWcw?=
 =?utf-8?B?ZkNFa01BZTQ2dkZlWjR5MGRoVWJCZytSZGh2d3BKaTlwYm5qM25zamZYUzhS?=
 =?utf-8?B?ckJQRFl4OTAzeVJkT3o3WWk2dXFhRVZyQmhQZ0Y4Q3JWdlUzMEtrNWU3Ny9n?=
 =?utf-8?B?R0t5SU00ejVNRWF2bW1xYWN3c2RmUUhyMFNTc3dsNTRacEhubFg2RGMyZXp4?=
 =?utf-8?B?cmE0bDNuVVpjdmxMZURlelVIYjlieWFZazVkRWJxNCs3NWV0UEdxVzF1aVNk?=
 =?utf-8?B?L041VmgxQktuSzB2Q28zNlNjWmFWZXR6TTQwRTZPdTY1bW81NERyRnZqblE3?=
 =?utf-8?B?SFdudkZhMENpekFydGRtNCtFcVkrL1hDSjZWSEV0V2l2RTQ2c2hRUzZjNUd3?=
 =?utf-8?B?Z292WXV4ZFVoTkFGMlhnbG1tYXBQeVNDdmE2SThWaHNlVE43Mnp3V2ppb3c1?=
 =?utf-8?B?c01lZHBESVY0WHp5MkZTZ2tDNHVrRERmUHZlUWxQYmhtYU1sSXFFZjFaU3J0?=
 =?utf-8?B?ZlhUZHJYa2srTVpQVG4wcWd3eFlDSUdBYTdXclRjUGJSOWcwWDFwT3ZXNVo4?=
 =?utf-8?B?VS9xQmhUakZPUjZ1YmYzZ1hFbXNFTVBlc3JHamFFQUt5Ny93SDBiRGRsa21Y?=
 =?utf-8?B?ei90dmtNMjRjK2h4TTRiSWZXdVZlNndsdmFzMFVHVDlGTnp1bThxb0Y4VC81?=
 =?utf-8?B?UjZpaUh6dlNIYklEd2JRdFJIaGcydlliRVE0L3Rqc0N2MFpqU2h3WHMzbjVS?=
 =?utf-8?B?cURCbUNKejJmdFF0Z0Z0VG92WDVwY1gwa1dMK1RYdDJBSGR2S1BDQkk1K29i?=
 =?utf-8?B?R1ZoU0htNmZ4cmFEUUQxSGZiQ2E4cUZTZEpPYkdJT2huZTN0RmlubFZyeGtL?=
 =?utf-8?B?b1M1QnRJNmwwam50RUVSdWplVUZ2VzEzWlIxYmd0VXpnMGdUZjI1TE1tTExy?=
 =?utf-8?B?S3pubUJ3dEFKbktLTXN0djEyZGtacWNJYmRJVmtrajhjemhuZGQzaDI4Mmlz?=
 =?utf-8?B?S1E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84647f92-86bd-4b7a-a9dd-08dc9e541510
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2024 07:11:55.1045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5/bxygNnprgC3kLHlSMRCNeEjsebT0IZs1ZAPS+5r3A6lFbEIyTlcuWsknxM9lPnXqr0+3yT+xRSJOMjekmciQA36BcknRHUvFF+G2g1mBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6360
X-Proofpoint-ORIG-GUID: qoXMHxWb9W9ekSBfyWszJ6VRlD_za3eA
X-Proofpoint-GUID: tGFjMx0yFY7yu1EvbXvzw6a1IBaY6ieN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-07_04,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 clxscore=1015 adultscore=0 impostorscore=0 mlxlogscore=996
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.21.0-2406140001 definitions=main-2407070056
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 4676qoIc008772
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 07 Jul 2024 07:12:09 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16393



On 7/2/24 15:31, Robert Yang wrote:
>=20
>=20
> On 7/2/24 06:13, Alexandre Belloni via lists.openembedded.org wrote:
>> Hello,
>>
>> This fails on our ubuntu 20.04 workers:
>>
>> https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/6923=
/steps/11/logs/stdio
>> https://autobuilder.yoctoproject.org/typhoon/#/builders/127/builds/354=
2/steps/11/logs/stdio
>=20
> Sorry, it might because the git version on ubuntu 20.04 is old, let me =
check how  > to fix it.

I had a ppa on my ubuntu host 20.04 which installed a higher version git,=
 that
made me didn't meet the error. I've tried pure ubuntu 20.04 from docker h=
ub, and
then reproduced the error, the fix is:

+            # Advertise the revision for lower version git such as 2.25.=
1:
+            # error: Server does not allow request for unadvertised obje=
ct.
+            # The ud.clonedir is a local temporary dir, will be removed =
when
+            # fetch is done, so we can do anything on it.
+            adv_cmd =3D 'git branch -f advertise-%s %s' % (revision, rev=
ision)
+            runfetchcmd(adv_cmd, d, workdir=3Dud.clonedir)


I will send a V2 for it.

// Robert

>=20
> // Robert
>=20
>>
>> On 20/06/2024 05:44:39-0700, Robert Yang via lists.openembedded.org wr=
ote:
>>> From: Robert Yang <liezhi.yang@windriver.com>
>>>
>>> * Test info
>>> =C2=A0=C2=A0 bitbake-selftest works well
>>> =C2=A0=C2=A0 bitbake world works well with the shallow tarballs
>>>
>>> // Robert
>>>
>>> The following changes since commit 5d88faa0f35f0205c1475893d8589d1e65=
33dcc0:
>>>
>>> =C2=A0=C2=A0 bitbake: siggen: catch FileNotFoundError everywhere and =
ConnectionError=20
>>> also in get_unihashes (2024-06-18 08:45:22 +0100)
>>>
>>> are available in the Git repository at:
>>>
>>> =C2=A0=C2=A0 https://github.com/robertlinux/yocto rbt/shallow
>>> =C2=A0=C2=A0 https://github.com/robertlinux/yocto/tree/rbt/shallow
>>>
>>> Robert Yang (2):
>>> =C2=A0=C2=A0 fetch2/git: Use git shallow fetch to implement clone_sha=
llow_local()
>>> =C2=A0=C2=A0 bitbake: tests/fetch: Update GitShallowTest for clone_sh=
allow_local()
>>>
>>> =C2=A0 bitbake/lib/bb/fetch2/git.py=C2=A0 | 71 ++++++++++++++++++++++=
-------------
>>> =C2=A0 bitbake/lib/bb/tests/fetch.py | 13 ++++---
>>> =C2=A0 2 files changed, 53 insertions(+), 31 deletions(-)
>>>
>>> --=20
>>> 2.45.1
>>>
>>
>>>
>>>
>>>
>>
>>
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#16383):=20
>> https://lists.openembedded.org/g/bitbake-devel/message/16383
>> Mute This Topic: https://lists.openembedded.org/mt/106779045/3616940
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub=20
>> [liezhi.yang@windriver.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>

