Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44DF7C433F5
	for <webhook@archiver.kernel.org>; Thu, 20 Jan 2022 06:41:51 +0000 (UTC)
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com
 [205.220.166.238])
 by mx.groups.io with SMTP id smtpd.web08.8534.1642660909706035112
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 19 Jan 2022 22:41:49 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriver.com
 header.s=pps06212021 header.b=GqD4HPv4;
 spf=permerror,
 err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}:
 invalid domain name (domain: windriver.com, ip: 205.220.166.238,
 mailfrom: prvs=8019647b9b=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id
 20K6fnts018751
	for <bitbake-devel@lists.openembedded.org>; Wed, 19 Jan 2022 22:41:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
 h=subject : to : cc
 : references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=PPS06212021;
 bh=fCdGuSlizHPJbhX5kMfeMdPBFCLhWfPN471SY5KE02o=;
 b=GqD4HPv4YHdYL4slCOjZ4ufFwRbsRAVNEVReXwYlowCAN7FDmRc5So8yquYAcBOPENqV
 ttuTJgNFBVU76kWxnrn33Eoty+FaSpbpf6zQSbntfinkTo9GrbID9zIofo5r1jucv+dB
 J/98Z+65yfoEWvlbcWqj95lFJaR4L2lGeySR1v8FXW/ZqjyRb9QvnV5Z5K1B+g7/Ylfl
 l8bKQSNpuanq0JEVKTPPZr9wWwpNKx0McdPie9PSpCqrUfrR5mdRrvsCAT9ooTC76wmS
 qMRToSjG9OLCN34dpi+KmERS8a8KLkNDKpS0d+aclVuA7EQk0SqTgU4CqSJ4+QtF6PLG Cg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3dppj80djd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 19 Jan 2022 22:41:49 -0800
Received: from m0250810.ppops.net (m0250810.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 20K6fmng018742
	for <bitbake-devel@lists.openembedded.org>; Wed, 19 Jan 2022 22:41:48 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3dppj80djb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jan 2022 22:41:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJI30y2JZeBH5E5NMi09JkRAJ5uRtXuqTCu9Lv+qbscJiQPQgnnhII2+B3uKcgTeE25drX3VLwsahmoV7RtYXvUvEzMz8m1x9Gr/E6++emPni4Kty8w03FHnY0lfBgeZC4o8Nsbv6WgFiSzKrU0LLFtesNxmLLPUNZdmtsySqXGi+h+HpiD5RQMggAF36rQLFXwW4Ya4If4cQ6GkaHyCafb7xqsQHAWO1gY83HAXfpxes2HRl4ApHMqYcvbPFaFp1kTcq2pslUYfHZKiqqhFDJ4G9yLI8WwCgYuCV1FWEkEm+CUuTi/8D4v4qIzu4FgSiPcsoiT76c6grJKvNYIZhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCdGuSlizHPJbhX5kMfeMdPBFCLhWfPN471SY5KE02o=;
 b=QxT7Ne3R+INNSmP8VJMSXVwN5fpzhdiaC5e/Rh1Lt0LiGIkqH15OEAGBZwLa31Wuf2b3n3pE6yuiHkWBIyTAG58IqTqJgNOSktooSUDaG0Go29JDmj1ERogZlvr+rY7AVrrXITGLk1dG0aKTAUtoQqw5c/FCLMAK4uwZg16tOM6LarUmw48h1/NnMMQ9f58OjODOtANiCZlrri9wbgw8zjGDkF9fsFH/3PA5MZxWrF0zkYCct+BVr4akBgmCC6VtFTpVKMHAwc79STDecFoUPrNYioxTABBglgqehxAB4JBwKmXG78xOueqJaIAslMolTDCgIddXEtvzkpjmW/O6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BYAPR11MB2789.namprd11.prod.outlook.com (2603:10b6:a02:cc::11)
 by BN0PR11MB5758.namprd11.prod.outlook.com (2603:10b6:408:166::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Thu, 20 Jan
 2022 06:41:44 +0000
Received: from BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5cb5:e426:2e48:17ed]) by BYAPR11MB2789.namprd11.prod.outlook.com
 ([fe80::5cb5:e426:2e48:17ed%5]) with mapi id 15.20.4909.010; Thu, 20 Jan 2022
 06:41:44 +0000
Subject: Re: [bitbake-devel] [PATCH 2/2] bitbake-worker: Add/support network
 task flag
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
        Jose Quaresma <quaresma.jose@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
References: <20220107231526.1517563-1-richard.purdie@linuxfoundation.org>
 <20220107231526.1517563-2-richard.purdie@linuxfoundation.org>
 <CANPvuRkZj_WKgLzUE8vu-15e8RMXWqLwg=5B3SzYeDhdkj+COw@mail.gmail.com>
 <34c5a34a48c54376f5a181a0c836ddc2be1c1735.camel@linuxfoundation.org>
From: Robert Yang <liezhi.yang@windriver.com>
Message-ID: <2d8f22ad-3706-cd13-0dcb-9924b0eddf9f@windriver.com>
Date: Thu, 20 Jan 2022 14:41:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: 
 <34c5a34a48c54376f5a181a0c836ddc2be1c1735.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-ClientProxiedBy: HK2PR02CA0156.apcprd02.prod.outlook.com
 (2603:1096:201:1f::16) To BYAPR11MB2789.namprd11.prod.outlook.com
 (2603:10b6:a02:cc::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1da40105-f635-4e06-c7f8-08d9dbdfec81
X-MS-TrafficTypeDiagnostic: BN0PR11MB5758:EE_
X-Microsoft-Antispam-PRVS: 
	<BN0PR11MB57588FA479270DC6B26A7B54FF5A9@BN0PR11MB5758.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HKItwy31U9z2KGce7H3CdcA7J+GsUiKVAIAmf00ouqRapwymPCtCDKllrJqZxDbmidrsySvNu3pU3cg//9zbfnJIM1m7JbDo8veB2RRNOVJU3pU9wyLa6keGbnoTV6p8zYvlc8pjenlJ9jkpcvsn6OIGtxmUWsao3wU79U387o/RoiRza9TdFAxBVyB2NkOSN/MzzGvKpbfCOs+LENeLWKy9PXNGeoWEc6wJruY9c3HMvoIjwwKM9lVmYZTlDvlq2DKyvETnGZFOHNr6l+jh4v2S/K2UGf3DQlan7uXv2ovExwhm8aAzxp7/m/riehMdY74LI05xnCWwl9tcK8ydCvi52crB7LMcIV6Rp5z44t+E1XK7daq7NOkrl3rY8sdGd/iiGwTWChqTAvE/r9NbuedlR0Jd35jud8f1Dr8XwAmQxIdfghe46M159XiuiWZz/FJ169zHDsVnGxpd97by7Dfs6PDWmFaFvtCqlJuFpqLCNTSCsDhsWmjWg54NeZjLfomgTcRYzusLhdSltoOxUDNcL2AnKkY3hnh2QTb84CdaAHgqsrOWzABYDHD0c9+6IUjqyR4WqoGzmSi76A8mymXEnQOOiwBK955IOoRqLAdYESrVzbKGcx2NpQKgf0jHfudBvHzt2KL9Msk5ToQ2MOF5Epp9VKpE1qZOCKrGX5086UWEqPzKRNTB8L8sQjLKaRF/qn14QKZ5Yb47kwKutnCYA/55M1tSlRBUZwJK8YanxKWaL9X+bttrAODx8NbAJrchIZYNUnbMqIBBe3shEQFEbYsrwjSFyk7+5pJR4ndqkqeOXXCXDOTDD5vn4MWZAMRfwB2ivYThmiWKX1ljO3Sz0PUmQJbqEepFpr6sEOL2VpfJGNaBV7rUDT7mnr1f
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2789.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(26005)(5660300002)(83380400001)(110136005)(31696002)(8676002)(31686004)(66476007)(6666004)(52116002)(508600001)(38350700002)(8936002)(6486002)(66556008)(66946007)(6506007)(4326008)(966005)(6512007)(86362001)(2906002)(2616005)(186003)(38100700002)(36756003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bGlKQlV2N2RVNnJFRXdLUnNLSXJJaDdZalEwaVFWZE5pNi9GakQ2SWNENVZm?=
 =?utf-8?B?ZXBwcytyY0xjSkxTRGgySmRYcElRc2tnUXRXZVprOXlGNzUvSVZQcXhrd1No?=
 =?utf-8?B?Y3lRUHljSWxqUU9jbnp0RVNXekVkOEtFUUptQ1IzNWMvLzZLdTZ3K3pQZXFQ?=
 =?utf-8?B?WFJzaEdhQUlpRVBJRUVkMG1XZUhZNmY0TW16dnRsQ0EvK3YwRTdEYWVQRWQ3?=
 =?utf-8?B?RDRUN0tlQmNaUlBsblpXL3pHaTdDMXFrbzhVWTFYM01QdlN5ekkxRzRKSTMz?=
 =?utf-8?B?MklveE9xZGlwMTY1K0ZtaWRpZ1RHSDBhN3QybWJXTjhIRUxMNit2YlNGSHFZ?=
 =?utf-8?B?aUhzN1NGN1o5b3c5cUR4TG9YR2NQUWorYzNlSDJmSHVzb0dnamlQSGtZdWxO?=
 =?utf-8?B?OEVuU3k3ZXdwRWMxVEZ1S2tVRHBqOFY3S3V4bHZEVVZFY0cyRTZmVDFZdlpZ?=
 =?utf-8?B?WUQ3dkxZVHNhSHV2U2pjejZIcnpEeGFJSjhvbktCL2pOYU1FYUFDamsrazR6?=
 =?utf-8?B?UVEzTmc5aittT3VmdXphdjltdGFnalZtMkl2YVNsL2JKNDdSNTBSMGJNc0tt?=
 =?utf-8?B?L2MrSkVYZDBSdkpoek1sOUIvZ0dvZWVsYzM4SERORlpITUNTbWpneDlDNDZo?=
 =?utf-8?B?cDhOaXZjQzZUS0djbE95NVFUbklwTVpkR0tvaDBBYUUvRGsyM3BueUU1WTY2?=
 =?utf-8?B?RkVXaHJOMjBNdk1wREl3S3lLUytEZFdVdXpnaUdzSksrWFUxdklpODZWazV3?=
 =?utf-8?B?QnUyRVAvRE1namhSTFFtQmx0WE1wK0xHd2pUc3FIZ21FYml3TTl3YjcwZ1FM?=
 =?utf-8?B?cUI3WloxV0ZGMnpWTTc4eS9tK1ZubjJ2akpEUnZRaGRnczZkWUFJeDNlcHV4?=
 =?utf-8?B?aUl4K1cvclNYNmxRRlFuNXZ4Y05tREdxNUw4OFk0dnZlOUV4aWdOSjN2VzZF?=
 =?utf-8?B?U1JEVnJOdnpLSGp3Sm1UaXRUbVFWRG5qRVZ5MDRQNVlCc2YvcExOTzJWNG8y?=
 =?utf-8?B?b1paR0JTUmR6ZFRzZVlDdm1hVWxuQmoxbmFRajRrVlREaEUwbTR4SnZhY3Vu?=
 =?utf-8?B?Qk5LTmNSMWRVL2hhVkNTdlgyUk10T2hsYjYxUG1ZclJzeDc1eThBdjF1L2sy?=
 =?utf-8?B?T2paZFdmcS9IVmsrcFRUbWh6UmUwM3JVY3ZveStkWE9ZSS9tbkJLL3h2NDYv?=
 =?utf-8?B?Wi90MVdWcXNaWXdBeSt4K0JPL00vSzdNSU1Zc2lsWDZuZXFiVldncU1LZ2JP?=
 =?utf-8?B?ZEJTUDhSRFBrYzNWM1FaMGhONkJ0TkV0SXBOUm4vWTlPVDNReGtiMllsczlw?=
 =?utf-8?B?MFVvQkhIZzdUVHIwd3hRaDZFN0VlczRzSktRZmdWaUF5a1RUZCtjVENNRGU4?=
 =?utf-8?B?cHJxSlowY2cvQytKaWJKbVJTZWc2K2Y1eTc5YTZIUE5yL2lVZy9wRVc4c0F3?=
 =?utf-8?B?enhQMTNpZnVKQ3hZWnV6NFB5VEh6WS9QcE4yL20rR0FzV1cxY1ZQQVc5ai93?=
 =?utf-8?B?VGVOVnFkVWNwdDRWNzRabzNqL09nTGZTbGJ5YW9oM0VJRUtoYU82NHNaWWZH?=
 =?utf-8?B?RE5DYXZLS2hXT205SklzS0JjVWt1YXF0OG9LSzBkZEJLaTlWWWtQUkZQMUlE?=
 =?utf-8?B?VUZmV0NsandlYjRYRHRYNWI0RDFqTktRSUowNHNlbGI3SzUvYkNLTkdPMTlq?=
 =?utf-8?B?bnIwU2kzMUFTRW9MWGhzOWhFS3dPRTY5N2ZqKzcwZE00WEw1UXpET2ZnS21U?=
 =?utf-8?B?KzFyTEFKNjU5ZzhWdm9CT0NGZE15QWhJWEFmSXJJaDdNS28wRE5TVG5OQXJu?=
 =?utf-8?B?UEpBQWpEZXhqUmNLRnhJVEowL1UvcEFQdlJuVS9EYUF2YU43N0FYTnNrUWE5?=
 =?utf-8?B?WXFqNG5OK2twdjllMXJ4cVlkVTQxRGhQOGZhTnF6SUZjSXRCYWhlNld0Sith?=
 =?utf-8?B?dGNqZVJZZWdNU0FIcEMvWENJSkNmeVVxWXdoMW5yYmxCaFFhVVR6bk5qQzBI?=
 =?utf-8?B?a2xuQ0xDdTlBSmJFWjg3aFFqblZWUHVlaE0xZEx0bnZIWGd3MlpsejJGVWFK?=
 =?utf-8?B?UHVyZFhjZ0RlSTYra2xhYzIxT08wRXdYYm91WVkzRVRoZXJmYVZranQ5eUdB?=
 =?utf-8?B?dDV0aUc3V0FVSHdjaGdSd2E2RzdjMVNZMjFaQkVRdDNWNTUyeWIxYW4zOXZo?=
 =?utf-8?B?c3NJaXpuQ2RmVlJZbXhkWWNBQXBVRS92UXZ2SmxlVXFUKzNIMHVSdGRQSjlv?=
 =?utf-8?B?M2NkYmhuU2drT05HdldFaFl6SVFBPT0=?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 1da40105-f635-4e06-c7f8-08d9dbdfec81
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2789.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2022 06:41:44.6441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 e1MG1IMq4DvNAdQDWwiUFurm5jagCM0kp5zz/puX4qHANvDqmgES0N8VJRj37skrMl+htucwA6Xh6WBaAchN3BTO75vU7QR0PfeFOlfRqXk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR11MB5758
X-Proofpoint-ORIG-GUID: Qq4l9NR9GuhJD_fHIu6af8x1QJgmgAV9
X-Proofpoint-GUID: EUjCCjzEaEj3aJIrSrVb15CPR07cPkrG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-20_02,2022-01-19_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 spamscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201200032
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by
 mx0a-0064b401.pphosted.com id 20K6fnts018751
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 20 Jan 2022 06:41:51 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13251



On 1/20/22 7:27 AM, Richard Purdie wrote:
> On Wed, 2022-01-19 at 23:16 +0000, Jose Quaresma wrote:
>> Unfortunately this patch breaks the usage of the icecc.bbclass.
>>
>> Currently I build with icecc inside a container with network isolation=
 and
>> my icecc demon=C2=A0runs outside of the container.
>> The only thing I need to do for using the icecc inside my build contai=
ner is
>> mounting the unix /var/run/icecc/iceccd.socket inside the container.
>>
>> I think that we need something like this functionality to have access=C2=
=A0to
>> some sockets connections=C2=A0inside the tasks with the new namespace.
>=20
> I'm open to proposals but the unshare functionality is limited so I sus=
pect we
> can't just allow/disallow specific sockets unfortunately. We may just n=
eed the
> global "allow" flag for the reasons Robert mentioned which would also w=
ork here,
> at the code of not showing up other network accesses.

I will send 2 patches to make we can global allow network accesses, one i=
s for
bitbake, the other one for oe-core.

// Robert

>=20
> Cheers,
>=20
> Richard
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13249): https://lists.openembedded.org/g/bitbake-de=
vel/message/13249
> Mute This Topic: https://lists.openembedded.org/mt/88273738/3616940
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [liez=
hi.yang@windriver.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

