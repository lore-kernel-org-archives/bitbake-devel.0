Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99354C04A6A
	for <webhook@archiver.kernel.org>; Wed, 16 Aug 2023 03:29:46 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.153524.1692156584990070711
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 15 Aug 2023 20:29:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=lZ/zKYhM;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=75922d74d2=qi.chen@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G2xfJw015258
	for <bitbake-devel@lists.openembedded.org>; Wed, 16 Aug 2023 03:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-type:message-id:date:subject:to:cc:references:from
	:in-reply-to:mime-version; s=PPS06212021; bh=+3wj7flEb10VC86hL+8
	zl7aT5fVEcgB4D6EBTN8X/KQ=; b=lZ/zKYhMZka8gQ4YI/xAMmd0mSDR8qdy3Av
	cc19b3QC5B891AxlY3N6f/nuJz3dRaCWc8iQptjeQ3exK0QVdleWEHcyDWc/vAjw
	6JXVasKuNHwYC+3NNFQHRLkLJ7OQU6kRIphDM3k/hVONuIHAeQwJvhW4Gi9f4etj
	hExWS5bE7aix3iAKni6msRxXW/iHFfd6+WSCq/IIZGNSH9+N1JR1w+YAjbA+wTwK
	qMJftxwbS/Hsj4XuLm0cZwVnNlSztAbQ6t4ibIYqUUAXJCRxhfv1NqlAlGijYJBP
	7w1ePe1pYNrmwYFgf66bpQ2NUUNIyaPDseKBlODiN5T+5bwD4fQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3se125uf26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 16 Aug 2023 03:29:43 +0000 (GMT)
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.22/8.17.1.22) with ESMTP id 37G3SMZq016249
	for <bitbake-devel@lists.openembedded.org>; Wed, 16 Aug 2023 03:29:43 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3se125uf25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Aug 2023 03:29:43 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLSSGL8fL+3i6IgWEOikiSKWXkKc+XFvMJyyXJ165f6Yn9nBW4HIyMr+BK/vgRGzwtIDdkGaNFW2LE8f31oJZwT1OOzxY8PZTg/cVkhDK7bcTGUIm0tbDOx9sMf/RrDEM5uBdn7xY6HolhFdTTckagku0qDcDHw+G0sVbVZj0vO5dDv//R2iirNvHS+xZvD8niIemIwgC14V4+jSdj6lGGoR6MdJYZzmtVWQo19P6w2A0RLrB8DsZmgvWSnpS/PpMfYnt65TMHkL2KjahcY7MvyE0g+YX3/pUBbexqj7MRPy1axPOhwLgCDzMWghcZ7rSIg+HNZtulbEJcVA27dMkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQyEnCsBEGvHSYmEndMiw6iHfg6rh2uefBjCsRwHoBI=;
 b=M08vVgr1TuESHyGgGw/YOSuoSWkpSImzUX2MAl7grjQ4ZNwxL2vRXMOwurzyD+5GJiWf6Y/JEWQbgrJHWD+sA89i9FDKmR58YPOC77SXaNMfG1IKjb5JvgLB4oPG0ZjPE8hBPHUG7NXibDVzl3B6VBVPJqn4xFz1NgBKlG2uDXj4bNhfMOmtzIVhx0ONJsipAtV9V/quh+ZQUUDJj3R1xO+ANH2mJQuYD2bA8FBHGe8ZjPq4KU1hBK+OVqcv7w2yTA0P4hIFjLuWTM/13BF7yRy1HWtXQDydjUbeOWNG032pDvXVl+qvdK0VM+1xhAzc7PpotbjZEdG6F0us+9tC6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CO1PR11MB5057.namprd11.prod.outlook.com (2603:10b6:303:6c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 03:29:40 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::c237:6c70:114e:9022]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::c237:6c70:114e:9022%3]) with mapi id 15.20.6678.029; Wed, 16 Aug 2023
 03:29:40 +0000
Content-Type: multipart/alternative;
 boundary="------------n4mqJWAvqS4xucJ8d5Ryqe07"
Message-ID: <8e61f009-cbee-17b5-3c6c-ed2da7ede4ec@windriver.com>
Date: Wed, 16 Aug 2023 11:29:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [bitbake-devel][PATCH V4] runqueue.py: fix PSI check logic
To: Martin Jansa <martin.jansa@gmail.com>, randy.macleod@windriver.com
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
        "bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
References: <20230803075638.2355913-1-Qi.Chen@windriver.com>
 <ac05a465-6da7-3441-b45d-ab65c73f244d@windriver.com>
 <1c7bfcd4-3880-55a0-61d0-06d934d3e98a@windriver.com>
 <eb48693137116c26346d2eb07d726022d3525f50.camel@linuxfoundation.org>
 <CO6PR11MB5602151D76F55281E46F9E47ED0DA@CO6PR11MB5602.namprd11.prod.outlook.com>
 <5c8fe14bde6417035a38d9199f0457afe34db968.camel@linuxfoundation.org>
 <d951a160-5f09-4dc7-af82-ac647031b9d8@windriver.com>
 <CA+chaQcJbdEZzVhTGj2zROHXj7s6Wh+wjzA1fV94ve3tpUVXxw@mail.gmail.com>
Content-Language: en-US
From: ChenQi <Qi.Chen@windriver.com>
In-Reply-To: <CA+chaQcJbdEZzVhTGj2zROHXj7s6Wh+wjzA1fV94ve3tpUVXxw@mail.gmail.com>
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5602:EE_|CO1PR11MB5057:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ddd6387-208e-4dd4-c68d-08db9e0905b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	JuW5Xr2b/SILlkGILEqWZD9R1z1XcoUh6D0YIDmfutKCvHdmOnq95orP6AsG2pJ6rV9XBAE2edW5g333V9jTxPWOTmEWXmxqZ7sCqHydfklkAL/fh7SGmpyd+n3Xf0qoH+93YdpokXWCmjDtAw2pSgghO9GuXVA60rwHQ4ToUw7Ud2M4aZ4kZRBOKPXzjcN5k+2FSNBABacF0P1n68v5Nyqx1znvVpZMw5BSdCAzdSjGO/zGhLtUvRjUP1DIFmQDkCJ+PA8W1ezF0zzc2zl5YTRA2orzl2WQ2fOWjMw8vrSGfmCWpP3EdXseVbgf+amiAiBRlCEtQF/VUB6Z7FMCZUxkIjFx8mVFtVxH8EY/n26pEFHKOiiX3Wrwm2XVe2yGPm8HCCYWiG1aLRS2dOeEivbg/CMhDFyrUBgltQyzjiybXgTxrFoStD33BUBWOlTTmpi68Ps6FSzgiSgW9vvd35cy/wbxG8DLMLGXYMaQuF0m8XlUjAYj6oNn7LHMBk4ClqlQzVk9C/dDgx+pAOrlnYMHGoHSvgiR3pFWga3xOJnmtnlBt5vcegXe/2DaT7GTDUVu1rw9alSJEn4Y4WhTDdxjoRjMewx5yzO8LpOLNRexuFrnI9Gjb5fv9JQGvdYcsehyYJibR2qk1Htd+ELsoQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39850400004)(346002)(136003)(1800799009)(451199024)(186009)(6666004)(54906003)(31686004)(66476007)(66556008)(66946007)(6512007)(6486002)(33964004)(6506007)(30864003)(2906002)(478600001)(966005)(26005)(5660300002)(2616005)(83380400001)(6636002)(41300700001)(316002)(21615005)(53546011)(8936002)(166002)(4326008)(8676002)(66899024)(38100700002)(36756003)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d1hnem1TbzhZcUxuakpudE9RSkQwUDVQa05jdjRWTWluSDVLSVZvYUtYeExG?=
 =?utf-8?B?L2kzYzZGSDJMK1hWL1VHbHZ5WUIrSldPYVpZVTVUZFB6VkNZanY4TERtK0lm?=
 =?utf-8?B?R01DeENEc3lLa0FvbHNRNHdBam5RTlBSRDdMOTNSYjFOQklvMXg2aHVwc0ZQ?=
 =?utf-8?B?Um9YTjlGeHBlVzQwWmxNOUZBdUNFMm9YZTZqa0ZsT0FEMWNmWTdHMENhUGhX?=
 =?utf-8?B?M0cyUWh1L0V6U3djdXU0RCtQazlORjRrY1YzY3AwaEJxVkh4R25QVndtNnh3?=
 =?utf-8?B?a3FFMmxJVU93QXBYaDJJR3VrdWRPTGVzSlpnN0U1alRmdG40Zml6cHE3KzVk?=
 =?utf-8?B?dHptc2V5dFl5Q1J1MXVGV3QzSks4TzdIOGYxRHhVNjQ1eTdoN3E4aHQ5NEZL?=
 =?utf-8?B?S3BSWGVTaDE2ZUFBRjNrN3RETXcvVW8zOHdkanlBeDMwa1pndFQ3SlM1N3Y3?=
 =?utf-8?B?YmVyUUJ5TjBzMFFEQjVBTVZVUFRhVC9Oay9pQmJTdUpWYVJBNDlyZmhENmdx?=
 =?utf-8?B?Z0JKb2tjTzFCZ1orRXhKdWpvdmxYckVPM1FnQzJhOUIyNkI3TzVHajJxUlpi?=
 =?utf-8?B?TE1UL1B5UkV5UUNxaWhGMlhIdXZYMCszLy82TWN2Sjhrek1HVDNvWVZNVFpa?=
 =?utf-8?B?VlZoMG04M01tSzF6clJ5eEV5Yjl0bzJKUDJaZXNxNi9mdFhGTjdkNDI5THJL?=
 =?utf-8?B?U1llRGFFN01vbjNocCt1M2ZrTGZFQWRibjVJdVdtOVNmVnFETTlwODVET1A5?=
 =?utf-8?B?N3AzNzFNcW1abi9KdWZ3NE1saW03ZktYKzNLTTNyVlJ2NTk3aTdzOGNITUVG?=
 =?utf-8?B?aUNuVVpJdXY2c1ppN3Nic0hSNE9SSm80WDlaNytyQWFEMzMrTzMwa2VDZ1A5?=
 =?utf-8?B?Z09nYWV3YncrS1ppVzdXZEpvWmxMU1A2OHlFNU5QSVFUMVlHV3dxajJMVkIx?=
 =?utf-8?B?Kys1d2taNHBmUUtFVDJrc2pIZXlsdld1UHMreldXdlJvZ0wwcjJPY2g0ZmtC?=
 =?utf-8?B?TjBKNTd6UUQ0amlqaktkbG9UbmRwd3JLcERyTXMxUVpXZnhnbU5TTWFxRFFB?=
 =?utf-8?B?Vi9IRGNjcFI3dGhPZXAxUWVKQ3h0RjRZc25kdDhhOGhENXNONnNOLys4d0tQ?=
 =?utf-8?B?VWhKRlNIbmpndGg2eEdRNnh2L3B5eUZuOEQ3Wi9abXVLcGk0aEg3WTRoTytU?=
 =?utf-8?B?cEZxTU5scU1EVlBUV2tzWGY3TlBMYnVBN3FzRjF6cWpaV2NDLzllRnJacEVN?=
 =?utf-8?B?R2dZbnlCUUQvLy9qOTAwOUM1U3N2eGJSeU4vUU03VG5saWZkREJRT1hWeitO?=
 =?utf-8?B?T0R4YmcvVHJ3OW93dHovN0I4RjNYWGtpZEE5N2t6RWVISlJmRlN2Rlc0U2VF?=
 =?utf-8?B?L1hwZzZHNUcwUmdHNm9hRjhENjRJUjhDNkZyVGpuUm5seU5YRCtZRVJCenZG?=
 =?utf-8?B?L2hoUU1MUkVDQ0N0djFGQzZHc21tUFQ0ZFVDSzlnTEV5QjQ4aGZiTms5YlNh?=
 =?utf-8?B?VDhQRXdldHhwUVpkcFc4aWRWcVUzcjZ5eDh0UjlRTlJLei9OWlBWaUt5bEVo?=
 =?utf-8?B?TUdkTEU3NGs1RTk3akFvUkpYZjV2Q0h4YlladkQ0RkU3c1NZSWsyeHpWS0FH?=
 =?utf-8?B?ZUhGTWpFTHBaMng2RTFiUE8waTdPcFVMdmZjVllqVGo0MnhFVkYwUFpLZEg5?=
 =?utf-8?B?KzhrbzJ0ajVzL3NpK0NiSzVrOEk1OXB1SHhiSjc1anlqUlA4QlJaZStvUWd2?=
 =?utf-8?B?cG1nWENXeTcvblArRHdsUFh0Mjk2ZnVpa1ZueG10Y05MWDZheDZsZnVoZXha?=
 =?utf-8?B?cjN2RER5SktSUnIzeERqU2ZMK0pYeWM0U1NNSW9FZGhRNFdaWFE4by9vbEpS?=
 =?utf-8?B?VnVXQmJYL0d6SGg5eXR1SlN4OW5HQTBUb2xZUTlZK1U3RWx6Vm1WWDNqc2lT?=
 =?utf-8?B?M09YTzZBZnNYd3RjWkhLbEd0bW9PYlk0WUN5REl3a1lEOTdpRmM2RzhMZ3Bo?=
 =?utf-8?B?YnU3aFZJQTdma0pEa2lyL1RzU3hXTUFJcVJaZ1lmQm0wZEVhTXovdmdmbEkx?=
 =?utf-8?B?emwxTHZvaXJNM2U5bU9JRWk2Kzg1Y0swbURwYUkvMDVxZlZnMHZsTkUrWEpZ?=
 =?utf-8?Q?XO8ce8BNJKEbxGJgvt6gKk7va?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ddd6387-208e-4dd4-c68d-08db9e0905b8
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 03:29:39.8077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xcH5RgSkL5RsZlZkVtUQMeqTEELo91cxnujH8irKyYtSnz9epJRoJQblCzMTLLHVHnpdeMC76Gv6mILG61/qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5057
X-Proofpoint-GUID: p_Aen4XymKhi1-HSvLIhFmIDZtEwG4O5
X-Proofpoint-ORIG-GUID: Q_ej1fS0zVcbViwHUmUIlGRxQ7d_FpBz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_22,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2306200000 definitions=main-2308160031
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 16 Aug 2023 03:29:46 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14945

--------------n4mqJWAvqS4xucJ8d5Ryqe07
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 37G2xfJw015258

On 8/15/23 19:13, Martin Jansa wrote:
> there is still something wrong with latest pressure regulation, I see=20
> very high cpu pressure fluctuation and often only a few bitbake tasks=20
> running when the load isn't so bad
>
> NOTE: Pressure status changed to CPU: False, IO: None, Mem: None (CPU:=20
> 0.0/1000.0, IO: 0.0/None, Mem: 0.0/None)
> NOTE: Running task 207 of 1315=20
> (/OE/build/oe-core/openembedded-core/meta/recipes-devtools/gcc/gcc-sour=
ce_13.2.bb=20
> <https://urldefense.com/v3/__http://gcc-source_13.2.bb__;!!AjveYdw8EvQ!=
ZH11JLTlXWSmJ5ByhY-jU6bW7d7GeULdZpDpwS_ZhiLnUrFlp0pCghhUePQ2R9UDV_allduZ9=
rqsNZ1SkFJpXNU$>:do_unpack)
> NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU:=20
> 152474.1/1000.0, IO: 0.0/None, Mem: 0.0/None)
>
> this is with Load average: 7.40 8.32 11.41 on 32c 64t CPU and small=20
> bitbake patch I've just sent to show the pressure numbers in the=20
> existing NOTE to easily see the pressure numbers also on AB or jenkins=20
> builds.
>
> Attached log is from building rust with just oe-core and:
> BB_PRESSURE_MAX_CPU =3D "1000"
> BB_NUMBER_THREADS =3D "8"
> BB_NUMBER_PARSE_THREADS =3D "64"
> PARALLEL_MAKE =3D "-j 70 -l 140"
>
> What surprises me a bit is that it was running just 1315 tasks and the=20
> pressure status changed due to CPU pressure 244 times with highest=20
> pressure almost 200K even with Load average staying relatively=20
> reasonable. Memory pressure stayed 0 whole time and IO pressure was=20
> over 1000 (IO not being used for pressure regulation) in 75 cases with=20
> highest value of 330K.
>
> I'll rerun some of my test-oe-build-time benchmarks to see if it=20
> generates significantly different pressure now compared to:
> https://github.com/shr-project/test-oe-build-time/commit/a388df10f8eaae=
4437cf9931f7ccc6f86f1acaea=20
> <https://urldefense.com/v3/__https://github.com/shr-project/test-oe-bui=
ld-time/commit/a388df10f8eaae4437cf9931f7ccc6f86f1acaea__;!!AjveYdw8EvQ!Z=
H11JLTlXWSmJ5ByhY-jU6bW7d7GeULdZpDpwS_ZhiLnUrFlp0pCghhUePQ2R9UDV_allduZ9r=
qsNZ1Sg-hn6Fk$>
>
> maybe something else triggers these spikes as it's on my regular=20
> desktop with chrome and other stuff running on background, will be=20
> interesting to see the pressure fluctuations from our jenkins or from=20
> AB builds, it's much more convenient than pressure graphs from=20
> buildstats as it shows the exact values bitbake was using.
>
> Is someone seeing numbers like this?

Hi Martin,

Definitely yes.=20
https://github.com/ChenQi1989/poky/blob/io-pressure-logs/io_pressre_grep.=
log

Please also see my previous reply:=20
https://lists.openembedded.org/g/bitbake-devel/message/14924

Looking at https://docs.kernel.org/accounting/psi.html again, I found it=20
says:

"The kernel accepts window sizes ranging from 500ms to 10s, therefore=20
min monitoring update interval is 50ms and max is 1s. Min limit is set=20
to prevent overly frequent polling. Max limit is chosen as a high enough=20
number after which monitors are most likely not needed and psi averages=20
can be used instead."

I'm wondering if we should switch to using the monitoring capability as=20
stated in the doc.

Besides, I think we should start to set values much larger than 1000,=20
because 1000/1000,000 =3D 0.1%, which does not seem to be a reasonable=20
warning level. And the average load '7.40 8.32 11.41' means 7.4% percent=20
is stalled in the last 10s, which obviously is much larger than 0.1%. We=20
should start to set values such as 50,000 (5%) or 100,000 (10%).

Best Regards,

Qi


>
> Regards,
>
>
>
> On Mon, Aug 14, 2023 at 4:35=E2=80=AFAM Randy MacLeod via=20
> lists.openembedded.org=20
> <https://urldefense.com/v3/__http://lists.openembedded.org__;!!AjveYdw8=
EvQ!ZH11JLTlXWSmJ5ByhY-jU6bW7d7GeULdZpDpwS_ZhiLnUrFlp0pCghhUePQ2R9UDV_all=
duZ9rqsNZ1SiKvL7Sw$>=20
> <randy.macleod=3Dwindriver.com@lists.openembedded.org> wrote:
>
>     On 2023-08-13 04:36, Richard Purdie wrote:
>>     Hi Qi,
>>
>>     On Tue, 2023-08-08 at 05:55 +0000, Chen Qi vialists.openembedded.o=
rg  <https://urldefense.com/v3/__http://lists.openembedded.org__;!!AjveYd=
w8EvQ!ZH11JLTlXWSmJ5ByhY-jU6bW7d7GeULdZpDpwS_ZhiLnUrFlp0pCghhUePQ2R9UDV_a=
llduZ9rqsNZ1SiKvL7Sw$>
>>     wrote:
>>>     I implemented the logic you suggested below, but I found the 0 re=
sult issue remains.
>>>     I also checked my solution suggested in the previous email, but t=
he 0 result issue also remains.
>>>     So I added more logs to check the PSI data behavior. (I really sh=
ould have done this before!)
>>>     My setting is: BB_PRESSURE_MAX_IO =3D "1"
>>>
>>>     The result is a little surprising to me.
>>>     Seehttps://github.com/ChenQi1989/poky/blob/io-pressure-logs/conso=
le-latest.log  <https://urldefense.com/v3/__https://github.com/ChenQi1989=
/poky/blob/io-pressure-logs/console-latest.log__;!!AjveYdw8EvQ!ZH11JLTlXW=
SmJ5ByhY-jU6bW7d7GeULdZpDpwS_ZhiLnUrFlp0pCghhUePQ2R9UDV_allduZ9rqsNZ1SNf7=
l49o$> =20
>>>     andhttps://github.com/ChenQi1989/poky/blob/io-pressure-logs/io_pr=
essre_grep.log  <https://urldefense.com/v3/__https://github.com/ChenQi198=
9/poky/blob/io-pressure-logs/io_pressre_grep.log__;!!AjveYdw8EvQ!ZH11JLTl=
XWSmJ5ByhY-jU6bW7d7GeULdZpDpwS_ZhiLnUrFlp0pCghhUePQ2R9UDV_allduZ9rqsNZ1Se=
3ZPZMY$>  which is derived from 'grep io_pressure console-latest.log'.
>>>
>>>     There are lines like:
>>>     WARNING: io_pressure is 50448.00396988443; tdiff =3D 1.0781397819=
519043
>>>     WARNING: io_pressure is 0.0; tdiff =3D 1.015068531036377
>>>     ...
>>>     WARNING: io_pressure is 50448.00396988443; tdiff =3D 1.0781397819=
519043
>>>     WARNING: io_pressure is 0.0; tdiff =3D 1.015068531036377
>>>     ...
>>>     WARNING: io_pressure is 124236.79015441194; tdiff =3D 0.999937295=
9136963
>>>     WARNING: io_pressure is 186346.268013355; tdiff =3D 1.00002002716=
06445
>>>     WARNING: io_pressure is 0.0; tdiff =3D 1.0000898838043213
>>>     WARNING: io_pressure is 0.0; tdiff =3D 0.07874345779418945
>>>     WARNING: io_pressure is 0.0; tdiff =3D 0.03340554237365723
>>>     WARNING: io_pressure is 0.0; tdiff =3D 0.04926180839538574
>>>     WARNING: io_pressure is 0.0; tdiff =3D 0.012816905975341797
>>>     WARNING: io_pressure is 54966.74998052512; tdiff =3D 0.1193630695=
3430176
>>>
>>>     >From these logs, I'm starting to wonder if not using the average=
10/60 PSI data is a right choice in the first place.
>     Certainly 60 seconds is too long of an averaging time and
>     we concluded that 10 seconds was too long last year as well but
>     if we can come up with a test that shows that it's a good compromis=
e,
>     I don't object to that idea completely.
>
>>     I merged your v5 of the patch since that seemed to make sense to m=
e but
>>     I'm really not sure about the PSI data itself. That is something R=
andy
>>     looked into in a lot more detail than I did...
>     I've been focusing on CPU pressure and while I like your idea that
>     we can test the behaviour by setting the pressure limit (cpu, io)
>     to 1 and
>     checking if we only see only one task is running at a time, I
>     don't think that's a reasonable
>     expectation. It might work if we have a stress job running at the
>     same time that
>     keeps the system above the pressure threshold. Even then I'm not
>     yet sure how to deal with the actual data from the PSI especially
>     when we are polling it quite frequently. I suspect we should limit
>     how often we read the PSI data.
>     You have to remember that the value read from /proc/pressure/*
>     isn't updated on each read and
>     is the sum of N variables that indicate congestion in a given CPU
>     I need to read the kernel code
>     and lkml discussion again to understand why we see such large
>     variation in Total congenstion!
>
>
>     Let's ask a couple of simple questions:
>
>     What does the cpu/io congestion data look like and how quickly
>     after launching
>     a task, does the kernel reflect the new congestion state?
>
>     I was playing around on a 24 thread system by running enough cpu
>     burners
>     to have the system close but not yet experiencing contention. I
>     picked 20 cpu eaters.
>     Then, after collecting PSI info for a while, I'd start one more
>     cpu eater every N seconds.
>     I expected to see a nice square staircase but that's not what I
>     saw and I'm not sure why
>     yet. I was going to continue playing with that until I had figured
>     it out but maybe you
>     want to take a look as well.
>
>
>     I just had two scripts (see below but beware that this was playing
>     around so the scripts may
>     differ sligthly from the graphs shown here.)
>
>     1) collect-psi (should this run as a real-time thread and be
>     written in C to minimize impact?)
>
>     2) scale-cpu
>
>     Green points are the differences in some CPU Total values
>
>     Red line is the avg10 % from some CPU.
>
>     I think I scaled the avg10 % manually and tried to align them
>     until it was close enough
>     to compare visually.
>
>     It would be interesting to filter the raw Total data using your
>     updated algorithm.
>
>
>     You can see that the "stairs" are not nearly as sharp as expected.
>     Zooming in, you see that the data is quite noisy:
>
>
>     My next step was to under stand the impact of reading the PSI data
>     every 100 ms rather than
>     every 10 ms and to only launch a new stress cpu eater every 60
>     seconds or so in hope that
>
>     the PSI data would be more staircase-like as expected. Of course
>     bitbake wants to launch
>     tasks as quickly as possible so we do seem to have a filtering
>     problem.
>
>     Note that every after the ramp up and down of additional cpu
>     eaters has completed, there
>     are still times when (systemd and ??) cause additional cpu
>     contention but for short periods:
>
>
>     All for tonight.
>
>     ../Randy
>
>
>     =E2=9D=AF cat collect-psi
>     date +"%T.%6N";
>     for s in `seq 5000`; do
>     =C2=A0=C2=A0 for m in `seq 100`; do
>     =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 date +"%s.%6N";
>     =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #echo $s $m;
>     =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cat /proc/pressure/cpu
>     =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sleep 0.01;
>     =C2=A0=C2=A0 done;
>     done
>     date +"%T.%6N";
>
>
>     yp-ab/2023/stress-ramp
>     =E2=9D=AF cat scale-cpu
>     date +"%T.%6N";
>     date +"%s.%6N";
>     sleep 100
>     date +"%s.%6N";
>     stress -c 20 -t 2000 &
>     sleep 500
>     #sleep 2
>     for s in `seq 50`; do
>     =C2=A0=C2=A0=C2=A0 date +"%s.%6N";
>     =C2=A0=C2=A0=C2=A0 stress -c 1 -t 500 &
>     =C2=A0=C2=A0=C2=A0 sleep 20
>     done
>     date +"%T.%6N";
>     sleep 1000
>     date +"%T.%6N";
>     sleep 100
>     date +"%T.%6N";
>     date +"%s.%6N";
>     #sleep 50
>
>
>     I don't have time to explain how I filtered the data you'd get
>     from those scripts tonight but
>     if you look below, you can probably figure it out:
>
>     # produce total data (take diff in xmgrace)
>
>     $ rg "^1691|some" data/5000-sec-100-delay-100ms.log | paste -sd '
>     \n' | sed -e 's/some.*=3D//' | awk -e '{print $1-1691625397 " "
>     $2-40598616909}' > 5000-time-total-100-delay-100ms.dat
>
>     #produce avg data
>
>     $ rg "^1691|some" data/5000-sec-100-delay-100ms.log | paste -sd '
>     \n' | sed -e 's/some avg10=3D//' -e 's/avg60.*//' | awk -e '{print
>     $1-1691625397 " " $2}' > 5000-time-avg-100-delay-100ms.dat
>
>
>
>>     Cheers,
>>
>>     Richard
>
>
>     --=20
>     # Randy MacLeod
>     # Wind River Linux
>
>
>     -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>     Links: You receive all messages sent to this group.
>     View/Reply Online (#14940):
>     https://lists.openembedded.org/g/bitbake-devel/message/14940
>     <https://urldefense.com/v3/__https://lists.openembedded.org/g/bitba=
ke-devel/message/14940__;!!AjveYdw8EvQ!ZH11JLTlXWSmJ5ByhY-jU6bW7d7GeULdZp=
DpwS_ZhiLnUrFlp0pCghhUePQ2R9UDV_allduZ9rqsNZ1SKxz3b_0$>
>     Mute This Topic:
>     https://lists.openembedded.org/mt/100522098/3617156
>     <https://urldefense.com/v3/__https://lists.openembedded.org/mt/1005=
22098/3617156__;!!AjveYdw8EvQ!ZH11JLTlXWSmJ5ByhY-jU6bW7d7GeULdZpDpwS_ZhiL=
nUrFlp0pCghhUePQ2R9UDV_allduZ9rqsNZ1SIHpjiA4$>
>     Group Owner: bitbake-devel+owner@lists.openembedded.org
>     <mailto:bitbake-devel%2Bowner@lists.openembedded.org>
>     Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub
>     <https://urldefense.com/v3/__https://lists.openembedded.org/g/bitba=
ke-devel/unsub__;!!AjveYdw8EvQ!ZH11JLTlXWSmJ5ByhY-jU6bW7d7GeULdZpDpwS_Zhi=
LnUrFlp0pCghhUePQ2R9UDV_allduZ9rqsNZ1SZZ9zn1g$>
>     [Martin.Jansa@gmail.com]
>     -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

--------------n4mqJWAvqS4xucJ8d5Ryqe07
Content-Type: multipart/related;
 boundary="------------6LAuARGLNH0su1yIbZjTOBNp"

--------------6LAuARGLNH0su1yIbZjTOBNp
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 37G2xfJw015258

<html><head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dutf-8">
  </head>
  <body>
    <div class=3D"moz-cite-prefix">On 8/15/23 19:13, Martin Jansa wrote:<=
br>
    </div>
    <blockquote type=3D"cite" cite=3D"mid:CA+chaQcJbdEZzVhTGj2zROHXj7s6Wh=
+wjzA1fV94ve3tpUVXxw@mail.gmail.com">
     =20
      <div dir=3D"ltr">there is still something wrong with latest pressur=
e
        regulation, I see very high cpu pressure fluctuation and often
        only a few bitbake tasks running when the load isn't so bad<br>
        <br>
        <div>NOTE: Pressure status changed to CPU: False, IO: None, Mem:
          None (CPU: 0.0/1000.0, IO: 0.0/None, Mem: 0.0/None)<br>
          NOTE: Running task 207 of 1315
          (/OE/build/oe-core/openembedded-core/meta/recipes-devtools/gcc/=
<a href=3D"https://urldefense.com/v3/__http://gcc-source_13.2.bb__;!!Ajve=
Ydw8EvQ!ZH11JLTlXWSmJ5ByhY-jU6bW7d7GeULdZpDpwS_ZhiLnUrFlp0pCghhUePQ2R9UDV=
_allduZ9rqsNZ1SkFJpXNU$" moz-do-not-send=3D"true">gcc-source_13.2.bb</a>:=
do_unpack)<br>
        </div>
        <div>NOTE: Pressure status changed to CPU: True, IO: None, Mem:
          None (CPU: 152474.1/1000.0, IO: 0.0/None, Mem: 0.0/None)<br>
          <br>
        </div>
        <div>this is with Load average: 7.40 8.32 11.41 on 32c 64t CPU
          and small bitbake patch I've just sent to show the pressure
          numbers in the existing NOTE to easily see the pressure
          numbers also on AB or jenkins builds.<br>
        </div>
        <div><br>
        </div>
        <div>Attached log is from building rust with just oe-core and:</d=
iv>
        <div>BB_PRESSURE_MAX_CPU =3D &quot;1000&quot;<br>
          BB_NUMBER_THREADS =3D &quot;8&quot;<br>
          BB_NUMBER_PARSE_THREADS =3D &quot;64&quot;<br>
          PARALLEL_MAKE =3D &quot;-j 70 -l 140&quot;<br>
        </div>
        <div><br>
        </div>
        <div>What surprises me a bit is that it was running just 1315
          tasks and the pressure status changed due to CPU pressure 244
          times with highest pressure almost 200K even with Load average
          staying relatively reasonable. Memory pressure stayed 0 whole
          time and IO pressure was over 1000 (IO not being used for
          pressure regulation) in 75 cases with highest value of 330K.</d=
iv>
        <div><br>
        </div>
        <div>I'll rerun some of my test-oe-build-time benchmarks to see
          if it generates significantly different pressure now compared
          to:</div>
        <div><a href=3D"https://urldefense.com/v3/__https://github.com/sh=
r-project/test-oe-build-time/commit/a388df10f8eaae4437cf9931f7ccc6f86f1ac=
aea__;!!AjveYdw8EvQ!ZH11JLTlXWSmJ5ByhY-jU6bW7d7GeULdZpDpwS_ZhiLnUrFlp0pCg=
hhUePQ2R9UDV_allduZ9rqsNZ1Sg-hn6Fk$" moz-do-not-send=3D"true">https://git=
hub.com/shr-project/test-oe-build-time/commit/a388df10f8eaae4437cf9931f7c=
cc6f86f1acaea</a><br>
        </div>
        <div><br>
        </div>
        <div>maybe something else triggers these spikes as it's on my
          regular desktop with chrome and other stuff running on
          background, will be interesting to see the pressure
          fluctuations from our jenkins or from AB builds, it's much
          more convenient than pressure graphs from buildstats as it
          shows the exact values bitbake was using.</div>
        <div><br>
        </div>
        <div>Is someone seeing numbers like this?</div>
      </div>
    </blockquote>
    <p>Hi Martin,</p>
    <p>Definitely yes.
<a class=3D"moz-txt-link-freetext" href=3D"https://github.com/ChenQi1989/=
poky/blob/io-pressure-logs/io_pressre_grep.log">https://github.com/ChenQi=
1989/poky/blob/io-pressure-logs/io_pressre_grep.log</a></p>
    <p>Please also see my previous reply:
      <a class=3D"moz-txt-link-freetext" href=3D"https://lists.openembedd=
ed.org/g/bitbake-devel/message/14924">https://lists.openembedded.org/g/bi=
tbake-devel/message/14924</a></p>
    <p>Looking at <a class=3D"moz-txt-link-freetext" href=3D"https://docs=
.kernel.org/accounting/psi.html">https://docs.kernel.org/accounting/psi.h=
tml</a> again, I
      found it says:</p>
    <p>&quot;The kernel accepts window sizes ranging from 500ms to 10s,
      therefore min
      monitoring update interval is 50ms and max is 1s. Min limit is set
      to
      prevent overly frequent polling. Max limit is chosen as a high
      enough number
      after which monitors are most likely not needed and psi averages
      can be used
      instead.&quot;</p>
    <p>I'm wondering if we should switch to using the monitoring
      capability as stated in the doc.</p>
    <p>Besides, I think we should start to set values much larger than
      1000, because 1000/1000,000 =3D 0.1%, which does not seem to be a
      reasonable warning level. And the average load '7.40 8.32 11.41'
      means 7.4% percent is stalled in the last 10s, which obviously is
      much larger than 0.1%. We should start to set values such as
      50,000 (5%) or 100,000 (10%).<br>
    </p>
    <p>Best Regards,</p>
    <p>Qi<br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite" cite=3D"mid:CA+chaQcJbdEZzVhTGj2zROHXj7s6Wh=
+wjzA1fV94ve3tpUVXxw@mail.gmail.com">
      <div dir=3D"ltr">
        <div><br>
        </div>
        <div>Regards,</div>
        <div><br>
        </div>
        <div><br>
        </div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Mon, Aug 14, 2023 at
          4:35=E2=80=AFAM Randy MacLeod via <a href=3D"https://urldefense=
.com/v3/__http://lists.openembedded.org__;!!AjveYdw8EvQ!ZH11JLTlXWSmJ5Byh=
Y-jU6bW7d7GeULdZpDpwS_ZhiLnUrFlp0pCghhUePQ2R9UDV_allduZ9rqsNZ1SiKvL7Sw$" =
target=3D"_blank" moz-do-not-send=3D"true">lists.openembedded.org</a>
          &lt;randy.macleod=3D<a href=3D"mailto:windriver.com@lists.opene=
mbedded.org" target=3D"_blank" moz-do-not-send=3D"true" class=3D"moz-txt-=
link-freetext">windriver.com@lists.openembedded.org</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div>
            <div>On 2023-08-13 04:36, Richard Purdie wrote:<br>
            </div>
            <blockquote type=3D"cite">
              <pre>Hi Qi,

On Tue, 2023-08-08 at 05:55 +0000, Chen Qi via <a href=3D"https://urldefe=
nse.com/v3/__http://lists.openembedded.org__;!!AjveYdw8EvQ!ZH11JLTlXWSmJ5=
ByhY-jU6bW7d7GeULdZpDpwS_ZhiLnUrFlp0pCghhUePQ2R9UDV_allduZ9rqsNZ1SiKvL7Sw=
$" target=3D"_blank" moz-do-not-send=3D"true">lists.openembedded.org</a>
wrote:
</pre>
              <blockquote type=3D"cite">
                <pre>I implemented the logic you suggested below, but I f=
ound the 0 result issue remains.
I also checked my solution suggested in the previous email, but the 0 res=
ult issue also remains.
So I added more logs to check the PSI data behavior. (I really should hav=
e done this before!)
My setting is: BB_PRESSURE_MAX_IO =3D &quot;1&quot;

The result is a little surprising to me.
See <a href=3D"https://urldefense.com/v3/__https://github.com/ChenQi1989/=
poky/blob/io-pressure-logs/console-latest.log__;!!AjveYdw8EvQ!ZH11JLTlXWS=
mJ5ByhY-jU6bW7d7GeULdZpDpwS_ZhiLnUrFlp0pCghhUePQ2R9UDV_allduZ9rqsNZ1SNf7l=
49o$" target=3D"_blank" moz-do-not-send=3D"true">https://github.com/ChenQ=
i1989/poky/blob/io-pressure-logs/console-latest.log</a>=20
and <a href=3D"https://urldefense.com/v3/__https://github.com/ChenQi1989/=
poky/blob/io-pressure-logs/io_pressre_grep.log__;!!AjveYdw8EvQ!ZH11JLTlXW=
SmJ5ByhY-jU6bW7d7GeULdZpDpwS_ZhiLnUrFlp0pCghhUePQ2R9UDV_allduZ9rqsNZ1Se3Z=
PZMY$" target=3D"_blank" moz-do-not-send=3D"true">https://github.com/Chen=
Qi1989/poky/blob/io-pressure-logs/io_pressre_grep.log</a> which is derive=
d from 'grep io_pressure console-latest.log'.

There are lines like:
WARNING: io_pressure is 50448.00396988443; tdiff =3D 1.0781397819519043
WARNING: io_pressure is 0.0; tdiff =3D 1.015068531036377
...
WARNING: io_pressure is 50448.00396988443; tdiff =3D 1.0781397819519043
WARNING: io_pressure is 0.0; tdiff =3D 1.015068531036377
...
WARNING: io_pressure is 124236.79015441194; tdiff =3D 0.9999372959136963
WARNING: io_pressure is 186346.268013355; tdiff =3D 1.0000200271606445
WARNING: io_pressure is 0.0; tdiff =3D 1.0000898838043213
WARNING: io_pressure is 0.0; tdiff =3D 0.07874345779418945
WARNING: io_pressure is 0.0; tdiff =3D 0.03340554237365723
WARNING: io_pressure is 0.0; tdiff =3D 0.04926180839538574
WARNING: io_pressure is 0.0; tdiff =3D 0.012816905975341797
WARNING: io_pressure is 54966.74998052512; tdiff =3D 0.11936306953430176

&gt;From these logs, I'm starting to wonder if not using the average10/60=
 PSI data is a right choice in the first place.</pre>
              </blockquote>
            </blockquote>
            Certainly 60 seconds is too long of an averaging time and <br=
>
            we concluded that 10 seconds was too long last year as well
            but <br>
            if we can come up with a test that shows that it's a good
            compromise, <br>
            I don't object to that idea completely.<br>
            <br>
            <blockquote type=3D"cite">
              <blockquote type=3D"cite"> </blockquote>
              <pre>I merged your v5 of the patch since that seemed to mak=
e sense to me but
I'm really not sure about the PSI data itself. That is something Randy
looked into in a lot more detail than I did...</pre>
            </blockquote>
            I've been focusing on CPU pressure and while I like your
            idea that<br>
            we can test the behaviour by setting the pressure limit
            (cpu, io) to 1 and <br>
            checking if we only see only one task is running at a time,
            I don't think that's a reasonable<br>
            expectation. It might work if we have a stress job running
            at the same time that<br>
            keeps the system above the pressure threshold. Even then I'm
            not<br>
            yet sure how to deal with the actual data from the PSI
            especially<br>
            when we are polling it quite frequently. I suspect we should
            limit how often we read the PSI data. <br>
            You have to remember that the value read from
            /proc/pressure/* isn't updated on each read and <br>
            is the sum of N variables that indicate congestion in a
            given CPU I need to read the kernel code <br>
            and lkml discussion again to understand why we see such
            large variation in Total congenstion!
            <p><br>
            </p>
            <p>Let's ask a couple of simple questions:<br>
            </p>
            <p>What does the cpu/io congestion data look like and how
              quickly after launching<br>
              a task, does the kernel reflect the new congestion state?<b=
r>
            </p>
            <p>I was playing around on a 24 thread system by running
              enough cpu burners<br>
              to have the system close but not yet experiencing
              contention. I picked 20 cpu eaters.<br>
              Then, after collecting PSI info for a while, I'd start one
              more cpu eater every N seconds.<br>
              I expected to see a nice square staircase but that's not
              what I saw and I'm not sure why<br>
              yet. I was going to continue playing with that until I had
              figured it out but maybe you<br>
              want to take a look as well.</p>
            <p><br>
            </p>
            <p>I just had two scripts (see below but beware that this
              was playing around so the scripts may<br>
              differ sligthly from the graphs shown here.)<br>
            </p>
            <p>1) collect-psi (should this run as a real-time thread and
              be written in C to minimize impact?)<br>
            </p>
            <p>2) scale-cpu &nbsp; <br>
            </p>
            <p>Green points are the differences in some CPU Total values<=
/p>
            <p>Red line is the avg10 % from some CPU.</p>
            <p>I think I scaled the avg10 % manually and tried to align
              them until it was close enough<br>
              to compare visually.</p>
            <p>It would be interesting to filter the raw Total data
              using your updated algorithm.<br>
              <br>
              <br>
            </p>
            <p><img src=3D"cid:part1.SfFUDDi9.sgo1NSas@windriver.com" alt=
=3D"" class=3D""></p>
            <p>You can see that the &quot;stairs&quot; are not nearly as =
sharp as
              expected. <br>
              Zooming in, you see that the data is quite noisy:<br>
            </p>
            <p><img src=3D"cid:part2.2E6JJw1d.xaDFtGLL@windriver.com" alt=
=3D"" class=3D""></p>
            <p><br>
            </p>
            <p>My next step was to under stand the impact of reading the
              PSI data every 100 ms rather than<br>
              every 10 ms and to only launch a new stress cpu eater
              every 60 seconds or so in hope that</p>
            <p>the PSI data would be more staircase-like as expected. Of
              course bitbake wants to launch<br>
              tasks as quickly as possible so we do seem to have a
              filtering problem. <br>
            </p>
            <p>Note that every after the ramp up and down of additional
              cpu eaters has completed, there<br>
              are still times when (systemd and ??) cause additional cpu
              contention but for short periods:</p>
            <p><img src=3D"cid:part3.u1Xox1lh.dfIIUeZG@windriver.com" alt=
=3D"" class=3D""></p>
            <p><img src=3D"cid:part4.LlabFQP3.Hf0jK5Ff@windriver.com" alt=
=3D"" class=3D""></p>
            <p><br>
            </p>
            <p>All for tonight.</p>
            <p>../Randy</p>
            <p><br>
            </p>
            <p>=E2=9D=AF cat collect-psi <br>
              date +&quot;%T.%6N&quot;; <br>
              for s in `seq 5000`; do <br>
              &nbsp;&nbsp; for m in `seq 100`; do <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; date +&quot;%s.%6N&quot;;<br=
>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #echo $s $m; <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cat /proc/pressure/cpu<br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sleep 0.01; <br>
              &nbsp;&nbsp; done; <br>
              done<br>
              date +&quot;%T.%6N&quot;; <br>
              <br>
              <br>
              yp-ab/2023/stress-ramp <br>
              =E2=9D=AF cat scale-cpu <br>
              date +&quot;%T.%6N&quot;; <br>
              date +&quot;%s.%6N&quot;;<br>
              sleep 100<br>
              date +&quot;%s.%6N&quot;;<br>
              stress -c 20 -t 2000 &amp;<br>
              sleep 500<br>
              #sleep 2<br>
              for s in `seq 50`; do <br>
              &nbsp;&nbsp;&nbsp; date +&quot;%s.%6N&quot;;<br>
              &nbsp;&nbsp;&nbsp; stress -c 1 -t 500 &amp;<br>
              &nbsp;&nbsp;&nbsp; sleep 20<br>
              done<br>
              date +&quot;%T.%6N&quot;; <br>
              sleep 1000<br>
              date +&quot;%T.%6N&quot;; <br>
              sleep 100<br>
              date +&quot;%T.%6N&quot;; <br>
              date +&quot;%s.%6N&quot;;<br>
              #sleep 50</p>
            <p><br>
            </p>
            <p>I don't have time to explain how I filtered the data
              you'd get from those scripts tonight but <br>
              if you look below, you can probably figure it out:<br>
            </p>
            <p># produce total data (take diff in xmgrace)<br>
            </p>
            <p>$ rg &quot;^1691|some&quot; data/5000-sec-100-delay-100ms.=
log |
              paste -sd ' \n' | sed -e 's/some.*=3D//' | awk -e '{print
              $1-1691625397 &quot; &quot; $2-40598616909}' &gt;
              5000-time-total-100-delay-100ms.dat<br>
            </p>
            <p>#produce avg data<br>
            </p>
            <p>$ rg &quot;^1691|some&quot; data/5000-sec-100-delay-100ms.=
log |
              paste -sd ' \n' | sed -e 's/some avg10=3D//' -e
              's/avg60.*//' | awk -e '{print $1-1691625397 &quot; &quot; =
$2}' &gt;
              5000-time-avg-100-delay-100ms.dat<br>
            </p>
            <p><br>
            </p>
            <p><br>
            </p>
            <blockquote type=3D"cite">
              <pre>Cheers,

Richard
</pre>
            </blockquote>
            <p><br>
            </p>
            <pre cols=3D"72">--=20
# Randy MacLeod
# Wind River Linux</pre>
          </div>
          <br>
          -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
          Links: You receive all messages sent to this group.<br>
          View/Reply Online (#14940): <a href=3D"https://urldefense.com/v=
3/__https://lists.openembedded.org/g/bitbake-devel/message/14940__;!!Ajve=
Ydw8EvQ!ZH11JLTlXWSmJ5ByhY-jU6bW7d7GeULdZpDpwS_ZhiLnUrFlp0pCghhUePQ2R9UDV=
_allduZ9rqsNZ1SKxz3b_0$" rel=3D"noreferrer" target=3D"_blank" moz-do-not-=
send=3D"true">https://lists.openembedded.org/g/bitbake-devel/message/1494=
0</a><br>
          Mute This Topic: <a href=3D"https://urldefense.com/v3/__https:/=
/lists.openembedded.org/mt/100522098/3617156__;!!AjveYdw8EvQ!ZH11JLTlXWSm=
J5ByhY-jU6bW7d7GeULdZpDpwS_ZhiLnUrFlp0pCghhUePQ2R9UDV_allduZ9rqsNZ1SIHpji=
A4$" rel=3D"noreferrer" target=3D"_blank" moz-do-not-send=3D"true">https:=
//lists.openembedded.org/mt/100522098/3617156</a><br>
          Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.open=
embedded.org" target=3D"_blank" moz-do-not-send=3D"true">bitbake-devel+ow=
ner@lists.openembedded.org</a><br>
          Unsubscribe: <a href=3D"https://urldefense.com/v3/__https://lis=
ts.openembedded.org/g/bitbake-devel/unsub__;!!AjveYdw8EvQ!ZH11JLTlXWSmJ5B=
yhY-jU6bW7d7GeULdZpDpwS_ZhiLnUrFlp0pCghhUePQ2R9UDV_allduZ9rqsNZ1SZZ9zn1g$=
" rel=3D"noreferrer" target=3D"_blank" moz-do-not-send=3D"true">https://l=
ists.openembedded.org/g/bitbake-devel/unsub</a>
          [<a href=3D"mailto:Martin.Jansa@gmail.com" target=3D"_blank" mo=
z-do-not-send=3D"true" class=3D"moz-txt-link-freetext">Martin.Jansa@gmail=
.com</a>]<br>
          -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>
--------------6LAuARGLNH0su1yIbZjTOBNp
Content-Type: image/png; name="XZUChC4yuWKoFExs.png"
Content-Disposition: inline; filename="XZUChC4yuWKoFExs.png"
Content-Id: <part1.SfFUDDi9.sgo1NSas@windriver.com>
Content-Transfer-Encoding: base64

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

--------------6LAuARGLNH0su1yIbZjTOBNp
Content-Type: image/png; name="trRgDyMGVHfFtgpY.png"
Content-Disposition: inline; filename="trRgDyMGVHfFtgpY.png"
Content-Id: <part2.2E6JJw1d.xaDFtGLL@windriver.com>
Content-Transfer-Encoding: base64

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
YII=

--------------6LAuARGLNH0su1yIbZjTOBNp
Content-Type: image/png; name="NTQ7Zve0b8r0L0Un.png"
Content-Disposition: inline; filename="NTQ7Zve0b8r0L0Un.png"
Content-Id: <part3.u1Xox1lh.dfIIUeZG@windriver.com>
Content-Transfer-Encoding: base64

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

--------------6LAuARGLNH0su1yIbZjTOBNp
Content-Type: image/png; name="m1vc8eMYfyAR6aV6.png"
Content-Disposition: inline; filename="m1vc8eMYfyAR6aV6.png"
Content-Id: <part4.LlabFQP3.Hf0jK5Ff@windriver.com>
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAA+sAAAKlCAYAAACzJX3hAAAABHNCSVQICAgIfAhkiAAAABl0RVh0
U29mdHdhcmUAZ25vbWUtc2NyZWVuc2hvdO8Dvz4AAAApdEVYdENyZWF0aW9uIFRpbWUAU3VuIDEz
IEF1ZyAyMDIzIDEwOjI5OjMyIFBNoQhgbwAAIABJREFUeJzs3WtystgaBtCXUz0vLJiXFsxLS0bG
+ZHGJgYVb7CBtaxU92cAtwaEh33L2rZtAwAAAEjG/+YuAAAAAPCbsA4AAACJEdYBAAAgMcI6AAAA
JEZYBwAAgMQI6wAAAJAYYR0AAAASI6wDAABAYoR1AAAASIywDgAAAIkR1gEAACAxwjoAAAAkRlgH
AACAxAjrAAAAkBhhHQAAABIjrAMAAEBihHUAAABIjLAOAAAAiRHWAQAAIDHCOgAAACRGWAcAAIDE
COsAAACQGGEdAAAAEiOsAwAAQGKEdQAAAEiMsA4AAACJEdYBAAAgMcI6AAAAJEZYBwAAgMQI6wAA
AJAYYR0AAAASI6wDAABAYoR1AAAASMw/cxdgLbIsG7Vc27ZfLgkAAMB98kv61KwDAABAYoR1AAAA
SIywDgAAAIkR1gFYhOzfBwDAFhhg7ouGBmMYO5ADAMMEdgB4362B4+SVdAjrX3a9sz87mmKWZUZg
TJC/S7r8bdL07t/lOqC34W/8KY6ZNPm7pMvfJk3+Ls8bCuU+w7RoBg8AAACJEdYBSF6/Jl2tOgCw
BZrBA7AIQjoAsCXC+ofcGkxOvw+AZer3k3ejAIC1kV/Spxk8AFy5HtDOCPQAwNSEdQAAAEiMsA4A
AACJEdYB4Mp1H3V91gGAqRlgLnEGeIDnOGb4lK0EdMcMPMcxA0xFzToAAAAkRlgHAACAxAjrAAAA
kBhhHQAAABIjrAMAAEBihHUAAABIjLAOAAAAiRHW4QXmWIXnOGbgOY4ZeI5jhjUS1gEAACAxwjoA
AAAkRlgHAACAxAjrAAAAkBhhHQAAABIjrAMAAEBihHUAAABIjLAOAAAAiRHWAQAAIDHCOgAAACRG
WAcAAIDECOsAAACQGGEdAAAAEiOsAwAAQGKEdQAAAEiMsA4AAACJEdYBAAAgMcI6AAAAJEZYBwAA
gMQI6wAAAJAYYR0AAAASI6wDAABAYv6ZuwBrl2XZw2Xatp2gJAAAwJaNySakQ1j/MkEcAABIwaNs
IsynRTN4AAAASIywDgAAAIkR1gEAACAxwjoAAAAkRlgHAACAxAjrAAAAkBhhHQAAABIjrAMAAEBi
hHUAAABIjLAOAAAAiRHWAQAAIDHCOgAAACRGWAcAAIDECOsAAACQGGEdAAAAEiOsAwAAQGKEdQAA
AEiMsA4AAACJEdYBAAAgMcI6AAAAJEZYBwAAgMQI6wAAAJAYYR0AAAASI6wDAABAYoR1AAAASIyw
DgAAAIkR1gEAACAxwjoAAAAkRlgHAACAxAjrAAAAkBhhHQAAABIjrAMAAEBihHUAAABIjLAOAAAA
iRHWAQAAIDHCOgAAACRGWAcAAIDECOsAAACQGGEdAAAAEiOsAwAAQGKEdQAAAEiMsA4AAACJEdYB
AAAgMcI6AAAAJEZYBwAAgMQI6wAAAJCYf+YuwNTqur78f57nkef5qOXHLAsAAACfsJma9aZpIsuy
yPM89vt95HkedV1HWZaDy3e/2+/3sd/vIyKiLMtommbKYgMAALBBWdu27dyFmEKWZVFV1SV4R/wE
+N1uF0VRxPF4/PP89UdT13U0TfNr2UevuZGPFwAAWDj5JS2bqFnvN33v65q1n06nX8/vdruoqurP
8vv9Pk6n083tAQAAwCdsIqx3xjRhHxPED4fDJ4oDAAAAgzYR1vs16P3A3gXzW7XoQ4aWBQAAgE/a
TFgviiIifpq4N00TTdPE4XCI8/n8K5iPrTXXFB4AAIBv2czUbcfjMcqyjNPpFLvdLiLC4AkAAAAk
aRM1653rUdxvTdv2SVmWvf0DAADwiNyxLpsJ69086+fzOc7nc0T89GH/dmBv2/btHwAAgEfkjnXZ
RFjvz6ee53nkeT5pYAcAAIBnbCKsd33Uu1Hhu//vB/bO2NHeb40WDwAAAO/aRFi/pT9K/LVbo70f
Doeb6wAAAMAnbDqsR/yubY+4X2PezdGuVh0AAIBvytoNjCTQ9VmP+DtdW5ZlUVXVrwBe1/VlDvZ+
mO/6tl+PKn9LlmUGagAAABZBfknLJsJ6xO9B5rpgXtd15Hk+WFPeBfaqqiLP80uz+LFBPcLODgAA
LIf8kpbNhPVO0zTRNM1lVPixy7/S9N3ODgAALIX8kpbNhfUp2dkBAIClkF/SsvkB5gAAACA1wjoA
AAAkRlgHAACAxAjrAAAAkBhhHQAAABIjrAMAAEBihHUAAABIjLAOAAAAiRHWAQAAIDHCOgAAACRG
WAcAAIDECOsAAACQGGEdAAAAEiOsAwAAQGKEdQAAAEiMsA4AAACJEdYBAAAgMcI6AAAAJEZYBwAA
gMQI6wAAAJAYYR0AAAASI6wDAABAYoR1AAAASIywDgAAAIkR1gEAACAxwjoAAAAkRlgHAACAxAjr
AAAAkBhhHQAAABIjrAMAAEBihHUAAABIjLAOAAAAiRHWAQAAIDHCOgAAACRGWAcAAIDECOsAAACQ
GGEdAAAAEiOsAwAAQGKEdQAAAEiMsA4AAACJEdYBAAAgMcI6AAAAJEZYBwAAgMQI6wAAAJAYYR0A
AAASI6wDAABAYoR1AAAASMw/cxdg7bIse7hM27YTlAQAANiyMdmEdAjrXyaIAwAAKXiUTYT5tCQV
1uu6/vXvPM8jz/OZSgMAAADzmD2sN00TdV3H6XS6uUxRFLHf7wV3AAAANiFrZ2qnfR3Si6IYDONN
0/xa5ng8TlrOd2RZphk8AACwCPJLWmapWW+aJna7XVRVNTp8N00TTdNEWZaLCuwAAADwrMnDelej
/uwdm67/usAOAADA2k3eDP4TQbsL/KkHds1IAACApZBf0jJpWG+a5mODxH1yW99iZwcAAJZCfknL
bAPMPWMJwXyInR0AAFgK+SUt/5u7AGN0zd4BAABgCyYdYK6u6zgcDi+tWxTFh0sDAAAAaZq8GXyW
ZS+vu7QmGZqRAAAASyG/pGXyZvBFUUTbtpef8/kcVVX9eu7653w+x/l8nrqoAAAAMIvJ51nf7/e/
/t00zZ/nruV57i4PAAAAmzF5zfoSR3UHAACAKc0+GnzTNNE0zd1lyrKcqDQAAAAwv9nD+n6/j91u
F3Vd/wntTdNEWZZxOp2MBg8AAMBmTD4a/JCmaWK3291d5nw+L64JvX72AADAUsgvaZm9Zj3ipx97
27ZRVdWfGvRupPilBXUAAAB4VRI162vlzhQAALAU8ktakqhZ71z3W2+aJuq6nrFEAAAAML0kwnpd
15FlWRwOh19hPc/zyPPcaPAAAABsyuxhvWmaOBwOERGDI74L7AAAAGzN7GF9t9tFURTRtm0cj8eb
y51OpwlLBQAAAPOZPaxHxN2QDgAAAFsze1gfavp+rd+PHQAAANZu9rC+3+/v9kcvy1ITeAAAADYl
iXnWm6a59F2P+BlUrht0rnM+nyPP8zmK9zLzFAIAAEshv6QlibDeqev6T0gviiL2+/3ignqEnR0A
gOXLIrv8fxuubddMfklLUmF9bezsAAAsWT+odwT29ZJf0jJ7n/Wx6rqeuwgAAAAwicWEdSPCAwDA
tK5r0dWqw3QmDet1XUeWZS/9GBEeAACm1/YewHQm77OeZX/7vYy1tP4T+nwAAABLIb+kZfJm8EVR
RNu2T/9007oBAADA2k0e1vf7/aTrAQAAwNJMHtZfmS/dSPAAAABsSTLzrDdNc3PE96Zp4nQ6La7/
hD4fAADAUsgvafln7gJERJRlabR3AAAA+NfsYb0L6lVVRcRPLfp1U/mmafRZBwAAeEMW/83MZSq+
9M0e1iN+T8nWNYXvB3Z91gEAAF7XD+rdvwX2tE0+wNy161r0PM8Hw/lut5uoRAAAADCv2cP60KBy
eZ7fHGwOAACA51zXoqtVT9/so8E3TfOr1rwrTpZll37sh8Ph1++WwmiKAADAUsgvaZm9z3qe51FV
1SWQd87n868QXxTFxCUDAACAecxes/7I0OjwS+HOFAAAsBTyS1qSD+tLZmcHAACWQn5Jy+wDzEX8
1J6XZflnULmmab46bVu3/Xuv0f3egHcAAABMZfY+69cDzB2Px8v/53keeZ5HlmVxPp8/1hy+e82q
qmK/3w8u0wX0rjzdDYX9fr/YZvkAAAAsw+zN4MuyvITfscH53dc7nU53w38X5q8/mmfLoRkJAACw
FPJLWmavWc/z/GZI7zudTm+/1pigHhGXWvdr+/0+siyLuq5HlRkAAHhfFtnl/80PzlYk0Wd9CnVd
x+l0iqqq7gb1MX3kr6eZAwAAvqMf1If+DWuVRFi/N3hb0zQfCcfdNsbWiN9abqjGHQC+Ies9AIBt
mT2s7/f7qOs6yrK89AnvRmkvy/Iy+FxRFC+/RldbXlVV1HUdWZZdfq5r0sfeGPjmKPUAoCYJ4Md1
s3fN4NmK2fusR/yMAF+W5c2gXBTFW4PLdTX33eBw+/3+MojcszXuAADAtAR0tmj20eD7ulr17v+7
qdvenSoty35qI67fan/auO53t5bt1HUdh8Ph7rRv16/7roT+RABMZKgm3cUqAPd8In/IHulIoma9
84lg/uzrdb41wrudHdJmdFlS1UZr/wTgKe9mj09VNvIZs/dZv6VpmijLcrBf+Se90xceWDZ9gkld
23vMxSB3ADCP2cN6P5SXZXl5frfbXeZWPxwOv373Sdc1+WNHe9fHHYC1c0MLAOYze1iP+Am+bdte
BpHrgnlRFHE+n+N8Pr+1/VemW7tVm384HNTGw0oYXRYAgFTNHta7geT6/+5q1I/H40cGmevWHZrP
/Xo0+Hs15t36atVhPVJoZgypckMLWCpdeFiDJMJ6X39O9E/J8zyKovhTW9699vVrVVUVh8NhsGxF
UUw6CB4AzMkNLWBpdOFhLWafuq2bCq3vel71boq1d4vaNa/vasbruo48zwdryvtTtOV5fgn6z8z3
nmWZ0eABAGBCpr58nfySltnDesRPiO6avhdFEfv9PvI8j6Zpoq7ry+8+VdQupI+pIe/mfn+l6bud
HQAApiWsv05+SUsSYX2t7OwAADC9fmAX1MeTX9Lyz9wFAAAA+KQ5ArobBHza7APMAQAALJlB7fgG
YR0AAAASI6wDAAC84brZu2bwfII+6wAAAG8S0Pk0YR0AABjNQGowjSSawdd1PXcRAACABwykBtNJ
Yp71MfP5lWUZERF5nkdExH6//3q53mWeQgAA1mQonKtdXw/5JS1J1KxH/OwY3U9ZltE0za/fn06n
yPM89vt97Pf7S3gHAACAtUmmZj0ioiiKS8150zRxPB4j4qeZ/OFw+HWXJ8uyOJ/Pl+VT5M4UAABr
o8/6eskvaZl9gLm6rqOqqj/N2pumibqubzZ3r6oq6rq+BHoAAOD7BHSYRhLN4IcC+Zga89Pp9I3i
AAAAwKySCOtD9EkHAABgq2ZvBh/xE8z7NemHwyEi7teud8sAAADA2iQxwFxZln+atBdFEcfj8fK7
oijidDpFVVXRNM3luZT7rBugAQAAWAr5JS1JhPVOXdcR8VOj3q9Vb5om8jyPpmlit9tdnjcaPAAA
wGfIL2lJKqyP0Y0S3825njI7OwAAsBTyS1oWF9aXxM4OAAAshfySltlHg6/rOpqmmbsYAAAAkIzZ
w3pExG63i7IsL33WAQAAYMuSCOtt215Gde9Cu9p2AAAAtirJPutN01x+ljCQ3C36fAAAAEshv6Ql
ybDe6U/VVlXV4kK7nR0AAFgK+SUtSTSDv1bXdWRZdgnqRVHMWyAAAACY0D9zF6CbM71r9n46nS6/
q6oq8jyPPM9nLCEAAABMa/awHhGXGvTOEpu8AwAAwKckEdYjfpq67/d7tegAAABsXhJh/Xw+C+kA
AADwr9kHmNMnHQAAAH5LIqw/Utd1lGU5QWkAAABgfkk0g4/4CeS3XI8SDwAAAGs2e1hvmubPaPDA
87LILv/fRjtjSQAAgHdlbdvOelVfluWvpvBN0/xpGn84HGLmYr4ky7JFlpvl6Qf1jsAOAMAz5Je0
zF6znuf5rznVm6a5PN9X17W51wEAgE3QapLZB5i7luf5JbD3HQ6HGUoDAAAwretWk0OtKFm/2cN6
0zS/fiJ+Ant/wLmh8A785/puq7uvAACwbLP3Wb8eYK4rTlmWf0aAX1r/CX0+AACAZ801HpH8kpbZ
a9bzPI/z+RxFUURRFJfnj8fjr3+fz+cZSgcAADAtrSaJSKBmfc3cmQIAAJZCfknL7DXrAAAAwG/C
OgAAACRGWAcAAIDECOsAAACQmH/mLgAA8Jr+1D5GCgaAdVGzDpCYrPeAW673D/sLAKyLsA6QEAEM
AICIhYT1siwjy7LIsizKspy7OAAAAPBVyfdZr+s6TqdTRES0bRtN00RZlnE8Hmcu2ThZ9rhWrG31
MwR+tNHqh8wo9hUAnjUmm5CO5MN6nucREVEUxeXf+/1+ziI9RRAHniV0MZZ9BYBnPMomwnxaslaa
/Josy4R1AABgEeSXtCTdZ71pmrmLAAAAAJNLJqw3TRN1XUdd17+eN6AcAAAAW5NEWC/LMna7XRwO
h1/P53kex+MxsixTyw6shjnUAYBrWe8BEQmE9W6096IooqqqwWWqqvpT4w6wRP0TsJMxABDx95rA
NQIRCYwGfzgc4nw+X0Z9vxXKu+nbAAAAYO1mr1mP+G96NoC160+1ZdotANZIc274jNnDejd/+j36
qwNTmeICo/33AQBrozn3a66vC1wnEJFAWD8ej1GW5WAgb5omyrK89GkH+CYXGADAXNreAyIisjaR
We+7UH5Lv1/7UmRZFol8vMAIQ+HcCRMAntM/nzqPLov8kpZkwnrEf4PLdVO4FUUReZ7Hfr+fs1gv
s7PD8rjAAAC2Sn5JS1Jh/Z6madSsAwAAfIn8kpbZ+6yPZZA5AD7JaMUAQMqSqFlvmuYSxrsm8EMS
KOpT3JkCSJPxCQDgL/klLf/MXYC6ru8GdACAe4w1AcAazV6znmXZZSC57udaXdfRNE0cj8cZSvg6
d6YA0qRmfT38LQE+R35JSxJhfUwRDDAHkK4l1mwuscz8JawDfI78kpbZm8FXVTV3EQB4w3VYyiJb
RFhaQhkBgO2afTT4/X5/mV/9njHLAADbcn3TxU0YANZi9pr1iIg8zyPLTJ0DsERttJqUMyv7HABr
NHtYb5omdrvd3MUA4A3CEgDAZ80e1ne73WU0+IifZvHXutHgAQAAYAsWMxp8XdeDQT5lRlMEgPd1
3SymasGhWwewVfJLWmYP63Vd35xffens7ADwnuvZBr4dnk0FB2yZ/JKWJEaDH9PE3WjwAEDET6Ae
CtUAsCaz91nvgvqY0eCX1gwe+qZuxgkwZOnfRf2QnkW22PcBAI/MXrMeEXE4HOYuAnzV9cUlwByW
+F3UD+NTBHPztgOQitnDetdXvaqqaNt28KeqqiiKYuaSAgBzaP99TP16gjqMk/UewOfMHtYjfoL6
vSbu+/1+lQPQAUTof8t0pq6l/oY1vAdYk+vzV6rnMzcUWKLZR4NfM6Mp0rf0fqJ8x9QjXQPAJy1h
BoUllDEV8ktakqhZj/gZaK6u6yjLMrIsiyzLoq7rUSPFwxJoUgkAAIyVRM160zSx2+1u/r4oijge
j9MV6EPcmQLG0OoCgCXr11ynei5bQhlTIL+kZfaa9S6oV1X1Z5C58/kcVVXF6XQyzzqwWlpdALBk
SxiUcQllhGuz16zXdf1w/vQu0C/tLo87UwAAwFLIL2mZvWZ9DCPBAwAAsCWLCOsAAACwJYsI62VZ
zl0EAAAAmMzsYT3P85uDx9V1HVmWxel0iqqqJi4ZAAAAzGP2AeYifmrOT6fTzd+bug0AAOC75Je0
zF6zHhFxPB7jfD5HURR/fldV1SKDOgAAALwqiZr1tXJnCgAAWAr5JS1J1Kzf0jRN1HUdTdPMXRQA
AACYzD9zF6Bpml9hfL/fR8Tffuzn89l86wAAAGxCMmF9v99fwnhd15eg3o0Cv9vtNMkAAABgE2YP
6xHxZwC5w+EQEWrTAQAA2Kbk+qyXZRkRP9O1CeoAAABs0ew1603TRFmWked5NE1zaf7e9V3vL/dp
dV1Hnud3bwrUdR0R8XA5AAAA+JTZa9b3+32cTqc4HA6XoN5v/t6F+f5gc59Q13UcDoebNwHquo6y
LGO/3/8a9M7I9AAAAHzb7DXreZ5H27aDNdjd4HOfrtVumubSL/7e7/sD2nVlqOv6Tx97AAAA+KSs
3eAQ612z+8PhEFVV/Wlyn2XZ4POPfje07AY/XgAAYIHkl7TM3gx+anVd3w3aXQ3/Pfdq5QEAAOBd
mwrrXX/zMU3qbwX6bt53AAAA+JZNhfVHteoR42vNx9TAAwAAwCs2E9a7kd0BAAAgdbOPBj+Fb4wo
P1aWZW9vwyAPAADAI5/IHqRj8rDeBecpzTndmqANAABM4d3sIeynZfVhva7ry/zo1+Xo/tv9TjN5
AAAAUjB5WB87gNsng/O91zydTnE6nS6vWVXVqDIK9gAAAHzLLAPMHQ6HS832LWVZRpZlUZblw2Xv
2e/30bbtn59uCraqqi7P9d0a7f1wOERRFC+XBwAAAB6ZvGa9KIqn+o83TRO73S7O5/Mkzef3+/3N
mvXupoFadQAAAL5p8pr1ZwN3nudxPp8nnde8awp/XaNf13UURTHLqPIAAABsx+Q166/USud5fulX
PoWujLvdLqqq+jVA3VyjygMAALAdWbuQucW6Ud2nrtVumiaapnnpJkOWZaZuAwAAFkF+ScssA8y9
6p2B5l6V57k+6gAAAExqMWF97JRvAABrk/UeAGzD5GH9lYHijMIOAGzVdUAX2FkjN6Pgr8kHmHul
htzc5gAAsE79kJ5FFm3oMw0RMwwwl2Wv3TGbap71TzJAAzCH/kWPCx5YvqHaRsc2a3K9j9u/5yO/
pCX5PutFUSwyqAPMQXNZWJ/r4CLIsDb9fdr+Df+ZvBl8xDJryQEYT+0+fJbjiLWbeh93nmIJJq9Z
r6pKUAdYMbX7AKTMeYqlmDysC+oA36O5LADAOswS1pumibIsI8uyyLIsyrK8TM8GwHva3gMAgGWa
fDT4iNsjwq+tL7vRFIGt0hcQgJQ5Tw2TX9Iy+QBzdV1HxM8o710wb5omTqdT1HUdx+Nx6iIB8GEu
fABImfMUSzB5zXpZlhERf0J50zSx2+1WVbvuzhQAALAU8ktaJu+zfjqdYr/f/3k+z/MoikLfdQAA
ADZv8rAecXtE+Hs16kI8AAAAWzFLWH+FsA7Ty/59AAAA01pEWG+aJg6Hw9zFgE3ph3SBHQAApjX5
AHO3pm0bY2mDHRiggSW7DuhGTeUdpsgBgPTJL2lZRM06AMt1feNHSw0AgMcmn2c9IqKqqqfX0Qwe
ptVGewlVakIBAGBak4f1qqoGp24D0iOkAwDAPCbvs74l+nwA/NBnHQDSJ7+kZdKa9aZp/kzBluf5
3fnVy7KM4/H47aIB8EUCOgDAcyZvBt/ve15V1d2gHhGx3+8FdgAAADZl8mbwZVlGRDwVvuu6flgD
nyLNSPgmzYrn4XMHANZKfknLLPOsn8/np4P3EmvX7ex8y9DUV4Lj9/ncAYA1k1/SMmlYr+s6mqZ5
KXQvccdZYplZhldCoxrh9wnrAMCayS9p+d/UL/hqU/aqqv4MTgeMcx0yh0Inj10Hc0EdAIBvmXyA
uVd1QX1p/dbhG9po1ZTPxGcNAMAUJq9Zf7V2/HQ6CerQ0/YeAADAukwa1vM8j9Pp9PR6atXhPZpv
AwDAskwe1ouiuEzfNkbTNLHb7aIoii+WDNZPTTwAwHSy3gNeMXkz+P1+H6fTKcqyfNgkvgvq3XoA
AACpM7gvnzD5POsRP1O4HQ6HiIgoimKweXv3+26Zpc2xHmHqAwAA2KKlTvcqv6RllrAe8Tuw37PU
oB5hZwcAgC0S1vmE2cJ6xE8z96ZpBkN7URSx3+8XPaicnZ2l6U4sSziZAACkbInT7MovaZk1rK+d
nZ0lub4DvJSTCgAAnyG/pGXSAea6mvRPbQvWxGihAABAZ/Kp2z4Rsj8Z+iEF/ZAusAMAALM0gy/L
8uX+6HVdR9M0ixh0TjMSxkqlCbo+6wAA2yW/pGXyedYjfuZMr+t61FzrET816XVdR5b9BIklBHV4
Rj8czxmU238fAADAvGYdYK4syzidTr+eq6oqImJwhPjz+byo0eHdmQIAAJZCfknL7KPB35u+LeJn
Crc8z2O/309csvfZ2QEAgKWQX9Iye1i/1oX3JYbza3Z2AABgKeSXtCQX1tfEzg4AACyF/JKWWQaY
AwAAAG4T1gEAACAxwjpwkf37AAAA5vXP3AVYu25u+Hv0CyEF/ZCeRWa+dQCAlRmTTUiHsP5lgjgA
AJCCR9lEmE/L5M3gm6aZdD1gnH5Nulp1ACAlWe8BWyGsAxftvw8AgFRcB3SBna2YfJ71LMuiqqqn
1zscDotrUm6eQgAAeM9QOFe58B3yS1pmCeuvWtqOY2cHAID39QO7oP498ktaDDAHAAAkTUBniybv
s14URZzP52jb9qmfoiimLioAQBIMrgWwPZOH9TzPI8/zl9YDANgag2sBbNPkfda3RJ8PAOBdBtcC
PuVR33/5JS2T16wDAAAwLa10lmfyAebquv717+tm8U3TRF3XcTqdLs+dz2fN4AGATWqjNRI2wAZN
2gy+H8SLooj9fv8nhN+a2m2JgV0zEgAAIBWawS/LpDXr/Vr04/H45/dlWV7+vyiKy7JN08Rut7Pj
AAAAvEjLnGWZfIC5W3drukAe8RPUr8P8Eu/yLLHMAADANskvaZl0gLm6rqOqqsHf3Qvq3fPX/d0B
AABgjSYfYG5IP4Tv9/vBZV6dnx0AAHidAQ5hHpOH9aZp/vz7cDhExO9+6tcOh4MmGQAAMKGh6b4E
dpjGpM3g9/t9nE6nS016XdeX5u/d74c0TRNFUUxRRABGyHoPAAA+b9KwHvEzBdvhcIgsyy416t3z
Q7Xq3cBzmsADpGGolgUAgM9IUQSUAAAdm0lEQVSaPKzneR7n8/ky0FxVVYNBvWmaKMvyUvN+OBz+
NKEHmJoaZQC25LrJuybwMJ3Jp24bq2maxdemm/oA1mUooG/xosXnAADrJL+kZbaw3jTNpaZ8rSO9
29lhXYTU/xgZGADWR35JyyxTt3X90Ptuza8OQHoEdACA75q8z/pQUI+IX6PEA6RIvz0AAKYyS1iP
+BlYrm3baNs2zudzFEXxa3R4gBS1vQcAAHzL5H3WsyyLqqoG51TPsuzmFG5LpM8HkDp9zwGAjvyS
lslr1iPiZhivqsr0bAATMV86QPpMGQrblVRYv0d/dgAAtsRNVdi2WcI6AAAAcNtsfdaH9Oddv3Y4
HBbXf0KfDyB1+qwDpGuoJt13Nd8kv6RllrD+qqXtOHZ2AADe4aYqU5Jf0vLP3AUAAACGCeiwXZP3
WS+K4jK/+jM/RVFMXVQAAACYxeRhfWh+9W+uBwAAAEszeZ/1LdHnAwAAWAr5JS2mbgMAAIDECOsA
AACQGGEdAAAAEiOsAwAAQGKEdQAAAEiMsA4AAACJEdYBAAAgMcI6AAAAJEZYBwAAgMQI6wAAAJAY
YR0AAAASI6wDAABAYv6ZuwBTq+v68v/7/X708nmeR57nXysXAAAAdLK2bdu5CzGFpmlit9v9ef58
Pg+G8Lquo2maOB6Pl/Xruo79fj86tGdZFhv5eAEAgIWTX9KyiWbwXdA+n8/Rtm2cz+coiiIiYjDA
N00Th8PhEtQj/qtZ79fMAwAA78v+fQD/2UTNelmWv4J3J8t+vhCqqvrVJD7Lsj/Pjfnd0LIb+HgB
AOBl1yG9DdfPc5Ff0rKJmvVbzdarqvrz3Jia88Ph8HaZAAAA4JZNhPUxteBj1xkK+AAAAPBJmwjr
j/SD+dhac33XAQDgff1m75rAw382N3Vb3+FwuAw0BwBL1e/v6UIXWCLfXfDXZsN60zQR8VoT+Wd0
g9i9wyAPANxyPTBTFpmLXoCN+kT2IB2bDevdVG5j50x/laANAABM4d3sIeynZZN91rv+5t8O6gDw
bde16GrVAWAdNhfWm6aJpmkG512PGD/a+7ebzwPAWG3vAQCsw6bCetM0Udf1zaDed2u0d4PSAQAA
8G2bCeuPgnoXzu/VmE81KB0AAADblrUbGAGtaZrY7XY3m7hfN4uv6zoOh8OfAejKsoyIGFUzH/Ez
QMMGPl4AAGAF5Je0rH40+C6oR/w0YR9y3ay9qznvAn6e55ea97FBHQAAAF61iZr1d3QD0r3S9N2d
KQAAYCnkl7QI619kZwcAAJZCfknLZgaYAwAAgKUQ1gEAACAxwjoAAAAkRlgHAACAxAjrAAAAkBhh
HTYs+/cBAACkRViHjeqHdIEdAADSIqwDAAAskFaS6yasAwAALIxWkusnrMNGtdEO/j8AADA/YR02
rP33AQDAsqh4Wb9/5i4AAMAn9ZuDuoAF1sx33LqpWQcAVuO636Z+nAAslbAOAAAAiRHWAQAAIDHC
OgCwGtf9N/XnBGCpDDAHAKyKgA7AGqhZBwAAgMQI6wAAwKSyfx/AbcI6AAAwmX5IF9jhNmEdAAAA
EiOsAwAAQGKEdQAAYDL9GRvM3vAcff23RVgHAAAm1f77YDx9/bdHWAcAAIDECOsAwKZkvQfAUug+
sD3COgCwGdcBXWAHbknxpp7uA9sirAMAAPToH04K/pm7AAC8p38Rkerd9iWUkWnYFwBgHDXrwE0p
Nv/ityU06V1CGZlGCvvC9Q0CNwwASJWwDgzS/AtYq7b3ABhiMDdSIKwDLNgSagmXUEYAuOamHnPT
Zx0Y1EZ7qVGf6kSlL+trlvBZLaGMfF//e6X7NwAwTFgHbpryQnqoL6sL+flMfaOG7bBPAcA4msED
8IvxCmCZDAoKsC7COgC8SDgiFW6yAayPsA4kwSBkLI1wBAB8kz7rQDIE9DTMMbggAAC/qVkH4A/T
1cCymBMaYH3UrMMHmIoItkcLBFJjPwRYFzXr8KahKceAbdACAQD4FjXrAKxSCi1e1LwDAK9Ssw7A
6qTQ4sVo8fC+T0+PmPUeAKkT1uFNc0055oIDgDX79A2vFG7iATxDM3j4gKmbuA5dcGhmy9poQg4A
bJmadQCS826N2lwtXm69phsOadNSCYAUCesAXyYEzKPtPeYuA+nSNDpdn77hlcJNPIBnaAb/ZVn2
+KTftk4WPKc/v3P3b9J0XUPsbzWOOcyBiM8f/75P2Lox2YR0COtfJojzLS44WDv7OFNw8xPYkkfZ
RJhPi7AO8EVqiCF9jk0AUiSsA3yZIACQJq0qgJQZYA6AhwySB6yNwQWB1AnrANz17jRqAAA8T1gH
AACAxAjrALBiujDAMPOus0a+89dFWIeZ+DJlKfoXsC5ml0UXBrYu6z2GtL0HLJ3v/PUR1mEGvkxZ
Ghez47gJxy32jekZQA5YOmEdAD4gxZtwWkWk4Rv7xqMaY2B7fOevj3nWAWDFXLCtz1CNsb8zW9c/
LrZ8PGz5va+RmnWYgTufAPBdBpDbDl0eWCs16zATFw2QlndrZdpoL9twfNNn35iPzxtYMjXrwKro
w8krPlUrYyA+bvnkvqHGGBjLddGyCevAaqQ4wFcKDEQF62PKsXT4fp2fG1jDXBctn7AOsGL68Y3j
Qo8tECo/TxhKhxtYrJGwDgDhQo91EypZGjeX3mdA4+UT1oHVcFL6S40xwPc473yHm0uf4yb0shkN
HlgVJ6S/fCbAKyPSm7d6HJ8N8C1q1gEANuCZGrYtj3eh+TWQCmEd+BijjgNsxxq/8zW/ToPuBfBD
M3jgI4ZqYVI4wT7b7BOA383mu3/3feo7/92m+Wtsqr/G9/SKLb936KhZB1ZLDQnA6749Q8Kz39GP
muav4Xt+je8JeJ2wDgDAU9Y608RSm19/ujvCGrs4wBIJ68BHpHjhttSLLoAl+HbN+9DrTfU6Szpn
fLoVmdr9bXFjJm36rAMf842Lm3f7nL9bJn0HWZJP7K/GeWAqr0wnd6/v/Br22bX2wydNbsykT1gH
knVdWzD1RUuqg+bBkE/sr2OOOUGCT3p3H1pjeF9quYHP0wweABhFLQwp2+r++ekuXyl2a4OtUrMO
cIPmiCzJkvdXTe9ZkhT310dleVTm6++OlN7bmqT2HT103tjKTa6lyNq2nX9PWaksy8LHC+9J8aJo
jXzO80jtwi3i/r4wdBH3yXEhPrE9tu3bx9QS99dHZf7Gcc1fS/mc5Ze0qFnnM7IX7sL5ImCEFE9k
azP32ABbleqYCPfKsOTa+3e5obUM/j7pcgzB8/RZhy8zHcZ3+XzZkhSm2Jl6uq4UfHpqLJbLlKCv
cQzBa4R1+JLrC2onp8/z+X6Gi895PDuI01oHz7L/sTSPblZNcUPtmdd4dIwZUG4aPmdeoRk8fMFa
LqLZDhcN8/C5//A5fMfYQcV8/p/zSreiZ7uWvPIaj5b59j7Q70Kz5f1ty++d1wjrzNff/NHr6tPO
A07+9K19X9hyf/G5zfFd8+7f+lGgM1ZFGlIdu+Ib1vq+4JuEdb6nH7ZfuSGwYENTXzhJfYfPlYjt
BI+1vq8lmPKzTzXAuVmUBjeqYTuE9Ymt8st1Y0F8rFX9jQHYtKluIKR4nfRMmaYK0il9PqlJcR+C
VxlgbkKbGgxLE3ZgQgYpY00+MRDVM4OKpXLMpHid9EqZnpkt4VuDjs09a8RcUtyH4B1q1nnNFLXp
S+vT/uW+/5of8klrqHm4fg9Lfi9L5rvpOz7xWX5yULExYybYF17z6c9qK92CYAuEdYZ9ur/5o1Cq
Kf1drzQ/dNHELWu4kFvDe1iDVPtW8x2Ppiu7/vca9oW19g9f43uCNdIMfkIpNjljndY6HzMA65Xq
ddIzzdpT8OhzXHNT8VT3IXiVmvWJPfPF4a7nA0trJj9kTIuCth3V/BDGSqGm6N39OYX3sBY+R1Ji
P/yMLX+OW37vrI+wnqiUm3hmvaK0A1nz5/cu/j7NZ5mupc2//M56n/Cp5rKOife9e65xI5GOfWG8
uT8nNzthOYT1hRh7ETV4Ani3P3ivhvrPRXb7+4v+5Yvwb/Rp763T3WD4c3Ph27Xvn+j7/0ILAhdN
05n6xtpa+4WyXPa/16zxO3ot7+ObUvkO97eCZdBnPVGvfInqpzys3xIgm+Hc1E2fMvVrt73H1LY6
ZQzjfGuqoiVI7djQv3Meztd8U2rfM8Dr1KzzMYs8MXy53/tgS4RPf0yJ9d3/dk3z1pvuraXVxBLL
/e7nnmr3pinLsYZ9l/H8vR8zbVta5uzW1vE3o09YT1iKfYqug8KY5T/zwjNN/faNIHxvnW+8j8TC
/DtSvAgZOk6/fdym8L63JpWmq0vmM9yWLf+9U7t2Y5y5u7VN+dosh7D+QNM00TRNRETs9/vJX//6
YL13l3qKGrdPBPWp77S32Z0+69wP818K8mu7kLk1bsMST7hLqglLeT9KuWzMby0tZPhr6ecAIC36
rN/QNE2UZRkRPyF9v99HWZZR1/VT2/lkv6Exfdyu+yl3faX/9Jdu2/s/LxjT9/Fb/fQu7/HG+2mj
vRnUBz+f0S+c/ffzCb0yd+X69b7e9Gubo1bIxv3038LADaZbc7pmvccY+td+11T9aJ/9u9/axtD/
p+BW2ba+/35jrIJP7EtzmXJckTk+py2PTXHPt78Htv49821D1zSvHlf+PoyRte2C2sBOqCzLyPP8
T216lmVxPp8jz/O762eRRWQR/ePw3YPy2X4tg8t3Tz3xZ+/XEN36Qhr73l7pm/Oo9uF6mze3NxCo
r0Prp2veh0Lxs6P6/1rvjZsCg2X54nXbrfd+76S2hhPX6P1xAs/W3L3bd+7e6z3zdx/azq2uBq+U
81VjP59nyvbp2tUpamuvX+PV13yn9cGz56Klt3R49Vi+9Z07dBwt9bP5pjHH8r3j4dY6S/XJc0oK
x+SYc82t5YfcOj/d2t6t7c99fGZZFuJhOjSDH1DXdZxOpzgej39+V1VV7Ha7ZHbip784L4s8PxVc
15xr6EvoXlOvdy7sbvV5e+lLfvBvdqO/UP8my53v5rHLfcxcffc/5OHd51vlT+x4u7ffXe+fr+yr
Y0Lvq8fOreXeDVn3Xu+ZWodHtfvfalZ663N4VPah9e793e9tb8z36DM3aD/9Wd367r/3mrf25aFz
y6N17pXj1rYevdZU3rnofnRMPHq/Y7bZPTfVzZZnX6MzZfnGfEaPrlE+UY6hMo25wXlr3VvLPLqh
+uyxPnbfS+GY7Jfjme+iMdu93v69bY49p94q37s33EmTZvADDofDw2UeNYcf2/zrmeYzYy7Onw3C
/cc33Psy7F/IP1OGexde19t82r/Nz3+9XhuDYXFouTHNzG9dADw6UY5a542uDa90B7h+v/fe/6Ob
GXdvivT3kasm+GN+178J8Gi/v7W9Pxdft8oQ/zVvvXfRfKsMg/9+oQy3Psdb/x66EHh0QffoGHv2
uH7mmH2lqeeYz/yZ93drG12Zng3+/TKOKV9/+We/7/rrjFn/2c9izL495nVe+R5/pazPbv/R98e9
8rx0bnpQnm9ta+wxc2+9sd8T18vf+nxfKd+YdR79bmi5W16plX1UhrHfU7fe79Ayz7zfZ37/yjE1
1L1uzN/pepl3/7a33sOj9V5paTBU7k+Xb+z37rOvz3SE9Ruqqhp8/tlB5trs3xAy0M/3z5ftUMC4
+mmz4YvAvv5222j/K8MDY7687x3EYw/ye18Kr3xhZPH7bugzX35jL/izyP6E0oflelQJfuMkM8Yr
6wwGsV7/+Mv27t1ouPMZ3Fvv3v73aP985qbIrfeRtfHnmLv8LoaPyaHXHlW+/rH7Z+Ebr3NvnRGG
ynBzjIYYLkNXvu7v0X1vPTwmPzBmwzMXB9fH7Ku1HalfkIz9Ln132698l7zjE68x6m9+41i79btb
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

--------------6LAuARGLNH0su1yIbZjTOBNp--

--------------n4mqJWAvqS4xucJ8d5Ryqe07--

