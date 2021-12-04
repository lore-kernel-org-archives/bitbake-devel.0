Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD58AC433F5
	for <webhook@archiver.kernel.org>; Sat,  4 Dec 2021 15:55:11 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.26204.1638633310557691694
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 04 Dec 2021 07:55:11 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriver.com
 header.s=pps06212021 header.b=PIoyFMhk;
 spf=pass (domain: windriver.com, ip: 205.220.178.238,
 mailfrom: prvs=79726358c8=randy.macleod@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id
 1B4Ft8Ku031992
	for <bitbake-devel@lists.openembedded.org>; Sat, 4 Dec 2021 15:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=subject : from :
 to : cc : references : message-id : date : in-reply-to : content-type :
 mime-version; s=PPS06212021;
 bh=li74yccanIpIh2tzhJwiIxJM17De4/Qp+5R1ZmPxspY=;
 b=PIoyFMhkAU1wGRoY9GrB/qt8LKsi6UC1rkVDCuAO9VhA8cuDaZLa6Cb2EqoLIdoCag26
 dBE13RVbBv2n9Lc3qVk/LlVriKUtrvyjRKXuyzCkbkljmp9lcJP+1If6IH4nQw3LQoTE
 XFVzTfWuvRbZ5IuU88Gqk4jkHKGzFbdkT528hslEDvTvAzDQkErSYzNJgmZaiMXcG+T6
 te5K9SfIh0lTmddz21Ww4KGYq9x+pAr5qLdS/2Xzvx8sIgo/zGxtV9LOFs4tmDuYFjdj
 poPx/iny6WujCncWwwi1Q8pNrqQs/GTC7QApbRpv1GQsrrmYaHYfH2N6fV4UHmHWh+DG MA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3cr1fmga7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sat, 04 Dec 2021 15:55:08 +0000
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 1B4Ft7qx031985
	for <bitbake-devel@lists.openembedded.org>; Sat, 4 Dec 2021 15:55:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3cr1fmga7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 04 Dec 2021 15:55:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ElcOjTJHFigX+ktYvupo1Gj8NA659YOkMMN1/+WCxzRS7fjGJj1OlFeKmvOPbLC8VU57Zga00GCl2UCnAaW6f9l4Gx1cph1t8L7EfQVtg/1SMTUdMbgaEviTG/Qs/vzBfc/PyzQ12ecfSVRD9iLcA20DBqgk0YwAm9JblwmSyNHqhMkDWTXv4GiDEZNuaLScG0KXreR5rGRz4HcOBqlHBoKCtSWbEj+qbxkX1egfiD+YZ16reAm1hb1T+jKr2iiiIabJVklVVHEXa4rJ9rdUWzL+uWDexEmwnSu2BPxOHydKDk5/MZRVjs1hXHO1nQc98kBzmd0ReIbcCrFDlQINNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=li74yccanIpIh2tzhJwiIxJM17De4/Qp+5R1ZmPxspY=;
 b=LTfBjLW1+7PcA8sex+89W1rSLbfXECpq61Pk6R8ct03L9B34MwM46ZLYu3HKv741Wlk0iaQMCMUnYmAxn6qEK/rY+gUwjfJqNjgpR/8RBYPCgjEOzH5DnFWTSlBUIIWEhdMZ4a+yJLNC01VphkSS6Dj4xQWn5zbeb8eqUL0XNoW6+7+vBAqzg74xPjD8CwcGQbhR3M8NZWPwp3vSZ1MjD3U+qUd7YwjM85brUWDmhW57TvUu0/AYmN+ZnMO/FFCU9FNVtmSPOWpvuQJL7dVMiQZY9J4X0XtIpMFb5+yKf+OMHBxn76IwE/336ShbTSXTMbQm/SVXMSWf6NxcLnkFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3994.namprd11.prod.outlook.com (2603:10b6:5:193::19)
 by DM4PR11MB5295.namprd11.prod.outlook.com (2603:10b6:5:392::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Sat, 4 Dec
 2021 15:55:04 +0000
Received: from DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::c52d:281d:a9ee:67b6]) by DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::c52d:281d:a9ee:67b6%7]) with mapi id 15.20.4755.020; Sat, 4 Dec 2021
 15:55:04 +0000
Subject: Re: [bitbake-devel] [PATCH] bitbake-worker: Add DryRun event
From: Randy MacLeod <randy.macleod@windriver.com>
To: Mark Hatle <mark.hatle@kernel.crashing.org>
Cc: bitbake-devel@lists.openembedded.org,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        "Yang, Liezhi" <Liezhi.Yang@windriver.com>
References: <20181002013719.97783-1-mark.hatle@windriver.com>
 <675086deaafea11489a53cdb9dc693d16a0f50d4.camel@linuxfoundation.org>
 <16BD539807513EEF.1024@lists.openembedded.org>
Message-ID: <f5376006-3465-2280-bcce-dd0a32555033@windriver.com>
Date: Sat, 4 Dec 2021 10:55:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <16BD539807513EEF.1024@lists.openembedded.org>
Content-Type: multipart/alternative;
 boundary="------------0598813149809CBF08C4A916"
Content-Language: en-CA
X-ClientProxiedBy: BY5PR17CA0054.namprd17.prod.outlook.com
 (2603:10b6:a03:167::31) To DM6PR11MB3994.namprd11.prod.outlook.com
 (2603:10b6:5:193::19)
MIME-Version: 1.0
Received: from [172.25.44.7] (198.48.226.187) by
 BY5PR17CA0054.namprd17.prod.outlook.com (2603:10b6:a03:167::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Sat, 4 Dec 2021 15:55:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c78f377-77d1-4a11-eea9-08d9b73e6fce
X-MS-TrafficTypeDiagnostic: DM4PR11MB5295:
X-Microsoft-Antispam-PRVS: 
	<DM4PR11MB52953A05348D75EC3046EE56F86B9@DM4PR11MB5295.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	k+xyPvbsZe2xjNT3+77G+MYgLk1f5pfD0wkFA33W86bHn1t6NQmcMULBG8JzGa7KuA7YR7kj/LQQhftydacuM4e1Ug0aoertHeaw7J56wSDhY3CnjCblAR26O/FVP68eygJk64j790n/YS5Of03acvt/EfIGHT3WnCP/Q0nwCOjk9iUwirLr9AEvjx6Hlpi3wpjtJlNgXBIFM4hoWwK5M0Rgulhs2W/ZMRvRrRgVCmxZqv2/VjdFZGn9WS7/TPGXUtsaQDvAT928H4x6+AT2dvVpriWxF7qWavVgDgSXqIKctPeMMhWV1N73dzvpSHWO7ed9tB4Rw7lULILvOLvYyAa86SQR1FQTeo3a3c7opD+WQN4VOMAPkmhVLYm+mukB39tTB3ps7c8a9B9dzrR+BALw4mt8QPCVHfREOfD9LeX+I6k+9n8GUQXM52LKqKQC514S1GKn/P+x7w2Vytphf+wbn3iUz6IpnHIiRJnvNEYSzzbtX71kMKMRsstkif+F1doqr0UI3Z4pT/AAJJSSN+ODpBP0ROvYdqfgD41vanxM17fQmpSQpeLYu7AzOy4TOddZooVNQD1hT0BlH+nRMbg6INoR6QfFpqnwO/Qf55nM0SydFQloK4YFW1sxfZMdVOhgaiPPH1kuHLCPV3GKhcwWFNYnJgYQMMiyT8WByot/SOwkyW1aPmPHKExdmqWe5YV5rrRMLLKzvdIeb81ucyn3+ukXk3udB7GRQDf2wDrgCcdeSz08kceldZMqcdBRwSzK6kvTC+qSIHZfSo5Ji7W+nwKrQT1RzeZUw+shrte0f4dfwkeoIU5rmcrERYSuJghKMnImTlgSykmMLzQCgATVouXFI8KU6OpQomkzhvpPeFiADVFoZSSXhRVGH6XP2rFOvOnclAEMV+5l1iXoUw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3994.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6916009)(6486002)(38100700002)(2906002)(166002)(107886003)(83380400001)(8936002)(31686004)(66476007)(66946007)(66556008)(38350700002)(33964004)(16576012)(54906003)(186003)(8676002)(508600001)(966005)(5660300002)(2616005)(53546011)(36756003)(52116002)(26005)(4326008)(316002)(86362001)(31696002)(956004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?d25SUG8rTEFzMmpFNldUU2l3b0VpT1JXSytHbG1VbGt1NjZHOCt6bnVPUDQ3?=
 =?utf-8?B?SGFnRDI2Ny83dkpjbm5WQ283T2JuWUhBMndTVlhZTis2YjhQU1Zhd1RkUFVw?=
 =?utf-8?B?WXJzTmtiUWMwMFFJamJjRlhxL1FTVjNSNnVRUnIvY1RxeTZmQks0SllEUXdI?=
 =?utf-8?B?K2t5U21UbUdPNlBwYzJYWDZyM3hjdkgvcWlnOExPVGxsMkpuam8yM1FJTDBS?=
 =?utf-8?B?Nlc2MVQ4amRCT3c1cHdodEt1VElFU2lKTjMxRVowenZKaXczeG5ZKzlZQm5B?=
 =?utf-8?B?Qm55MjFneUlCbm41WXRmL2J2TmppODJKR0RoZmhzd0IyWE55d05IVUFnL0No?=
 =?utf-8?B?aHFGZ1pDOENFUWNwaFFzU1FBWFpYVEYvc1c2ZEVIWnJqZkJrTUNjZ0laSVVC?=
 =?utf-8?B?MHVwdFk3NjByZXlZZ1BkOFRncDB2QlI4V0JMWkRKc3IzL1JlTTVDMnZGOTFw?=
 =?utf-8?B?VkRvWGgxMXhpa09ncnJBcGlTeU5wN241cVFJODVIZUxneFBYYllDM2dvMVFN?=
 =?utf-8?B?UTRGRkhZWGdpWENpVzV3M0ovQkJFQmcyc0ZnWndoR0FvbmVjR1JZUE8wTVRG?=
 =?utf-8?B?bERZc1dGTG4rbGtkUlhVeEpQNVFPYVlLS2RSR1gwdnBBSk9BOEM5SlZyMmpP?=
 =?utf-8?B?TURXQmpENW50U2t1MCtXWGhJKzEraUhWMUxRdXp2NnRkSGI4SDQxdlNXSGd3?=
 =?utf-8?B?Sk0rZGhTczVnWWE4STJpWjVmUFRWU1EvdWFHZU14TTNZTXRaU3E3RzJQV2VY?=
 =?utf-8?B?T0JjWWRwWHNnOFUyVlNuSG1uQ0lWVDlEOVVmSjBienJhbGxiTTZSVzBxcjdo?=
 =?utf-8?B?Q09nckxCWWpvcXN0UFpYOGpMY0lKa1hSbkowdTlrWEZKK2h2dTBXcFpvTXdN?=
 =?utf-8?B?aEtDN05BaithYjdGK0laZ1dnU01RclZ4OEhjNFBUQ3NVZ01ZaVVma3l4UlNs?=
 =?utf-8?B?bUQwWG1jL252aTFWNmNjZksxbGlCTDRHa3A0UCtac1M4SkpEMU4yaDNnN2JR?=
 =?utf-8?B?TWNmZGorNU12YkttTkNOOGV2YlFibFV4eDY4V2xpa2RRRzVxZHZVZndZbC9n?=
 =?utf-8?B?cGhBUEIyTE90eGZOdVl6cTMyQzNJdk5kZ29PYmZheHVKZHlIdUJieTA1eVA1?=
 =?utf-8?B?MHRES3BYVkNScFVMMDBmZzZ0VmlRVzF2Z1JMcnZ2WGFSdjBWcEdieUpVYkE5?=
 =?utf-8?B?WDVHTFozSDNsQit6dzcreDhqUk9IZjByMGhhczZ5Q0RyTEc4M0NrT3FYTVBh?=
 =?utf-8?B?bmc2aVR1WUREcEcxQlN6cmNNakZLd3k5OXFHYmN4azc4VWd0VUVjK0Zid3I2?=
 =?utf-8?B?Z0pjYXFYdFd4aWYxM2RDK1dXalNMRGZ1S1hpRC9YWm9scmRqdWJGUSt0dTBw?=
 =?utf-8?B?WW44Qkc0VjNhU00wL0JtSVI5QmVVWXBpMFhLc2dZd2NnNmRlaXhOKzhiRWM1?=
 =?utf-8?B?N2pDQW5Ra3RzU1k1V2l2eFJIUVZIUjVvRk9iSjMxS3pEdVpGbUJNb0VKWmJY?=
 =?utf-8?B?elM4cW54S3lzU2dyUWdHanVEblBOMG9SMFRGQ25WTXBiajAxQXRiMm0zRUZU?=
 =?utf-8?B?TiszSTA5SE1aZHhibXh1R0VERUU5UmI0SXRzSGhrdG4zcFFQTW5nY1VoZk0x?=
 =?utf-8?B?aUNhUFVGK2xvdmd6WU1HVHB1dVd5K1NXMXNUblY1cWpMRERmVVlHRUlwVU5x?=
 =?utf-8?B?aVNZSG5BUWNsYk5mTitlUUxoRGMwR3QzVXdSaG9XQVMycUh2TkJtNmVGN092?=
 =?utf-8?B?NFpOZldHQUpJZE5ZUjRjNktma3l6aDRXR0FVTXhpTUo3MUFYNWN5aGhPeS9m?=
 =?utf-8?B?VTUyM202eU03Q3RHdVFhUFRhNzdCUURZUkF0VS9TSXVoL3ZtSU9QNlMvUENl?=
 =?utf-8?B?M2c3Wjk3cDJ1cUsvZFpqZmVOY1Z4ZlVxbGgyL2hqaHlrNkdzOWVBdi95STBS?=
 =?utf-8?B?M0NjbU4wWWE4K2t3Ym0wSVBMeU9pM2I4NVlmaVlDbWNaUnJOaE1MU1Y4L1pp?=
 =?utf-8?B?eU1mbVBQb3U2U3pseUZ1aXRGNWRvREJTajF5cXVWK2x0bkZRNENoS0sySzNh?=
 =?utf-8?B?OXhUa1VzbGU4bjBRUjIyTlBhZFhQcVFMK1ZPWXplQU5mVnR2b3VKZFFCTmJr?=
 =?utf-8?B?Um96dUZCWmZBMUpFUWJ3U1AvUUdKZnI5VC9WUnVBM1A5WG9SM2c2VTY1V0ov?=
 =?utf-8?B?UnI4RjFqblhzcXUyUHQ3ZndMTU1QSGpDdUloZ0tCZVZNQ0t3d3VWODNvTS9w?=
 =?utf-8?B?TjRzWFo5K2VjV2dCMnhheWNwc213PT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4c78f377-77d1-4a11-eea9-08d9b73e6fce
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3994.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 15:55:04.3823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 0+8POSx+UP2R+rBi2vtHcxz8Gohmsjm7MkULbDjBmxUX9XKibegGaiilTtt4cjCXq2JkMjRvS85pNb9HbU/4ikq55GEv3p/lYXJvQM0bwDQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5295
X-Proofpoint-GUID: sJre1oJ0NktwqrQbC8ol_Nyv100m2tTE
X-Proofpoint-ORIG-GUID: GtwmA4TwvqWClfOfScAvD7xc-RXSdKPD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-04_05,2021-12-02_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 phishscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112040101
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 04 Dec 2021 15:55:11 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13131

--------------0598813149809CBF08C4A916
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-0064b401.pphosted.com id 1B4Ft8Ku031992

Use Mark's current email address.
../Randy

On 2021-12-03 1:55 p.m., Randy MacLeod wrote:
> On 2018-10-04 4:57 a.m., Richard Purdie wrote:
>> On Mon, 2018-10-01 at 21:37 -0400, Mark Hatle wrote:
>>> There may be actions that a user wants to take, but the information
>>> is only available during task execution.=C2=A0 Using the DryRun event=
 you
>>> can prevent the actual task execution, but get access to the
>>> associated data stores.
>>>
>>> Signed-off-by: Mark Hatle <mark.hatle@windriver.com>
>>> ---
>>> =C2=A0 bin/bitbake-worker | 2 ++
>>> =C2=A0 lib/bb/event.py=C2=A0=C2=A0=C2=A0 | 5 +++++
>>> =C2=A0 2 files changed, 7 insertions(+)
>>>
>>> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
>>> index e925054b..e27fe7ac 100755
>>> --- a/bin/bitbake-worker
>>> +++ b/bin/bitbake-worker
>>> @@ -268,6 +268,8 @@ def fork_off_task(cfg, data, databuilder,
>>> workerdata, fn, task, taskname, append
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 os._exit(1)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 try:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if dry_run:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 localdata =3D bb.build._tas=
k_data(fn, taskname,
>>> the_data)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.event.fire(bb.event.DryR=
un(), localdata)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return bb.build.exec_task(fn, taskname,=
 the_data,
>>> cfg.profile)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 except:
>>> diff --git a/lib/bb/event.py b/lib/bb/event.py
>>> index 5b1b094a..c03541a1 100644
>>> --- a/lib/bb/event.py
>>> +++ b/lib/bb/event.py
>>> @@ -832,3 +832,8 @@ class FindSigInfoResult(Event):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def __init__(self, result):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Event.__init__=
(self)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.result =3D=
 result
>>> +
>>> +class DryRun(Event):
>>> +=C2=A0=C2=A0=C2=A0 """
>>> +=C2=A0=C2=A0=C2=A0 Event to fire during a dry run
>>> +=C2=A0=C2=A0=C2=A0 """
>>
>> I think we can add something like this but the DryRun event should
>> really be in build.py and subclass TaskBase, called something like
>> TaskDryRun?
>>
>> I'm hoping that doesn't upset some of the other code that looks at
>> TaskBase events but its certainly logically where the dryrun event
>> belongs.
>>
>> We may want to pass dry_run into exec_task as a parameter and put this
>> code at the top of exec_task to make things cleaner across the files?
>>
>> Cheers,
>>
>> Richard
>>
>
>
> Hey Mark,
>
> I was looking at local WR patches that we carry and noticed this one.
>
> When I asked you privately about it in 2018, you said:
>
> > Randy said:
>>>
>
>>> Isn't this always firing?
>
>>> It's mostly harmless but it's no longer really a completely dry-run
>
>>> if you're logging PR info. Do you think anyone will object or
>
>>> have you already discussed it with upstream folks?
>
>>>
>
>>> Why not add a new flag?
>
>>
>> If there is no event handler, then firing takes nearly no time at=20
>> all.. I've
>
>> sent the change to bitbake.. We'll see if RP or others have comments.
>
>>
>
>> The change itself though is designed to be generic, in that we want=20
>> any possible
>
>> event handlers to work through this -- as it could be useful for=20
>> collecting
>
>> statistics and such as well -- without running a build.
>
>>
>
>> --Mark
>
>>
>
>
> so do you or Robert still care about this ?
>
> I don't see it mentioned in the WR docs but
> now that I think about it, it could be useful in a few use cases.
> The one that was mentioned in the internal email was:
>
>> Typically populating PR service takes a full build.=C2=A0 This is beca=
use the
>
>> do_package task is what actually assigns the PR service values.=C2=A0 =
So=20
>> we want
>
>> a way that will allow us to generate the PR service values in=20
>> significantly
>
>> less time then a full build.. (minutes vs hours)
>
>
>
>
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13130): https://lists.openembedded.org/g/bitbake-de=
vel/message/13130
> Mute This Topic: https://lists.openembedded.org/mt/72130803/3616765
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [rand=
y.macleod@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>

--=20
# Randy MacLeod
# Wind River Linux


--------------0598813149809CBF08C4A916
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Use Mark's current email address.</div>
    <div class="moz-cite-prefix">../Randy</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">On 2021-12-03 1:55 p.m., Randy MacLeod
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:16BD539807513EEF.1024@lists.openembedded.org">On
      2018-10-04 4:57 a.m., Richard Purdie wrote:
      <br>
      <blockquote type="cite">On Mon, 2018-10-01 at 21:37 -0400, Mark
        Hatle wrote:
        <br>
        <blockquote type="cite">There may be actions that a user wants
          to take, but the information
          <br>
          is only available during task execution.&nbsp; Using the DryRun
          event you
          <br>
          can prevent the actual task execution, but get access to the
          <br>
          associated data stores.
          <br>
          <br>
          Signed-off-by: Mark Hatle <a class="moz-txt-link-rfc2396E" href="mailto:mark.hatle@windriver.com">&lt;mark.hatle@windriver.com&gt;</a>
          <br>
          ---
          <br>
          &nbsp; bin/bitbake-worker | 2 ++
          <br>
          &nbsp; lib/bb/event.py&nbsp;&nbsp;&nbsp; | 5 +++++
          <br>
          &nbsp; 2 files changed, 7 insertions(+)
          <br>
          <br>
          diff --git a/bin/bitbake-worker b/bin/bitbake-worker
          <br>
          index e925054b..e27fe7ac 100755
          <br>
          --- a/bin/bitbake-worker
          <br>
          +++ b/bin/bitbake-worker
          <br>
          @@ -268,6 +268,8 @@ def fork_off_task(cfg, data, databuilder,
          <br>
          workerdata, fn, task, taskname, append
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; os._exit(1)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; try:
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if dry_run:
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; localdata = bb.build._task_data(fn,
          taskname,
          <br>
          the_data)
          <br>
          +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bb.event.fire(bb.event.DryRun(),
          localdata)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return bb.build.exec_task(fn, taskname,
          the_data,
          <br>
          cfg.profile)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; except:
          <br>
          diff --git a/lib/bb/event.py b/lib/bb/event.py
          <br>
          index 5b1b094a..c03541a1 100644
          <br>
          --- a/lib/bb/event.py
          <br>
          +++ b/lib/bb/event.py
          <br>
          @@ -832,3 +832,8 @@ class FindSigInfoResult(Event):
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; def __init__(self, result):
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Event.__init__(self)
          <br>
          &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; self.result = result
          <br>
          +
          <br>
          +class DryRun(Event):
          <br>
          +&nbsp;&nbsp;&nbsp; &quot;&quot;&quot;
          <br>
          +&nbsp;&nbsp;&nbsp; Event to fire during a dry run
          <br>
          +&nbsp;&nbsp;&nbsp; &quot;&quot;&quot;
          <br>
        </blockquote>
        <br>
        I think we can add something like this but the DryRun event
        should
        <br>
        really be in build.py and subclass TaskBase, called something
        like
        <br>
        TaskDryRun?
        <br>
        <br>
        I'm hoping that doesn't upset some of the other code that looks
        at
        <br>
        TaskBase events but its certainly logically where the dryrun
        event
        <br>
        belongs.
        <br>
        <br>
        We may want to pass dry_run into exec_task as a parameter and
        put this
        <br>
        code at the top of exec_task to make things cleaner across the
        files?
        <br>
        <br>
        Cheers,
        <br>
        <br>
        Richard
        <br>
        <br>
      </blockquote>
      <br>
      <br>
      Hey Mark,
      <br>
      <br>
      I was looking at local WR patches that we carry and noticed this
      one.
      <br>
      <br>
      When I asked you privately about it in 2018, you said:
      <br>
      <br>
      &gt; Randy said:
      <br>
      <blockquote type="cite">
        <blockquote type="cite">
          <br>
        </blockquote>
      </blockquote>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">Isn't this always firing?
          <br>
        </blockquote>
      </blockquote>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">It's mostly harmless but it's no longer
          really a completely dry-run
          <br>
        </blockquote>
      </blockquote>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">if you're logging PR info. Do you think
          anyone will object or
          <br>
        </blockquote>
      </blockquote>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">have you already discussed it with
          upstream folks?
          <br>
        </blockquote>
      </blockquote>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">
          <br>
        </blockquote>
      </blockquote>
      <br>
      <blockquote type="cite">
        <blockquote type="cite">Why not add a new flag?
          <br>
        </blockquote>
      </blockquote>
      <br>
      <blockquote type="cite">
        <br>
        If there is no event handler, then firing takes nearly no time
        at all.. I've
        <br>
      </blockquote>
      <br>
      <blockquote type="cite">sent the change to bitbake.. We'll see if
        RP or others have comments.
        <br>
      </blockquote>
      <br>
      <blockquote type="cite">
        <br>
      </blockquote>
      <br>
      <blockquote type="cite">The change itself though is designed to be
        generic, in that we want any possible
        <br>
      </blockquote>
      <br>
      <blockquote type="cite">event handlers to work through this -- as
        it could be useful for collecting
        <br>
      </blockquote>
      <br>
      <blockquote type="cite">statistics and such as well -- without
        running a build.
        <br>
      </blockquote>
      <br>
      <blockquote type="cite">
        <br>
      </blockquote>
      <br>
      <blockquote type="cite">--Mark
        <br>
      </blockquote>
      <br>
      <blockquote type="cite">
        <br>
      </blockquote>
      <br>
      <br>
      so do you or Robert still care about this ?
      <br>
      <br>
      I don't see it mentioned in the WR docs but
      <br>
      now that I think about it, it could be useful in a few use cases.
      <br>
      The one that was mentioned in the internal email was:
      <br>
      <br>
      <blockquote type="cite">Typically populating PR service takes a
        full build.&nbsp; This is because the
        <br>
      </blockquote>
      <br>
      <blockquote type="cite">do_package task is what actually assigns
        the PR service values.&nbsp; So we want
        <br>
      </blockquote>
      <br>
      <blockquote type="cite">a way that will allow us to generate the
        PR service values in significantly
        <br>
      </blockquote>
      <br>
      <blockquote type="cite">less time then a full build.. (minutes vs
        hours)
        <br>
      </blockquote>
      <br>
      <br>
      <br>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#13130): <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/message/13130">https://lists.openembedded.org/g/bitbake-devel/message/13130</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/mt/72130803/3616765">https://lists.openembedded.org/mt/72130803/3616765</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:bitbake-devel+owner@lists.openembedded.org">bitbake-devel+owner@lists.openembedded.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/unsub">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a class="moz-txt-link-abbreviated" href="mailto:randy.macleod@windriver.com">randy.macleod@windriver.com</a>]
-=-=-=-=-=-=-=-=-=-=-=-

</pre>
    </blockquote>
    <p><br>
    </p>
    <pre class="moz-signature" cols="72">-- 
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>

--------------0598813149809CBF08C4A916--

