Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F884C433F5
	for <webhook@archiver.kernel.org>; Thu, 14 Oct 2021 09:01:55 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web12.6848.1634202114468201519
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Oct 2021 02:01:54 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=rrZSHYQL;
 spf=pass (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=59216200f6=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19E8Ug2J018734
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 Oct 2021 02:01:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=x1qoLXSnsrBHTHB5wUL+XrYf+dYLr5zMYyYZB0fc+Ps=;
 b=rrZSHYQLNNY60UYjAxdV3L6sOqqmY/0OT/IdxSo/MwccIByYPs282SuZ72bAaBWnZ7dy
 hndx990dCmWyQt1juqP8fxOHOSzvUSgpovCfdwdyJm7q407PS6quWn5Ag+mf1zcJphhW
 H4Vf0T9yBcye0ioBezZCYSiz1fjqzGfeAi26sYxMbZKLPqgfyp/RfyFeof/gMu/OSNjx
 WA517IZD2AvOgktN8h4nsRGb81EHkVSIr7ZDuqKPJycKUckSl8aKFJKBIHD/mltabqwa
 sDaM6vx/hUrr4NtwGyXnsJWD1OZPcuBPMrfltTUSi7g9AKz416I6hepjZ7N48XpJ5xDI NQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com with ESMTP id 3bpc1yr6ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 Oct 2021 02:01:53 -0700
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19E91rLD013305
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 Oct 2021 02:01:53 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
	by mx0a-0064b401.pphosted.com with ESMTP id 3bpc1yr6ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Oct 2021 02:01:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClIaspHvpHYSQumQD4soyn1MKdvCp6XH8mlQrts37/DywD6UuMUreKHs31Xwu4akXA7mDZFQV1IO9ClPcTtfF4Wl1jfak7aZygQo3/5rFNpioPBWLJJzkFsRqz+aXqHbYP7xSA39e01aK8Pb/S4XG7HfkHupDDKJP4zITIXLzgV5RO6RefU7pL7JUsZXY2tWmgklkFfkH/0UP39+ucz7u15UqPMjj+AwtswvSaLCoW8rLXthsnYoBRjoOybUx2uS7/uMxkgXpR7kFiCtD1U5AEv1K86kRwpsGYVp2GpUzsQvkUokb+XpQtIkoXFkF374pRx2acG6FBUoE01vGOgCAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1qoLXSnsrBHTHB5wUL+XrYf+dYLr5zMYyYZB0fc+Ps=;
 b=Ogh9oGUzKBgws6bwzsCNq73VyJiv4dr5WO2p+AEeWo4JOnlEO6Eac4jbPhha5c/GJqOBAqVsqG9aGtUQgF6HrYpfCMHWdgF/TsCdns+kpXUd7ACdL82YFmbAcBH3j9ulYkpp7WKYV+fjFVhB7xrPx7DgIixk1vMlYCQ1qxRDoYLrxelr8b6nogdkiphdD1r7vJzRaxGM0MWAwBpdV1IIvaIxRaNdMPkq77Cc53+gBKiUGipLV2/BGK3lHWBIq2lVhXJTb9BkNFnxgQziwp0yjnKZxm2MbrQVrQtikLzosH03MVE1xfjjAmu6vNWqSJ1Xo5Ls+7R0Cy/Xol92j+E5kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: windriver.com; dkim=none (message not signed)
 header.d=none;windriver.com; dmarc=none action=none
 header.from=windriver.com;
Received: from DM4PR11MB5469.namprd11.prod.outlook.com (2603:10b6:5:399::13)
 by DM5PR11MB1387.namprd11.prod.outlook.com (2603:10b6:3:7::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.22; Thu, 14 Oct 2021 09:01:50 +0000
Received: from DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::c13d:a0c3:e1bb:9432]) by DM4PR11MB5469.namprd11.prod.outlook.com
 ([fe80::c13d:a0c3:e1bb:9432%4]) with mapi id 15.20.4587.029; Thu, 14 Oct 2021
 09:01:50 +0000
Subject: Re: [bitbake-devel][ 1/3] bitbake: fetch2: fix premirror URI when
 downloadfilename defined
To: Scott Weaver <weaverjs@gmail.com>
Cc: bitbake-devel@lists.openembedded.org, Kai <kai.kang@windriver.com>
References: <20210905222738.1050768-1-weaverjs@gmail.com>
 <20210905222738.1050768-2-weaverjs@gmail.com>
 <dd26626a-079e-86d8-34ce-ad5d2b71ac8b@windriver.com> <YVJ3M8RII6ssdf8/@popos>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <34cf16c3-3a71-9556-9132-6adc7917418f@windriver.com>
Date: Thu, 14 Oct 2021 17:01:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <YVJ3M8RII6ssdf8/@popos>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR04CA0043.apcprd04.prod.outlook.com
 (2603:1096:202:14::11) To DM4PR11MB5469.namprd11.prod.outlook.com
 (2603:10b6:5:399::13)
MIME-Version: 1.0
Received: from [128.224.162.198] (60.247.85.82) by
 HK2PR04CA0043.apcprd04.prod.outlook.com (2603:1096:202:14::11) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25 via Frontend
 Transport; Thu, 14 Oct 2021 09:01:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c8332b79-5cca-4835-6746-08d98ef14246
X-MS-TrafficTypeDiagnostic: DM5PR11MB1387:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<DM5PR11MB138798FEC72EAA82D19D3C29FFB89@DM5PR11MB1387.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OPC8YydW2EXPpSwAWppB9buSFCxjDHAcGnf/A2mnZthM9Y6SiTG9gT51eYmZPJGWirT3dLEOiNG5u6LApAtCWOhdUiKczGvCo9Af1MCgpzFafozfsYGAx7QDAzfM5w7LoJuPMV6h7UCPCFkeg0yQFgatE4OL5O+fBTua9oBM+gYIvqj7njY/5H72NY8HaJFJ08TjUmdGZecHGJCWZKNudceXY+Tq7qwVBYL/iBHVkWfubZuLbWZeVIgTZ545aErfro+3WV/Y42AhBav5P2333SC0x7mYjVYyMBdIEYhwmuhmD0zgrk1q1LmUIQenn+FAqrOeOXu2KTgdXcA+rW+3sutM/UAHoW3NTtyPOKBaYSNMadotLW/H6wj2FSXk46XXvc4wXWBTrkrWBsGvFJcDbQeVILaBxTnSxckMQnbpKTr6+Yhtnui6k3D+HQ+f1CFFaWlRm3wm5xjiJ1RIiJhCXoAivu5Or+5Ye12d2mnKhu/fRg0b3wtNnzr4SJdN123AYOoY9QZc1gsZbjfpiVRKwJSjzmyi3s5FkNF8H/gRfQJ2QG/s2BK4EnMGI3j9t4jcFVv7tBZJuFCmggHJVtqhyHPqJ6UC/7/Jo4soKmSC8DuuNS7Qn/UPqhOv/lir6Wq6+V93G6KEYQZVWMiOzAPLMsUhDV07BRl7H7WiPrWh3CSWTATuTw9PqSfiGlvk+k1qqx4IEyQoKxEDQng/pnwxPKcO0O+skK7BrvCdHHMI4BD8/O8Pgg0ysmUk535O5IHbnohb4x3Xru05dxoEThUpEByVBSP/zZ4KIy6QrXUdHVQSCk4pscUPS1Uukyldaw7wL5jdky1mCgsI90DcWKUp2kjTjyZwZH9KjMKeSXm/LiN9Us8SMki3zVfaXbXhqAdhxcmeZL1P1C6WYi88Hp2sG1M1z1XR1H/pOSmId+6rzkA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB5469.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(16576012)(2906002)(38100700002)(8936002)(508600001)(38350700002)(6916009)(6706004)(4326008)(6486002)(66556008)(66476007)(966005)(83380400001)(2616005)(316002)(31686004)(186003)(66946007)(6666004)(31696002)(5660300002)(86362001)(53546011)(36756003)(107886003)(8676002)(52116002)(26005)(956004)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q1FtdXZoTThTYWdhOEtUQndsTHJ0bGllUVRJTldIMkp4Rm5YVERNbnU4amxq?=
 =?utf-8?B?TWloY2xtcWQ5TlQrWXVRMG8zdFhXMkk4dHdYT0MzYnh4SWliMDAvNlR5eGtR?=
 =?utf-8?B?ME4zRW1CQ3VnTUh2eWlEN2xyL3dFN1NhSVpEODJja1YwcGtDazVIZ1JzaEpW?=
 =?utf-8?B?T2RCaXZodkJEUExqZWxYS1FlN1VoRm9sSnp0RTBTZUJYVmhLc3M3VWFYNlpL?=
 =?utf-8?B?dE9mdUdEUzBKa0ZQcllUOXZRaVZ3YkVBVUpISzJncVl1aHc0RHoyZ3hJZ2s0?=
 =?utf-8?B?NDlXN3pvcWUxYmtrODh4Yjc2YVEwWnhLbVU0Znpwc045ZFZLdWdod2RRTGMv?=
 =?utf-8?B?QlNLWnVhcXAwdng1OGMvd3pyK0F0TG5Rdmt4eHM4S21HQ0lrQlAwTHpGM0lG?=
 =?utf-8?B?bTNkOVE0MkJxWlJrUW13RUgxVy9jd1psK2NVYkFCdFRiV0diOFlLajJkOEJC?=
 =?utf-8?B?OWdDNXE3MUYrYmZqTUFweW1uc0hIN3dzTjVjS09mdWNPdHJRc2c2TzRDSkRj?=
 =?utf-8?B?aWdwYnhKQVd0WVpmVzg3dWdjMjVXNXQ1Mk5wNzVjZURhRkIxK3BLYlBaa0Q2?=
 =?utf-8?B?M1gzdStlS2QxWG1GZ0xCS3RaT2VPS3d6OTJuZXJTajMxa2I2aTdPbjV3VTF0?=
 =?utf-8?B?SUh2cldYcGsrWlE0a0gxWW41Yk16aUhRaGZOUDJoL21HS3JXc2Q0MUM2SGxP?=
 =?utf-8?B?R0RIczJkbWJFOUI2TWd2VTRrajFpKzhEcFZzSG5pbHlvQ2p4S2lrdGQzY2kx?=
 =?utf-8?B?ZWhibzdRd3dsTWxLbUk1YXBRNlZhamkwTVRnYmN4bUNtZEZicTFIcHJaYkRS?=
 =?utf-8?B?R2hadUROWUhlN1A0dFJDcHBlTmNjUkJvSzFpcDM3ekMxaWJ3YVlMSnJpL2hU?=
 =?utf-8?B?M01XMy80M056M2NHNzJBVGlqNlRqdkZIQnd3bzMwemE5Qnc3bzhKandsbFUw?=
 =?utf-8?B?SHI4U3doOUdZWFY0VVVBM1k1SDdETUVhWEpiWm9sMWJnN3VabXMyMWxqbkJx?=
 =?utf-8?B?dFVBR0FtMlVsYlJVRGFCNzFVMUhHaHY1UEhHL1ZSNnIyRnVPQ3hqTitONVpR?=
 =?utf-8?B?WnpXaTJoTk1nczhEa0lsM3dGVDlta2pCcXRaRmJUWkhLQlVlWkJ0ZVFQUzdL?=
 =?utf-8?B?eG54K2hqaEhWUjNraDlLS080YzlITnBhOFdwdmRndHgvaUltelExVEZFM3JG?=
 =?utf-8?B?Z1AxV3NEQy9tTHA0ODNHNG8vM3ROQzdTeWlGeDlObWk5QjNMS0dlb2UzMHlv?=
 =?utf-8?B?VVJDYWNMa3hYaGZHU09adkxRd1Y1N0ZsYXpYQi9UTDdOOGhVVlZyWWt4NW5w?=
 =?utf-8?B?U0ZUODZ5M05adlNXcGY2c0RJMFJWRXlMNm0vM2dDNnpIcStvUXNvWWlSTlQy?=
 =?utf-8?B?NkxrcXRIQVNXVWNjRUZZSUpLYjVocHVCbEFJdHlaUkg5ZnFQbVZ5L0haSmlw?=
 =?utf-8?B?b2ZMUkc3V1VPa1hCYnh4QVVaVEV6NVlXWnlJRFNTRTJpcHhld0oxN0REV0lD?=
 =?utf-8?B?U1UvdE1kRHFQbHVnSHMzd0lITGV6NmNaMUdDdVFYcTFhNU5aSmNmS3dmRlB3?=
 =?utf-8?B?T3I4SlhzNlZFKy9TVFZsTjhvenlDY1VvVmx3bmdkSFNCb1RMY2d2MEZHaVZT?=
 =?utf-8?B?QldnNUVPL1dBL0JaZm1reFByRk5zSDhaOUFJM1p6a0dUb010SkVjcEpzU01h?=
 =?utf-8?B?ald2NEtQQXdUeEJWVlRyTDMzamNobzlmRUJHZVkwdzZzbGtIUzZsVUdaZkZE?=
 =?utf-8?Q?Y73O0nj+ny8paKMwEcDIr7mBF9pa5TZnvIQmRRc?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c8332b79-5cca-4835-6746-08d98ef14246
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5469.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 09:01:50.5891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 ldFlN7Tl7/sVZUT1j3hlkvJ/mk19dMA4rmveW4CwJOtF0P5D8mNlYKkvPzU8U5pTo/0TPf5PoZUOF3QSXhqs+P94UQO2iE1r/d88+GDo4Lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1387
X-Proofpoint-GUID: 1YZQYmsqEJ7HLCUWKFO3eKhSzcllaIQ3
X-Proofpoint-ORIG-GUID: xBRkPzs8wgRCJ2Lk6urCUnWWx2cBJcUR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-14_02,2021-10-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 mlxlogscore=999 clxscore=1011 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110140055
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Oct 2021 09:01:55 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12775

Hi Scott,

On 9/28/21 10:00 AM, Scott Weaver wrote:
> On 21-09-22 09:58:13, Kai wrote:
>> On 9/6/21 6:27 AM, Scott Weaver wrote:
>>> When downloadfilename is defined in a recipe's SRC_URI and PREMIRRORS is also
>>> defined using the same URI, the downloadfilename is appended to the mirror
>>> URI and it should not be.
>>>
>>> [YOCTO #13039]
>>
>> As I commented in the bugzilla, I suppose it is an invalid bug.
>>
>> It save the tarball with the name of the value of downloadfilename rather
>> than the basename of the url.
>> In this case, the name of tarball in the premirror downloads/ directory is
>> uthash-2.0.2.tar.gz rather than
>> 2.0.2.tar.gz if the premirror is created by run bitbake do_fetch. So when
>> premirror is used, it checks
>> uthash-2.0.2.tar.gz in the premirrors but not the original value
>> '2.0.2.tar.gz'.
>>
>> With this patch, it fails to fetch the tarball from premirrors. It could be
>> reproduced by config:
>>
>> BB_NO_NETWORK = "1"
>> BB_FETCH_PREMIRRORONLY = "1"
>>
>> Regards,
>> Kai
> 
> Sorry, Kai. I didn't see your email until just now.
> I'll look into it. IMO, I would treat this like a new/different bug
> than the one I addressed with this patch but regardless it is a
> related use case to this BZ.
> 
> I'll update the BZ after I've dug into this.
> 
>   - Scott
> 
> 
>>>
>>> Signed-off-by: Scott Weaver <weaverjs@gmail.com>
>>> ---
>>>    bitbake/lib/bb/fetch2/__init__.py | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
>>> index 914fa5c024..47a4943369 100644
>>> --- a/bitbake/lib/bb/fetch2/__init__.py
>>> +++ b/bitbake/lib/bb/fetch2/__init__.py
>>> @@ -466,7 +466,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
>>>                        # Kill parameters, they make no sense for mirror tarballs
>>>                        uri_decoded[5] = {}
>>>                    elif ud.localpath and ud.method.supports_checksum(ud):
>>> -                    basename = os.path.basename(ud.localpath)
>>> +                    basename = os.path.basename(uri_decoded[loc])

Use 
meta-openembedded/meta-networking/recipes-connectivity/dhcp/dhcp-relay_4.4.2p1.bb as 
an example:

* Before the patch, basename is bind.tar.gz
* After the patch, basename is bind-9.11.32.tar.gz

The patch changes basename from bind-9.11.32.tar.gz to bind.tar.gz, but didn't
remove downloadfilename=bind.tar.gz from the mirror URI. The commit message
says:

"the downloadfilename is appended to the mirror URI and it should not be."

But the downloadfilename is still in the mirror URI after the patch.

And the patch has a side effect is that it makes PREMIRROR or MIRRORS harder to
use, the saved filename in DL_DIR is bind.tar.gz, but the required name
in the mirror is bind-9.11.32.tar.gz since bind.tar.gz doesn't work any more,
which isn't as straightforward as before, people who uses DL_DIR as PREMIRRORS
doesn't work any more.

BTW, leave downloadfilename in the mirror URI won't affect anything AFAIK.

// Robert

>>>                    if basename and not result_decoded[loc].endswith(basename):
>>>                        result_decoded[loc] = os.path.join(result_decoded[loc], basename)
>>>            else:
>>>
>>>
>>>
>>
>> -- 
>> Kai Kang
>> Wind River Linux
>>
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12711): https://lists.openembedded.org/g/bitbake-devel/message/12711
> Mute This Topic: https://lists.openembedded.org/mt/85401309/3616940
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [liezhi.yang@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

