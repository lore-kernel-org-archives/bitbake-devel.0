Return-Path: <randy.macleod@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA879C7EE23
	for <webhook@archiver.kernel.org>; Thu,  8 Jun 2023 13:25:29 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.8841.1686230722173558564
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Jun 2023 06:25:22 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriver.com header.s=pps06212021 header.b=lzUDzwOm;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=55233c9957=randy.macleod@windriver.com)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 358CAFK9027408;
	Thu, 8 Jun 2023 13:25:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=content-type :
 message-id : date : subject : to : cc : references : from : in-reply-to :
 mime-version; s=PPS06212021;
 bh=n5wf4wQSkxvUenzWxFx9F5e1L1GzaoTHGWobZ0AcVGk=;
 b=lzUDzwOmJLCOKO6LJ9Vog71Uy3QaEg1P1WLZxTKTA0fhK7QdpQTAyoMtMEsRKrjRyDU+
 x9uwXbNV/mwdukCUjFI4tsTgZZwzcFyreYOyhVzmcnu57zG4PqpolAupjsGXHSdKOqcn
 ngy8dag8i5rYwgOHxF2GecDlYMP3cf8RAFCNTr9hoIz0dxDrMeyrGxSTEmuSwDeJEjf7
 Kb0iFQpKkZrV9GMD+3DZpDq0ZrMv478xml/M0mc+5ymG1ySdtD6QIVr9g2GRpQrSOr5S
 hlmsLVP+VEzWU1Gr0ko11k971EIMU/3E5rr/Jee1O/I4Bedc7BdrUkm1xG4gbYbMNyvE Ww== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r2avq1qk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jun 2023 13:25:21 +0000
Received: from m0250811.ppops.net (m0250811.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 358DPK5F020914;
	Thu, 8 Jun 2023 13:25:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3r2avq1qk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Jun 2023 13:25:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AW4IKRtKRPK4Y63SBtUWdhgHcSz+WuLd0TX6/Y+O5RgMZbe8jrHcDuWE8NCFJu7G/PFL3Hh8BoVZoalxbnb8R13VkGnjevVuEEmSbFVmy6E0YzHvU/cn2bj6lHoO05EHljQ8Zx3x9KSjtzZoteS4bW7QYJyn47FLtd/kpaJk8HgM2/DpXIVDtWMpP/PcvYsmjf8L4gx1LYU8/5BphnRq6WwN6gQj06rHGnX1MD9CzIHr9dfahHeZUkZepvw5IeHIvAzbPIvvlzkzr5dhIYP4dQuVhgfj8SY8JPOAxz9c5hrUiwc/8AMJyipEOOUt6LMicRrPAk09V3LRcARjFxtFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5wf4wQSkxvUenzWxFx9F5e1L1GzaoTHGWobZ0AcVGk=;
 b=UtxR2nYjfEx4Zoq/Ywz3+FP/BzlN7NYiV/znMqg7ylppaisY8I1MmR8bAzXi8B27HKGb1HGCpo5F9M6YlWaL28wYeCrTXh8pxXc2dbRgmtFQqu6/4Z79pyIJ2ldJeubDeA+TVJU3sRbCZLAEJAqe/qTG8lINztfEVcqBuCnsrQQaxLS+GR6nsw9mSAEJIa5rlA/YQifFCNmZL8I9AaAty2Jaf1pTmtPp/pq/0IkxAXTzenyOXu4tZG6XpkB321HClCE3i7WgQ17Tcv+Xa5RbV093lK6FrMgLBN3q0S6J2KCr8SICVCNrHMQ6Hh//oWz56A5wmZBUeIp8aKzR0FVBhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB3994.namprd11.prod.outlook.com (2603:10b6:5:193::19)
 by CY5PR11MB6187.namprd11.prod.outlook.com (2603:10b6:930:25::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.39; Thu, 8 Jun
 2023 13:25:19 +0000
Received: from DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::5a4c:c35b:8704:34d5]) by DM6PR11MB3994.namprd11.prod.outlook.com
 ([fe80::5a4c:c35b:8704:34d5%3]) with mapi id 15.20.6455.037; Thu, 8 Jun 2023
 13:25:19 +0000
Content-Type: multipart/alternative;
 boundary="------------fSOb3wMs9FYlo0Kv0uklOfrz"
Message-ID: <b3ca0397-a7b7-f22e-6543-ce5163858e0e@windriver.com>
Date: Thu, 8 Jun 2023 09:25:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [bitbake-devel][PATCH V2] runqueue.py: fix PSI check logic
Content-Language: en-CA
To: Ola x Nilsson <ola.x.nilsson@axis.com>
Cc: Qi.Chen@windriver.com,
        "Randy MacLeod via lists.openembedded.org"
 <randy.macleod=windriver.com@lists.openembedded.org>,
        bitbake-devel@lists.openembedded.org
References: <20230523020905.2911543-1-Qi.Chen@windriver.com>
 <a963a98b-0420-5785-b393-306ebbf6f230@windriver.com>
 <jwqilcg4ydl.fsf@axis.com>
From: Randy MacLeod <randy.macleod@windriver.com>
In-Reply-To: <jwqilcg4ydl.fsf@axis.com>
X-ClientProxiedBy: BY5PR03CA0025.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::35) To DM6PR11MB3994.namprd11.prod.outlook.com
 (2603:10b6:5:193::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3994:EE_|CY5PR11MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: b9932f9d-06ee-46bb-e438-08db6823cdb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	oT3fWqbruXDiom03vC4s4/RXUXRXFJcTZMJ6Ho3HWuL/zRCHoKuZRS0AdUx1uzw3hXepLnbBhtHp80GZ1aelIEE855ULOnyaCkquCRK0eJdeubSon8zW+143YCS0quSjQXCvYc9jcVCiJwiWurvdZwOzM7RxqNSGXO/yJDzg/I7DJ5aGCL512cFY2fimGDhDeO9b0MFcPN9jESS/YEaz7UNemjQ1nBI5ROwHuOMGFW+qolI9nCWrYU3NSvE69lhvioycaV8H5fqr1TPdW9QT4w/klC6+iWJteeUotKQtXXbBNafLzMxzZ61wv+v9O0Xio+ikb12h/BF+2FTW98jOQVjUf4KgDMISKp8ifyTuTzfU2y/z2IkBRUWVdC70geiw0gkEnuSPnvFXfWs0+9GnQFmX9GxPaa6BKCfgO9R5N+1xv6ibZ8aDA7dwb5qzy30W2sEoyOG58isjT/ahpKxDPyZWvm0d/4E8HEOS0VTD4s5kqAyP6zKixfNSpmk9ZQQ9OxmoHoClzhxEDNhpjuAiLPshVIXsvieZ0vG0msQPWEtTCUZgZPcPkRWAiOIXNnmhV2MARAU+Lk4vQSv0KpB4zG7JQuIgDEd/D06/AeA/ovlPSDhZjUhFH+wPy9e1thwuQt3dHBA0DV3+z+nw2o9pYw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3994.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39840400004)(366004)(376002)(396003)(346002)(136003)(451199021)(83380400001)(478600001)(8676002)(8936002)(41300700001)(316002)(66946007)(66476007)(66556008)(31696002)(4326008)(5660300002)(38100700002)(6916009)(86362001)(6486002)(36756003)(6666004)(33964004)(2906002)(30864003)(186003)(26005)(6506007)(53546011)(6512007)(31686004)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TXJINTRNR2R6aEw0bzZaVC90bktPNkRJMy9LOGd4SHdtSzQ1cEZRQk5XcWZ3?=
 =?utf-8?B?L28rTUFxeERDVjNBNStZeVJoK2hpNUV6Z2wvV0FIUkFGWjhzenBHZ0U1cEM0?=
 =?utf-8?B?ZnptRWNackhrdEd1cml2cTdmMlpXZTU0b285V2tQRldPQkYvNUM1TFNpWXkw?=
 =?utf-8?B?ODBBankyRk5Ia25IN21Ceko3RFRWWGwwYitaOU5jdEhkUnh5RHB3dFdBaS9E?=
 =?utf-8?B?UUxubG9FWWEwb2RJV2xNQjVkVE5ZL2djeEZDK1dkRE9kRXlPa3pPM1phdyta?=
 =?utf-8?B?SWNqTDY0a2tqbnZXMkVPaE1DcG15KzRkWFFnNmg5MUVVdGVGeFVlYS9sQVVI?=
 =?utf-8?B?cmZWZVFCZkFucXNiYXgyQnovWEFlYUN4b01CSk5vdWVXRWQvWklRNzQ0QkRJ?=
 =?utf-8?B?L25Vc24wWG96cFpjbklwaVNhNk9Ld01hNjgyUDd0Sk1KdmplemwvSGNBVldM?=
 =?utf-8?B?U2wrK2ZsekdGVyt4S2Q0UW94SjFORUZ4YmIxOG84M2Rxbm1IYVJvTGMrei9t?=
 =?utf-8?B?NnJ0aEZRajhoMnhaNjhrclFyb1pBL3NGanZqVHZtYkd5VEQ2cGNOZm85QnFm?=
 =?utf-8?B?ajI3ay9vb3RCaEY5cGJVQ2R0djlyRmdkTjBIYVgrUHBkR0F6cEdKdThjNmZv?=
 =?utf-8?B?UHVhNFFaRGlxS1ZScVFGSW1YZ1JTbVZvcXJxQVhsdnI1Uk5Fc1N0ZXozVDkz?=
 =?utf-8?B?a3ZoeHc1M0NrRUFSb21kZUxYdHFQMmttNUNyU3VjV2MzeE5RdnZkeVN0ekpz?=
 =?utf-8?B?VFE5QXlLaVN2MllBaUZ0aURHZ1kyRTJ1NFVtZEVPVkZrU2xkWE12djNvSVBH?=
 =?utf-8?B?c09xdkozUE0xNGx0VnBHa2VXVk1yUklMQmRtTWpPV0I0ZE9vVE1OZUFPZ292?=
 =?utf-8?B?YkxNaVNTdEhka2kwc2U5VWlLckRnTVZHNG9uSUJxc2w5bGR6YUd5RHB0SlNi?=
 =?utf-8?B?RG9LNnNmc08rTmZLL0ZZWlEyNUg5RGREK0kyakQxcmFmMDRkZkFkQlBWU01W?=
 =?utf-8?B?MUZ0OTF3SWVIeGF0blo3dENlSWpUaEx6eGdEc2Z1eFV5aVNrRlFBMVoxMkg2?=
 =?utf-8?B?UTNXdWhnZ2FHcFRXZDZDQUdrZ1JCRCtQUG9ZcDBFSUcvL084NndvSmF4bTNY?=
 =?utf-8?B?N1BPWm0vWmxGYlN6TFA1VFZTVFhoN2I0OTYxeFZhZU9WWUhiaXVQUTFUZWdl?=
 =?utf-8?B?aGRQd2dsa0pGaUxPb1NmbHc0VVRLcFBqQUorSUg2bU9VdG1hcEo3WkFScHpZ?=
 =?utf-8?B?MnNLRlpLQzZXZEcvMFRIdWZIN0p3dEUwaW5acGlkb3dBbnVNcFZPSjVJdGQ2?=
 =?utf-8?B?MVFBSTdjazJHYi9LSlZmSHpHUWZmTTc2RC9va25aRjA4ZHNaYUhkWEZ0dTBz?=
 =?utf-8?B?YnRqeFVjak1GTHFQNVoyRDZIYUsrVkNLL1NobUVaMng0ZmZQSFQ4ZXNHNldB?=
 =?utf-8?B?WVdwOEpGMmppd1JPRHBid2xENGpLTmVqUVhySzkyNzY2YU55a0pESnJqcUtz?=
 =?utf-8?B?ZGl2S1hndHR2NTd4d3VhZnhxSXZRaTh2N3NOMGZkWmxHczMyWU9MRmRUeTFR?=
 =?utf-8?B?WDFHaHY1blE0d3JJM2d0V2k1OFA1b2tqYlpNZzRoRjlhOWFlN2pLaVB0R1Y0?=
 =?utf-8?B?Nm5YVTZZRm9oSXhWVWkyYzd1VmMyWEhkUmJFbjJQMkVUTkIvdFdIOEsvRlU1?=
 =?utf-8?B?VzVYc29yWHZYWlVWMk93bDQ0a0MxSENvWXd6R3hWNlVWME54Y0xwaHpTeGNV?=
 =?utf-8?B?bWdWYnE1SDNHWU5qNkhxN2hYZjhZU25jYWxjYlpRMkFBRmducEJrN3lSUU1U?=
 =?utf-8?B?ZkI2aFFXTWNQRXdZVnc0N3RoZkJpaDlLTWw1Tit2U3RMUWRtRU4zbk1heWYx?=
 =?utf-8?B?cm1QZFZGdURNc2tSL1h1aGMrckFWdk85bE1MN3luRzd5clc4bFhMVnhaMXB3?=
 =?utf-8?B?K2ZGTXJzbElzN0k2Q3hsNk9EYlN0Tis3UXhjdXBRMlBTOWFZSG1QdmNrRjcv?=
 =?utf-8?B?b3dTQ0ZhdU16UEk1NTdHRlNuWWlla0JwdVJRRmx4b3Zjczh4RWV3NUg2Qlcy?=
 =?utf-8?B?Uys0S1l6Qk9ZbTNWcFNBOVhqZFZQcFdNaHNLN3lUWkRDeG50emtpdGFUb1RM?=
 =?utf-8?B?a1h5eGRPazg0WHg4eEphcllCYkR2ekRIT0poSEpKSVpQdXlHdXJYemVMS2R0?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9932f9d-06ee-46bb-e438-08db6823cdb5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3994.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2023 13:25:18.9501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SWV5qlkNlqpRwaT3fn+0sP8tcVsevvPGVU4zFtDz9F7ususdaZ0A3uUydE66NxCbo+AMhEPn/TVPFEDB0eZJGST1w3/UDDmWtxx+1eYWcR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6187
X-Proofpoint-GUID: rRBV_tJHol-BjjuE09es3jCmvmGSyWlK
X-Proofpoint-ORIG-GUID: khskUM5dVbQbAzxXENkvu3ZjALUAD0Vx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_09,2023-06-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306080116
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Jun 2023 13:25:29 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14835

--------------fSOb3wMs9FYlo0Kv0uklOfrz
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 358CAFK9027408

On 2023-05-25 04:17, Ola x Nilsson wrote:
> On Tue, May 23 2023, Randy MacLeod via lists.openembedded.org wrote:
>
>> On 2023-05-22 22:09,Qi.Chen@windriver.com  wrote:
>>> From: Chen Qi<Qi.Chen@windriver.com>
>>>
>>> The current logic is not correct because if the time interval
>>> between the current check and the last check is very small, the PSI
>>> checker is not likely to block things even if the system is heavy
>>> loaded.
>>>
>>> It's not good to calculate the value too often. So we change to a 1s
>>> check. As a build will usually take at least minutes, using the 1s va=
lue
>>> seems reasonable.
>> I don't have time to check today but I'm not convinced that this is tr=
ue.
>>
>> I suspect that in the typical case, it would be okay but there will be
>> workloads (perhaps rare workloads) where you want to check more often.
>>
>> The 1 second intervals where we no longer launch new work may
>> result in a significantly longer build. IIRC, our benchmark was buildi=
ng
>> core-image-minimal on a 24 core system without PSI regulation and then
>> with it set to 300. I'd look at the elapsed time and the
>> buildchart/bootchart:
>>  =C2=A0=C2=A0 scripts/pybootchartgui/README.pybootchart
>>
>> Ola, have you been able to test this and if not, can you?
>>
> This patch is identical to the V1 except for the commit message, so I
> consider it
>
> Tested-By: Ola Nilsson<ola.x.nilsson@axis.com>
>
> /Ola

Richard and Alex were waiting to merge this but I think we need
some indicating that this produces a better outcome than before the patch.

I've pencilled in some time on next Tuesday to do that but
we're working on a release so higher priority work may interfere.

Qi and I will get to this eventually and reply here or with a new patch.

../Randy



>
>> All for today.
>>
>> ../Randy
>>
>>
>>> Signed-off-by: Chen Qi<Qi.Chen@windriver.com>
>>> ---
>>>    bitbake/lib/bb/runqueue.py | 29 ++++++++++++++---------------
>>>    1 file changed, 14 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
>>> index 02f1474540..4d49d25153 100644
>>> --- a/bitbake/lib/bb/runqueue.py
>>> +++ b/bitbake/lib/bb/runqueue.py
>>> @@ -179,6 +179,7 @@ class RunQueueScheduler(object):
>>>                        self.prev_memory_pressure =3D memory_pressure_=
fds.readline().split()[4].split("=3D")[1]
>>>                        self.prev_pressure_time =3D time.time()
>>>                    self.check_pressure =3D True
>>> +                self.psi_exceeded =3D False
>>>                except:
>>> bb.note("The /proc/pressure files can't be read. Continuing build
>> without monitoring pressure")
>>>                    self.check_pressure =3D False
>>> @@ -191,6 +192,10 @@ class RunQueueScheduler(object):
>>>            BB_PRESSURE_MAX_{CPU|IO|MEMORY} are set, return True if ab=
ove threshold.
>>>            """
>>>            if self.check_pressure:
>>> +            now =3D time.time()
>>> +            tdiff =3D now - self.prev_pressure_time
>>> +            if tdiff < 1.0:
>>> +                return self.psi_exceeded
>>>                with open("/proc/pressure/cpu") as cpu_pressure_fds, \
>>>                    open("/proc/pressure/io") as io_pressure_fds, \
>>>                    open("/proc/pressure/memory") as memory_pressure_f=
ds:
>>> @@ -198,21 +203,15 @@ class RunQueueScheduler(object):
>>>                    curr_cpu_pressure =3D cpu_pressure_fds.readline().=
split()[4].split("=3D")[1]
>>>                    curr_io_pressure =3D io_pressure_fds.readline().sp=
lit()[4].split("=3D")[1]
>>>                    curr_memory_pressure =3D memory_pressure_fds.readl=
ine().split()[4].split("=3D")[1]
>>> -                now =3D time.time()
>>> -                tdiff =3D now - self.prev_pressure_time
>>> -                if tdiff > 1.0:
>>> - exceeds_cpu_pressure =3D self.rq.max_cpu_pressure and
>> (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff >
>> self.rq.max_cpu_pressure
>>> - exceeds_io_pressure =3D self.rq.max_io_pressure and
>> (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff >
>> self.rq.max_io_pressure
>>> - exceeds_memory_pressure =3D self.rq.max_memory_pressure and
>> (float(curr_memory_pressure) - float(self.prev_memory_pressure)) /
>> tdiff > self.rq.max_memory_pressure
>>> -                    self.prev_cpu_pressure =3D curr_cpu_pressure
>>> -                    self.prev_io_pressure =3D curr_io_pressure
>>> -                    self.prev_memory_pressure =3D curr_memory_pressu=
re
>>> -                    self.prev_pressure_time =3D now
>>> -                else:
>>> - exceeds_cpu_pressure =3D self.rq.max_cpu_pressure and
>> (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) >
>> self.rq.max_cpu_pressure
>>> - exceeds_io_pressure =3D self.rq.max_io_pressure and
>> (float(curr_io_pressure) - float(self.prev_io_pressure)) >
>> self.rq.max_io_pressure
>>> - exceeds_memory_pressure =3D self.rq.max_memory_pressure and
>> (float(curr_memory_pressure) - float(self.prev_memory_pressure)) >
>> self.rq.max_memory_pressure
>>> -            return (exceeds_cpu_pressure or exceeds_io_pressure or e=
xceeds_memory_pressure)
>>> + exceeds_cpu_pressure =3D self.rq.max_cpu_pressure and
>> (float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff >
>> self.rq.max_cpu_pressure
>>> + exceeds_io_pressure =3D self.rq.max_io_pressure and
>> (float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff >
>> self.rq.max_io_pressure
>>> + exceeds_memory_pressure =3D self.rq.max_memory_pressure and
>> (float(curr_memory_pressure) - float(self.prev_memory_pressure)) /
>> tdiff > self.rq.max_memory_pressure
>>> +                self.prev_cpu_pressure =3D curr_cpu_pressure
>>> +                self.prev_io_pressure =3D curr_io_pressure
>>> +                self.prev_memory_pressure =3D curr_memory_pressure
>>> +                self.prev_pressure_time =3D now
>>> +                self.psi_exceeded =3D exceeds_cpu_pressure or exceed=
s_io_pressure or exceeds_memory_pressure
>>> +            return self.psi_exceeded
>>>            return False
>>>          def next_buildable_task(self):


--=20
# Randy MacLeod
# Wind River Linux

--------------fSOb3wMs9FYlo0Kv0uklOfrz
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <div class="moz-cite-prefix">On 2023-05-25 04:17, Ola x Nilsson
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:jwqilcg4ydl.fsf@axis.com">
      <pre class="moz-quote-pre" wrap="">On Tue, May 23 2023, Randy MacLeod via lists.openembedded.org wrote:

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">On 2023-05-22 22:09, <a class="moz-txt-link-abbreviated" href="mailto:Qi.Chen@windriver.com">Qi.Chen@windriver.com</a> wrote:
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">From: Chen Qi<a class="moz-txt-link-rfc2396E" href="mailto:Qi.Chen@windriver.com">&lt;Qi.Chen@windriver.com&gt;</a>

The current logic is not correct because if the time interval
between the current check and the last check is very small, the PSI
checker is not likely to block things even if the system is heavy
loaded.

It's not good to calculate the value too often. So we change to a 1s
check. As a build will usually take at least minutes, using the 1s value
seems reasonable.
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">I don't have time to check today but I'm not convinced that this is true.

I suspect that in the typical case, it would be okay but there will be
workloads (perhaps rare workloads) where you want to check more often.

The 1 second intervals where we no longer launch new work may
result in a significantly longer build. IIRC, our benchmark was building
core-image-minimal on a 24 core system without PSI regulation and then
with it set to 300. I'd look at the elapsed time and the
buildchart/bootchart:
&nbsp;&nbsp; scripts/pybootchartgui/README.pybootchart

Ola, have you been able to test this and if not, can you?

</pre>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">This patch is identical to the V1 except for the commit message, so I
consider it

Tested-By: Ola Nilsson <a class="moz-txt-link-rfc2396E" href="mailto:ola.x.nilsson@axis.com">&lt;ola.x.nilsson@axis.com&gt;</a>

/Ola</pre>
    </blockquote>
    <p>Richard and Alex were waiting to merge this but I think we need <br>
      some indicating that this produces a better outcome than before
      the patch.<br>
    </p>
    <p>I've pencilled in some time on next Tuesday to do that but<br>
      we're working on a release so higher priority work may interfere.</p>
    <p>Qi and I will get to this eventually and reply here or with a new
      patch.</p>
    <p>../Randy</p>
    <p><br>
    </p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:jwqilcg4ydl.fsf@axis.com">
      <pre class="moz-quote-pre" wrap="">

</pre>
      <blockquote type="cite">
        <pre class="moz-quote-pre" wrap="">All for today.

../Randy


</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">Signed-off-by: Chen Qi<a class="moz-txt-link-rfc2396E" href="mailto:Qi.Chen@windriver.com">&lt;Qi.Chen@windriver.com&gt;</a>
---
  bitbake/lib/bb/runqueue.py | 29 ++++++++++++++---------------
  1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
index 02f1474540..4d49d25153 100644
--- a/bitbake/lib/bb/runqueue.py
+++ b/bitbake/lib/bb/runqueue.py
@@ -179,6 +179,7 @@ class RunQueueScheduler(object):
                      self.prev_memory_pressure = memory_pressure_fds.readline().split()[4].split(&quot;=&quot;)[1]
                      self.prev_pressure_time = time.time()
                  self.check_pressure = True
+                self.psi_exceeded = False
              except:
bb.note(&quot;The /proc/pressure files can't be read. Continuing build
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">without monitoring pressure&quot;)
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">                  self.check_pressure = False
@@ -191,6 +192,10 @@ class RunQueueScheduler(object):
          BB_PRESSURE_MAX_{CPU|IO|MEMORY} are set, return True if above threshold.
          &quot;&quot;&quot;
          if self.check_pressure:
+            now = time.time()
+            tdiff = now - self.prev_pressure_time
+            if tdiff &lt; 1.0:
+                return self.psi_exceeded
              with open(&quot;/proc/pressure/cpu&quot;) as cpu_pressure_fds, \
                  open(&quot;/proc/pressure/io&quot;) as io_pressure_fds, \
                  open(&quot;/proc/pressure/memory&quot;) as memory_pressure_fds:
@@ -198,21 +203,15 @@ class RunQueueScheduler(object):
                  curr_cpu_pressure = cpu_pressure_fds.readline().split()[4].split(&quot;=&quot;)[1]
                  curr_io_pressure = io_pressure_fds.readline().split()[4].split(&quot;=&quot;)[1]
                  curr_memory_pressure = memory_pressure_fds.readline().split()[4].split(&quot;=&quot;)[1]
-                now = time.time()
-                tdiff = now - self.prev_pressure_time
-                if tdiff &gt; 1.0:
- exceeds_cpu_pressure = self.rq.max_cpu_pressure and
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">(float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff &gt;
self.rq.max_cpu_pressure
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">- exceeds_io_pressure = self.rq.max_io_pressure and
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">(float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff &gt;
self.rq.max_io_pressure
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">- exceeds_memory_pressure = self.rq.max_memory_pressure and
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">(float(curr_memory_pressure) - float(self.prev_memory_pressure)) /
tdiff &gt; self.rq.max_memory_pressure
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">-                    self.prev_cpu_pressure = curr_cpu_pressure
-                    self.prev_io_pressure = curr_io_pressure
-                    self.prev_memory_pressure = curr_memory_pressure
-                    self.prev_pressure_time = now
-                else:
- exceeds_cpu_pressure = self.rq.max_cpu_pressure and
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">(float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) &gt;
self.rq.max_cpu_pressure
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">- exceeds_io_pressure = self.rq.max_io_pressure and
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">(float(curr_io_pressure) - float(self.prev_io_pressure)) &gt;
self.rq.max_io_pressure
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">- exceeds_memory_pressure = self.rq.max_memory_pressure and
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">(float(curr_memory_pressure) - float(self.prev_memory_pressure)) &gt;
self.rq.max_memory_pressure
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">-            return (exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure)
+ exceeds_cpu_pressure = self.rq.max_cpu_pressure and
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">(float(curr_cpu_pressure) - float(self.prev_cpu_pressure)) / tdiff &gt;
self.rq.max_cpu_pressure
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">+ exceeds_io_pressure = self.rq.max_io_pressure and
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">(float(curr_io_pressure) - float(self.prev_io_pressure)) / tdiff &gt;
self.rq.max_io_pressure
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">+ exceeds_memory_pressure = self.rq.max_memory_pressure and
</pre>
        </blockquote>
        <pre class="moz-quote-pre" wrap="">(float(curr_memory_pressure) - float(self.prev_memory_pressure)) /
tdiff &gt; self.rq.max_memory_pressure
</pre>
        <blockquote type="cite">
          <pre class="moz-quote-pre" wrap="">+                self.prev_cpu_pressure = curr_cpu_pressure
+                self.prev_io_pressure = curr_io_pressure
+                self.prev_memory_pressure = curr_memory_pressure
+                self.prev_pressure_time = now
+                self.psi_exceeded = exceeds_cpu_pressure or exceeds_io_pressure or exceeds_memory_pressure
+            return self.psi_exceeded
          return False
        def next_buildable_task(self):
</pre>
        </blockquote>
      </blockquote>
      <pre class="moz-quote-pre" wrap="">
</pre>
    </blockquote>
    <p><br>
    </p>
    <pre class="moz-signature" cols="72">-- 
# Randy MacLeod
# Wind River Linux</pre>
  </body>
</html>

--------------fSOb3wMs9FYlo0Kv0uklOfrz--

