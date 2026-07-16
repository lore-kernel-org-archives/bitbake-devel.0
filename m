Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8BFC44511
	for <webhook@archiver.kernel.org>; Thu, 16 Jul 2026 16:16:43 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.15])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16325.1784217061273418052
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 16 Jul 2026 08:51:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@est.tech header.s=selector1 header.b=jwkaQvNr;
 spf=pass (domain: est.tech, ip: 52.101.84.15, mailfrom: david.nystrom@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aimJrHAY44jL3C3PAm1d4Ay2CDz3dOtRs6nkLBB13+RelThLt43/RKDHTa47IormuWM1KsqXmvLosoX7fe6+jqBl6fDWorxaxfnt+kAJaltq5B8mNj3mP3PrGZUCjFUmvBr2XNIfZC0zHxbtFBZyq1G2lDruXw/ynuVpQ+yy3Knx0T0/g3+54J6N4snlUdv4VdmRbJEp/E9NoMFmVgQWfEQyH993O3/oqxI6x1TBEiYIGCVCohPa7yOnabLLcZoVtEGJ1Jpoa93Y5JOyQMBiUouQHOQVMzqo8zC88QMTRB27NxiXIvzH0Re7/VpgjdPRukVJVyVteBtUZjY20oNLSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8luVAp9fhkTOJfJJXcbhyqzhQzBIWXEtnVsTBCH39qY=;
 b=BeGoHpx4EReB3N6ZmtBJ+ysX5Sw4QV9oO6xM5Lv9feyFoAlYQyNSoMF3T4errKV2RYp1MidQi2cloiEG4oUFu/xXVy75Jj+6DEXOkKMgFGEEUzPk9yYrB2LNrBH6P9RL+Hfov6OpeUAvGoydhgHFOaAbBHE+bBj2zLVJXRGG3Jc3yNlBWc09K9sVO/L3beLJ22c+XPbtVW3ry0MAMpjrumMKz6PKRpXn5+/YqFJQ8K/G3bZtqfa+LqiNT+dVEjjKVgTsFDrV3D8cmnxTOkrphBfJU0IxYAliSDQ7+/jof4qe+yvyaYQ5j0BQOAZxU/QrxV0Kv2bDYlcw9EUaC6hd3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8luVAp9fhkTOJfJJXcbhyqzhQzBIWXEtnVsTBCH39qY=;
 b=jwkaQvNrvDXeF21BXbPnbAnE4YVib7a++o9wmvSSCp0dSBxZhpyGTpbfvaKtl4ujsuxFKjKhqQ0zix1wprb6YzBWFs6FtOxZtnzfjTSzwds4pNq7ljR6K+ycuuyNnZeZ9/7qG62z70L4a09qSJFP7dHNS17NwFqO1AOvLHQarw0OlmhbXHRnAkdVPSWDdWWQDIAfotoODuidjIZ51kfOttp5cWKSSpFWEWTrC3F0sRslty2LO5M0MoLtlAWAueOivtD5ksYy0LWNyVlbwLOUulSsxcMcKfw7GxB/nIbq/kbcNx32saHLXyAo93IlrWwjfaPWieq1zg8KBq0+CBFOTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM (2603:10a6:b10:f3::19)
 by DB8P189MB0601.EURP189.PROD.OUTLOOK.COM (2603:10a6:10:126::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.4; Thu, 16 Jul
 2026 15:50:57 +0000
Received: from BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::49f:4bc1:672f:45c8]) by BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 ([fe80::49f:4bc1:672f:45c8%4]) with mapi id 15.21.0202.014; Thu, 16 Jul 2026
 15:50:57 +0000
Date: Thu, 16 Jul 2026 17:50:54 +0200 (CEST)
From: =?UTF-8?B?RGF2aWQgTnlzdHLDtm0=?= <david.nystrom@est.tech>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
cc: david.nystrom@est.tech, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH RFC 0/2] bitbake: Add basic landlock support
In-Reply-To: <a4ad8dcdef504155bebebe81125b68bb66692c2e.camel@linuxfoundation.org>
Message-ID: <9c697498-9771-31c3-667c-32a038e3d8ed@est.tech>
References: <20260612-landlock-v1-0-77891f63ed7f@est.tech> <a4ad8dcdef504155bebebe81125b68bb66692c2e.camel@linuxfoundation.org>
X-ClientProxiedBy: GVZP280CA0096.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:275::14) To BESP189MB3241.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:b10:f3::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BESP189MB3241:EE_|DB8P189MB0601:EE_
X-MS-Office365-Filtering-Correlation-Id: 397264b3-996f-46e7-36e6-08dee35206a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|1800799024|366016|11063799006|4143699003|18002099003|22082099003|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	tbyQ6rBu3gfENFqKHGk46r7eXgkCcAxGTV1UKTH+WbiIVhXDlPzwj6o8oI6PIJcJyJsg0fTGmxoXy0qRlFfGtQ8+BGO8KWsaLoYPx7Rv7EtpLEL91KbGRf99d6GRZkojqWdJjwIMzxnCoBoWrgS1SkIpIki4IoCLVNsGVDCeHQrR4stwq75aDlmjqp+XkzFbe8R6TK9kh7FErePbgXDBNCpus0RayG7BORvK+YIMvUUMS2Qzp0Ta2olB9Ugtafu0+E6Dp7P2c8vr0m6kNwvYA3T+L5UNuqz7vgIhZnZso0DEIYdZmhkiJ3Rwp+SBIFbcnDtJAXV/xkCz0lSdl6Hxw946TBF9U1t3KkHSeqFtQ3Y9xw2caQ0Js/iNIgo5zn5slzjrzvpOnoVqN6/cvjLduYJSECC7y//On2RDNCz9fslDtuZtvphcYb9jxtICADf7b15puBDKmJLXqurOZDB/9ErXe7Jk0FS4X0bAifMaHxbsmFkt7910WwgmGV4ralwsyl/DtofpPd7Z5wKI4Aia39L+ed7xL76YjBV8wdTmP9dUOibPuTPd6xdYBmVOPQuJh3HdLfl5zEXaZO92R+Gkk0Q9DCPVxrAeijHiG8QIM/yLMwUSTSX4TyXfM3jIFcsFerPytsKwc5Y0T47bbojar9XDhhhCc4Hm0tki/es702k=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BESP189MB3241.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(11063799006)(4143699003)(18002099003)(22082099003)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q1Q4T0dsVVdMS21ka2YwbDl1NEdyZklpMHc1TENUTDVYRVRSWENnb1E1aWFO?=
 =?utf-8?B?aUxYSGkvM01NK1lRMTdCMTFlMVRneFhqbzRDS3h6b2FyQUwveXZQUTNmUjdm?=
 =?utf-8?B?a0lXT0U1ZmNPWlBQTEppQWlxN0gyUEhnaktxSUFYWnhraUt3OVJOMitQUzB5?=
 =?utf-8?B?V254Q3NSRzBMQ0FLTWFaZDZZV2J6TUtuWHVFdFJ5b1dTNmFOSGJyRmxoNkpK?=
 =?utf-8?B?VldkUHZxcTBxWk1JSXhhUEpJRUtibjd2cHZKOVNYSHYwTG9WaHVvbnlHUjE4?=
 =?utf-8?B?UXVCSTJXL0NXU084TzBrVHRPbWQ0b3pyNXk5YVhIeWx3WmNyYU1BZ0FDVmdX?=
 =?utf-8?B?K2NxSEtka2NBWEhRNEJrWUFjcXhEanlZc2Zpb2pBb1NjcjRpeDMyVEoveGpu?=
 =?utf-8?B?V0dBTnRDdEFhdHN1Wk1oZGdKRGtsVkFXaHcvYmgybzM5SFQzTFlycVB4cFhk?=
 =?utf-8?B?Snl6c2k2UHI5ZHdVNTRxTEVaS3ByMWRCOForUzFFaU1vbVNuRUxBd21RQnpx?=
 =?utf-8?B?TWlobUN2WFZTV09BNzVjdmpPY1NUVDNJZk1hakpPRXRLckF2Yk5UVE9kVWpv?=
 =?utf-8?B?WDVwT3dlSjMrWUpROWJKcnBpeG8zNjEyTkFFQWpWU2pXYzI3N0EvcWU1cTlE?=
 =?utf-8?B?cnA4YmNlZ3h0VWdCZ0t2KzdlVGMwTFZNN1RxR21RM2k1S1ZLTmpIcnYvaVE5?=
 =?utf-8?B?OEVTZkpPQ214alowb3lWNGZJMEMvN1VZak1xR3ZDSDlUYVQ0akZqMGc2aUwy?=
 =?utf-8?B?Zyt5L3BqTmZzVXNaUm4yTzlScDlWYWNkQlRrZ0tkWHZkYVFvUVRmVE5ISGds?=
 =?utf-8?B?OUx3Z2pubXMxM2o4aXBwMmFqUS85TFFZZ1Zhd3ROREdhVjdkV0VZKzV6aTU0?=
 =?utf-8?B?VGQ5UlNUa3Q1WVFmcUR1S3NpUnBwcldiQ0tMOEZWRVBNM3d2eFhuNUIwVnp3?=
 =?utf-8?B?T3dYZ1VncHdwWi9mK1hxell6VEowK2hsNm1rOEpTWHgwK3p0RUllSHROWFF0?=
 =?utf-8?B?RFplNmU2Zm1vNHVmd1R4UzVtd01HZk5WR0FPMU1mbmw2Q04vYzJDL3lSdjFS?=
 =?utf-8?B?V29QUnJLdWJiTm9seUlhb1QvT0g2NkZHQ2J2SFZaY01WQVJPZUtnaVZqWXpt?=
 =?utf-8?B?REk2OU93YTZUbFFPV2RWRG13R3lZWS9TalpIekVUcFBvbmF2RVlFa2Y3Mkk0?=
 =?utf-8?B?TUZFanF2L1BDRHRNeXFIRm5MeXZsRWc2eFlxRXNYdW1zc3NtQmltOFY2VXFZ?=
 =?utf-8?B?NDkzK3lNdG0wRTU1MkNXNTc3Z3dkeVkxMDZhY3pyWkV3SE8wRmw0dUtmQmo4?=
 =?utf-8?B?OE9kcHg4K2hYS3lEMHd5dTlZMmFmbXQwRGxTT0ZVN294ODRrNEgySlk5M0R4?=
 =?utf-8?B?elRaQzBDLzdORWJkdS9JdkVyTnlPdUhJQjZGMk1UamRka29rNGxVT1NxL0FC?=
 =?utf-8?B?Z01NTE5BcCtiYTRQV0p2ZHNJdUdIdUQrc0FRWU85alVtR0dFT0t2Y2dMa25n?=
 =?utf-8?B?cGZrRlpjbzdoOGtURTAxUVVpaVdrRTh3TGtRUUllY1ZOeUNWUEhNcll0d0VF?=
 =?utf-8?B?T3I4T2dFUDgrY1RxTEl0c3Z2YUtUWDBhSlE4WFlOaWJ5WlRyVURVek90eHJ0?=
 =?utf-8?B?Ymh3UDJ1Vi8rVW9adVVmSHZ5NU8yVUgrVVEwNXZ6K3luR0ZZRUtCY0taNHhW?=
 =?utf-8?B?VmVaV2h0cnB1amJvdjk0WkRnNFNiRy9ubzlVZ3hTb3dKcTlPUmhZRGlpM3Fz?=
 =?utf-8?B?QkZnczRmeGVQeGZBaVBxOUh6WTRlTXNYaU1qQTdpelk5SURLdnRGMHA3MnB4?=
 =?utf-8?B?ZW1BK05RK1dzKzhsNEY5UTZHY3VCVjg1UmE2TkpJaEpRUG5nUXB1NlI2SHo2?=
 =?utf-8?B?WmVVbXppQ2hVRk5DcFpVTzUyOEdwUndFdWdZRG1MNFlkRmt6OXRxR0NNZ0F1?=
 =?utf-8?B?VzFldTdLMDJSaFdnVlQ2a251WXZCQ3UrZHJsa0Y4b1l5enBJNU04Z0RVaDdv?=
 =?utf-8?B?eFZlK3cyeEJPcVY1ZXhJZUt1SHJibWhPMUtFcjdXWmFkb3dHeWt1Z09JWEZN?=
 =?utf-8?B?MllBZkY1Mkh0QmJUanUrZ2hqN1JQSk1rU1p0QXIydHVRc1I0WDByTERvT0po?=
 =?utf-8?B?a2g4RWM2aFpncHZhcndZNGY5eGVGMUFuWFF6MEVkYkVhRVVUWjgvSlh5SzlS?=
 =?utf-8?B?K1pIVWlacG9jRkx2SG5NMEFDYVVmaFFDLzlBZWZFQmtpcXAySjFVcGVMakJN?=
 =?utf-8?B?bzFDRGxtc3FicHBCMWcrU2d2bDFqV2pTbGFMNmNrbVZKdHZTeS9Kc3BYY2tW?=
 =?utf-8?B?a3I3SThsdno2eElpQUNvMkdDbk5oSVFJNDB5RVVKMVkzZW5sSG01QT09?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: 397264b3-996f-46e7-36e6-08dee35206a9
X-MS-Exchange-CrossTenant-AuthSource: BESP189MB3241.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 15:50:57.2311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PYYCXenBduNHyLLJ4d1J6a2mkV5eqZRGmyYXCIRrQpMhlpD0CsjebshqsxbuZhtmRHumGRuXaD+rMQ5vACi0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P189MB0601
Content-Type: multipart/mixed; boundary=832332988958181617842170541250322
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 16 Jul 2026 16:16:43 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19840

--832332988958181617842170541250322
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Thu, 16 Jul 2026, Richard Purdie wrote:

> Hi David,
>
> On Fri, 2026-06-12 at 13:38 +0200, David Nystr=C3=B6m via lists.openembed=
ded.org wrote:
>> When current implementation runs in an unprivileged docker container,
>> basic networking will be allowed by default in all steps, ignoring the
>> network varflags intention.
>> Introduce support for landlock blocking of bind and connect, providing
>> basic support for blocking TCP.
>> UDP is corrently beeing worked on upstream, but not yet supported.
>>
>> Landlock requires PR_SET_NO_NEW_PRIVS to prevent escape,
>> which is also attempted, this prevents privilege escalation from child.
>> devshell and related are already tagged with network varflag and
>> can sudo at will.
>>
>> syscall ABI is asm-generic, 5.13+ for all archs except alpha.
>> On alpha, we leak 2 fd:s in the childs context before graceful exit,
>> which is cleaned up at child termination.
>> Don't have an alpha target, so this is not tested, evaluated via
>> static analysis only.
>>
>> Landlock also provides a future possibility for filesystem
>> limitations with the purpose of catching bugs, and preventing
>> persistance of supply chain releated payloads. writes to f.ex.
>> .bashrc and friends.
>>
>> Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>
>> ---
>> David Nystr=C3=B6m (2):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 utils: Add landlock_restrict_network func=
tion
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitbake-worker: Call landlock_restrict_ne=
twork for tasks without network
>>
>> =C2=A0bin/bitbake-worker |=C2=A0 2 ++
>> =C2=A0lib/bb/utils.py=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++++++++++++++++
>> =C2=A02 files changed, 28 insertions(+)
>
> I think this has generally has positive comments, we just need to take
> Paul's review comments into account about the magic numbers. Would you
> be able to send a version with those tweaks?

Yes, thanks for the review, and sorry for the late reply.
Will reroll with comments.

> Thanks,
>
> Richard
>=

--832332988958181617842170541250322--

