Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52B0C433F5
	for <webhook@archiver.kernel.org>; Fri, 15 Oct 2021 06:27:37 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web12.5933.1634279256562166111
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Oct 2021 23:27:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=OYS2qdec;
 spf=pass (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=5922da58ec=qi.chen@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19F6A3eK022142
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 Oct 2021 23:27:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 mime-version; s=PPS06212021;
 bh=Z5Id2gbQY8G/0diJFiTC62MevaU6ZwLcZQNUt0ezkyY=;
 b=OYS2qdecrmJa3/MnLhe8uDRFk8HQWiFVCT99yADel3N0cioX5f4qIK29/y1sT9YG5alw
 0dTixO3Ttz8y+0aCns5vV46MBWabbE/9VrjxoIlgeWFmaMcSsH3c1lf2GYTAKuw6ARiW
 L5tsfGrjLrgM7/SYLZ5L0mUZBeL1LQecvekeC6FzfJNafqiuIH0dA3cCN7e6BkVij+rc
 JoeNT4ohoyiWyVVfL28jBaB/FzA2O/IxWAAf8PgzNbNl355P/1CG3NTUmmxgeEGKdGFB
 DTmn/mUL2wD75cRn3VIeiACc4oVt2BgP8GKQdjVIuWniiFuaWD9/gek/rWMuIun3p7Da Fg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com with ESMTP id 3bpbdq17wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 Oct 2021 23:27:35 -0700
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19F6RZUg027760
	for <bitbake-devel@lists.openembedded.org>; Thu, 14 Oct 2021 23:27:35 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam08lp2171.outbound.protection.outlook.com [104.47.73.171])
	by mx0a-0064b401.pphosted.com with ESMTP id 3bpbdq17wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Oct 2021 23:27:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MH5RlectNmssTDWKc2lU0nL4v2ZTe4fozieXwz1AE6PKsQ2BhE8fTxxNQSPIfG0O/FdAgLM2j4qbaUDsswKi2etUY7OQ6ZzoXhbgsrlPh99mjglCGs6n7OSlZGp+EyqfBs4Y0Iao6kDoYAfR5urHH9SrVZIcF+xsqoBbsyWO7zoQ8D4oMglXwsJOlHetTLxX07AzaHFjqviUG4uejuYqYoE/P+vJhYtUso4QFIOWMpQ+8QJOlyfSG4uMI7Ed6aELN3/x4Ic4Y4k6Sy9Ba/VrloDpKuUEd69w4NQEJXKx20+0wGKqAxzHyzzzk3+4/1y1IUpzbQyISsmdnbaMB6hgrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5Id2gbQY8G/0diJFiTC62MevaU6ZwLcZQNUt0ezkyY=;
 b=OjV8PM475lh7WZHw694pXrlVnINHWlXABeuJXLz/X64WEyLZfQuLsYTwrlpuKUuaWLkMmQECTaLEQP2XWAV8fu0z+TNllJH++UW9Ne20uyqGrjfhnRIvWqoQKEPFVEckECwp99xRHYa0ejplN5AqSMa4ZIkpLp0O9FJQQ0IzYuaQWhAvy6uP8qfOddMPxQvHf5bUjqLtflppdC591z5OKktoA2YEYIFpTlBdieMqf/5YM7PBS8h1x1z8NFoLa9YqsrwLEsCeAQuVfOUdjdELWNSoQEdl+GNWTW9i97DpWJak/Fp2PF62lFwPOKu+C1q6K6F9NdYlBM/XT96UrPFA/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: windriver.com; dkim=none (message not signed)
 header.d=none;windriver.com; dmarc=none action=none
 header.from=windriver.com;
Received: from PH0PR11MB5611.namprd11.prod.outlook.com (2603:10b6:510:ed::9)
 by PH0PR11MB5625.namprd11.prod.outlook.com (2603:10b6:510:ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15; Fri, 15 Oct
 2021 06:27:31 +0000
Received: from PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::9d20:68ca:19c3:803f]) by PH0PR11MB5611.namprd11.prod.outlook.com
 ([fe80::9d20:68ca:19c3:803f%9]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 06:27:31 +0000
Subject: Re: [bitbake-devel][ 1/3] bitbake: fetch2: fix premirror URI when
 downloadfilename defined
To: Scott Weaver <weaverjs@gmail.com>, bitbake-devel@lists.openembedded.org,
        Richard Purdie <richard.purdie@linuxfoundation.org>,
        Kang Kai <kai.kang@windriver.com>,
        Robert Yang <liezhi.yang@windriver.com>
References: <20210905222738.1050768-1-weaverjs@gmail.com>
 <20210905222738.1050768-2-weaverjs@gmail.com>
 <16AE2029FEDEE475.7161@lists.openembedded.org>
From: ChenQi <Qi.Chen@windriver.com>
Message-ID: <31e9f58c-dceb-6626-aa4c-2ea9307cf221@windriver.com>
Date: Fri, 15 Oct 2021 14:40:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
In-Reply-To: <16AE2029FEDEE475.7161@lists.openembedded.org>
Content-Type: multipart/alternative;
 boundary="------------9969F5590443DB9ACE755C4C"
X-ClientProxiedBy: HKAPR04CA0003.apcprd04.prod.outlook.com
 (2603:1096:203:d0::13) To PH0PR11MB5611.namprd11.prod.outlook.com
 (2603:10b6:510:ed::9)
MIME-Version: 1.0
Received: from [128.224.162.145] (60.247.85.82) by
 HKAPR04CA0003.apcprd04.prod.outlook.com (2603:1096:203:d0::13) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.20.4587.19 via Frontend
 Transport; Fri, 15 Oct 2021 06:27:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 848cee28-5065-4040-4242-08d98fa4de38
X-MS-TrafficTypeDiagnostic: PH0PR11MB5625:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: 
	<PH0PR11MB5625DE82D058E52542299290EDB99@PH0PR11MB5625.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Csq30mAcb+fOn5Z2PocJ7UxQDL4j0Xo1IHksuDMzsvXc22Pohu/jL+LZqMa1HGEBQjZWqrQZGNucsLePqy51wEdf21yuMu3x5jeneat4Ah08j4sA2sqZT/YdWmOkRVstB1OPnzYQM9b7SsiD88n4eDXOSTYBrNlMN+h6E8z7xN3tdzbaXU9HYBBN/zQuhd63FLAT8y243t1J/tarSyJJ71g6zGTzJ664d4mE8LsNmF7TZVAFiBl6nZ00JAfyM1c/r46r6Ws8ALKLDS+uk3ivx8vv2iGJllFDyd/wx8qKEdkG1F7WBEX782GYxtsp9IWtJjudrO93OdEeMoj20oe4TWe3LVsQxiOkPOSqRpcu/0+kJfx+DwV3w2SLWoquLMqnbKDYsc+KxaOik6dosp5INtxlfrnuO5lGJSBUEe8oAet8NYfCuWKDBPjnkOvnCgzlIHMo6I8i9QrIaFmnzNm/KsX2TYFzfVotwWDgFD1ocXlcNKzEXWUf4oMJvzP+YnUsnExPmXbUrAS9rcFTbtKAc0BNhNv6YasDkfLTim1kg6Y/7IjmOkfAfoE/u6knZ6sCp7FIeQCiRUMXYnFjWG+KxcpD5cdCDgq8PlvBHQqnsusdmXU3orKFeg0Fh1UtQxIK3dDI2NGYIdw06Y+UJImZD1vmlhltCLxm+ULwczKvYcUG3EEp6PqGrAwRRwfzXZRa5fcMuSu9gnCIUsOV2GnH7AR8mUrVvuOttGUWh5OdjspMWwFzwQih0DAVeEOVQde8frBg/hbByYXTuQJ75HTe7C+5p1r3kOecDaFGFbeBZpPWwVxNjq2QC87L12tKubfabkbZnLhVpBtGaUyU74DqxMk9vJL/f0bAFgeB/83Nk7qOMwxbe1EsKi5gw2k24j2Ksmdw1kRThkDXm5j+JDuuEZG1ALuM+Gt6Oqo9VsOR8DE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5611.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(26005)(31696002)(110136005)(83380400001)(33964004)(6636002)(508600001)(31686004)(6486002)(16576012)(66946007)(6666004)(2906002)(186003)(6706004)(36756003)(52116002)(8676002)(86362001)(66476007)(166002)(53546011)(38350700002)(66556008)(5660300002)(38100700002)(8936002)(966005)(316002)(2616005)(956004)(78286007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UThuRC9GcGIrWHI3cGFOb3FuSFBXSGhMM3Y5VmxuY1FkV295YW5YNmJJMERn?=
 =?utf-8?B?N0xGc2g3TG5CeTBsY08xL05lbkYzZWlpdzdOREJLeHZaVWh3Q2tYSGljc3pR?=
 =?utf-8?B?dnZtZm5iMVpneWdNd2xHYU4vSVZ2T0NEN280MnpybGpvVHZKdlRna1VabU5W?=
 =?utf-8?B?eHkwemtnM2tJYWhiQ1dIK3RadlY2RFVZeng4dzh2S2RtcWtzSDNCbnNvTHBU?=
 =?utf-8?B?RCtvTWV1Y1U2Wnh2RjN1cmsvS2p1QkRpaHBEdTA1d2hVTGpWWExib01DSU1k?=
 =?utf-8?B?R2FlMWcvNWZwNWQxUGdTaVFXQnoybDJXdXh2d29Edm01UWtjSW5CVXdmbUhs?=
 =?utf-8?B?UE1YL1pyZVNOSkFqTmEwYlZRRE5rVWh4a2p5TDNNOGRSNmtUem9TQnN6S2x6?=
 =?utf-8?B?Q3RFQTBrT0xDaVhBSTZHOFQyQnJhRXdlNFNPWk44Tm8zWnIycTdpaGpyRzVk?=
 =?utf-8?B?YnlqYWxJMFJoR1FpbDJ6TThBUUtLZUZQVHUxa0o5T21WZ1ZpVUdBUGtGN1ox?=
 =?utf-8?B?N2k5b0oveTE5RU5xZ1kzSVlKYjVPMytKRjBCa3hOdDhwUFNITGhjQ1JBMmtX?=
 =?utf-8?B?alRsclplMzJwTE1MZXkraDl3U0FWNnkvM0tWOFBkdUhoTlFZamdwMGFmdmlh?=
 =?utf-8?B?WkNuaFhIU0hwcDN0RmtyZk1MYzE3K3Zrdk9SakdwSFk4US96bjd1djNrTkVE?=
 =?utf-8?B?bzAxNEk5Q3hYbnNnME11MGdFbGliSEM2VWFsWENQWnJ6Ri8xenpFdUlsSHc5?=
 =?utf-8?B?R1VtWDQxWWY0VXlndExVVjgrZzhSMEx5dzR3L2w5em43UTVlQTgyU3BTMFRQ?=
 =?utf-8?B?ZVNWTE93MUNPakRuRGliTGRvOFN0a1ZNKzR3WnkxWWpHblROZC9GMlF5SmFr?=
 =?utf-8?B?RDNrbFVhOFBHblRablNyMU9UZ29MYmt1UXNZWDZlMUYrUXFRNno2RHhVeURW?=
 =?utf-8?B?QjZZYVBFdktwOXU2Z2NPNUozWXU0SHBUU0JodEtHbXhRQVNibUdWZUZyTzdE?=
 =?utf-8?B?YjhNRXM5dGd6TmRNbTd2ODh6UTRHMXlPeE1MZFpycDB0ZHR2SUFwa2xGU2VD?=
 =?utf-8?B?Z0FJdTVyMUVkZXpWVS9odnlON2hMTVI1RldYZFhXMXltd3ZVRnUzTHNqWlNi?=
 =?utf-8?B?dTRnZ0FESGJNWGpJOWFidWJrY1oxMnJEck5BOUF6MmJ0bWdYbExwVi9waEYw?=
 =?utf-8?B?emZkVU05aUQ4dDJhQytEYTVVeU02S2crejhibXB2T1dZUlV5U1MvdmcwcEp4?=
 =?utf-8?B?VWdZYzZobWJRZTg3cmhrbDhac09sVFh0SXlPczhGRlByKzRzc0dhSHBBYzQx?=
 =?utf-8?B?TC91bzlYd3VwYXZaUmRCcCt6OVlpTWNiQzQ5UnBKcUxOd0FwZXhMY1UrVEli?=
 =?utf-8?B?MGU2V1hyVVFTa2hPVVkzdkFUVldnMUpwYldlV0Z4NENnbWxtU1Y5UFhrTTRR?=
 =?utf-8?B?dDJVWTNHYlVWTEw2UzZXOHc2YloxT1BxOGJZNnhnbGtDN1A1djRmcGRPSXNs?=
 =?utf-8?B?RkZpVzBlN2ZHNGowaHdEMkNpT0U5b2ZzOXZNbzZOMk1WYWkrK05CUkxwOWJF?=
 =?utf-8?B?czlFb3E0ZVpEWEpobjZlaUYyUy9YaVVtUmNRdzEzZGQwc2ZybU5TWnJFNnNL?=
 =?utf-8?B?Z2JHVC9BSldsZU0xd0tWYkxISnNtL29DaFdPTzJtRGJlZTJhWmQ5cWhMVXlq?=
 =?utf-8?B?R1VBbzVuV21Zd3VSeTBPSWkraVp5VjhRdTNmUGJmV3gwRVV3NnJjUkNHMlRM?=
 =?utf-8?Q?l4aqw65xixTnAqtM8YcogDyMCn8oEkfScbFl4Ej?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 848cee28-5065-4040-4242-08d98fa4de38
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5611.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 06:27:31.6756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 0Zdn4WF4r2vN+SrmZKNm7d3LTjciE1Z49sSL3x54rvquCXhlu8IOoMoDSYSa497J6How0kMaghiQ3ELHFKjxBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5625
X-Proofpoint-ORIG-GUID: vE5P_C3s1w4T5Komg0WFasSEXzNMspRm
X-Proofpoint-GUID: 6KTTBpO5DAER7ASkKB3vu_dVv5Cp02Fo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-15_02,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110150041
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 15 Oct 2021 06:27:37 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12781

--------------9969F5590443DB9ACE755C4C
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/2021 02:37 PM, Chen Qi wrote:
> Hi Scott,
>
> I think the key problem here is which tarball name to be used for 
> premirror.
> Previously, it's using 'downloadfilename'. So instead of holding 
> 1.4.0.tar.gz on yocto's mirror, it holds freeDiameter-1.4.0.tar.gz.
> Now, with this patch, the basename of the URL (e.g. 1.4.0.tar.gz) is used.
>
> This at least causes the regression that a local download/ directory 
> could be serve as a premirror.

Sorry, typo. Should be:

This at least causes the regression that a local download/ directory 
could not serve as a premirror.

>
> I've sent out a patch to restore the previous behavior, it should also 
> solve yocto#13039.
> The title is: [bitbake-devel][PATCH] fetch2: fix downloadfilename 
> issue with premirror
>
> Could you please check if it works for you?
>
> Regards,
> Qi
>
> On 09/06/2021 06:27 AM, Scott Weaver wrote:
>> When downloadfilename is defined in a recipe's SRC_URI and PREMIRRORS is also
>> defined using the same URI, the downloadfilename is appended to the mirror
>> URI and it should not be.
>>
>> [YOCTO #13039]
>>
>> Signed-off-by: Scott Weaver<weaverjs@gmail.com>
>> ---
>>   bitbake/lib/bb/fetch2/__init__.py 
>> <https://urldefense.com/v3/__http://__init__.py__;%21%21AjveYdw8EvQ%21NcbTHox-6oqYMaVTv6H3RVVTYA06zLNBPvkC6ZLg3Y6PRXUmmAyBKwEPXzGAFvB8Gw$>  | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/bitbake/lib/bb/fetch2/__init__.py 
>> <https://urldefense.com/v3/__http://__init__.py__;%21%21AjveYdw8EvQ%21NcbTHox-6oqYMaVTv6H3RVVTYA06zLNBPvkC6ZLg3Y6PRXUmmAyBKwEPXzGAFvB8Gw$>  b/bitbake/lib/bb/fetch2/__init__.py 
>> <https://urldefense.com/v3/__http://__init__.py__;%21%21AjveYdw8EvQ%21NcbTHox-6oqYMaVTv6H3RVVTYA06zLNBPvkC6ZLg3Y6PRXUmmAyBKwEPXzGAFvB8Gw$>
>> index 914fa5c024..47a4943369 100644
>> --- a/bitbake/lib/bb/fetch2/__init__.py 
>> <https://urldefense.com/v3/__http://__init__.py__;%21%21AjveYdw8EvQ%21NcbTHox-6oqYMaVTv6H3RVVTYA06zLNBPvkC6ZLg3Y6PRXUmmAyBKwEPXzGAFvB8Gw$>
>> +++ b/bitbake/lib/bb/fetch2/__init__.py 
>> <https://urldefense.com/v3/__http://__init__.py__;%21%21AjveYdw8EvQ%21NcbTHox-6oqYMaVTv6H3RVVTYA06zLNBPvkC6ZLg3Y6PRXUmmAyBKwEPXzGAFvB8Gw$>
>> @@ -466,7 +466,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
>>                       # Kill parameters, they make no sense for mirror tarballs
>>                       uri_decoded[5] = {}
>>                   elif ud.localpath and ud.method.supports_checksum(ud):
>> -                    basename = os.path.basename(ud.localpath)
>> +                    basename = os.path.basename(uri_decoded[loc])
>>                   if basename and not result_decoded[loc].endswith(basename):
>>                       result_decoded[loc] = os.path.join(result_decoded[loc], basename)
>>           else:
>>
>>
>>
>
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12780): https://lists.openembedded.org/g/bitbake-devel/message/12780
> Mute This Topic: https://lists.openembedded.org/mt/85401309/3618072
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [Qi.Chen@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>


--------------9969F5590443DB9ACE755C4C
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 10/15/2021 02:37 PM, Chen Qi wrote:<br>
    </div>
    <blockquote cite="mid:16AE2029FEDEE475.7161@lists.openembedded.org" type="cite">
      
      <div class="moz-cite-prefix">Hi Scott,<br>
        <br>
        I think the key problem here is which tarball name to be used
        for premirror.<br>
        Previously, it's using 'downloadfilename'. So instead of holding
        1.4.0.tar.gz on yocto's mirror, it holds
        freeDiameter-1.4.0.tar.gz.<br>
        Now, with this patch, the basename of the URL (e.g.
        1.4.0.tar.gz) is used.<br>
        <br>
        This at least causes the regression that a local download/
        directory could be serve as a premirror.<br>
      </div>
    </blockquote>
    <br>
    Sorry, typo. Should be:<br>
    <br>
    This at least causes the regression that a local download/ directory
    could not serve as a premirror.<br>
    <br>
    <blockquote cite="mid:16AE2029FEDEE475.7161@lists.openembedded.org" type="cite">
      <div class="moz-cite-prefix"> <br>
        I've sent out a patch to restore the previous behavior, it
        should also solve yocto#13039.<br>
        The title is: [bitbake-devel][PATCH] fetch2: fix
        downloadfilename issue with premirror<br>
        <br>
        Could you please check if it works for you?<br>
        <br>
        Regards,<br>
        Qi<br>
        <br>
        On 09/06/2021 06:27 AM, Scott Weaver wrote:<br>
      </div>
      <blockquote cite="mid:20210905222738.1050768-2-weaverjs@gmail.com" type="cite">
        <pre wrap="">When downloadfilename is defined in a recipe's SRC_URI and PREMIRRORS is also
defined using the same URI, the downloadfilename is appended to the mirror
URI and it should not be.

[YOCTO #13039]

Signed-off-by: Scott Weaver <a moz-do-not-send="true" class="moz-txt-link-rfc2396E" href="mailto:weaverjs@gmail.com">&lt;weaverjs@gmail.com&gt;</a>
---
 bitbake/lib/bb/fetch2/<a moz-do-not-send="true" href="https://urldefense.com/v3/__http://__init__.py__;%21%21AjveYdw8EvQ%21NcbTHox-6oqYMaVTv6H3RVVTYA06zLNBPvkC6ZLg3Y6PRXUmmAyBKwEPXzGAFvB8Gw$">__init__.py</a> | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bitbake/lib/bb/fetch2/<a moz-do-not-send="true" href="https://urldefense.com/v3/__http://__init__.py__;%21%21AjveYdw8EvQ%21NcbTHox-6oqYMaVTv6H3RVVTYA06zLNBPvkC6ZLg3Y6PRXUmmAyBKwEPXzGAFvB8Gw$">__init__.py</a> b/bitbake/lib/bb/fetch2/<a moz-do-not-send="true" href="https://urldefense.com/v3/__http://__init__.py__;%21%21AjveYdw8EvQ%21NcbTHox-6oqYMaVTv6H3RVVTYA06zLNBPvkC6ZLg3Y6PRXUmmAyBKwEPXzGAFvB8Gw$">__init__.py</a>
index 914fa5c024..47a4943369 100644
--- a/bitbake/lib/bb/fetch2/<a moz-do-not-send="true" href="https://urldefense.com/v3/__http://__init__.py__;%21%21AjveYdw8EvQ%21NcbTHox-6oqYMaVTv6H3RVVTYA06zLNBPvkC6ZLg3Y6PRXUmmAyBKwEPXzGAFvB8Gw$">__init__.py</a>
+++ b/bitbake/lib/bb/fetch2/<a moz-do-not-send="true" href="https://urldefense.com/v3/__http://__init__.py__;%21%21AjveYdw8EvQ%21NcbTHox-6oqYMaVTv6H3RVVTYA06zLNBPvkC6ZLg3Y6PRXUmmAyBKwEPXzGAFvB8Gw$">__init__.py</a>
@@ -466,7 +466,7 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
                     # Kill parameters, they make no sense for mirror tarballs
                     uri_decoded[5] = {}
                 elif ud.localpath and ud.method.supports_checksum(ud):
-                    basename = os.path.basename(ud.localpath)
+                    basename = os.path.basename(uri_decoded[loc])
                 if basename and not result_decoded[loc].endswith(basename):
                     result_decoded[loc] = os.path.join(result_decoded[loc], basename)
         else:
</pre>
        <br>
        <fieldset class="mimeAttachmentHeader"></fieldset>
        <br>
        <pre wrap="">

</pre>
      </blockquote>
      <p><br>
      </p>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <br>
      <pre wrap="">
-=-=-=-=-=-=-=-=-=-=-=-
Links: You receive all messages sent to this group.
View/Reply Online (#12780): <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/message/12780">https://lists.openembedded.org/g/bitbake-devel/message/12780</a>
Mute This Topic: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/mt/85401309/3618072">https://lists.openembedded.org/mt/85401309/3618072</a>
Group Owner: <a class="moz-txt-link-abbreviated" href="mailto:bitbake-devel+owner@lists.openembedded.org">bitbake-devel+owner@lists.openembedded.org</a>
Unsubscribe: <a class="moz-txt-link-freetext" href="https://lists.openembedded.org/g/bitbake-devel/unsub">https://lists.openembedded.org/g/bitbake-devel/unsub</a> [<a class="moz-txt-link-abbreviated" href="mailto:Qi.Chen@windriver.com">Qi.Chen@windriver.com</a>]
-=-=-=-=-=-=-=-=-=-=-=-

</pre>
    </blockquote>
    <p><br>
    </p>
  </body>
</html>

--------------9969F5590443DB9ACE755C4C--

