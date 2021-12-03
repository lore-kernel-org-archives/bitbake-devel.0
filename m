Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7D2C433F5
	for <webhook@archiver.kernel.org>; Fri,  3 Dec 2021 18:55:52 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web10.15800.1638557751413094003
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 03 Dec 2021 10:55:51 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=SyDhwd36;
 spf=pass (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=797145d64d=randy.macleod@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id
 1B3Inbmm010412
	for <bitbake-devel@lists.openembedded.org>; Fri, 3 Dec 2021 10:55:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=subject : to :
 references : cc : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=Vvwd48FcIh0a1GWHzEoTqk+rZJ65kCQ8dkNlXn4U+3o=;
 b=SyDhwd36DAqhc1JR5EiQFxGXyaAMXWhP2VO+zKztrdX+tQEwYxchxtGSgJrzU3ztmpmL
 p0KH/F04DV8MFaGsCKrcTt0hpYoYv27VgQQ17CbC6rbesbh7aliRKR+3QDvVHBs3h5iG
 7snTF8foPWVyG8CQVwWZusRtsPAAUe0vxIK1NoEyWbKFh54jRjwtyTETx8W87fzZ+dcy
 H1UNCJ8PUsSVd0Nz0U/Z0lxOmzEyDW4Gn8+4HpZ52Hr/21n3SSpMW6OVUUlBMVlMYJ95
 gqZvr8Z7kTo12+NPKCD3YrOn2VG0WWPo38CFSVTGIyA8A8MF7g2hxb5EzgYV5BA4ZzZ9 RQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3cqcnu0jk5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Fri, 03 Dec 2021 10:55:50 -0800
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 1B3Iqkxo016157
	for <bitbake-devel@lists.openembedded.org>; Fri, 3 Dec 2021 10:55:50 -0800
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3cqcnu0jk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Dec 2021 10:55:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyrjDY3EeSw4OlOc8coYw5u0HRtlYpomTF+0HbcGPF7H4OUSEsQQF93aEsLvMayWbvriGKZVyCaPLqYDq8ozc+EpsIzXo6k0Q2kVaf1OEGOn9w7p1uBoXQ5UZjB54Vq3ox0R0unCILpbU+mjNwoy9qdFyZAT0Q7Sfsgg1LlqDgrbZHa47eqZMR0NiIfdQUN3EGf/8YVudqufVFvH6YEVBehytFFfWJ0XrO5IScfa6cjhCYhPVm88Db0Uv8jVMDLJqnhFIWM2wr3m30/J55V+TqhE1s8YDAEDoWufwcJZarBIlMMYyYZLnPa+CKOxMUYpB15gNAty2EaaG4C/QSII+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vvwd48FcIh0a1GWHzEoTqk+rZJ65kCQ8dkNlXn4U+3o=;
 b=FibAvAHaIPwWZ4bVURaXfzcsnclMdi/ERDsLhOSA9yyIW3DMaBfHdLvLoo7lkYifDRqAQLgTDKMbNvu2D8+/n1LOj00zLqeJ1GAWvYLbuXPRUuy6i/I8dZydaSFY5YDVCdqtNm+LVoF0MgisDaM0HHZPSaDdW23d972cnWsKs6vECU/ebIQ7KMUtHsQ2VOQ3Gq5zllL4tFDepQqz73H6kc8ZNtFwTjTK89Sw+wo1qGBMlZM6PhAx+NeDZAB7tYhBBOkvJjz3S4T+ZX8SDWJQ3Dt8NUIn3MKaxFaHDtQtAM74uyu9f7VzAedXjTmWBTkhXQ93MDlgqLkw7KCxODp0Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3994.namprd11.prod.outlook.com (2603:10b6:5:193::19)
 by DM6PR11MB2714.namprd11.prod.outlook.com (2603:10b6:5:ce::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Fri, 3 Dec
 2021 18:55:48 +0000
Received: from DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::f1b5:133d:c04b:46a3]) by DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::f1b5:133d:c04b:46a3%4]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 18:55:48 +0000
Subject: Re: [bitbake-devel] [PATCH] bitbake-worker: Add DryRun event
To: Mark Hatle <mark.hatle@windriver.com>
References: <20181002013719.97783-1-mark.hatle@windriver.com>
 <675086deaafea11489a53cdb9dc693d16a0f50d4.camel@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        "Yang, Liezhi" <Liezhi.Yang@windriver.com>
From: Randy MacLeod <randy.macleod@windriver.com>
Message-ID: <6e818bc3-d9f8-1f2b-494d-b91709a5abdb@windriver.com>
Date: Fri, 3 Dec 2021 13:55:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: 
 <675086deaafea11489a53cdb9dc693d16a0f50d4.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0336.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::11) To DM6PR11MB3994.namprd11.prod.outlook.com
 (2603:10b6:5:193::19)
MIME-Version: 1.0
Received: from [172.25.44.7] (198.48.226.187) by
 SJ0PR03CA0336.namprd03.prod.outlook.com (2603:10b6:a03:39c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23 via Frontend
 Transport; Fri, 3 Dec 2021 18:55:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 21e1c6e7-67b8-45e7-a8e2-08d9b68e84bf
X-MS-TrafficTypeDiagnostic: DM6PR11MB2714:
X-Microsoft-Antispam-PRVS: 
	<DM6PR11MB2714E5A1A374F6AF29982140F86A9@DM6PR11MB2714.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZjgstK/J6C4+uoeKHnsEAe3XKcDdzdtsqhjpBqnmarJliSERw4zqMtLVmbPw43iXxA8ZlfOt/st0ryeK6EqYt9xf7GWOhnlgkBKeV/GydKyw0NuYgHABKs6hEr69JxzexPgg/c6OjC22mDT6ZuKiD4vZ3JagGxH99UEteDMtMGyMxV5K2SqwZ4ypOn0CjPWOjGtJurIBHeGwY02Up79S6unBi2RHvsEQqdeN4Zc/JWZHJ8PK22M6zGAoZ2WWlfjq0cXhaN/V1KTrgd+v4GCSAVYOx8t4BIP/THZlSsXggNXYyJN7h+tIg52H/PHydWZvglpUdd+eGVuQUyey7Ek+AsLz0RrEP0x2mNaPGeAk3sxilbA94n2bsnlLhQXKCx66C+/GUwYUfw7YE7cAdOi3qQRE0wioW53h5Hgtj7UWWmm52Hx/fIAXbc9kYUvGysPT3jbauKevNSfHYhfQsQV140Ji4ITeMoi5DzoGVDwGlPmnJevAXEgU0afztQcg9N/WPoNlg/0AdNXmSWb4zKP9OP9eonauE4s1A+I0CUnKlo+eVq3mMaRQkdy6A9G59m3XwMbuHVEBDbnSe86nQVHT30Ife4IQOBdEPMcZE/Akdxug3zDGQL0EpIjuqRll/XaUjBYNi8y56R83OxrGiaghh9Oxs3p8bobWNkTnTOxGLslzSGr1tDcJs4NCcwKtvStZc87Zt4i2pATDQ4CKxAQ+5hKV9tPJlg0E0afh2qeZ19ucF/Ng4dxYaLC4FvEB3pxzHwHueiLnWRp1ls5kBCQ0aw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3994.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(8676002)(508600001)(38100700002)(38350700002)(83380400001)(5660300002)(6666004)(31696002)(86362001)(31686004)(2906002)(6636002)(66476007)(26005)(4326008)(53546011)(316002)(16576012)(37006003)(36756003)(107886003)(2616005)(6862004)(66556008)(66946007)(956004)(8936002)(6486002)(186003)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SFFlWXVnS2xvelQ5eUY1Y1pWSlh2OHozQnYyUTVjZWt5MWd6c2lkdUNiS1Ft?=
 =?utf-8?B?VjNVd3lhOEM1UU5xZ0tSTDB6dEI4elkrVS9JRi8zTURxTm9LeFcvQjBFeDQ5?=
 =?utf-8?B?V1Y2TDBaZ1N5NG9Lc0Njck1TQjJCanM4VDhaaU9BQ0JGS0RyVDYwcnRHTUJt?=
 =?utf-8?B?TVJvbGpNN011S3Q1RkRBSjI1WlJaZWRHeC9zNmJ6Zk1BdlU4Y2t0bWNFZG1q?=
 =?utf-8?B?UU9VdmZZWlBBcExTR1lGRVc4RGtOeWZlMitucDlEQStHN01JMjFaeWlzaWgr?=
 =?utf-8?B?ZUJza04vRTVPYnRpV0V5d2VmdnVzYkJNbDdGRnR6TmVUTFNKVzRWeFdIUnNZ?=
 =?utf-8?B?bXdMTHFBZTZIdG83S3RVQ2h2Z012ZkgvWkpRbTkveERjVEJIaElHU1dhSVl1?=
 =?utf-8?B?MzRnak1EeGpNODNqaE5hSk4vcDJIRXhqaEtMRlIwZ0YxRnpZVkFLbS9yalVp?=
 =?utf-8?B?a3BvT2w4cWk2QjlCRTRiRFNJVlJ4NXRiNmgzK1FqY3lTcjNtZENTYnBTY1VK?=
 =?utf-8?B?NElnay9uSklBMTlMdmpoNjZ2eVRqWFdEc0Z4TUViNmJ1L25EUUZ1a1JRb0x0?=
 =?utf-8?B?bENWc2Q2azlrZUwyVTJJN2RscDlsQ3Z4bzFyK3ZvWGh6OVRrbVB6YW9nai9T?=
 =?utf-8?B?SGFtMWlCMVdBR2FTS1A1THFaaXk2QUlYampjZy9PQjhWNjJOYVpILzN6RW45?=
 =?utf-8?B?ejAwRlNkd0hBcDV0a2J2cFpLdmFOM1ZhUEhGeDNWdCtFSEpEN0FlVEtqSU1I?=
 =?utf-8?B?MTNTeDYzN0h5TzlORkVxRURUNThKT1JmaFVsVGovWUhXRGErS3hoZnB4OE01?=
 =?utf-8?B?VlJjRCtUUlVQaUFmcklEUHBpZFJKayt1b3NuRFVsT2RsOCtvTzEvTVlLeWhH?=
 =?utf-8?B?SERjZW42VDFVK0RjVWI3TVBCRDlkUzU2M3FEYUlLc2NwYWt2dUpVT3JTc2x5?=
 =?utf-8?B?ajdOTHB4OUtFRXVKdWEzdHc1L3d5NFJkQ0pUZXFLYXBzV3lsdk14ZEcyTUl4?=
 =?utf-8?B?S04vTzFpa1lma2xkd2FvVkhIa2RwUndIYXdkbWtPZHFQN04zTUQ3UklqUEdx?=
 =?utf-8?B?eG1tNUZXZWFONy9Ib2xTdXhjVnl2b1NtTXlkaXdiSzdMU3p4dXJia2N6QmRv?=
 =?utf-8?B?YWdGN2FPL1M0dXBYZEFJVWRuSE1yZWNqQm00blVNOUQ0TjhMc1JlV2Qxc0pE?=
 =?utf-8?B?VTNIdUpaM21JYkZXZGtkWW84cWt3SUgvcEQ3NVE5OUUxR1hTQURXRVdqcG1V?=
 =?utf-8?B?ZUdKZXRSblIzQnl4UitmYVJyMG9xSlFEV0FKUkg3MHY5cDMvYyt3cXhUakda?=
 =?utf-8?B?aGNWWURCOFErQnptS0lhVjVpV1pqWUlad0V6dlVTamJhMExpUG9LS054Rnha?=
 =?utf-8?B?TGwxdklzR3pNLzdQRUFZdDdaL3duZkgvcjE2dkFoeFR6Z1g2YSt0M1RQWVJ4?=
 =?utf-8?B?TjlIdzRHVDU5QUZzdWVESjR5ZHlOTzl2bGJFa2orZUs0V2hoRUE1Tlp0djhk?=
 =?utf-8?B?WFBYVzZqa0MwTkNwTmsyNXI1YWtrL0pna0pMVWRWWXRweU14Zm5RendzRHF6?=
 =?utf-8?B?b2RmRlovdVp0TktLLzNGM0k3UDBQZUtQTVQ3azk3NldnUzVxYUlURkVpWU1o?=
 =?utf-8?B?MDBZOEhwMkw3TkJhV0RET2UvcFE1UysvbXQrWllwUi9MOHVJMCsvS21nM0hp?=
 =?utf-8?B?dmk2N0VjWjg3V2xrc0hvKzBicld4cmhqUFluM3l6ZWg4MjZzZk43akt4NlNQ?=
 =?utf-8?B?OHNlaWlHQlpXampmU0FBRmRWT2NZTEZ4LzFQV21QS29xRWdtQUx0b280VHU0?=
 =?utf-8?B?aEtYcnB3Q3RKV2FyVHBGUUVWSW9WOGhFZGZyc1dpYWtNcXh1VGR1UW1Xckdt?=
 =?utf-8?B?S29QRDNiZlp6aGFLVnV3N0c3MjBvYUN5UE9rNDBoV01ycGxlUnNXWjMzYjRV?=
 =?utf-8?B?WGloS05uN2ZGa2Q4L29HZFNCTSt5V3FMTEFEa0ZmbGVMOUdnTUE3dXdwR3B4?=
 =?utf-8?B?cWxUZGl6SzQycmM5SDMzN21SbmFLUW1HNUpBOG01MTFJL2I3S3R0N3B6NWVB?=
 =?utf-8?B?VHRoSDlhUGsrbERhYTduZldtaWRwVTVkQnN5aWN3YmVPM1ZuNDV6V3I5MWZN?=
 =?utf-8?B?SVlHVXVtbll4K0RpZ2JmMWoyZUlsSzVSVDRQb1RZczM3TWdtTWc1c3hjOExI?=
 =?utf-8?B?TE9kNUUrbmp4WkYzbmR0OUU2dk1Vcm03aVYrUFJLeU11bm80eEhnSEpXbndL?=
 =?utf-8?Q?QsipZaZH4panr8xz8pbMt0QdKXS4QEw2KnJfiCMf1U=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 21e1c6e7-67b8-45e7-a8e2-08d9b68e84bf
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3994.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 18:55:48.0189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 qhZbHOiboYy9ZWORDUeXA3679T3nA0NiDrWRFIQ0rttnBm170zW4CkwxXfVJqZyNfmdiwmFa96+BIWrXMB5cRFzMspqCcIqk73vN6/pLJXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2714
X-Proofpoint-ORIG-GUID: OOTH37TJxfubnWuisHLyoTGYzuZ53d8O
X-Proofpoint-GUID: 7WnS_rxT1TZUkrU98d4uERaxFITirrPT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-03_07,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1011 bulkscore=0 priorityscore=1501 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112030121
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 03 Dec 2021 18:55:52 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13130

On 2018-10-04 4:57 a.m., Richard Purdie wrote:
> On Mon, 2018-10-01 at 21:37 -0400, Mark Hatle wrote:
>> There may be actions that a user wants to take, but the information
>> is only available during task execution.  Using the DryRun event you
>> can prevent the actual task execution, but get access to the
>> associated data stores.
>>
>> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
>> ---
>>   bin/bitbake-worker | 2 ++
>>   lib/bb/event.py    | 5 +++++
>>   2 files changed, 7 insertions(+)
>>
>> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
>> index e925054b..e27fe7ac 100755
>> --- a/bin/bitbake-worker
>> +++ b/bin/bitbake-worker
>> @@ -268,6 +268,8 @@ def fork_off_task(cfg, data, databuilder,
>> workerdata, fn, task, taskname, append
>>                   os._exit(1)
>>               try:
>>                   if dry_run:
>> +                    localdata = bb.build._task_data(fn, taskname,
>> the_data)
>> +                    bb.event.fire(bb.event.DryRun(), localdata)
>>                       return 0
>>                   return bb.build.exec_task(fn, taskname, the_data,
>> cfg.profile)
>>               except:
>> diff --git a/lib/bb/event.py b/lib/bb/event.py
>> index 5b1b094a..c03541a1 100644
>> --- a/lib/bb/event.py
>> +++ b/lib/bb/event.py
>> @@ -832,3 +832,8 @@ class FindSigInfoResult(Event):
>>       def __init__(self, result):
>>           Event.__init__(self)
>>           self.result = result
>> +
>> +class DryRun(Event):
>> +    """
>> +    Event to fire during a dry run
>> +    """
> 
> I think we can add something like this but the DryRun event should
> really be in build.py and subclass TaskBase, called something like
> TaskDryRun?
> 
> I'm hoping that doesn't upset some of the other code that looks at
> TaskBase events but its certainly logically where the dryrun event
> belongs.
> 
> We may want to pass dry_run into exec_task as a parameter and put this
> code at the top of exec_task to make things cleaner across the files?
> 
> Cheers,
> 
> Richard
> 


Hey Mark,

I was looking at local WR patches that we carry and noticed this one.

When I asked you privately about it in 2018, you said:

 > Randy said:
>>

>> Isn't this always firing?

>> It's mostly harmless but it's no longer really a completely dry-run

>> if you're logging PR info. Do you think anyone will object or

>> have you already discussed it with upstream folks?

>>

>> Why not add a new flag?

>
> If there is no event handler, then firing takes nearly no time at all.. I've

> sent the change to bitbake.. We'll see if RP or others have comments.

> 

> The change itself though is designed to be generic, in that we want any possible

> event handlers to work through this -- as it could be useful for collecting

> statistics and such as well -- without running a build.

> 

> --Mark

> 


so do you or Robert still care about this ?

I don't see it mentioned in the WR docs but
now that I think about it, it could be useful in a few use cases.
The one that was mentioned in the internal email was:

> Typically populating PR service takes a full build.  This is because the

> do_package task is what actually assigns the PR service values.  So we want

> a way that will allow us to generate the PR service values in significantly

> less time then a full build.. (minutes vs hours)



-- 
# Randy MacLeod
# Wind River Linux


