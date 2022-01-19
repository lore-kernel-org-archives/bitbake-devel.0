Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0AFC433FE
	for <webhook@archiver.kernel.org>; Wed, 19 Jan 2022 11:49:47 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com
 [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web12.5116.1642592987037998060
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Jan 2022 03:49:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=JkgbwCuc;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.178.238,
 mailfrom: prvs=8018707d56=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id
 20JBnfJF002252
	for <bitbake-devel@lists.openembedded.org>; Wed, 19 Jan 2022 11:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=YV6X3/LFKfomipjQgbimXBckbzv4wvmumyI5AXF4/M4=;
 b=JkgbwCuczrsQ5B1guSKzxC5F1u+wmAG/ln5s5sYSsd7xCSA6JfApnQoPFJQgv+GV+OLV
 VeCP3Iyk3j7p+Ssy2ybmFdCjAjMl2zOl3yb31G6r1W7ggYHsviziz7Z9jIRGYy4G6N76
 k0AtHi/JrGOqEkBhtGnzdBtldrTbZaZHtxgTgtT3gH01cCriQ3zIDHe5GcCF/5nVHNup
 L9UpLqZ/fMv0h0Fjp1R4Sqc9Ypu1gP+1i7iAa2cqoDYCrz0fxxWspMhLt8u/J3avyRBK
 tzcrE/p/xzKIrwJnWVALkyn2wusB8LciTYNDl+AWOEowjhjpW5sIPNDS88KYD7egyNmU qg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3dn8m5hj33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 19 Jan 2022 11:49:46 +0000
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 20JBnjre002262
	for <bitbake-devel@lists.openembedded.org>; Wed, 19 Jan 2022 11:49:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3dn8m5hj31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jan 2022 11:49:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZEI5bQmjvbltqbLqcEFbbVyir4dNJThmQtIV9k8DJCTxFS6PhUnzG3klEIFdqDgquofHeDdAF7PfqB5hPGMBekDNen1rOKTcU9Q9Nty+nsWT539rAVKNiYZSshfQ22OuXpkJ7A2uTiJz209MeoFz3yXvFwpA6Y6RX3Wv7FKOjdddib9g7227g+sKN61SAjmS57c7Iac9UjvUkv//Wh5pRs0TW2c+93icZ3le4pw8E2g8O2kq3DA80RiwouImrDGkHxmzbGI3mAnpjfqUWny+k/SHaBmE0Z8NJ/SkjO6LT3yusaKCXLc+mS6/WSep5ellVS/h2oHOyp9j+Y23HM8+EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YV6X3/LFKfomipjQgbimXBckbzv4wvmumyI5AXF4/M4=;
 b=RNxferIct61SGGVmsdDj+mW2AoIkQBJraP6od/KeI5yzv+a+70QPPRY45+wUda/+hmAlUHx2sE6igVWboEbqaFWEMKxQwhakXy/wenr/BhWfqPxhyqtitBeQMNc8hyvakeGmGlbnQbvlvjZAhqNY/DTThqoIUWNeGBFgEr8X2RR3Voo9c+oL1ZYEcEn2LNkqoVkpXE7c3syU4JXZwUTQJQ1+S0g4eLx+WVzj6jbA4LKsf7DZN2cqOHYvnbYwMXvcrv1OAJwC0opgK2Aqtrju1SO/HLvcd5HXRZ7vlv/UY6mlwtuFe03x5Bf+ai8oF41+tNxQ3cjAz+FN7jL5IdqQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11)
 by DM6PR11MB2700.namprd11.prod.outlook.com (2603:10b6:5:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Wed, 19 Jan
 2022 11:49:42 +0000
Received: from BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5cb5:e426:2e48:17ed]) by BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5cb5:e426:2e48:17ed%5]) with mapi id 15.20.4888.014; Wed, 19 Jan 2022
 11:49:41 +0000
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-worker: Add/support network
 task flag
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org
References: <20220107231526.1517563-1-richard.purdie@linuxfoundation.org>
 <20220107231526.1517563-2-richard.purdie@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <706c435f-4c16-0914-fc9a-bbc4050319a1@windriver.com>
Date: Wed, 19 Jan 2022 19:49:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220107231526.1517563-2-richard.purdie@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0161.apcprd02.prod.outlook.com
 (2603:1096:201:1f::21) To BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6646d063-f8c6-4553-2adb-08d9db41c757
X-MS-TrafficTypeDiagnostic: DM6PR11MB2700:EE_
X-Microsoft-Antispam-PRVS: 
	<DM6PR11MB270064CFB5836935C03EB026FF599@DM6PR11MB2700.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	iHm2P1+dhgjZOFPue3s+bQ/SEHPWUGN6n7ZUDsJX1NtDw42o+azJiGI/DrENAKKUJHeqe0sOezSg4GIKgSK8ukQhKYRVfvCbulVtoKXQm3eKAAiUTUEjXQevoLWY5Xs4OnBAtDkrFQvv0bi5OTu/371ZdYhkSOvRndaNfVPGkO4Z4gZsjAFZlOjrmj1hDL6KHRE8hZEC8F5KsGopd8CU27B9MTwOor6Ju+eg3F23+qyVShYRk5UpHV6JAd6OP8E9mGB7YgRzMRYB9udwpQmA5ZHOlDCECZaL3w2+a/Zmbt5rXCnRgPtbqS0uBO6eWUI/BHszeSfO3adVDxecsThs1YV0bkxP8uSPIGZ3ovw6UUO8sA8mWIlSHkp2cNckM2du4QCIw6gd3uBC4159CB7irAg5c5p22Nih+txv2sXjD34mL2CVR/zKgNHWb5KsRUE17NHV5a3T7X3ZXgn9u1F+RfDvcT/91XN4LcFoB/dwFSfpt3i2K9C2o2PssKgnyONr4yS1KL9Zg83W5FCpkKfNFzS7sDQWNes8C/LX5YxdWc529QooWEvHJ6vfHiuqiAHHrVAqnabmXABwxdXgf8Sgi2Y8LHU+F5dw/AkqVqXv/7wUxLcuB1/zAF43oCOOxyhOBzL9o0w2QRVMbuzfvOdEzZdiSIKES2eTwBv6hb6zk+Dm7XU/x2bEV+LirUBjciS7mKa+mJ2exMWlczIyW5HYOEm8VJc7Fd3NcYVQmTkOSEnqh8Gy/j2mchJq5WyMsWFQmO5gUsD3PO5Ba6bDrVWWPWqYjl1iZ9qFwWQpk8BiDgzJuzaAmBPjU9/wZwaNCNrDvw+QUoskefqxDOIActpevWXLTIjRgPNbMIkYTXe23ysIzh3Cejeg+gcavMLFJpfwcbyAIh6SYT0bwpMXBXEFVg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38350700002)(38100700002)(31686004)(316002)(2616005)(36756003)(8676002)(8936002)(52116002)(6512007)(2906002)(6486002)(83380400001)(966005)(26005)(86362001)(508600001)(6666004)(31696002)(5660300002)(6506007)(186003)(66946007)(53546011)(66556008)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?QUlNOXRJZ3pXWVh1ZGpZdVNOSTlVZlRsQzVvK3RUSFpzUWp0a05WYzF3YW54?=
 =?utf-8?B?UCtNSFAxUTRCMmZPR1J4QTgvK0tXNk1Zd1lMeTd5ZHVtZXY2QkFtb2lhZ3lG?=
 =?utf-8?B?UlROTVJBeEtlRHFQRkhNbWN6MzNPQVI0N1l2bm1qN2R4YUhScUdoMW1RYlJO?=
 =?utf-8?B?dEZlNUVaRzNObU5EN0V0b2F5UGU5ekpndlo5K1B3UW5yeGY0dDZaWFBmTGk1?=
 =?utf-8?B?TUwvT0hneGV2UGVSQTFyUXZHRE9XNTVxRGZGNTl4L0x0cHRNQWlxa3g0S3pF?=
 =?utf-8?B?cHhTZWpndFl1OEtEbUd0ZXlCMmMybXBUcDd2YlFndU5rU01QN3ZsZHVwUVpF?=
 =?utf-8?B?UVg3bjlJNnNyQ3RSekxRL3ZxVjBWbG1MbVpRNUF1eGlnM3M3Z3NBSE1leEIz?=
 =?utf-8?B?c2h3dXZ3aWU0SlZpM1B5ZGxEemRsNXdiazZVRjRobXkxNEdZbXFwSk02T2ho?=
 =?utf-8?B?K043RHp3OXFBN01OU1lLeEdPMWtzVVlyb0JTbGxPOWxmRXNHTEF3SzZPWUdt?=
 =?utf-8?B?eVNWeHFxMVovRzVNMzdTM29RQUNDWUdyU0FJMEpTd0Y2N2szbzl0a2ZsdnNQ?=
 =?utf-8?B?SHRFTUFnT2lDU3lKWE1nZVpvUkFhUnlDZ0taNHhtcUlPcDRIRko2YzFDQkJR?=
 =?utf-8?B?TnF6R3o0UUN0RFAxQW5QUVRjN3ZxeTN0S2VzZWppOWlLVjJlbVFDd1JqVlhi?=
 =?utf-8?B?T0JtcUpJTjFJcmRnOFByNFR5NlRTakg3NXJiVWIvell5NGxFSnF5SGRIamlq?=
 =?utf-8?B?ZU9jTkFlNDY0RUpTemdyYzBZNGtkTlByRVVRR1VXdGtQVVdyamRKVXh6TnEw?=
 =?utf-8?B?WEhyWDF5ZjVqMHUyZjl3ckhzd0ZQdWN5bm1jUUgwOTN6MEtxd3dhcHVqbWRX?=
 =?utf-8?B?QjNDMVpKMlVmTkh4N3FLMCtUMUM5TTR4K0MxcHpzNHJzY0ZhemlCaTQ0MTNZ?=
 =?utf-8?B?MFVycGVDVUtCaHFRUVd1SkxjMk4xNC9GWTAzZGdRTEQ2Q21xVWFGZm92dHhu?=
 =?utf-8?B?aTJCZVFDbjN0SUNEd2JKaFZVcDZMSXliRVliWmRqcmNFb3R3NUNTYkJROCsy?=
 =?utf-8?B?MkE2RldvNHpwUU16MzJKUXNLaWlsY1hqVm40cVExa3pjQnR1N3FEb2UvdW1W?=
 =?utf-8?B?WjZXRmUrTEJZbzVWZzJuWDFTZ2Y3bndXWWpVaEhVVzBTTlFIeXk1K1BUTUpT?=
 =?utf-8?B?cmtGOFNLa2d6RGl6OVNYdkVkU3FGaGpUYkZuSkpkMDBYcytvUHJPbzRkTkkv?=
 =?utf-8?B?WThBK0kvanZBMzA2U3RDYjQ2NFBNRThVTndRUlpVQTZLMXRCSUt0NTUzcHAx?=
 =?utf-8?B?QVhlTCszRTdDMXdobnFHaGpEdVNIRnJCenVTSTBiMUcralFwZzR0VzVNVVpE?=
 =?utf-8?B?V3pkeStja2YzZmhJNTBlVm0vMmtRcHV2dFV0UzJNYVZyRnlsMHpXWU9UV2xh?=
 =?utf-8?B?Z3l1bHZtaFNsZ2dwbFZiVEF2OENCMzhHQTI2NXB4amR0Z1hWaERtTk9lbUFm?=
 =?utf-8?B?V1Z2Vi9ZcytFRitmQWx2SnFETWx1Szlpa3o3SldzR1dVYXpmNVltSEkvbTBG?=
 =?utf-8?B?bzZRR0lrSlJOS1BGa05JcFZKazFzbXFLQjlGRm5KcUxvdktNczhVS2haOFhX?=
 =?utf-8?B?Si83MVBvaE0vUGJia0JWL0RKUW5YNGxlQ1dCVmZ4dDBYS1IyZ3dYb0ZSY3Iz?=
 =?utf-8?B?a0s1K0hyNzVGZFNFVm9LUHVXbU52U24xYWp4MG10dzBkaE5iUThrcXNTT0Ey?=
 =?utf-8?B?TXZJeDdFR0FrUWVNS3FwNmVJQitlN2xuNEtveWZYNVk2YVBVamp1TXBzb3Nx?=
 =?utf-8?B?OXRZL0RYMTFac2o5VlEzTStMSENBcTZDdVo3ek1JWG00dW9hVkZHWjdrejd2?=
 =?utf-8?B?MW16MWtBOXlGZ2lOZ2M5KzRqakJZKzhkd3RHRzM3d3FGVndoSTA3bXA0V1dr?=
 =?utf-8?B?UWlxNEJlSU9keVNvYXcyeTdYNlZzS1JTYWJTMWhha1cwZW94KytHbWV3ZU1h?=
 =?utf-8?B?VnVxYzJHUFZpcGJWaURQZ2hROStYTzZ0RDF6emJOZ1V6SnZHYXFrL3pkNnBL?=
 =?utf-8?B?M2hrUXlhSDRSQ1dzcXVQcDFoa2RMRVBNRU11bkF1aFZqUlBOWk54dldvVFFr?=
 =?utf-8?B?TGFjbzE4VElLa281QzBxdFFaWHVYZDhVbVNEQ24vSzlacUxXcGJPZ2ZVUi83?=
 =?utf-8?B?Q0hMNEwrZGtzTzQ0ZDZwUTk3MnRIeDBoNmVsOTd2N09ZTFdudjg3bktJWXdB?=
 =?utf-8?B?cE4wYU9nMXlJTDY0bWU1aTBSWEdRPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6646d063-f8c6-4553-2adb-08d9db41c757
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 11:49:41.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 8ZKecy+qBTGRjua8en1Wk9LDRsr9tIdOvpLY8vd64bUkxgdbxSyZeEHYGqEVjKq18QCwvtCsTjHOgjOQgv7i6rCnuZhSCXKwZyJHcnZoiOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2700
X-Proofpoint-GUID: VKhEtDP5u1MHmDl4zbKHyWUIFIVCaMn4
X-Proofpoint-ORIG-GUID: MBqIIz1yzmjhjNDrCroVJIhe2L3nwr1v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_07,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0 clxscore=1011
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201190067
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 19 Jan 2022 11:49:47 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13244

Hi RP,

On 1/8/22 7:15 AM, Richard Purdie wrote:
> This patch changes behaviour. After this change any task which does not
> have the network flag set will have networking disabled on systems that
> support that (kernel version dependent).
> 
> Add a "network" task specific flag which then triggers networking to
> be enabled for this task, it is otherwise disabled.
> 
> This needs to happen before we enter the fakeroot environment of the task
> due to the need for the real uid/gid which we save in the parent process.
>

It seems that this patch doesn't work with NIS user, since NIS user alwasy try
to access the network to translate UID to USER, but there is no network, so we
will get the errors like the following during the build:

do_ypcall: clnt_call: RPC: Unable to send; errno = Network is unreachable

These error messages may cause build failures such as

1) bitbake quilt-native -cdevshell doesn't work when set OE_TERMINAL = "screen" 
in conf/local.conf:
ERROR: quilt-native-0.66-r0 do_devshell: Unable to spawn terminal screen: 
Execution of /path/to/0.66-r0/temp/run.do_terminal.189055' failed with exit code 1:
getpwuid() can't identify your account!

If no OE_TERMINAL is setting, it will go into a shell with "I have no name!":

I have no name!@host:/path/to/quilt-0.66$

2) bitbake cmake-native failed
This because the error string "do_ypcall: clnt_call: RPC: Unable to send; errno 
= Network is unreachable" has been assigned to a variable, thus caused while 
errors, for example:
VAR=$(whomai)

It will get the string "do_ypcall: clnt_call: RPC: Unable to send; errno = 
Network is unreachable", and cause build errors.

// Robert

> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>   bin/bitbake-worker | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index bf96207edc..3aaf3c2444 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -152,6 +152,10 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
>       fakeenv = {}
>       umask = None
>   
> +    uid = os.getuid()
> +    gid = os.getgid()
> +
> +
>       taskdep = workerdata["taskdeps"][fn]
>       if 'umask' in taskdep and taskname in taskdep['umask']:
>           umask = taskdep['umask'][taskname]
> @@ -257,6 +261,10 @@ def fork_off_task(cfg, data, databuilder, workerdata, fn, task, taskname, taskha
>   
>                   bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
>   
> +                if not the_data.getVarFlag(taskname, 'network', False):
> +                    logger.debug("Attempting to disable network")
> +                    bb.utils.disable_network(uid, gid)
> +
>                   # exported_vars() returns a generator which *cannot* be passed to os.environ.update()
>                   # successfully. We also need to unset anything from the environment which shouldn't be there
>                   exports = bb.data.exported_vars(the_data)
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13225): https://lists.openembedded.org/g/bitbake-devel/message/13225
> Mute This Topic: https://lists.openembedded.org/mt/88273738/3616940
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [liezhi.yang@windriver.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

