Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EB6ECAAD8
	for <webhook@archiver.kernel.org>; Wed, 31 Aug 2022 03:10:28 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.21163.1661915426715470622
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 30 Aug 2022 20:10:27 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=cbWpgAAP;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.178.238,
 mailfrom: prvs=6242a1491b=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id
 27V3AEko009604
	for <bitbake-devel@lists.openembedded.org>; Wed, 31 Aug 2022 03:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=message-id : date
 : subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=6Oxg34qOPRgpaDQlS5R2sNb1VCfxB0PxjKOMq08rPOU=;
 b=cbWpgAAPLW6kBXU8JFdfZh3Og+NtS7dW+ZMdd3ZWpnpan/EAG6AJ5aX544vHsmChJ0Xi
 9DF9sM7t+9L9fdcVrh0HzIu110b8Y5vMHNQtuihOy+HN87YAkSAAPVWAkNeq+MvnB528
 7KXcaaS8UYxuf3OjuiUezsLVehiKG3Ii6eKb+SnRXR3XFvmQPZq6uXBIwodaI377S0YU
 yBUD9HvIjrxpc8sOHbrJUucobMGg2VJPXloQ1Ge34s5Y3NLpKPkluFx9ccyenb4YsRRm
 31xvdFbFbtgPhhCaLEkcMSIyP1S7dqlf4AutKeNzg9+BOo+lczbZfd1XoNBl1inxCDQ9 Kw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3j78g2kchw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 31 Aug 2022 03:10:25 +0000
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27V39SBd006850
	for <bitbake-devel@lists.openembedded.org>; Wed, 31 Aug 2022 03:10:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3j78g2kchv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Aug 2022 03:10:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J19FDAQDJTpp8vC5vGsWgWjE3igQ5sD1ONueIcI7Qzg63njUjyPcrocNqYxUH03LZ7fYvIGXOrFJMZK84IcTBlsZzWPuaFkLi5/p/aKtnj/r45DxwI9DhzdI34eIm2ton8l0rwdCLyR68dNZwBqNdPA+9sijkjpuMRLiVOtXHDjye5iccl/UWGSDinxT7oYNhj7nCn2e77DGuoddXANoy7n87YWBkAmfO6aH25Y1ZV2p7CmPUcYGoEXsrt/O6Wvxt2ZT7pBUtL2MnKbSOLjsxeBBg4Gmq007rw8qfSZ8piAmkNcdq+Z82K18tr3/O4Q7VeaAFJLCI3m23zw7TEgDaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Oxg34qOPRgpaDQlS5R2sNb1VCfxB0PxjKOMq08rPOU=;
 b=UqV8B1g0rSR0/xljo1w6TLF9RNehSlPOGTX+Jl2dFO9iwdKDeC0GjICrfm0dvnLTF2WzZDNxVGvyw7zKeOQ6xL++wnrS/QbFwlxILOnxbBN0oJPVoU4secWpExtZCZJciavg9N+RLebUuuPUsTAh0O+Fcb70lhWoKHUoZAl0DuSUA07lI4dFIJkb48Bb2Yl5KjJUWeHK7UBplywrl8hPlgo/LAVCrZz4rYOX8U+8lyOS8yQdVU2r9mD0Vn6PACo1qyTSZrA3BFIUjZ9t9SbxrSpZa9ZXk0RygPZ+Qw94cX2/l4c/il9q/v3QwKYnRyPCdGsnwpY1BV3ei5pk7BTtJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11)
 by DM6PR11MB3513.namprd11.prod.outlook.com (2603:10b6:5:63::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 03:10:21 +0000
Received: from BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::3cda:360d:94b:1b67]) by BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::3cda:360d:94b:1b67%4]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 03:10:21 +0000
Message-ID: <d20cbc04-16ad-763d-a7da-20a2495f19ad@windriver.com>
Date: Wed, 31 Aug 2022 11:10:14 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [bitbake-devel] [RFC][PATCH V2] bitbake: fetch2/git: Use git
 fetch to shallow clone revisions
Content-Language: en-US
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>,
        "bitbake-devel@lists.openembedded.org"
 <bitbake-devel@lists.openembedded.org>
References: <20220826131047.51373-1-liezhi.yang@windriver.com>
 <94af8607626d42e58b05fb79a2d07e02@axis.com>
 <7e6cdfb0-3022-69fb-f835-54bf7f042962@windriver.com>
 <d9b06a8c3f874ee386fb80d0ada7b24e@axis.com>
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <d9b06a8c3f874ee386fb80d0ada7b24e@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0132.apcprd02.prod.outlook.com
 (2603:1096:4:188::15) To BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ea81eff-c099-4f49-2f8f-08da8afe56b8
X-MS-TrafficTypeDiagnostic: DM6PR11MB3513:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	maqRDFgpty8r2w/xuxx+havhyY6ZsFb/Of8GIZkvscfjwbhMxDdaInwRyUsd76hs0K0RUGRsoOG6YkaQwllKOyC9i8+f5JAOvwWo6t046WSwVOhCzcNdROJSqAUq4WJfA4iv0f4or2385mPn/JaPonsTzfzqgHKmdyUAj0+ubym8pLHb0cfhj0yXf2HCw2jypKaxnHbRi++uIjY6fWPuscKjSeZVuHfQpwjMmm+iaX775NGCbOrnsjyYbwU8aJNFzLZ1cjV82J9d4EpRzLebyD4ZCp/YbRUYGx3HY1SeGcz3xUzusy7dEqH0eXjHuaQWS151/EQ6rP/g5qC9hFwzq+49HIvIj+8jVBMRPCEgAZyRe6z2j+tN8iNgbC2d+LQJb7eu4seIF6OUWaYC5o7e7Ki/SqwjrCAnsom9L41YElMu53gHr16TFGhl50UzS0cXhn/IzeL6cHNh7nX8Wt4nRXalWM3k3sOBhCgUSxahCaIwxJt4gYNGYQH6J2NRCvbGdTL0ezpr5W10lHMWm4FcxVKiY8r7EJR/Xonm0EjHyRXteRipp9bXZxKGL+AFnUEfxNKwD9c8g/D+LdtfadYdRlfazqP6mIhHH5UBB2DCbxc8PxSOxc1tZN0VKb/51rdEJD2qEDwU2is5L+Rvcty9YCjLtSHQmJ4GmGLuRgpn8+g0Nb+9yGeSDkPqkUpM/rm5vTgqN6tsd1cMTgotSez9h+YGypGXt+uHVxe3yJiqtTMRDJ4BU2Nq/obzXT+DRLZP1so6+FunM2FFcNCH9y/K0OQWGdbnTA+GjjFa8JYD7XU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(366004)(39850400004)(346002)(36756003)(31686004)(2906002)(26005)(186003)(6512007)(66946007)(66556008)(5660300002)(66476007)(8676002)(8936002)(2616005)(316002)(110136005)(53546011)(478600001)(41300700001)(6666004)(6486002)(6506007)(83380400001)(38100700002)(86362001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cDZPUTZEMkNFTmdJRnl3QkJTMm40b0tZYWgwN0pDZDlsLzVYaEIycGtjb0Qv?=
 =?utf-8?B?VTExNWo5MngrYnI5S29QV0RpL3dnaEJ0ai9EVG9hWEQ0WjFhdEhxSHVicllF?=
 =?utf-8?B?YUw2cXNCYkVzVVE3OTJFOTc2YnJHdWgweEJDdXU3RUZtWmp1bE52UlAveUNF?=
 =?utf-8?B?bjgxZEtXUGE3Nk1tQUt3ZUZJUk5OSmVXdVFLeHRIcmJnbEVIbldUM0tLUVpV?=
 =?utf-8?B?VGltOXNNSDQwazloSmlTOXhwUDBCOUYzRW4rQmFoY0xHenI5TW5hR0lwRVhn?=
 =?utf-8?B?NHZBdG1SckFHa0hsK0ZueUxRU3hSbUtjTUxYZ3BBQjVSZGZvNGhHZDBZY3Vn?=
 =?utf-8?B?bTdtRWwvTHNNb1pHY05IWFRBZEVUd3IrZ3FobnVBdGtGMzJBd2Q5TGY4K1pQ?=
 =?utf-8?B?dmpzdjVtY0hLMzVxcHFXWFE4M3NoWmNlS3pmaVFTM0JDQW50UGhSOFhlQUFF?=
 =?utf-8?B?Wm15TEF1N3gyOUZOaFkwSldxcEtwazVyTEZnUHE5emZOSUpscTJYcUlZWDRj?=
 =?utf-8?B?Vi9tRXNCOUpFWWRXTnZnaXJwN2Y4R0J6OVBvRm8rYytNUjhFeWs2U1pCSVVO?=
 =?utf-8?B?QllNaUd3OXE0ZEplbE9xMlJmZzIwNUswcDJJZE1SZUFxelRuOUdCUlF5YWtV?=
 =?utf-8?B?Nm5FSEd2aERIQllOb3YycXErNHU3UTRpZjhRbE1ISGc2ZUtmMmdwa3J3ZXNs?=
 =?utf-8?B?d3gwZVVyTE1RUW9MSXhvKzdhOTdWYS9nZmhnd0tGZTNub29JNUNCK1g5Mndx?=
 =?utf-8?B?ZzJaOU0zZllXajdxaGF5UVljR2diczJJbVA2YVNrWTFGWG4xbnZwbE5oQUky?=
 =?utf-8?B?ZGxHTGJzV3BxVG9tWW5Dd3FWcTM3SnlSRHNYcElUN0ZTcDd5Q0tFNzlVV05Z?=
 =?utf-8?B?amFEeEJPcldoTDlGQW5LdlpYdW90dmlSU0FHVmdrRWZhcGVLcUtPd3g1RFJz?=
 =?utf-8?B?UkwrSE5NOWQzNTNsRGYvcmVKZUdlbVhvZ1VIOXlZWUdHS0ltWU9VZldickM2?=
 =?utf-8?B?WjJSeUlCcjh5V2dnNVNoVXY4bmkzZW8wYlc1bVRINVdTdDJmMTI2VStuOFpM?=
 =?utf-8?B?bStnN0pybWUyYlJUeUNrRXVZRGFCZGZaRlpBSUsvT1pPMDFRSWp3dndyYkhG?=
 =?utf-8?B?SkRzZlV2MU5RR1doSEc2bGpQaXRjeEUwTExwemk2dWlBR3gwdTFvbTB4dllz?=
 =?utf-8?B?Ym1MQUlXV1NzSWduUVlIbE5VcXcxUlltUmFDU2JkcDZUZkUrYWRvR2ZEUVl2?=
 =?utf-8?B?aisxWUFwK2QrMkxvRHpZOWtTcFdaT1lONy9vMGljMi9mRXhYLzIvZXRRKzZF?=
 =?utf-8?B?TkpMbVY1TXZmQnBlcm5MSlRGQzV6MklsY2dTUitLbm1qWnNvS2QvaXpHNm1J?=
 =?utf-8?B?YlVqYTEzSUVqWFBkMnBvQk53SFQxZk1Cem1GbmRHRkpCZVlYaHhqZjdUdk5q?=
 =?utf-8?B?T2d0SjhsWEVmSHJmS3UvSmVoRDc2NlJrU2lBTmJFaXJwSG1NYWNWenBUWXpn?=
 =?utf-8?B?ZnVTdUQ1blpEeitsaGw5V0RpRzkvSDdkM1lUeWJVdVd2RVJUWjdYNHlWWVU1?=
 =?utf-8?B?Zm1ETktzdWJ6Qm10dnpHNXBLaXFpUlA5WUEyaFV0ZGErUS84QUxLYml2Ylhr?=
 =?utf-8?B?cmlrcUFLZ3YrdUJyMmgxY2xmdFNhbnBsZFlocnZLdmVvaUdxRDEvbjh4R0tL?=
 =?utf-8?B?VWdZa0w4SEMrMjJUQmdmNXhDNXRFV0h4dXJPem82U1dXNVlNVGZyQnNTQjZq?=
 =?utf-8?B?L1Q2WGdieUROVzFjK0xEVHBBV1VIUkwwY1NxdUtlcENTUkovVnFPeG0wd1dv?=
 =?utf-8?B?Uy83bXFQZ2hRN01sT2o0QkRVbHY0Z205QlF1MHlvdFlsRTRsd1h1UjRuYnVT?=
 =?utf-8?B?SHFwcXdweWk0bWxFL0JtekRza2VyQ1Qwd3pTcUpGdmZ3MW4xbndZMldyTU1K?=
 =?utf-8?B?MkUzTFFKTjdiSmgyTzNnUjJ1MWJNTHgwQ0xFc0Rray9TUzZMdWc5c2Z6Mjdk?=
 =?utf-8?B?OVd0ZG4zUmVsTjhBbnc5RExpYWlEQ2lsOFlIeWxLc0M5NnJxWWtheUdIREdU?=
 =?utf-8?B?a2JiejJpSWFmUEhxQk1namhWTWtHZXB5Rmlvd0VzcldoSEZiaUsxYUxkWXBu?=
 =?utf-8?B?ajU5RFlsbDdQbGlVWXhaelZNbEs1R2Y5aWRJZGVHUmFKNDBlOVJqYkxKcU1v?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1ea81eff-c099-4f49-2f8f-08da8afe56b8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 03:10:21.0396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 daEvT4RsXb42LNDcPAIlx+nug+t3U1GffwcVTbyk3r2NSrDR9OXae3mJ1PwJa1orJ6I+WHFo92VbBfeRb4kHsT2yff4gm+9B2KiIgKx4FnI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3513
X-Proofpoint-ORIG-GUID: joizwjmxDWvnD2JlIAfPyB4DZc7j6UPd
X-Proofpoint-GUID: wY3pkseYtkMX1NRV3ka-4i-43zDUofqS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-31_01,2022-08-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208310014
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 31 Aug 2022 03:10:28 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13947



On 8/29/22 6:46 PM, Peter Kjellerstedt wrote:
>> -----Original Message-----
>> From: Robert Yang <liezhi.yang@windriver.com>
>> Sent: den 27 augusti 2022 05:37
>> To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>; bitbake-devel@lists.openembedded.org
>> Subject: Re: [bitbake-devel] [RFC][PATCH V2] bitbake: fetch2/git: Use git fetch to shallow clone revisions
>>
>> Hi Peter,
>>
>> On 8/26/22 22:21, Peter Kjellerstedt wrote:
>>>> -----Original Message-----
>>>> From: bitbake-devel@lists.openembedded.org <bitbake-devel@lists.openembedded.org> On Behalf Of Robert Yang
>>>> Sent: den 26 augusti 2022 15:11
>>>> To: bitbake-devel@lists.openembedded.org
>>>> Subject: [bitbake-devel] [RFC][PATCH V2] bitbake: fetch2/git: Use git fetch to shallow clone revisions
>>>>
>>>> * V2
>>>>     Fixed typos in commit message
>>>
>>> Patch history should go after the --- below.
>>>
>>>> The "git clone --depth" only works for refs, doesn't support revisions, but
>>>> "git fetch --depth" supports revisions, so use it to do the shallow clone, the
>>>> idea is from "git clone --recurse-submodules --shallow-submodules".
>>>>
>>>> The workflow is (Only enabled when BB_GIT_SHALLOW = "1"):
>>>> $ git init --bare <clonedir>
>>>> $ git remote add origin <url>
>>>> $ git fetch origin --depth <depth> revision
>>>> $ git branch <branchname> FETCH_HEAD
>>>> $ git tag v<branchname> FETCH_HEAD
>>>>
>>>> Here is the testing data based on poky, the testing server has a very good
>>>> network bandwidth:
>>>>
>>>> Add 'BB_GIT_SHALLOW = "1"' conf/local.conf
>>>> $ rm -fr tmp downloads # Fresh download for each build
>>>> $ time bitbake world --runall=fetch
>>>> $ du -sh downloads/git2/
>>>>
>>>>          Full        Shallow      Saved
>>>> --------------------------------------
>>>> Time:  15m59s       2m31s       84% (13m28s)
>>>> Size:  12G          1.2G        90% (10.8G)
>>>>
>>>> * The Size is for downloads/git2/, the tarballs are not counted.
>>>>
>>>> We can see that it saves a lot of download time and disk space, for
>>>> example:
>>>>
>>>> linux-yocto: 2.8G -> 228M
>>>> llvm: 2.5G -> 171M
>>>> cryptography: 1.5G -> 35M
>>>>
>>>> And "$ bitbake world" works well.
>>>>
>>>> This a RFC patch, please feel free to give you comments.
>>>>
>>>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>>>> ---
>>>>    bitbake/lib/bb/fetch2/git.py | 83 ++++++++++++++++++++++++++++--------
>>>>    1 file changed, 66 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/bitbake/lib/bb/fetch2/git.py b/bitbake/lib/bb/fetch2/git.py
>>>> index 4534bd75800..57bb61d5ee1 100644
>>>> --- a/bitbake/lib/bb/fetch2/git.py
>>>> +++ b/bitbake/lib/bb/fetch2/git.py
>>>> @@ -244,6 +244,7 @@ class Git(FetchMethod):
>>>>                    ud.unresolvedrev[name] = 'HEAD'
>>>>
>>>>            ud.basecmd = d.getVar("FETCHCMD_git") or "git -c core.fsyncobjectfiles=0 -c gc.autoDetach=false -c core.pager=cat"
>>>> +        ud.basecmd = "LANG=C %s" % ud.basecmd
>>>>
>>>>            write_tarballs = d.getVar("BB_GENERATE_MIRROR_TARBALLS") or "0"
>>>>            ud.write_tarballs = write_tarballs != "0" or ud.rebaseable
>>>> @@ -344,6 +345,49 @@ class Git(FetchMethod):
>>>>                return False
>>>>            return True
>>>>
>>>> +    def shallow_clone_by_fetch(self, ud, repourl, d):
>>>> +        """
>>>> +        Use "git fetch --depth <depth> revision" to implement shallow clone
>>>> +        since git can't clone a revision, a better solution should be:
>>>> +        "git fetch --depth <depth> revision:<branchname>" but it doesn't work
>>>> +        when revision is a tag, e.g.:
>>>> +        error: cannot update ref 'refs/heads/master': trying to write
>>>> +                non-commit object <revision> to branch 'refs/heads/master'
>>>> +        """
>>>> +
>>>> +        import datetime
>>>> +
>>>> +        depth = ud.shallow_depths[ud.names[0]]
>>>> +        revision = ud.revisions[ud.names[0]]
>>>> +        branchname = ud.branches[ud.names[0]]
>>>> +        if not branchname:
>>>> +            branchname = "master"
>>>> +
>>>> +        # Rename branchname if it exists which can:
>>>> +        # - Avoid conflicts during update
>>>> +        # - Keep the revision on a branch so that "git submodule update --recursive"
>>>> +        #    can work since it requires the revision on a branch.
>>>> +        branch_path = os.path.join(ud.clonedir, 'refs/heads/%s' % branchname)
>>>> +        if os.path.exists(branch_path):
>>>> +            os.rename(branch_path, '%s.%s' % (branch_path, datetime.datetime.now().strftime("%Y%m%d%H%M%S")))
>>>
>>> Any reason this is done using os.rename() rather than `git branch -m?
>>
>> It is because this is simpler and to keep align with branch_path, otherwise, we
>> need:
>> - git branch --list to get the branch list and split them by '\n', remove the star.
>> - Check branch in the list
>> - git branch -m to rename the branch
> 
> If you accept that the command can fail, then you do not need to list
> the branches. Just do the rename. If the branch exists, then the
> rename will succeed, otherwise it will fail, but that is expected and
> ignored.
> 
> What I do not like about the use of os.rename() here is that it uses
> internal knowledge of how Git stores its data.

Thanks, I will update it.

// Robert

> 
> //Peter
> 

