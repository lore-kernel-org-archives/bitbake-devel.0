Return-Path: <Qi.Chen@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35654C433EF
	for <webhook@archiver.kernel.org>; Mon, 18 Oct 2021 03:18:38 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web09.31410.1634527116994492866
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 17 Oct 2021 20:18:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@windriver.com header.s=pps06212021 header.b=LhBNaKn9;
 spf=pass (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=5925725244=qi.chen@windriver.com)
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19I2s6lN021427
	for <bitbake-devel@lists.openembedded.org>; Sun, 17 Oct 2021 20:18:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=subject : to :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=s3Fd3ydgBw3wLQjXiJGTcER9wT679CIMPzRSzbpTJNY=;
 b=LhBNaKn9zPTNYfy0gYnd7SnNP8RSKlm0S8s2lMeeLeeOzaU5Y5pS7N99p+OwlvukQIEE
 c/uKC8T9dJHs9nLn6XVi2ah3Ey3gFcGlXUJ5SH9xAWmgsw+rxiWiGuZZ03jRFr559FwT
 TdfMI8gvtfVL0lsH5u/Yeb5TpBJUfA1pJ5fh3F2E8cG06xG2GPEYTGplAjIDxVETBSp+
 jSI9XTUe61VdBi5uX86eibPGhHP8KgRPiGJ9dnpJIF43NpNePGbUVpOJum8MPCyxK+yU
 lXZOiYr5UiePA393Qdcf+U9mDYNzgOwcAJbEciPrBI0/Z9GXT7lkCLNkX/aYNZaYyV07 RQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com with ESMTP id 3brs4v869q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Sun, 17 Oct 2021 20:18:36 -0700
Received: from m0250809.ppops.net (m0250809.ppops.net [127.0.0.1])
	by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 19I3IZJf029439
	for <bitbake-devel@lists.openembedded.org>; Sun, 17 Oct 2021 20:18:35 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-0064b401.pphosted.com with ESMTP id 3brs4v869p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 17 Oct 2021 20:18:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jiKMQ12lTkKarsFiibs1EwgNff+DHhyq6PEtNFKy9KdlLGPcMywfGYhRDLV5NoDPIg4+Z+3/bQHsB+dEzBm5B+7FxTuL6U4cvYvjk7capbWDVhHaP+6fEBNfty0YFFEJ4n5sw8V129arYwYxXGWhatEOpdc7/ST7XqEHNF+2NIzBGrFzQDA/HEDZ9n3ra8FreS35xTm7TQ2gp8tRwq/+/lUueYoGBvMTFPkCMqhbDYXvrKzLDT4hPUJzYOz2NxXpPU71fXwOu3qJs3qW2QV0JiEJ9/qC7cKbl9nqF42t6lyeyxDq9gp/iGD4yyjJZd88su/E+Ormkmdt2neOED+umA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3Fd3ydgBw3wLQjXiJGTcER9wT679CIMPzRSzbpTJNY=;
 b=YI6wizmyRIsScQ92pFBlOqdFUsaWi8wPPKlurK13BL21qpJ5fICaUd29ou/Fygn+OkCKqK5mYVfxyIBKyxsnhjFsYDcMvp0XQ1NgPXoJqXRPi4SdaWFBMlD5tfs3oXPS3VNeNTXpUE5Hu0Z0v4MPiXoULJP6KV/eLtx/5eZg5BzAbOIQKxd8lcT9id5AXCF7jNQwnPi/c8IpZbXk1gNjToyK6moqaMxFULLf8oVtsLaRjV60FmeC2sKfrX94j34KudLlfQc5biaxklf+l/WJLA031Z3JCVl/ixVtCmycuy9eDkw0n4e5nyy4ne1l8OMQewj63x/nHaAUKgXpxwQDTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from CO6PR11MB5602.namprd11.prod.outlook.com (2603:10b6:303:13a::5)
 by CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Mon, 18 Oct
 2021 03:18:33 +0000
Received: from CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::98c4:c603:2360:7b8b]) by CO6PR11MB5602.namprd11.prod.outlook.com
 ([fe80::98c4:c603:2360:7b8b%7]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 03:18:32 +0000
Subject: Re: [bitbake-devel][PATCH] fetch2: fix downloadfilename issue with
 premirror
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        bitbake-devel@lists.openembedded.org, weaverjs@gmail.com
References: <20211015061753.70640-1-Qi.Chen@windriver.com>
 <582824039f6ac8e11b9a5ff91256ee591372c1ec.camel@linuxfoundation.org>
From: ChenQi <Qi.Chen@windriver.com>
Message-ID: <31821a69-ea42-b5b1-de7b-2adf0b71223d@windriver.com>
Date: Mon, 18 Oct 2021 11:31:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
In-Reply-To: 
 <582824039f6ac8e11b9a5ff91256ee591372c1ec.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HK2PR02CA0182.apcprd02.prod.outlook.com
 (2603:1096:201:21::18) To CO6PR11MB5602.namprd11.prod.outlook.com
 (2603:10b6:303:13a::5)
MIME-Version: 1.0
Received: from [128.224.162.158] (60.247.85.82) by
 HK2PR02CA0182.apcprd02.prod.outlook.com (2603:1096:201:21::18) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.20.4608.15 via Frontend
 Transport; Mon, 18 Oct 2021 03:18:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: adcf6871-7711-4ed7-45ad-08d991e5f6f3
X-MS-TrafficTypeDiagnostic: CO6PR11MB5635:
X-Microsoft-Antispam-PRVS: 
	<CO6PR11MB5635B31235719ACCA4F58102EDBC9@CO6PR11MB5635.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WPdukwX+5G4Q2ObW76Xx5Su0sV1d7azGSfJX82V6PbE0piChrSl6rahm/fH5MS2xQA80PhB3z8vVvsHjvOdI5dkxnJ/QaybhIkydSG3vHaQ1+nc9vWaOaM3C3kzlxYmAE3mF1hosLgLbs4RCupbIw/2hsH1xH2DvSm+JpqnNuLdNkmENrzQSaCBZxMtnYftWoIgSOshhwQuEcpBaN8INwBZiXppKs+LLbTQF02VkW95f5yFw3DtKulo0UWPuWT+wTTMGVYFhnycVMfdttbqYya2b9RxUyqp0DTUcVPmfmjHF/eTGOl1qwXvaeRZzIPcPILM1aIWVELQpuy7NvbKe819DgdNKT4nBin8C6N9sQ5to5vi4tGx0BpO32lWs2X/iUUi/i/yDVhGpub9Hf4qe7qY0dXaSy7P5HhqtQt3zsHKtbY2yRUTqvRuaYAGhMF5b93IJk1MzlK61NfBFJR3GD1Gs28OvqzGkC8jeOvQMWklnTeBarNtqsEKmnS4nNEVzwzfe+bcbme1klxaprPColpi7oT70YwUQeh5K/ZHjMhXwJ4e8SHQDoqdy29/MyL35mWgpd6AWm6aDqwi5CaFfxFZQjfb9BYj4y7FBgQiVVCXR5wWILyiu2EFsR/GIVAAWND6X2egYu6QVzowiBDO+5q/SZf3NkLFQgqsN7HNaiBv9TZIj4vosTAgi25reYViQHBH/MUt+BEQvNizsSDK3WI6rXrYZS5Uy2JzcunOflAyfrcoeAYyRBxa8Gm5gLCFj1coWZ3eM9jdA/9TSE+l112uvx/J4QUzBL0dOufbWiU6//OBBAH89kuGWPgua8c7Jnpo1O0cbYPGye5bc1urDbS5Tt5dmxJ1jbTC4NgK5cRCY+HxnwWDrAbDDGgrFLzBWVmQfD+MoEYoXIy/q/AhBZZsgz28uXXPL6IKITaJLq/o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5602.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2616005)(956004)(2906002)(16576012)(6706004)(316002)(8936002)(6486002)(5660300002)(31686004)(4001150100001)(83380400001)(52116002)(186003)(53546011)(66556008)(26005)(6666004)(86362001)(38350700002)(66946007)(38100700002)(8676002)(31696002)(966005)(508600001)(66476007)(36756003)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?U3BiZzVZRXZ4eEluVk15N0ozQi8wSFpNTFV0eStkc0pudVAzNjQ5S3AzaUtm?=
 =?utf-8?B?QVBOdStqRVMyaTdMYTY2UHpqd0I3Wi8yUVo1WDVBUGRmek1PdEhDSTg5NURD?=
 =?utf-8?B?cGFRVHREN21sRFY4M0dKbVk0NjE0TkdBMVFpZGl4L2djRTFxS0daVUxRM3k3?=
 =?utf-8?B?emlzSnp2MXhHcFBQMUJnTUhuMFg0SjVqcE4xTWNnRWtvcUl1Tjk5dFJCdnFP?=
 =?utf-8?B?dkJvT2hoaFR4bjVTYUlHR0xoZCtJeFR2bUgxNis5cnVGaHM5SE9STTlXMjZt?=
 =?utf-8?B?dDBGUENHLzdKUG1ocjQ3c2U0UXZlT2Jpbk4yU2p2OTFFOFJ1czFUQWVwNVZ5?=
 =?utf-8?B?dHd3YzdCQjlvV3dJQStMVzdHOHdVbHhDd1Ayc0wyVGJMMjZiVHRORVlyb0pU?=
 =?utf-8?B?bk1mdVA1dVRqRzdCM2lPZXI4RXp2bmxXcGdGY1NHUkxQV3ArenlkcHd4dlll?=
 =?utf-8?B?aHNSbHpmNzF3dmkveTZkMUVoalFHR3JOSDlxTUFxSE9IeEgwOVhSUm8xbnUw?=
 =?utf-8?B?amVzSmE2V25Oa1FvZ2prWGxnc0Fta3VQczFldG1XTTZwak1UZWV5MWNRZkwy?=
 =?utf-8?B?Zmp6THpxVjVYeStHQ0s3ZGwyQTFrTjU2cGZ5NmNuTmFNNHRUTUJnWGpnL2F6?=
 =?utf-8?B?WG9ZdkF6L1dDaHhNYW15cVdPQ092RGZ0VjdXQnhnSnNveGtkdWpyMmRZU0t0?=
 =?utf-8?B?Mkh0SFV5REtrcGJuSXcvOUZzQUNPTVZFNnZhakVvQy9iK0lzTUh6cncxdHdX?=
 =?utf-8?B?bVh1MFhUcEJ0aW9xVG5Gd09zTlg2TWhLTklNK1NtRHh6YkYvVXlEemlyQkow?=
 =?utf-8?B?ZnFsVk5DRnJJMDNRR0UxQVJYaTZ4NCtuK2dMT004VllJejhibDgyTk14ZWpB?=
 =?utf-8?B?RWVaUmFqaHJOckVGTWJselVrbHFjQlcwZDBJZkV3R1VNOVhCKzM4V3FacEJS?=
 =?utf-8?B?SnJ2elcwRktjWEZURXZBc21TTVFTNEJhZjROemZKdWFVMnJpR3pOZlhsMThO?=
 =?utf-8?B?K0FPZGZwL2N1OWpzMHlIQ0xSeFl6V2N1cHlCNUtEMTNhY0pIRElzaEpMQnNT?=
 =?utf-8?B?a1M4U2M1TGRUUzJuWm45N1ZFd1llQmhuVjdudmQ2bDZQeWFYWDBTeWRCbkxu?=
 =?utf-8?B?WUl5bWZiVGpLSkdNZ0dZdGFDa01nL01EMVc3cDg4b29lbm5vUlZnd3pnZWdQ?=
 =?utf-8?B?akM4NXhDUVBJNzMxM2UybnhiZzRYbW9PSUN1TW9uSjFvZUhJbXRVelRiSkJn?=
 =?utf-8?B?ZGUwL3o0ZitvbVI5czI5ZVNIOHFQcTQwa2czWFI0MlFPRnlxUm4zbVRQdDBj?=
 =?utf-8?B?enNOQVFPWklBdFp1c2tQWTVvdE5EUWl3RHdjUVdPWVZQNk9sSHZxNUpyUWU2?=
 =?utf-8?B?dXc1T2FWTWdvZXpRMFpDeE50TTY4eVhuVkZNY2pndi9ueTRUdExOekE5ZGJ6?=
 =?utf-8?B?WTJXZnN1b2ZLc1hteitXUUNYRHVFSFNYUzdnKzhDYVBNUWlyVlc3UjllbzBI?=
 =?utf-8?B?MUdEVEcrYk1Bd3dqUEtRRUdHOXRVOGZjZ0UwTHhhZkJ6eEQyYWJ5Vnp5ZVJD?=
 =?utf-8?B?M2s3cjBoVFNTZzlTTnVReVhkcmN1UkRNeENKVFpxWXd3ME1MRzE2YzQ2K1J5?=
 =?utf-8?B?ZDEwdW1rc09HZ0pjdGdobkIrWlVhTXh0eXpDZk5ZSXFVQmpXNmlHOTg4aTdp?=
 =?utf-8?B?cTR3aGNaaVkxRThRR2FPMVp5SnhyejcrV1VkeXl2eE9ESFVCdmJSRE5KMVVL?=
 =?utf-8?Q?XjiM9p9PDYVCElaWfW2BkH31TQA1CwrLOblt8FR?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 adcf6871-7711-4ed7-45ad-08d991e5f6f3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5602.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 03:18:32.7397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 WRtvFD6xDOmQcGbuN1dNnqBfJziw5V4MlkR9fwHMclXyt8+/2T7jmVpj48qcZ0zi2anGl9jb7/W8psxAqyOLww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5635
X-Proofpoint-GUID: wkiNWpF5R_Yz7BkM7fl3GP9unOMlEDI8
X-Proofpoint-ORIG-GUID: ZUEhuzWV0gqGtWWQJaQ_0Xs1njd3Sr3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-17_07,2021-10-14_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110180017
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Oct 2021 03:18:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12789

On 10/15/2021 07:35 PM, Richard Purdie wrote:
> On Thu, 2021-10-14 at 23:17 -0700, Chen Qi wrote:
>> The following commit to fix [Yocto #13039] causes regression of
>> the behavior of PREMIRRORS.
>>
>>    "bitbake: fetch2: fix premirror URI when downloadfilename defined"
>>
>> Take meta-openembedded/meta-networking/recipes-protocols/freediameter/freediameter_1.4.0.bb
>> as an example.
>> SRC_URI = "\
>>      http://www.freediameter.net/hg/${fd_pkgname}/archive/${PV}.tar.gz;downloadfilename=${fd_pkgname}-${PV}.tar.gz \
>>      ...
>> "
>> With the above commit, it now tries to fetch 1.4.0.tar.gz instead of
>> freeDiameter-1.4.0.tar.gz. This makes https://downloads.yoctoproject.org/mirror/sources
>> not work for freediameter, as it holds freeDiameter-1.4.0.tar.gz.
>>
>> The commit above tries to avoid fetching from invalid url such as:
>> https://<some_mirror>/1.4.0.tar.gz/freeDiameter-1.4.0.tar.gz.
>> And its solution is to make basename to be 1.4.0.tar.gz, thus causing the
>> regression.
>>
>> This patch fixes the above regression. For Yocto #13039, it now tries
>> to fetch from url: https://<some_mirror>/freeDiameter-1.4.0.tar.gz.
>>
>> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
>> ---
>>   lib/bb/fetch2/__init__.py | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/lib/bb/fetch2/__init__.py b/lib/bb/fetch2/__init__.py
>> index 666cc1306..000b49a50 100644
>> --- a/lib/bb/fetch2/__init__.py
>> +++ b/lib/bb/fetch2/__init__.py
>> @@ -466,9 +466,13 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
>>                       # Kill parameters, they make no sense for mirror tarballs
>>                       uri_decoded[5] = {}
>>                   elif ud.localpath and ud.method.supports_checksum(ud):
>> -                    basename = os.path.basename(uri_decoded[loc])
>> -                if basename and not result_decoded[loc].endswith(basename):
>> -                    result_decoded[loc] = os.path.join(result_decoded[loc], basename)
>> +                    basename = os.path.basename(ud.localpath)
>> +                if basename:
>> +                    uri_basename = os.path.basename(uri_decoded[loc])
>> +                    if basename != uri_basename and result_decoded[loc].endswith(uri_basename):
>> +                        result_decoded[loc] = result_decoded[loc].replace(uri_basename, basename)
>> +                    elif not result_decoded[loc].endswith(basename):
>> +                        result_decoded[loc] = os.path.join(result_decoded[loc], basename)
>>           else:
>>               return None
>>       result = encodeurl(result_decoded)
> I've been meaning to reply to this thread as the regression wasn't good. We need
> to be able to use DL_DIR as a mirror.
>
> Could we add another test case for this case so that this doesn't regress again
> please?

Yes. I'll do it.

Regards,
Qi

>
> Cheers,
>
> Richard
>
>
>
>


