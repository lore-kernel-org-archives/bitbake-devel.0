Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A761FC4332F
	for <webhook@archiver.kernel.org>; Mon, 12 Dec 2022 20:48:22 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web11.55577.1670878097152604060
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 12 Dec 2022 12:48:17 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriver.com header.s=pps06212021 header.b=FroZ5y+a;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.166.238, mailfrom: prvs=9345c419cd=randy.macleod@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCCAMeK009852
	for <bitbake-devel@lists.openembedded.org>; Mon, 12 Dec 2022 12:48:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=message-id : date
 : subject : to : references : from : cc : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=scWK6MvtqDPZZ/vlXrYoBliLsZkgMmIil5AwX8kArpg=;
 b=FroZ5y+ahxqCnQWGY36DGasBa3/2IzdV9MOy/jwwu4eN5PK6AlaPr679eqe2uaaKmUxD
 Lxs320iZ1tyTf/owDjSW4S2zMrpCWlK8gdgDnvDM9a1Wgr+aKfP7iyIf4VHSvBORpZq+
 Oq4X9hYSuOImhZJd45WKyQhDNuXOgA6syGRv5T2/FYyJocqItnpUXasNxiWZQf3+8heQ
 IeU8nzP0zHfM2qUaN0l4SKbMN1SO1R0nngi954qJ0crzRz0OWcKqrU04iv+wG+/QT+H5
 vkq8RN3zNj2Gn6hhbjYgyHqi5odT6R5Mw+YuVIYuAUEZ+QHqD10RwmAjzwf1vOEms+Tj rA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3mcp95sqeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Mon, 12 Dec 2022 12:48:16 -0800
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2BCKjgwK010583
	for <bitbake-devel@lists.openembedded.org>; Mon, 12 Dec 2022 12:48:16 -0800
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3mcp95sqee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Dec 2022 12:48:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JyzquVc1fGRE7DTg8sSCOCZdgIpkjk5seq7npON9awdzyuW7O0y1gmeeXZnyECFhbA077MRHZWI2O+asvBLoHJs161ADfRvykDSWgV19vmE8fGOIatao/HQJWU5i+ReUITwrcsYwpKECEdvN+VCFGoxXjd+lV8PTAzIlBD3w3pQCU4LOi7hY29Q6fURo7DuyM6UTCdNVxepv2dLnzZdB2h5daUgL9bqN++mtXrA8ZitaoI71zcxdiJTfzjtV4lUJvr16j3SSmKNk+JkQ/Rx5tuVwY/R+Y+rX4JX1qAx5vuKPqj7A9ISn7+r74Gnn87zn+J+CqYxIUNIJ5+QXqFK51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scWK6MvtqDPZZ/vlXrYoBliLsZkgMmIil5AwX8kArpg=;
 b=n5TX0cbteninDUro/vejRvGnUB/u4sX1J4bOmL87mDo/n0o8qSXb6D20YEGWjga/OPHDh5DbX+Vf6DpPuBu1ncCt4doma8JFCpyil6BfrTvdTxc0toAuSi6YOwcZnyClAZc09oMTr2o7O8e/GTuAfevOID6g/VWAS8AJ3qkmEEUO43YHCBSsRYhSvQIEjOuN7VQHc2qGcbGUEvHhC9yOZjvzL2K8ua3G5KgG4L9LGbyrMijofpWJtmVpVZOqvqcRl01a30coFvqn0435+EAGj++etcscV7e3ceTjvfhkypGuOEuf/A0QLuravfLgArZ2CAH5lQb3rWulyycXqNbAgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3994.namprd11.prod.outlook.com (2603:10b6:5:193::19)
 by CY5PR11MB6305.namprd11.prod.outlook.com (2603:10b6:930:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 20:48:14 +0000
Received: from DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::e794:335f:5e0f:8d36]) by DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::e794:335f:5e0f:8d36%6]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 20:48:13 +0000
Message-ID: <49ffc1db-9b43-e570-d726-dba12d560a30@windriver.com>
Date: Mon, 12 Dec 2022 15:48:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [bitbake-devel] Bitbake PSI checker
Content-Language: en-CA
To: bitbake-devel@lists.openembedded.org,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        ola.x.nilsson@axis.com
References: <jwq5yegq5h5.fsf@axis.com>
From: Randy MacLeod <randy.macleod@windriver.com>
Cc: Zheng.qiu@uwaterloo.ca
In-Reply-To: <jwq5yegq5h5.fsf@axis.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY5PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::40) To DM6PR11MB3994.namprd11.prod.outlook.com
 (2603:10b6:5:193::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3994:EE_|CY5PR11MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 442b0455-210b-4a63-044e-08dadc823003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jwCy8gTtmeLGNaN+69Dll1bwoZ7E1pGq/Tc8LP1m6+jHOut3lm8vgeBX9Xaxjt68cX4Gh4QNxEYs92gfl7ayYRDAhcnrgzjjn56V7bBZqnsqSA/1O0mkaqm/69O4siFZA1lU2wpHm8w5RrlU+hkH+Nsku8qtyWl4QmOAUAiFtzDVHRRKR6SmmcucVH32v6JQe8dpjLiJnqoWHRIIHkQDsfL+zwdjQC3lnQqXJ3L2gcDtA2u/AmVZA3zGdL6Kg8/RdTldZs35cNv9sef5fHMq9fpekMcVkVgPe7XMLnfVH6rX3wWYJ+b7AEdkrEQDLquYWFlScCxV3k8DCkbulNmLA++qMqjQbZXWgq80TyPPdSTKOIAT/Pm9Jy+XYYVlaUGiy3QwQDjYYT9S5xK0QQW3e4u81YzNNhNbxTGubvGUAqROnwi2/fdmsi9oIzqglfXgkT7KdImwvxT2Mc9Wc85AM6+iGktWokoU7S6ZL9xMjRFAIYyIC9YH87De+5sKgU14kjUgf7PIuzof5+MPeKVn/PUmmd1zA+Qt+kkGkUU7XRZ3an1wERJsLo+/rtay58u5xqUUOjSvC/lO+b931nfb5kogPqVlEns1WbzGk0VH43sIGf+VCCxZGefMXYQ0ezHVkXU92qftCpirPtHBdLA3He7ebO9RfMQufBq4kj7hf/GBpovvaahMYoXyoaYUXFOpzmPUi24SQzRFlh2cED5R5KXGZfx0tj3L6jV+WiMclRVQRuuoQUIEqJeiYjgEHrzWPWnf84XX9BKqU+/3OlCh6NaF5yMH+r6HaRjahnjKxEE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3994.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(366004)(136003)(396003)(39850400004)(451199015)(6512007)(36756003)(41300700001)(83380400001)(26005)(31696002)(186003)(6486002)(478600001)(966005)(8936002)(5660300002)(316002)(53546011)(66556008)(66946007)(66476007)(4326008)(86362001)(8676002)(31686004)(6506007)(66899015)(38100700002)(4001150100001)(2906002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VmFhK1dOa1duSENyYStuQ0VWZ1ZiUXBOdG5BQlIyMUpVUVpZMnNsZlVrRlV4?=
 =?utf-8?B?THF2aFo5L1Uyd3lsQmVpeGhDLzRqdkJ4b0IzZWRqbGVRRlN5UEpZSzdpdmVD?=
 =?utf-8?B?TFpHdkNjZUYvcThQU0xnK2FXN2xFVjhDWm5zQStuem5RNFhhL0JoTVU5TXJJ?=
 =?utf-8?B?b0tLeExjd1p3alArM25USVZDK3pvKzJpQzZUUHdBQUNsdDhLbXI0cHhwbFl3?=
 =?utf-8?B?SjFGeXJyblBwclFhUUlXc3pTTU5sQ0N5L0hMY1QyVEhveXV2MmJPVTQ4ZWIv?=
 =?utf-8?B?T3Q5Z3lSZHVoUnZyOFRsNmh6Z1ZocS9jUVZFRHZkU3RWVU9xS0xiclVrdkc2?=
 =?utf-8?B?eE9tKzAwQ24zdU81akZ3ZGJCa0dYci9kMlFLKzE0L0xINHNqOGUrU2hKMzJw?=
 =?utf-8?B?NTgzTkRQYjlYcXdiby8rT1RiblFxK21MTTRKdGd3VkhFdXdZS1VYRFZpc0Jp?=
 =?utf-8?B?UDgxRkhmc3lPcDVuYkozM04vMWU4WW91NndOdm1uN1pVK1BpOUU2QzRkRGk3?=
 =?utf-8?B?NFJBampsNzZvcFJ1RUlkbDBib1ZmcjQxRHJGcUlUMTJUTitsZHJyNFlzUHdt?=
 =?utf-8?B?dUE2SytwS2I0QnF4eUNMSzQ1QUVRWVdDQjllNlphOE9uSzdCTmJnWldDTzBU?=
 =?utf-8?B?UkhobXF5cGt1eGc3ZFRVRk5PUHZJeFJ0b21pTlhWeVRMQWg3bWlxZjBmVUVX?=
 =?utf-8?B?eStXTy9lL0U1UkZqS1c4Mit4KzdMQ0FJYjVrZkxEeWQ5dUQxYkJyNGJmOVla?=
 =?utf-8?B?Z3RTcGNBV28yTkVWckNab0ZGUDNkdzdGR1BCWis4OFBObVNjSWhweXpyaFNm?=
 =?utf-8?B?Z3ZqSHFmWS92Z28vMmZEUlFqdnNUS25zMTZyNWZDVXNQYlhHM3F5VS9OMlRR?=
 =?utf-8?B?TU15Q3NNWUtXR2dxZmhZajVxQVI4RWRQMDdsRmdDVHNmRnJLT05RaTVEUDEx?=
 =?utf-8?B?Z1JWeVBqRndmTzlReEJKRlZLTzQweXRFM1g3WlpuMUdzclVCNitWTDV5TEhG?=
 =?utf-8?B?TjVlV3IzZ3JKUldrN2d6NTQ4UVE0K28vSjJDMzZZSU4zbnJ4dXNIU01WWXNB?=
 =?utf-8?B?YnJRZUJreTZZRDlGQk9tVG5QU1dUbUN5MWhpU0VRTXAwR0JKbUZROFVyc0Mx?=
 =?utf-8?B?Rit3eElwVm9pbkFTblFXOHN4ZkYvYTBielhmb0ZyVGlra2taVXd2YWhxMVYz?=
 =?utf-8?B?M0hwcUw3b2I1dWthZkJaYnA0dEY3VDFzaWh2RFdsL1pNS29aKzdLL2h2VTNG?=
 =?utf-8?B?djVObmVvRWxVQVFNQms1a1FyM2h0NUZ0NjlvdW1Sd2x2cm4yeWE5Ylh6c0J6?=
 =?utf-8?B?Z2NpQ3dPM2xzemFjVStYVVkwS2wzYmVHbXdoMDFTZDQxY3lXTlVsR25XM3Nz?=
 =?utf-8?B?cG10MldCb085Z2FmM1kzM0JNZHFmQ2ppRnl3QW1SR2Q0YUVLa25iVit3MGhn?=
 =?utf-8?B?U0FCWXhuaFNYaHBYN2szV0p1VkU1T3FMc1UvVDlPcmwxRmVLcW90d09lb0tt?=
 =?utf-8?B?Z0xCSmI1VnlFY2ZkS0hXYkZ4MXRTSXdBUXlYeHp3T1BTYzJxaENyNkY1Nmc5?=
 =?utf-8?B?T21USFV3S0lLcnZtUWpDdFpId0lZczZzUURaRjVxQVI0Zitvb3pqQmRjZ1RQ?=
 =?utf-8?B?eGp6K1FYNzUrVHpkNUFQTzg5MVd2alBKSTJhNGhvKzRWSmc4b1I4K0dNV2Jp?=
 =?utf-8?B?VVAzSVhVY2MyakhmQTdXQ3FQaXd6SlRTTFEzT2hmZHM1VldwNVcwZHNSWmlz?=
 =?utf-8?B?bTBaT3dxdUxIMWdXQTZhMWVjQ3NiOEcrU0xFUW93bGlEYjduczlSc1ZpSlhX?=
 =?utf-8?B?dGFnc2w4ZVdPTVg0RG1vbDZjVkE1TUhWQ0dYSlp3dVB1djNTeCtXbG8xeDZo?=
 =?utf-8?B?RURJakdqN0V2dmxNR0pmdTluUXpKTWFDdzFzdE0xQVlZUG9aZStRbVRZSER4?=
 =?utf-8?B?d1Bya2lONGhZL3VhYm1PTGF1V25wM1htUzAxY2piQTQ3dnZSMTFlWFNLSHE1?=
 =?utf-8?B?VWQ1b1hzVXdiblhWSHF3c2lIbmVpZTFvTU9JQU9xblNKUjFJcnVnYW9mWTds?=
 =?utf-8?B?eWhSY0t0Mi9NTk1vQk1BUXFrM2cxSUhuK2w4VU9ieGUvZnlDODVjZzJoTWoz?=
 =?utf-8?B?WjEwdmJrV1Rxa3VIZmg5WTVEakgwY2JqKzZNMGYvb2pWaFZxQ0t3YTE4VDBr?=
 =?utf-8?B?M2c9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 442b0455-210b-4a63-044e-08dadc823003
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3994.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 20:48:13.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZuPPXDZ5av44Gs4DzYpITbd+o3pYlIkBVSIjW+kbfSX5a2yl+4YlO7iL9SJBlMiw4ahohKpk9cvzfX0XYs0YAYzc6jfLtcDvLbfraTBjWM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6305
X-Proofpoint-GUID: 36Cb4QFYAomMZ796TUmPzGWloxYR7T7d
X-Proofpoint-ORIG-GUID: sOFQ7z1gUoD03-V_KFKQBkILC4OOdCOr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120182
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 2BCCAMeK009852
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 12 Dec 2022 20:48:22 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14184

CCing Richard

On 2022-12-12 05:07, Ola x Nilsson via lists.openembedded.org wrote:
> Hi,
>
> I've been looking into using the pressure stall information awareness o=
f
> bitbake
That's good to hear Ola.
>   but I have some problems getting it to work.  Actually I think
> it just doesn't work at all.

Doesn't work at all?

Well that would be surprising. See below.

>
> Reading the code I find that
> runqueue.QunQueueScheduler.exceeds_max_pressure claims to "Monitor the
> difference in pressure at least once per second".

That comment isn't accurate. I'll fix it.

Currently, the pressure is only checked when
bitbake is looking for the next_buildable_task.

This can occur many/100s of times per seconds at some points in a build
and later, when larger recipes are compiling, the function may not be cal=
led
for 10s or 100s of seconds depending on what is being built.


>   But using some
> debugprints added to that method I see output like
>
> 1670840023.757171 cpu_pressure 0.0 io_pressure 0.0 mem_pressure 0.0
> 1670840023.758697 cpu_pressure 0.0 io_pressure 0.0 mem_pressure 0.0
> 1670840023.760158 cpu_pressure 0.0 io_pressure 0.0 mem_pressure 0.0
> 1670840023.761733 cpu_pressure 0.0 io_pressure 0.0 mem_pressure 0.0
> 1670840023.959357 cpu_pressure 969.0 io_pressure 16135.0 mem_pressure 0=
.0
 =C2=A0 19 second gap
> 1670840042.384582 cpu_pressure 8978077.0 io_pressure 1353882.0 mem_pres=
sure 20922.0
> 1670840042.384582 cpu io  pressure exceeded over 18.677629 seconds
> 1670840042.486946 cpu_pressure 466.0 io_pressure 30792.0 mem_pressure 0=
.0
> 1670840042.490340 cpu_pressure 466.0 io_pressure 30792.0 mem_pressure 0=
.0
>
> where the first column is the value of 'now', and the pressure values
> are the calculated deltas.  The 0-pressure values are probably because
> this is very early in the run and the time delta is less than 0.01
> seconds.
>
> But there is a time delta of almost 19 seconds between line 5 and 6, an=
d
> unsurprisingly the pressure exceeds my max settings of CPU:600000 and
> IO:200000.
>
> But the very next check is only 0.1 second later and while the
> prev-values wont be updated, the calculated pressure will be used.  Thi=
s
> pressure will be below my settings and a new task will be started.

Yes, that's a bug and I need to fix it. See below.

>
> Am I missing something here?

You aren't missing anything.

The code has "limitations" but it has still proven useful to some people
and on the Yocto Autobuilder system. Note the lack of 'interval" errors=20
starting

around Aug 18th, 2022, when we enabled this feature for the YP Autobuilde=
r:

 =C2=A0=C2=A0 https://autobuilder.yocto.io/pub/non-release/


> If the pressure should be monitored each
> second, isn't it reasonable to have some sort of tick to update the
> pre-values?  And using the pressure delta of intervals of less than a
> second also seems to give too low pressure values.

That would be a better implementation in some ways but
what we've done so far is only check the pressure when
bitbake is checking for a new task to run. This will be less
intrusive and people do worry about the efficiency of bitbake.
Adding a 1 second timer may not be where we want to go.

It's a little tricky to provide short-term averaging regardless
of how often the function is called. Here are the improvements
that I'm considering:

1. Rather than just keep track of the previous pressure values
seen more than 1 second ago as done currently:

 =C2=A0 =C2=A0 =C2=A0 if now - self.prev_pressure_time > 1.0:

and always using that as a reference, we can
store say 10 values per second and use that as a reference.

There are some challenges in that approach in that we don't control
how often the function is called. Averaging over the last 10 calls
is tempting but likely has some edge cases such as when there are
lots of tasks starting/ending.


2. If there has been a long delay since the function was last called,
we could check the pressure, sleep for a short period of time and check i=
t
again. Some people would not like this since it will needlessly delay=20
the build
so we'd have to keep the delay to < 1 second. Too short a delay will redu=
ce
the accuracy of the result but I suspect that 0.1 seconds is sufficient=20
for most
users. We could also look at the avg10 value in this case or even some=20
combination of
both the current contention and avg10.


3. Just calculate the pressure per second by:

 =C2=A0=C2=A0 ( current pressure - last pressure ) / (now - last_time)

This could handle=C2=A0 short time differences such os milliseconds
as would be a 'cheap' way to deal with long delays. In your case,
the pressure would be:

 =C2=A0 978077.0 io_pressure 1353882.0 mem_pressure 20922.0

divided by ~19 since the initial values were close to zero.

Then for the next time, just 0.1 seconds later:

1670840042.384582 cpu_pressure 8978077.0 io_pressure 1353882.0 mem_pressu=
re 20922.0
1670840042.384582 cpu io  pressure exceeded over 18.677629 seconds
1670840042.486946 cpu_pressure 466.0 io_pressure 30792.0 mem_pressure 0.0

Multiplying by 10 or easy calculation, the would be a pressure:

cpu: 4660, io: 307920, mem: 0.


Do you have another idea or a preference as to which approach we take?


../Randy


>
> /Ola Nilsson
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#14178): https://lists.openembedded.org/g/bitbake-de=
vel/message/14178
> Mute This Topic: https://lists.openembedded.org/mt/95618299/3616765
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [rand=
y.macleod@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

--=20
# Randy MacLeod
# Wind River Linux


