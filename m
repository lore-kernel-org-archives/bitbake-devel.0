Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8D79C4707C
	for <webhook@archiver.kernel.org>; Wed, 10 Jan 2024 15:28:39 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web10.14381.1704900509524914899
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jan 2024 07:28:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=PPS06212021 header.b=JT6F8TOv;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=1739e1d70f=randy.macleod@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A6Vaw1018872
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jan 2024 15:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-type:message-id:date:subject:to:cc:references:from
	:in-reply-to:mime-version; s=PPS06212021; bh=EAXp5KEuz5+gnRMuE3v
	SPoDA400oyWxZl6mgiQlyGXg=; b=JT6F8TOvQ+g5VTT8A/R0sqFLWYC8vU/zbww
	SaPSAGzpCHRRwB2y82fAPfRoc48sczDDDmGxemX15MC2gQZoL1ZjpNr8fqKAD8Ss
	c/yf097TtwgEAc/GOghVsTnD41Ub8idTmnsc5WhOiVe1335KJc6lSCfVNyu07rpl
	p5DknNbEFg+wpIa7/sS2yfD6FIETJgWtUf+h8IooyWGGjH5wJPP1fsziGb8T4DW5
	zKrHSV/e66reiwfnmsAxM1/lFlbmO8bG+QUXlRfkZsH2r7x5M33n34iw2bITmaZc
	TAeyJI6sIW9uPAXU1NWz3bmIERgjPIZ7wM0PVfWXMs3I+z5+a2w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vewekcqtu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jan 2024 15:28:28 +0000 (GMT)
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 40AFQuLd007637
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jan 2024 15:28:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vewekcqtf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 15:28:27 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkVBniFX8X1a+EF0gL/C9xdRiCjbETxWvLIrwzWnqUEG2ZSmhSyV4TC/2RPBDR1amgz6fn0iDUQeCc5fB4nrp6SAT2FTOtC/IRa3+DgAPXsCxVxikrL1tvIMOycXFMkcTr3DqduOoq2/lV1mhzRgPTA1ppTe6OGg60ScDENdrq8BWPZruRPm4RVMk910aG8WBXc4DP2hrqQXsMSUEds83cH8PS6IPZQf8ZF1oAVQHakNeedCXrbxIHjGFXdAaVERtfNkFLiSzVKOlyTLVtA2IOszXvH96E+5Pn47G8O6l3JgKaO6BglPOdptBv3U89W34RKPCy0kOiXWgDu+4lkJwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAXp5KEuz5+gnRMuE3vSPoDA400oyWxZl6mgiQlyGXg=;
 b=ZbM8d2hj4Q5hLeSKuJwW0m56PGnTWh/b4JfwuEQ3JJI8A1tybhGvU0PGp8L4WALzgz4/Rl+sGKsSPPsBmRjz54ti5qEscsivzC2q8lctU4QiZF6VQlH2KzsjSz+3g9GkL29AeE6JWHsPse2h5PlK+7rmRjQlktGFcgha6GjuaIUVyw3+tMrR0d8fTzY1HPEcTVtqtH7RBRoc5+4YxElOB8Nd/HoBToddKPct3dp8HW1ZItWEUn3PN72FfVGdMpLpYgVqKgq1vQWd8u/bDhNE4psUFnUd1FWfFRsYaSWRpVtXGlQ7E3JHlJROwYiuHwXYNMmtyweQuz7bDo9mJB2AYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ0PR11MB5920.namprd11.prod.outlook.com (2603:10b6:a03:42e::9)
 by BN9PR11MB5242.namprd11.prod.outlook.com (2603:10b6:408:133::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Wed, 10 Jan
 2024 15:27:51 +0000
Received: from SJ0PR11MB5920.namprd11.prod.outlook.com
 ([fe80::f3ba:ff33:12be:cff7]) by SJ0PR11MB5920.namprd11.prod.outlook.com
 ([fe80::f3ba:ff33:12be:cff7%7]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 15:27:51 +0000
Content-Type: multipart/alternative;
 boundary="------------tMv4RidxfGR36F0apC0oLBPK"
Message-ID: <aab3f796-728e-4716-b094-daee2e822612@windriver.com>
Date: Wed, 10 Jan 2024 10:27:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] runqueue: Add pressure change logging
Content-Language: en-CA
To: Etienne Cordonnier <ecordonnier@snap.com>
Cc: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
References: <20230713105303.4105584-1-richard.purdie@linuxfoundation.org>
 <CAHUKmYZvYbs236DUrUna_SGRm-9R1SPkDAvZJn+XkrwJri2xNg@mail.gmail.com>
 <15224f4fe986ab3508c1d0dc3d9b33b0b3e2e9c0.camel@linuxfoundation.org>
 <c0a11023-9bc7-40de-9240-0006c98f1607@windriver.com>
 <c527e73b-7e94-4495-b155-437d48284359@windriver.com>
 <CAHUKmYYtHVt-BNR7et6bLv2bDQLTm0Q+50GLBtzCuukJWhrGZQ@mail.gmail.com>
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <CAHUKmYYtHVt-BNR7et6bLv2bDQLTm0Q+50GLBtzCuukJWhrGZQ@mail.gmail.com>
X-ClientProxiedBy: PH7PR17CA0046.namprd17.prod.outlook.com
 (2603:10b6:510:323::6) To SJ0PR11MB5920.namprd11.prod.outlook.com
 (2603:10b6:a03:42e::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5920:EE_|BN9PR11MB5242:EE_
X-MS-Office365-Filtering-Correlation-Id: 4583cd8a-e5b0-4113-5164-08dc11f0b546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YZumI3Vd6AsY3qquPX2HpCXEMleJLvGaLxnK69yiBYWwD9WbYCyquhwFlNcWIv52gGTT/jAAzTmFvEG0woPlO8FsDSpUKSpN55lU4jAUD2DfRm6f2gpKf5Y2PyQSiL0LAvmxCyRvZpuu6U2shWU/RkZ9V0Wo6cp26PwLgfIQ6t9lH1WF4DHJOVvQjqU+H4QIx7IdO9aSM6zUWcLswdlC+RWy0zyy6I7y8M7xqq4eRvZCAi6NMniyuDcBafyancmyVwTyJ/htH7dfV48Yq+yorzIVmy1ozyRiRvif/WVys/Sqw8QZuPW1rZV0q6dYgWwLLzC/xX16mkOf23jAzxnDKnWWsFRG9nmMWmhLK3UAL5tXpnLbb1p4eJFSv47b8w639eRy7ZvWe3DfNWKXme8+7DUiD7NsQdR2sSiBGVwLALhWeWnSyjRnI20x1bxDK4225xBtlmhs8lmHsNNqJcZ5Y7RgjGULW5hEpMdulcHRMLrxqh/v20z2zOTxWUjWy+J48mYLtc4pLH/ZZFXecR8oM83FQLVO236MO23Qowth+Kx9vson7kRLGIUN0cLe9tUwmlM1RqNpwBfO3coKLvw6KuWp9eXxiR3S6PKGh8+A26cPtsIrYoJU5LDCLiZiaLhBDx0tSKH3T7zy/2yD22fu5g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5920.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39850400004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(31686004)(41300700001)(36756003)(86362001)(31696002)(2906002)(38100700002)(83380400001)(26005)(2616005)(33964004)(478600001)(6506007)(6666004)(6916009)(6512007)(316002)(66556008)(66946007)(66476007)(53546011)(6486002)(5660300002)(8936002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UFhWeE90eFQrTTVMWTdHbWRDU2d6WUQ4dUJsRjNPRm5DR1FwZDRreE9BUzZ0?=
 =?utf-8?B?R0c2NEdDakJrbmg1Rnl4cnNyVVo0am5hT0hvejFSbTF4dEN0TWVqL3FvUTEw?=
 =?utf-8?B?OWh3akZHb0hSRkYzSTdTUVB1bU9mWWhUMEhUTDRPZkdXdTJzc2w0eW9pRjhm?=
 =?utf-8?B?QlFNa2pSUXRFbFEyV0lSSVhmbmNQV1N4Z1NNWm1JYUtoY1lzV1JkdUw0cTVa?=
 =?utf-8?B?Mk95ODArcy9jQXhLNjlBVThFWWdWWmp4WmZsRHNLbzBFMmxwdGl1UzQxY0Rt?=
 =?utf-8?B?Q1V2eitVWHdvK08rSjRTTDEzQnNIZjQ0dGovVU1PMFNxQlNBOEhvajNQUDNP?=
 =?utf-8?B?SXF4dHoyRDlSWVR0UDlXTjl3TkxjbUpTNEZzNnRSZ2phZ080cmUzMWtZMUg3?=
 =?utf-8?B?U3NHOXhjZmdpa3RiTTNQdHVxZUZXNFJXV3hDdm1VR3Fjb1NwWjFrbkQva09l?=
 =?utf-8?B?QWFoL1N6ZU5KUjc3N0pxVmVkVjJPaVB3TEsrMGVWc2JRSjhFSzlBTjRDZk54?=
 =?utf-8?B?bXhyWmJkQllnUThDTzVoMW5FOWRhUVlJSHdhRm5aS3ErckQxeGt2V0N2N0Rk?=
 =?utf-8?B?aVpJYzNDVW5CYzdnQTY0c2xzWi8zQlBkS0NzZys1TXF6cHlpaFZOczVkUWw4?=
 =?utf-8?B?ODVmVUpxU2puRERSeDg2S3Rwb1ZxRDNTTjFFUVNmRDNUQTdnTmlkd25KRHov?=
 =?utf-8?B?a1E0MmxNNGd1SHc5akt5aU4vRjlFL0I2bFZsSTZjWmRFVlRHc3pPL09ERkcr?=
 =?utf-8?B?VERQYUZNK0VzVFlHU3JCQXd5QWJjWW8vQ2JHV211TWlPL21DL21uV0dER0cy?=
 =?utf-8?B?eTlGOW83N25BWHN0cU1HaWc5bk94WGlTWm9BUVlxVkNPd0FLWXFVNTN5bm8w?=
 =?utf-8?B?SWQ4N3BmcUQ3TFFGS1puV0hFdDFabFpLQlp1RndtbTZHWVpwcmhIYzd1Vktj?=
 =?utf-8?B?bkQ0NFFUTUdrdkEzU3RWM3NhUWVwaW1JdmpaWnlNdnBCaFFlTG9xZktqb2Fl?=
 =?utf-8?B?bVdJcXJCODNvQWx3MmRpY3I5WVphbG1KZ05EMW9vOTRCdVJ6RGZhOFFqbkps?=
 =?utf-8?B?Nno4K3VIbVR5QWNkaHFMQ1BVWHAyTE14dVhiWTk4Z2pqUU9ycXVhU05RNzcy?=
 =?utf-8?B?NjdoUlprczZVLzEzRkptYzJ2bmdjMDVQK1AzSHp1UDY1amtNWVNrWUt3M3pC?=
 =?utf-8?B?OVB5OWx0L3pZWFQzZmVWY2VwblZzNzB4WWh3TzRQbjJFaXg0TGVLVkhwbmNj?=
 =?utf-8?B?R2tjaUQwTXd2M1BJSFZCY0hRMzZvSStWSkN3enVMak1yaGlhSzlVQmd4WmRo?=
 =?utf-8?B?aXpKZFNkR21YY1loWEU0WG5RUEo0LythZmt0YmJxV0hxR0dKVTEzSnFFWVFl?=
 =?utf-8?B?eTRvRXJJVVBQN2hTVEp4anhmdkl4a1NVT0J6ekZ4NGVWM3crL29UcFMzWTlr?=
 =?utf-8?B?am9WVVQ5MHZIbW90VDNoMmd0Q3AwVG9icE5JNXljTExRa1Z0cjZDUWVtdmVy?=
 =?utf-8?B?RDVXMngwemo0WkE1aDlDcUQyc21RMWhtSVpOeVlPYkorWHVqWWVvTmxWVWxQ?=
 =?utf-8?B?cXdIUEpWM0tVWHZ1WkRRVEZiaG5pVm5hZ0RUTHF1azZucytIcnNjcWx3OE1V?=
 =?utf-8?B?WHZWeUlScXNtcnZUdWFJKzBpUzh0Ukxpc3VSNEF0YTN5OE1NQktmS2dwY2dW?=
 =?utf-8?B?VWFNd3lOUkNWNGdSR2ROUjhwd0NzQkMya0x6WEZ6SjhWQm5ZcmcrY0Z3NGhw?=
 =?utf-8?B?SGJOYTJmNmFQNDk0TDJPWFRJMlViaFpzZjhUMG51RW1wWCs4ZEVNTDNqeXhq?=
 =?utf-8?B?ckFJc2IzRzZkTmdKVjcyUkxWQW5vZDY2Z21pamhscWVCT2syRU12QmlNMjlP?=
 =?utf-8?B?M2ljUEVaYUtBbm5kWHhHaWNSY3BiTW9FcFFPVTBjVTBEcEZuY2Nhc3F3cUhD?=
 =?utf-8?B?YWtjOGNCTVlUQkNqMThPbE01RkhCNUg2S1poL0c1TVp3S0x2d3NaSWY2MjZT?=
 =?utf-8?B?bDJiZXNiVTFHblRIdWZxd2dCam1sYytUVEg0MHFQUThrWmJ6OWhldkJLdEIr?=
 =?utf-8?B?Umd5YitYT20yOWU5Vkoyb3VVRUx0aEdibGlBMmZFU2s3c3hsYUh2M2J4SGw3?=
 =?utf-8?B?NWo0SGsyWG85Ylg3dG1POEppL1VUS2lIRndFN3owL3ErVUpHSC9GOThIZng3?=
 =?utf-8?B?dXc9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4583cd8a-e5b0-4113-5164-08dc11f0b546
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5920.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 15:27:51.2351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o5YDdQ+BTPFLvOqq0y6+/1+mDEg0O/1rQWBDlig2FFNJduzMsjeSHknc6mZEmy0pP9xdahwfzQ7PeEJvlfS/6e0Ic8GR5diAxE3TmWMY7Ig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5242
X-Proofpoint-GUID: Wcfwe_GqG2-r9nWJrM_L16PMcu_AXapk
X-Proofpoint-ORIG-GUID: 7DDzb66ICGVnG7Z-Ju7CgeyRy0Y727bF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401100125
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jan 2024 15:28:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15779

--------------tMv4RidxfGR36F0apC0oLBPK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Etienne,

On 2024-01-10 9:09 a.m., Etienne Cordonnier wrote:
> "How many physical/virtual cores are actually available?
>
> Is some other activity doing CPU intensive work on the system?
> Is the one task running > 48 compile jobs and causing CPU contention 
> in the system?"
>
> -> This is a physical PC with 24 physical cores and 48 cores when you 
> take hyperthreading into account (Intel Xeon Gold 6240R)
>
Thanks.
>
> -> there is no other activity doing CPU intensive work
> -> some bitbake tasks can easily load 48 cores, yes (this is a custom 
> image with some extra layers added)
>

I see, then other than deferring new tasks, there's not much that 
pressure regulation can do to help once one of these
CPU intensive tasks is started.

Other than the log verbosity which we likely won't change for a while, 
did you have any PSI-related concerns?

I did notice that your last log was:
 > NOTE: Pressure status changed to CPU: True, IO: None, Mem: None (CPU: 
21922.9/500.0, IO: 10137.8/None, Mem: 194.8/None) - using 1/48 bitbake 
threads

When there's memory pressure, that's usually an indication that the 
system is paging to disk.


Also, despite the logs, do you find that pressure regulation is useful 
for you?
You can always leave it turned off and only rely on the task and job limits.

Thanks,

../Randy


>
> Etienne
>

-- 
# Randy MacLeod
# Wind River Linux

--------------tMv4RidxfGR36F0apC0oLBPK
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">Hi Etienne,</div>
    <div class="moz-cite-prefix"><br>
    </div>
    <div class="moz-cite-prefix">On 2024-01-10 9:09 a.m., Etienne
      Cordonnier wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:CAHUKmYYtHVt-BNR7et6bLv2bDQLTm0Q+50GLBtzCuukJWhrGZQ@mail.gmail.com">
      
      <div dir="ltr">&quot;How many physical/virtual cores are actually
        available?
        <p>Is some other activity doing CPU intensive work on the
          system?<br>
          Is the one task running &gt; 48 compile jobs and causing CPU
          contention in the system?&quot;<br>
          <br>
          -&gt; This is a physical PC with 24 physical cores and 48
          cores when you take hyperthreading into account (Intel Xeon
          Gold 6240R)<br>
        </p>
      </div>
    </blockquote>
    Thanks.<br>
    <blockquote type="cite" cite="mid:CAHUKmYYtHVt-BNR7et6bLv2bDQLTm0Q+50GLBtzCuukJWhrGZQ@mail.gmail.com">
      <div dir="ltr">
        <p>-&gt; there is no other activity doing CPU intensive work<br>
          -&gt; some bitbake tasks can easily load 48 cores, yes (this
          is a custom image with some extra layers added)<br>
        </p>
      </div>
    </blockquote>
    <p><br>
    </p>
    <p>I see, then other than deferring new tasks, there's not much that
      pressure regulation can do to help once one of these <br>
      CPU intensive tasks is started.</p>
    <p>Other than the log verbosity which we likely won't change for a
      while, did you have any PSI-related concerns?</p>
    <p>I did notice that your last log was:<br>
      &gt; NOTE: Pressure status changed to CPU: True, IO: None, Mem:
      None (CPU: 21922.9/500.0, IO: 10137.8/None, Mem: 194.8/None) -
      using 1/48 bitbake threads</p>
    <p>When there's memory pressure, that's usually an indication that
      the system is paging to disk.<br>
    </p>
    <p><br>
    </p>
    <p>Also, despite the logs, do you find that pressure regulation is
      useful for you?<br>
      You can always leave it turned off and only rely on the task and
      job limits.<br>
    </p>
    <p>Thanks,<br>
    </p>
    <p>../Randy</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:CAHUKmYYtHVt-BNR7et6bLv2bDQLTm0Q+50GLBtzCuukJWhrGZQ@mail.gmail.com">
      <div dir="ltr">
        <p><br>
          Etienne</p>
      </div>
    </blockquote>
    <br>
    <pre class="moz-signature" cols="72">-- 
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>

--------------tMv4RidxfGR36F0apC0oLBPK--

