Return-Path: <mingli.yu@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD9EFC433EF
	for <webhook@archiver.kernel.org>; Wed, 27 Oct 2021 06:39:41 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web09.8182.1635316780408834375
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 26 Oct 2021 23:39:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=VqJAOniN;
 spf=pass (domain: windriver.com, ip: 205.220.178.238,
 mailfrom: prvs=59342b0480=mingli.yu@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19R6dd88014956
	for <bitbake-devel@lists.openembedded.org>; Wed, 27 Oct 2021 06:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=86SAAcNgLT8xAJ1pmYpWXN+jQEnjSLeud01aHT/VARo=;
 b=VqJAOniNy203qW4UVbYyzd470WHwUXkfFRg6/SYci8/nUUt8CWbIWr2WbYkxtDjtu8gq
 hhka5s0TooeDM/PpWR+CZZkMMcta9A2WXrq8koJc4wpXCUgqIDcsACQTFZ6rGcz1kn0J
 nwURl1JCzOhZexei1T7uoYsvvKuheunieXwZbF3OOuJ6RTrDC5tVS8zKa/n7Q0L/BenX
 vSWRssJy5SsB94S8AjER7vJQEUL4/hBGQDsstfaH+fezcLn4YOG0dFl2o5/yA3x1Io7T
 aZbgeUukt0JzTV+yVrpVNjziTuWxpWH/bPNJLKwe3ELC4C73xavVpJI8PLFhIChdGJFX rA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com with ESMTP id 3bx4rch908-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 27 Oct 2021 06:39:39 +0000
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19R6dcjv014947
	for <bitbake-devel@lists.openembedded.org>; Wed, 27 Oct 2021 06:39:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
	by mx0a-0064b401.pphosted.com with ESMTP id 3bx4rch905-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Oct 2021 06:39:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+Y12lovJTaLbZ0X1GmgsjB/UAP0T70IG9gTTul7+w40CkMWDGDmh7GNhEct2fIX6rcBNFqpPXu9BKavckuTzsT+7g4QGMsblsicGJZYfxJ3VdgDLxOfNGOGH+EmH9S3/XKyuQwK3A7RA4HBK+ecCWnGPSG5DXHWS7wUYrzqSgXgvSjCSE6hQsaBQd0U5q1MAAkGyaNEROCmwTUg1wluGmKxS3+9SVPCZSEkXR6JFXeNvEVcQUh/+MB4egc4RmcOaD9J2U/54vLxvtTzUJCATfskP7CGuJ+zAqsR72GSZrtEU+lN8FvBqf8/fOtKt2qap+/kLx2Rkg902R7pAaEshQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86SAAcNgLT8xAJ1pmYpWXN+jQEnjSLeud01aHT/VARo=;
 b=iRmg+hwQb57lgZvgVfFtrwHGgvb6e161/u7Gu8Kr7NQcIVw16h1FzagyZtjBngOWolsXrAfzVrWpB7YXi5bkffpdSVurtMz239AQZsGk/rm5Iw+Pakt36gjFmBPmLhovDdYSsRJiZnKsgZtzJlFR+vHhuO7h52ZA/NLCSS96X5+9hfSEsIyK3uI335s8lsP0zz/3avQKfsMXiZy5r5QH/1W8l72l6rAW/Iu0hwVS4k1QhkIxj5dmSw+HmekPChTEdGczSWm+AkauT2/Rfm3Dwm/fpswtQa2cqcuPKUdKd5MMvJd7C/wmySNYBOWyh3PrzeKZndB3PawnEQuDHFEWHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=windriver.com;
Received: from PH0PR11MB5014.namprd11.prod.outlook.com (2603:10b6:510:31::17)
 by PH0PR11MB5127.namprd11.prod.outlook.com (2603:10b6:510:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Wed, 27 Oct
 2021 06:39:36 +0000
Received: from PH0PR11MB5014.namprd11.prod.outlook.com
 ([fe80::186:2d0e:a19a:3b6]) by PH0PR11MB5014.namprd11.prod.outlook.com
 ([fe80::186:2d0e:a19a:3b6%6]) with mapi id 15.20.4628.020; Wed, 27 Oct 2021
 06:39:35 +0000
Subject: Re: [bitbake-devel] [PATCH v3] fetch2: make sure the uri added as
 expected
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: bitbake-devel@lists.openembedded.org
References: <168714731971476B.24733@lists.openembedded.org>
 <20210913054810.30554-1-mingli.yu@windriver.com> <YXiOH15WmkbpUaO1@piout.net>
From: "Yu, Mingli" <mingli.yu@windriver.com>
Message-ID: <7348d54d-5071-4ac3-afbb-7dc4caa33943@windriver.com>
Date: Wed, 27 Oct 2021 14:45:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <YXiOH15WmkbpUaO1@piout.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0213.apcprd02.prod.outlook.com
 (2603:1096:201:20::25) To PH0PR11MB5014.namprd11.prod.outlook.com
 (2603:10b6:510:31::17)
MIME-Version: 1.0
Received: from [128.224.162.173] (60.247.85.82) by
 HK2PR02CA0213.apcprd02.prod.outlook.com (2603:1096:201:20::25) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.16 via Frontend
 Transport; Wed, 27 Oct 2021 06:39:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9342530-3b30-4da7-0abd-08d999148ab8
X-MS-TrafficTypeDiagnostic: PH0PR11MB5127:
X-Microsoft-Antispam-PRVS: 
	<PH0PR11MB5127E816050F5D79A2B756DBF1859@PH0PR11MB5127.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:513;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EWlAekHof5IWegt8PfhzClzFHFuHhw5Nl0qZoC0yUi/K80n8V64F6HhGKr+j/7lMYBqizs75T5ylA40eSHdbserIkixe5E7i7T6MnmXyCgp3P3LqT4qvB/p29ZQ6RyplDfJR3lWKgvEikh/qxdoCfaNsw1wY2mf5GuFCTZ6mC6qGyU2byN2jiA2K544DoyEtE8KKlrDcxuQ868n2FebMFwsuJSd7FUcy6rWi7CcRprqLzQT8xm6U25JF0XI7sBmwjS48jT+51YNPSyRc7UcQWtkZiFgEFJN8vWKkL4jRxKPnXUm5cJUQdMoA8y04gexxRCCpttSRJjemxBPcWq3mDg0UwR640gjD/Kz+XSYNL/JiUcaFbsLp+GBwizuqc+abUN4MOORq+nujY/X1CjJqkp0GfgStu+IYtwa5uq31rKQM6gb5PuCJ0rUtzGO563TZp9p1sbxLLhDLJ8YSSY/qs+pJE1t6jRh10GxHJZE9uY989WqQYbwkOtry7Q34FMj9g2IlVZrgyzGxXcZ3aqZC9BNSTwj14U51sIsYOP2j/HcIbqIHCrty6OchvSgQ/14DItJHDvntL2HgeBsoI540orRM0AbDQoy6NLaBfi4YbZlEtUKjh0CHIbXH4FRNKH0m5CIPbsnkrH6dXFCAnJzNT+NRb1AXtzB47q0znEchbxarvm2Iq5tIduHcCr2eG/3i1J/X5ggOkYJOwZXfutj0aYZHGCSSuEQ7BuUllhhV2Bx8ETJEreKfGwEk092Xdt8mULO0ds0kRp7Ao7rxC+Qzdys7cbC+sWgY0uW0pMIWRa9InsyCItZWY5mlecYB1Ak1h0LTkZJkVlOlJffXY2crAZeAUdZGOA1WHEOaWXNaQYlRadsAabmbQKw/voS6pJZfF2cHtb9/BdPFJi6MGWotIXlQdKpwkGzsx/Vge0JxXH+g0ZNhefw7PuDydQzjQxgB
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5014.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(16576012)(5660300002)(31686004)(316002)(66556008)(6706004)(53546011)(26005)(38100700002)(508600001)(83380400001)(66476007)(8676002)(6486002)(6916009)(2616005)(6666004)(31696002)(38350700002)(8936002)(186003)(4326008)(66946007)(86362001)(36756003)(52116002)(966005)(2906002)(956004)(78286007)(43740500002)(45980500001)(4084875004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bXFYUUEzQnJPVVRqbUFsNTFJb2tCUDVwbGtndDhZNEV2Sis3c0ZKYzhuamxx?=
 =?utf-8?B?Z3RtdGlieXIrN1BXZXNVL2QvanRWY2RVellaVUgvRHpqUHE4Z3BXc3pyeWt2?=
 =?utf-8?B?TnVkb1hQUmhheGFOcXN5bzdoQ2hmelBXT3JMN1V0czBFWTBUYWtteTZwVGN2?=
 =?utf-8?B?NThLbXI0Z3NvblpBdUp5b2hEeU0wUEM2SU4xeU9kcS83VjJDMG5EdUJZZ2Zz?=
 =?utf-8?B?blZqZHZXY1F2REVEcWczUU5jQVVhSmxwanFONzA0Qjd3OWxReDV2dVdnRW81?=
 =?utf-8?B?WW9YTit6b0d2dlFYL1hFM0tMU0ZINEhwbHd4T2ZnZ0lmc2N2S2FMbXA0cjBM?=
 =?utf-8?B?UWRGRVgzNU1FR3J5enpVdFgrZTVIeFhGRDV3SkZYVmhJTWNkNVRQdG9Cckhq?=
 =?utf-8?B?UzJBSWpDSk04VnhDa2tEd1hhbmVTekdsNTVYbi95eVlQRlhyeVRjSElkMkpo?=
 =?utf-8?B?aTZGNWNUYTdmNnYzcTBoU2dZNWYzODhsaDBYbkNnNFNtSnRXUHNwTmEvK3d4?=
 =?utf-8?B?aXZwTWZnTWRsWnNlczdmdXR2RzJaQWVkSVJ5TVZDVmtoc1ZWVHhLN1FoQUdY?=
 =?utf-8?B?eDBkT0lRTmU5RlpGY2VRVmw4WFpxTHp5RGVCM1dSVGxjV2VrUGNkcmF4eG1G?=
 =?utf-8?B?WUE2Tm9rMXhlTE1IR0lSRExXZDZSV0pLZ1hmdjA2OC9rODRDSWlxbW5XRnhY?=
 =?utf-8?B?TlgrcGdqR08rWnV1STB1aGRQci9KdFNJUEpadE0rVlpRWmdEZ0Y0VTRHYVVn?=
 =?utf-8?B?NEtVbjlTb3l5TnVnM1FCYS9seWdrQldUMGpHY0lVSFZTTnBBQU5CbmtVbzR5?=
 =?utf-8?B?L3ZlZUNDekNxcHhPdDlqSXZINHcwVE4zY1Jyc0ZmcUNDZC9iM01WVmVTaEJi?=
 =?utf-8?B?aGNoeWNQZ3V1d1YzZjdMNWtkUmdRU1g1ZzI2R2JGVkxFa29KMVdPa2IzL0pH?=
 =?utf-8?B?WklpNlZ4ZTBIT1NKalZTU1U0dWR1MFp0Nmlhcm9jSzNDMDdDUjhZMGlxS0Zh?=
 =?utf-8?B?emRSOFNJQ2pkSmltZ082bFREcnNkS3VzaUhxODdqdXovZS9CQ3pVc0RVVitP?=
 =?utf-8?B?b01yaFFXV0FmU09SaWoyS3ppVm93cncrRkJxOUhNbk5aa1FaWEcvTzVEVHV5?=
 =?utf-8?B?YWR5WVd3L3NhL3NNWGhJeE1IWWtraFU4NjJqRzFIS0hkdE9zVUxmcEo5aGpV?=
 =?utf-8?B?Z0o1aDN1M1lNWkhkRGRrYWxLTmt1cjR4U0ZQU0hMblNTc2xwZUhKLzB5bmJ1?=
 =?utf-8?B?Y3lwZDJoSTh6aUZKSklFd0lrbmR4K0tpdjFyeGdMcVN0cHk0RXZJSVJLU3k2?=
 =?utf-8?B?RFpyaGdldEg1WFpaY0ppUGFZanI2MjRCZUpOdllVWDQvRk81NjYraDFld1RT?=
 =?utf-8?B?Y2tycEMrSGk2VXhaK0lxNTMxZng0cDNpMXA3ZkVYbVVaaW1acWc1aU1BWW53?=
 =?utf-8?B?Um9HL2M0anUzS1dKY013UlVLT0V0VDJ6Qi9FQlA0NWthbDJlcWl3ajRzVkNl?=
 =?utf-8?B?cmVUYXFKM1diZVFtSGZsVnBaZHM5ZENuTEg0SHFnNDUvWGhaeFkwWlRZQzBm?=
 =?utf-8?B?R05mSWt5REhqR0h0VGFuOUVXazd0MGk3bkFsUDRkZ0FGd1lhQ21tWWozbXpG?=
 =?utf-8?B?K2w0REpyWDlEdjVFQVJ1VFN3NjhXUDhDTWNna2xxUlpQVk44SDE4WFRYMS9Z?=
 =?utf-8?B?L1U0d3JhVFhVZWU1ekZwbGwraWxtZm9nTmxIVTVYRkdML2dVVjFVeEltRWNG?=
 =?utf-8?B?Z2hDYnd6bUVaNHpNUE5XRlFFTFhPYUNKUitQVTJMQ2Y1d3MrMXNGaDFwRnFG?=
 =?utf-8?B?TnlIQ3kxZHVQcks0L3VvSlVJaTlnanMyV0MxbnRvUUJvTDlVNHJtTjhPY011?=
 =?utf-8?B?OXNFUHhBeVpSMnIxdlpXcURvMURNQzJtU0dncFA0UXA0YkxxbHVuek1mMTdp?=
 =?utf-8?B?V3oxbEFOQk5WaktPaU11dFFHc3FSWU1ZbFNHMXlYUk55d3AxN0V3SmpHT3Vy?=
 =?utf-8?B?TnJsdjdZa1hsVXBwU2QzSkdsSEhqcW9hc2wrdmtRaVpVMmN1UzBhdzBiSjls?=
 =?utf-8?B?aFl5VG9HUUNYajN6ZTZEM21wWnR5cWRDSUs5OWxaaUNiaGV6dWZpWTllUzRR?=
 =?utf-8?B?aDdEQlB1WnU2K1JuUXpzT0FxZCtIeitrcGdZV2NQMWdSWnBBRTM0Mkl3TVA2?=
 =?utf-8?Q?v6zf0dPnKg2ZLG0yXo5yICQ=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e9342530-3b30-4da7-0abd-08d999148ab8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5014.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2021 06:39:35.7449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 vyxLTBUYPbnxa3HD0+wIaMbOBi0j6a5EVz6h+aw2TBHTmZVNNjMRBerbp5iqbW73vODM9bbVMoLev0i10bLiVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5127
X-Proofpoint-GUID: AMsXsFs-HfP7bMR60jYTDRBbQDSC2yb4
X-Proofpoint-ORIG-GUID: 7UAH0wTnrFjH0z9pAJHjyfLBP7G8XGmn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-27_02,2021-10-26_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 spamscore=0 clxscore=1011 suspectscore=0 bulkscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2110270038
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Oct 2021 06:39:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12841



On 10/27/21 7:24 AM, Alexandre Belloni wrote:
> [Please note: This e-mail is from an EXTERNAL e-mail address]
> 
> Hello,
> 
> I'm sorry, it took me a while to properly test this patch but I'm pretty
> sure it is the cause of:
> 
> https://autobuilder.yoctoproject.org/typhoon/#/builders/87/builds/2773/steps/11/logs/stdio

Thanks for your following up! I will look into this.

Thanks,

> 
> On 13/09/2021 13:48:10+0800, Yu, Mingli wrote:
>> From: Mingli Yu <mingli.yu@windriver.com>
>>
>> When call uri_replace to get the new uris, we should guarantee the
>> new uri is added when the replace uri begins with file if the find
>> uri begin with wildcard which mapped as below.
>> PREMIRRORS_append = " \
>>       .*://.*/.*  git://somewhere.org/somedir/MIRRORNAME;protocol=http \n \
>> "    |           |
>>       |           |
>>       |           |
>>       find        replace
>>
>> Before the patch:
>> the original uri
>> gitsm://github.com/tianocore/edk2.git;branch=master;protocol=https
>>
>> PREMIRRORS_append = " \
>>       .*://.*/.*  git://somewhere.org/somedir/MIRRORNAME;protocol=http \n \
>> "
>> The new uri is git://somewhere.org/somedir/github.com.tianocore.edk2.git/git2_github.com.tianocore.edk2.git.tar.gz;protocol=http
>>
>> After the patch:
>> the original uri
>> gitsm://github.com/tianocore/edk2.git;branch=master;protocol=https
>>
>> PREMIRRORS_append = " \
>>       .*://.*/.*  git://somewhere.org/somedir/MIRRORNAME;protocol=http \n \
>> "
>> The new uri is None as the find begins with wildcard but the replace
>> doesn't begin with file.
>>
>> Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
>> ---
>>   lib/bb/fetch2/__init__.py | 2 ++
>>   lib/bb/tests/fetch.py     | 8 +++++++-
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>> index d9e1599a..1c5242c7 100644
>> --- a/lib/bb/fetch2/__init__.py
>> +++ b/lib/bb/fetch2/__init__.py
>> @@ -430,6 +430,8 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
>>       uri_replace_decoded = list(decodeurl(uri_replace))
>>       logger.debug2("For url %s comparing %s to %s" % (uri_decoded, uri_find_decoded, uri_replace_decoded))
>>       result_decoded = ['', '', '', '', '', {}]
>> +    if uri_find_decoded[0] == '.*' and uri_replace_decoded[0] != 'file':
>> +        uri_find_decoded[0] = uri_replace_decoded[0]
>>       for loc, i in enumerate(uri_find_decoded):
>>           result_decoded[loc] = uri_decoded[loc]
>>           regexp = i
>> diff --git a/lib/bb/tests/fetch.py b/lib/bb/tests/fetch.py
>> index 242be368..25893a34 100644
>> --- a/lib/bb/tests/fetch.py
>> +++ b/lib/bb/tests/fetch.py
>> @@ -406,6 +406,8 @@ class MirrorUriTest(FetcherTest):
>>               : "git://somewhere.org/mtd-utils.git;tag=1234567890123456789012345678901234567890;protocol=http",
>>           ("git://someserver.org/bitbake;tag=1234567890123456789012345678901234567890", "git://someserver.org/bitbake", "git://git.openembedded.org/bitbake")
>>               : "git://git.openembedded.org/bitbake;tag=1234567890123456789012345678901234567890",
>> +        ("gitsm://github.com/tianocore/edk2.git;branch=master;protocol=https", ".*://.*/.*", "git://somewhere.org/somedir/MIRRORNAME;protocol=http")
>> +            : None,
>>           ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sstate-cache")
>>               : "file:///somewhere/1234/sstate-cache/sstate-xyz.tgz",
>>           ("file://sstate-xyz.tgz", "file://.*", "file:///somewhere/1234/sstate-cache/")
>> @@ -447,7 +449,11 @@ class MirrorUriTest(FetcherTest):
>>               ud.setup_localpath(self.d)
>>               mirrors = bb.fetch2.mirror_from_string("%s %s" % (k[1], k[2]))
>>               newuris, uds = bb.fetch2.build_mirroruris(ud, mirrors, self.d)
>> -            self.assertEqual([v], newuris)
>> +            if not v:
>> +                 self.assertEqual([v], newuris)
>> +            else:
>> +                 self.assertEqual([], newuris)
>> +
>>
>>       def test_urilist1(self):
>>           fetcher = bb.fetch.FetchData("http://downloads.yoctoproject.org/releases/bitbake/bitbake-1.0.tar.gz", self.d)
>> --
>> 2.32.0
>>
> 
>>
>> -=-=-=-=-=-=-=-=-=-=-=-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#12637): https://lists.openembedded.org/g/bitbake-devel/message/12637
>> Mute This Topic: https://lists.openembedded.org/mt/85568847/3617179
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
>> -=-=-=-=-=-=-=-=-=-=-=-
>>
> 
> 
> --
> Alexandre Belloni, co-owner and COO, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 

