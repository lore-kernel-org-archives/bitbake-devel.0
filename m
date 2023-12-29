Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC58C46CD4
	for <webhook@archiver.kernel.org>; Fri, 29 Dec 2023 04:24:33 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.139480.1703823872770176609
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 28 Dec 2023 20:24:33 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=eAUR8KCW;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=17273a50bb=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BT4LIEx030158
	for <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 04:24:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=FdzXaXDgiSL2p+foNw4rM52xwW3RkohnSAzVe7qXGYs=; b=
	eAUR8KCWAlNV+lY61JSfBKQfuj/8L03wpXGQ6SSpkbFC7skbKhgy3ZnX9WHDudEL
	xr/OSmbGaqv1KQ6ManyTq7csw58w9Lpzpmr1EaLVAzv7Kg4lv9kgxiesoPxPaAMq
	BC2ny7bByMjkIarSwWe/Gox3YwzmClit/xNwuIrM9Mj+ii/Vr/iO9AQvD6f0OijV
	xUezzUPu38AjnDj2MWuEbf/MnjmbEK+SvcaBId6QfhqysYEAe2IOP9N3W9MeaUIw
	tUMDcxpYUE7Pb0DLGF5v22bBpRpK7ti7MYDjaJTqlD/P14lwytY3MJAu5YnyEVop
	2wzZe/mVBzqOd67oCRueBg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v5ph64vt1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 04:24:31 +0000 (GMT)
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 3BT4OUOv000338;
	Fri, 29 Dec 2023 04:24:30 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3v5ph64vt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Dec 2023 04:24:30 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a9r7D5zY1LKhhvWJba3k4Y9CHYo/dIAc/pDhnTpSz+iihRXWiaZ+pj48et16bYk17l0OnVO37o5i5Ip4H/6Ux59B0ss53cAskFZ+BVwAQuMVdiVMcmeveW7bDNPtKRzN5cxxumVpkilpvJBQvKCOglpEJ/3hZaQsU4E7WI0A9/I7Mq+t4LV4BGSIp8xOtbch6l9G3L0nONgg2ASdzZx91Pvs46g2MKunZDDaX3NXQ6vGumy4LIDis+LXhBZGYNryoP4aLKRErSBX/JPp98eJbkCj+L4Lkvf8CVozOMmMymorrAI+m+/dA6UCFHYbBAmHx1v10wn8aJsXoEBzZGIKnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdzXaXDgiSL2p+foNw4rM52xwW3RkohnSAzVe7qXGYs=;
 b=f0fidGaUMjFKxuVtTOs5eID8FF2wnoXjsAFrM5g4VhwLS3Jmuh4Zm7VotwbiQeH/AM5Fx7aP89lE0zUrS9rdxBTnqVZZLzVTggs7nuTuFMnvEenSoosZz7+QupJ61SRSgj2Iza9Gu3e+ranMDExVnWZg8vNw0LwU1hlDhNc+VikA95beqBXQKZa1OxtZx37vl6Gx49Ry/wz/thiMTdqXamTixIIMPGLxzIbbYrBuwHfaU0wHy+zQ5mbUVRwDM0wW5gXI+QeS43cVFWnJHcHrqU47+kHYuxgWwiAg6cY2akBhyeZqIYSSQKPHlJ+KDOKo77D1A7ZDzkK/2zT+RNVLZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SN6PR11MB2800.namprd11.prod.outlook.com (2603:10b6:805:5b::15)
 by DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Fri, 29 Dec
 2023 04:24:27 +0000
Received: from SN6PR11MB2800.namprd11.prod.outlook.com
 ([fe80::8fa5:3ac:9b74:3d95]) by SN6PR11MB2800.namprd11.prod.outlook.com
 ([fe80::8fa5:3ac:9b74:3d95%7]) with mapi id 15.20.7113.029; Fri, 29 Dec 2023
 04:24:27 +0000
Message-ID: <4170c6f7-d3d1-4ef6-ba05-70d726495758@windriver.com>
Date: Fri, 29 Dec 2023 12:24:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v2 1/1] bitbake: event: Improve error
 message for eventhandler
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
References: <cover.1703602054.git.liezhi.yang@windriver.com>
 <fc7836bc2ab8d8eded60098081d74d427091ad74.1703602054.git.liezhi.yang@windriver.com>
 <eaf8b03af08d979f90db0eca8ac46281ae29436d.camel@linuxfoundation.org>
 <666b301d-e444-4a20-a5a9-602e56e773b5@windriver.com>
 <8919f2990c1c8eace318a9075280a1b256c498c5.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <8919f2990c1c8eace318a9075280a1b256c498c5.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0012.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::15) To SN6PR11MB2800.namprd11.prod.outlook.com
 (2603:10b6:805:5b::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2800:EE_|DM4PR11MB6479:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad0ec72-b4b0-4df2-353e-08dc08260b12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	75oyYSINEBGQLjB75jlv10CB9yBCZqhsC1D6GAU9l+WJ++zI6UpAe3bwOun+RVrv6fJ2evOT9DMnLzlB5Vtqw5O7Way2LEirm6EmOXVfCJvIfJaQZ4S8fZqV5FrbcaNRGSadYyLl8bwuQebrRoo/4Cn5pEsCy/5xQEf2vg9QNLmjP2NaITDSmGv6HzaQYCsQzH13391gXu4UhyjfQb6spqrsvX9uNQTGDDmEpxgS5f5k+nXqt9AseX+Wh65HpIkz7OsxzkvvhJvwN11zefPGis6mJb1zDxgOzsdZ7QN2nBjHiE2J8289ywnr/HnDGNrjla2L0BhP3x5elNC24CqMG+TEvFWAAdpMmnkxuI6UwFa3Fw1ytr1uy8iKZMMXpyUahwMSnn8yeG8h7WqwrnPBYPBzr3UQoq9xnSClDpl1Hba94CfIODF/8InsS5r0n1gWnaiROe6RsZY//jj/fmKwVz+st8sMeBH7NpYLiMdAE2p3usg0a7Kmlt/OXMlCdNiRuBsrsCOsQ249e+ZNhBAg30pEsrYb9ubiFv/ldm/Phxf7KAW7qIupWrrATLFfYLaplr0pij7HKkZnjgQhxjZ54AL8wlhChZTFN2uBEf8KG8IB0tJW/AP3aFK2Plmv5PaIGgci2oud5DMXM+BVRxh7iiGKeKbgTiASaiTEs4pUe7xZo/OknhoVgbj7hTPTUQl4
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2800.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(366004)(346002)(39850400004)(230173577357003)(230273577357003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(66946007)(66556008)(66476007)(6486002)(316002)(8936002)(2616005)(26005)(478600001)(83380400001)(6506007)(6666004)(6512007)(8676002)(5660300002)(4001150100001)(2906002)(15650500001)(41300700001)(53546011)(36756003)(38100700002)(31686004)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ODhKOWpuUEEzYWR4Y1lCK2ZxYThDTGY4R1hzV1ZWZWdGeHNkV1RockE1OGh6?=
 =?utf-8?B?U0QzRllLUG5qV3R3SXliNUIxQkZjbTdxejVKYklUQXpTRjZSZ3BGUXJwVlZt?=
 =?utf-8?B?eEZ6c2toczhjZXlhUzFiNXZVbW00ZkF6S1hIYVpqWXJRUnJBdjkzcFBnUjhV?=
 =?utf-8?B?TFJMRmhrMFRVTU5UY21pK01PaUZhcmVadmhsYUFXdkxLOCtvdXlqSkh5aWxO?=
 =?utf-8?B?MFFiU0FiTC96S2Zsd0JsM3BRaDJqRW5xR3ZDdXM0R0RVS1RkcWVnMnl0UVZq?=
 =?utf-8?B?eXg0bFE0UWRjUHNzQlNjNEpBWklkVnk4cDB5T3Mzc281bWpKbU1MMlRuRFUy?=
 =?utf-8?B?UU5EVXkyUjZBOUdLN0NaVE9na2QzbloyQjRwcFdwUE43d1REK2Noelp0SlBJ?=
 =?utf-8?B?TkFES2p0OWlUQ29tSkhqcjQ4c0xjZlMzS29YZys5L0drU1JMVDNSSDJEUEV3?=
 =?utf-8?B?K1dRMlZudmVrdjE5ZitJaCsvbVVUbDdURHlvcEJUNG0zM2QrOGtuaDFydnRM?=
 =?utf-8?B?bzBoZWM0ak5tVklNOW93SXpNK1pIdmpLTmh3QmMxSDAzTXRxbDhHbHFydmU4?=
 =?utf-8?B?QTBJYXEwZGhleCt1QWJudVgxQjd5d3Q2OGxzMzhMR1lwWmltNGdqdXZSOElz?=
 =?utf-8?B?YXdBTFQxMkl2M1RhRkNWd2MwamlNaitsaGVJNDlpZTdHS2NlTkNRaTV0dmFy?=
 =?utf-8?B?K1VqYWdUMldkaDdTVVRta3RXOWhqNnFzQXJNVlp5V09WcGdvejFVOGpIbWZJ?=
 =?utf-8?B?dTZwc3RRQnpaNVkwalpaSHgybWx4RGIxaHJkMVBwQVR2L0w4R0RPN3BzOUxJ?=
 =?utf-8?B?MVhMODNCV1pDczZ5M252eVBzRVpRNkltbW0xbEJLSWZzdGNnbjZudmpENER6?=
 =?utf-8?B?dlB1MFU2WUR4R2JjUkR1cHNzTVRWM2Q5bno4cXR3ejhXM1l0MHVFK0psa2do?=
 =?utf-8?B?bWphZmlBZ29PK090OGZldTJlZ1ZwQnR2R2ZReVJpbDA2WkVNa0o5NFpRbU1S?=
 =?utf-8?B?RTFXa1BWOEQwcS8wTExNcmdNZGl3NUh3aFAycnpLNHY1aFlHZXRXbXorVWV0?=
 =?utf-8?B?Z1ZDVkRhMjFYMk1GWEtLNVNTZDg4MHRDSEptV3VNQVpIaHQwb1ZtaWZ5OE5s?=
 =?utf-8?B?UWZLMjJaRWZPY0xteDF2Nk9QNmtXRlh2MGt1YUMrV2RmaFFRaXdISlNJSHNG?=
 =?utf-8?B?MW1lT2IyMUVaTFZKRnNFaWIwY0s5RXB5RGtValVyMDN0WHRLZElYU0NLM2pN?=
 =?utf-8?B?STZIMWgvYlliT3NSNXRQaG1oNGtGZ0UrMkd1R3I4bGd2UVB3aEZtRjBqb1Vj?=
 =?utf-8?B?Z3h1UVg1SE5NTkpOYndBV3Q5MmJlZUpVV1Q2aVV0RlRmeVNkNHBicmFBcjBy?=
 =?utf-8?B?Y0Q2Rkh6NjNBSENyQVZTbDJrTW1jV2k4NzZuSlo5NEE2TmZSOVJNalpKdXMw?=
 =?utf-8?B?YlJ6eTRLU2lBcGl2MThlaktxa0pGNW1ydmxEMVRQMTVFL28vallJOTVHTnNU?=
 =?utf-8?B?ZTlpMTkvY013QUZWeFp2bmlSYzJZR3NWb3E2ZG5xNjVIWGFndEx6L0lrZG05?=
 =?utf-8?B?eW1yZVV3OExqL295NFZ3Ry83WndCWGpUU0tQTzZhdWVpcjdIK0hZZWcvU0lG?=
 =?utf-8?B?RWV5WFdBdkdydTZnazZ0T0dsOW5LQlNOaEFtTHYyMXJZalpCczBHTVpHOGdC?=
 =?utf-8?B?bllUQy83aW5rM2FmbTltSjRWK0dVTDV1eGR0eXlFRDJoTmpRMnhYemZ6eFBx?=
 =?utf-8?B?OThyQkU3bjlmL2hRWFNpWFNLWmVjZU9yUHprY0dRK0pIV2tPUjRLOGdZMmZE?=
 =?utf-8?B?WVV5NjRVQ2djcDVQS0FIM3FqMzFMZE5wMGJPOURrTmJYOGhKQlBGQXVyT1ZM?=
 =?utf-8?B?bVJxU2NHUlIrSHdCSE5jYWMwVFhiZ1ovTzJZbmc0b3g1OWVYV3hRcWUwSUFR?=
 =?utf-8?B?d2gxMVVqK2Z2enlDMVZzOU5JeVdLdEY3aXdET1NZWG94SGpIYUI2eEt2QzlN?=
 =?utf-8?B?REJXUFR3OUtmTzNLUHovWEF5UHFISVhsVjRxMlNtKzlFNkx2enZTZWdaQmpE?=
 =?utf-8?B?dmFMeFh5STY5cjhUZ3JsQ3Jja2RMWkVVVWJXYlJpOGxLbkUxaithNi9MT2pS?=
 =?utf-8?B?UWh0QXUzZ2FvbVlNbGNVK0dydG1wTm9oOGhYOEgyTTRvb2MyUkZ2VEdGR2VU?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad0ec72-b4b0-4df2-353e-08dc08260b12
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2800.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2023 04:24:27.0186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a24H/VaGBHvkv2qIu6l3prIsx+cSEBQJ5CniENZ7OOKjXcljF1Oml9QItReOyhFc+4V5C22MZTiEqnCsR1PHumzBRH1Y7zhMD5VkVV4+Pio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6479
X-Proofpoint-ORIG-GUID: 4xFvLNel-dj1IsTPRShn1d7nRCwwFsfl
X-Proofpoint-GUID: IuksJjzgzmjALpAH9_w9F_FDzRoBFtOd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312290031
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 29 Dec 2023 04:24:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15716



On 12/28/23 6:44 PM, Richard Purdie wrote:
> On Thu, 2023-12-28 at 15:15 +0800, Robert Yang wrote:
>> Hi RP,
>>
>> On 12/28/23 07:42, Richard Purdie wrote:
>>> On Tue, 2023-12-26 at 07:11 -0800, Robert Yang via
>>> lists.openembedded.org wrote:
>>>> From: Robert Yang <liezhi.yang@windriver.com>
>>>>
>>>> * In python 3.10.9, the error message was:
>>>>     ERROR: Unable to register event handler 'defaultbase_eventhandler':
>>>>       File "/path/to/poky/meta/classes-global/base.bbclass", line 4
>>>>         # SPDX-License-Identifier: MIT
>>>>                ^^^^^
>>>>     SyntaxError: invalid syntax
>>>>
>>>>     This is hard to debug since the error line number 4 is incorrect, but nothing
>>>>     is wrong with the code in line 4.
>>>>
>>>> * In python 3.8.10, the error message was:
>>>>     ERROR: Unable to register event handler 'defaultbase_eventhandler':
>>>>       File "/path/to/poky/meta/classes-global/base.bbclass", line 4
>>>>         an error line
>>>>            ^
>>>>     SyntaxError: invalid syntax
>>>>
>>>> * Now the error message and lineno is correct:
>>>>     ERROR: Unable to register event handler 'defaultbase_eventhandler':
>>>>     File "/path/to/poky/meta/classes-global/base.bbclass", line 256
>>>>         an error line
>>>>            ^^^^^
>>>>     SyntaxError: invalid syntax
>>>>
>>>> * Fixed it via:
>>>> - Don't pass filename to compile() to make it can report error code correctly
>>>>     in both python 3.8.10 and 3.10.9.
>>>>
>>>> - Fix the lineno offset and filename in traceback message.
>>>>
>>>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>>>> ---
>>>>    bitbake/lib/bb/event.py | 23 ++++++++++++++++++-----
>>>>    1 file changed, 18 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/bitbake/lib/bb/event.py b/bitbake/lib/bb/event.py
>>>> index f8acacd80d1..9eecb141379 100644
>>>> --- a/bitbake/lib/bb/event.py
>>>> +++ b/bitbake/lib/bb/event.py
>>>> @@ -260,16 +260,29 @@ def register(name, handler, mask=None, filename=None, lineno=None, data=None):
>>>>                try:
>>>>                    code = bb.methodpool.compile_cache(tmp)
>>>>                    if not code:
>>>> -                    if filename is None:
>>>> -                        filename = "%s(e, d)" % name
>>>> -                    code = compile(tmp, filename, "exec", ast.PyCF_ONLY_AST)
>>>> +                    code = compile(tmp, name, "exec", ast.PyCF_ONLY_AST)
>>>>                        if lineno is not None:
>>>>                            ast.increment_lineno(code, lineno-1)
>>>> -                    code = compile(code, filename, "exec")
>>>> +                    code = compile(code, name, "exec")
>>>>                        bb.methodpool.compile_cache_add(tmp, code)
>>>>                except SyntaxError:
>>>> +                exc_lines = traceback.format_exc(limit=0).splitlines()
>>>> +                # Fix lineno offset manually since compile() cannot handle it correctly
>>>> +                if filename and lineno:
>>>> +                    line_first = exc_lines[0]
>>>> +                    if 'File ' in line_first and ' line ' in line_first:
>>>> +                        lineno_new = line_first.split(' line ')[-1]
>>>> +                        if lineno_new:
>>>> +                            lineno_new = int(lineno_new)
>>>> +                        lineno_new += lineno - 1
>>>> +                        line_first = 'File "%s", line %d' % (filename, lineno_new)
>>>> +                        # Fix filename
>>>> +                        exc_lines[0] = line_first.replace(name, filename)
>>>> +                    else:
>>>> +                        logger.warning('Failed to fix lineno for %s:%s' % (filename, name))
>>>> +
>>>>                    logger.error("Unable to register event handler '%s':\n%s", name,
>>>> -                             ''.join(traceback.format_exc(limit=0)))
>>>> +                             '\n'.join(exc_lines))
>>>>                    _handlers[name] = noop
>>>>                    return
>>>
>>>
>>> This is better but I'm still wondering if we can improve. The other
>>> trick we could use is to inject "\n" characters into the start of the
>>> string you're compiling so the line numbers really match up. Would that
>>> work better?
>>
>> If you meant the following line:
>>
>> if 'File ' in line_first and ' line ' in line_first:
>>
>> I can use re.match() to improve it and send a V3.
> 
> I mean something like:
> 
> tmp = "\n" * (lineno-1) + tmp
> 
> which would increase the line numbers on the string to match the needed
> line numbers before we compile it.

Cool, this is very simple and works well, V3 is coming.

// Robert

> 
> Cheers,
> 
> Richard

