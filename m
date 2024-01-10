Return-Path: <liezhi.yang@windriver.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B522CC3DA6E
	for <webhook@archiver.kernel.org>; Wed, 10 Jan 2024 09:46:07 +0000 (UTC)
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
 by mx.groups.io with SMTP id smtpd.web11.8403.1704879965197000811
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Jan 2024 01:46:05 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@windriver.com header.s=PPS06212021 header.b=sCs2H2TI;
 spf=permerror, err=parse error for token &{10 18 %{ir}.%{v}.%{d}.spf.has.pphosted.com}: invalid domain name (domain: windriver.com, ip: 205.220.178.238, mailfrom: prvs=173902d519=liezhi.yang@windriver.com)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40A7F2XE023712
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jan 2024 09:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	PPS06212021; bh=pBjU3z1b4L8q8HPMVIidPh/G/yphzv4jz9ot+DeaYWQ=; b=
	sCs2H2TIjhgnq+l13WExzGyBtT0EiauO/ua9mes1JIdVi3HHcRbQtxHXxj00R6PI
	NJUqTK8FcBqZ8U6O/kWNGS1rFA9OiUW5asloGbo5C10pdnfcmOBEzl04sCPMMGwh
	mslQLrYhYkj+szaFiEpNN0SECtYE27it12QLjr8Fc7r1/WvqdAp39MsRwt+DLpiw
	HCFju5GsBv63XrE0q0Vh6RxHsAwJeZXVKaVLS2awexqqOUQxxyVuDY9ffN+9Mdb6
	A74epcAlz6KQ1bYUKPahWvz+L0WdY/Dbc2k5bHKaakA0KQTtC7FR9P/h3hvNY2Su
	3fZLlkYfefbeDTGj/nUWRw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vewu5cck1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>; Wed, 10 Jan 2024 09:45:59 +0000 (GMT)
Received: from m0250812.ppops.net (m0250812.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 40A9jwBD031320;
	Wed, 10 Jan 2024 09:45:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3vewu5cck0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 09:45:58 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzR006NGUlCG1CGolEWOdkaFdnvpd0WhaTKFU/xpDPsfYEEELz0fIv/UjWDgKA6Mbip2mNH8xFVdIP07oI6ei1x6s/hWRJQ5/hTZb6GXP5gLVtSNS5oR4KR4EaV7y+5+JpxMNtbMg/egz2cmldOKCzjwalIKi6eiytQ8/6MVxdywuAweph0bPcoA8QsDbozwdDuE/eqUpOCXZW4Iq2nFAIP/oJzFLV/3JSzBJ5uy+JEwMddjzN9Zt0CpYDzbvA73jsEAP80ZEq6rgKUVy9nyOQTzyD0q5fVFGbZl/yaHAJ2BDhr1Nnx2fJcbApwuSFbyYoFGFtGOg/U6T2AzrJKDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBjU3z1b4L8q8HPMVIidPh/G/yphzv4jz9ot+DeaYWQ=;
 b=GjrhjTqkzsGoYI+DRDkJSI9QWBomOX35TxQmrG8hR6g2LsvFW9dTw0npY5W4bNkRoBilrZ7wHFoJ+NNmFT6eo1Bk3HM+kBLyffwZnbzqtMZrG+ukdiPHGo91RP5KD2HFoqWc1fUQaBGk/cI79a7/2qWXoIBi1vUclCR7uM+I3ZBHcKe34zVYHNhn3jf5mZjzdm1Rn9X/oR9p4YiP06LycgTM+kEuhhOMPAhcjrdl9MC3e45bLLIqkDd/mKaKYppSp9lOT/cflbXa8+RK6Kwgn0dg4b31vKM9SNbqrlGHJMfvnE7CZ8eH9X7GLVlvM+MJIivttHINXkm6onMAZkPKzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from LV3PR11MB8531.namprd11.prod.outlook.com (2603:10b6:408:1b6::15)
 by DS0PR11MB6374.namprd11.prod.outlook.com (2603:10b6:8:ca::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.17; Wed, 10 Jan 2024 09:45:54 +0000
Received: from LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::50dd:9a9d:180:df89]) by LV3PR11MB8531.namprd11.prod.outlook.com
 ([fe80::50dd:9a9d:180:df89%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 09:45:54 +0000
Message-ID: <2cdccfda-6306-4ab2-9ade-ef9fac787233@windriver.com>
Date: Wed, 10 Jan 2024 17:45:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v4 2/2] bitbake: tests/event: Add
 test_lineno_in_eventhandler
Content-Language: en-US
To: Christopher Larson <kergoth@gmail.com>
Cc: bitbake-devel@lists.openembedded.org
References: <cover.1704786173.git.liezhi.yang@windriver.com>
 <4034b4a24d9ac56b13163ba2decff83a5f41be7f.1704786173.git.liezhi.yang@windriver.com>
 <53989CDF-1F8C-4FD7-B2D7-45FD5629903A@gmail.com>
From: Robert Yang <liezhi.yang@windriver.com>
In-Reply-To: <53989CDF-1F8C-4FD7-B2D7-45FD5629903A@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: TYBP286CA0042.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::30) To LV3PR11MB8531.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8531:EE_|DS0PR11MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 9602cb82-3fa4-4ab3-0d8d-08dc11c0f009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WGX6Xd5hkUaSwvw1LKjfd/JiED4NXYgJ8x57Lm4ep2CfkW+ZjSXUBUCpVehJ1L/4fdJG5KOgMN6fo8ZAgryX3LD30NwmNU36F0L4euVWzepADQMnVma8gKcIH56csJbI6GxhxQcfw0frcRhMUfvE/YKBrpH2dk5/iYrmmjjc4dFE01HGsXbgWdjG2PYnpXBr2FfpuD1vrXzEHMkb+n2ngUB8W08zB9hYoLkK5On8yXjuADD7pdCDBrBIrey5h69pM0akNOcZNulPqPx/xW2hrl8zZPUzl3eDQFrivMgdfGM9CEFvLjEMJmpkSvUF/UEiH6l/f5qeryCuXKKGI0t5qBgZflsdzqh8ox9X4tsvoG8/k2AYqItf4uLulf5sIlPNaZYTWtk1Np0wT1a0tOvNssYOguU4Sz4cKgbAanoEu7wFuFfJ1gxWiH5EydNEl+P5TibTD42xdfyN2LfsJpLgAVEPX/PXdb/+nqobQJVrDo2mydc+xlSDF4FherdweTl4CHrsr+GFk7089UMaVvT5SjPvgXk+foQNCxc6nHkHsIRi5xo4Z4TipSNp7ezkqdb9Dq+mXbJHqSJHiM4+/VjwPN/3HKNjUUEduywA9v5Zi2B2lYbv2Wx7pDgg8oa9m8a5rQwp4ztjERe613FpDhH1tQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8531.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39850400004)(396003)(376002)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38100700002)(66899024)(36756003)(31686004)(31696002)(86362001)(26005)(83380400001)(2616005)(6512007)(6916009)(66476007)(6666004)(8936002)(66556008)(66946007)(316002)(8676002)(966005)(4326008)(478600001)(6506007)(53546011)(6486002)(41300700001)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SUxmcUswRGxLTVpSU29sTjN1eHVWaVN1bGZVam5qNmVKVG56bjhWdVpXZTZu?=
 =?utf-8?B?Tk0rRlloNnVXczBneXBvYnFGVjVzZzFLRW9yMGNCZ0VOa1ZqWHZuc0lUSVhF?=
 =?utf-8?B?WHN5aXljL09MbFJGa2NEWDRra2lYMS9kRnh2S2gwbGNNU2phZnovVC8yY0Y5?=
 =?utf-8?B?TTcwTThkcUJDU2xVaCtRMjY2VXVpWjZjL3p4VjJkQTg4Y0VZcVZvR2YwSG9M?=
 =?utf-8?B?TkNuYzNwV2lIdHNNMXJEK21BbVBCOFc4NHY5WXlTc3h5dWtJeVZTbVZmVFdI?=
 =?utf-8?B?NUhvV05DRTJuRWZaSnFxODNFUitvKzB0enI0WkJOd2hjVDhINkgrOHNZazdj?=
 =?utf-8?B?UTFQSXdBMnMvc2JweXBzVTZyN2JjemFjKy8wVjExUmxKb0U0OTR5Z2FqKzls?=
 =?utf-8?B?MWZhaDZxcXdSaFlMZEZYTFJoTERhSThZU2dHMTBiei9ueElLd21zZGZETVBm?=
 =?utf-8?B?TERaaXRtbnFDbVF4bE53T0FndkdQTlZHL1dlc1dML3lXUjhuc2JkSnpTQk9v?=
 =?utf-8?B?YWR0cW9KOURhMEtvd0taanh5d21rS0o0WEEzTHJwYTVOdE5zYWNPQ3AzMGJN?=
 =?utf-8?B?d0hXV01iSFArdHBqOFRMVC83cDFtNEJNakpFR3lzdGtLQVBsRkFNOWJIVy9q?=
 =?utf-8?B?ZjdFdjh3K3Q0M3BCdmYyMlhVMGRDTDZ1MFZrTHpDeko1cWZqNVRSR2xhNGk4?=
 =?utf-8?B?cWVBTmZsbGFyeFBzZk5tTDJMWC9PdndiOFJydnB0VDZxeUxoYjhSclNPRHVF?=
 =?utf-8?B?UmVxYXNmWnJiaFhsa0lWMVF3azZ1MXcwdzlsbmhWQU10blpLeW1nb3k4UmFY?=
 =?utf-8?B?SzV3dWR5OXRFZ0d0bzZNK3pHSlJFOTFURCtmbzNrK1kvakkyejJGZ0VLblBW?=
 =?utf-8?B?NDJrSUhDU29pU2s0UWVnNEpqNUtpQlBqMEhRdU1UZUdkSWVJbGpZWGRFdkdu?=
 =?utf-8?B?enkrQndtR0d3RjVWa1d3Qm10N3dReUJuamFGK0ttaHN3dkZGK3FrWFVucFRS?=
 =?utf-8?B?WFFFR3Z0cERXbEkwMlh0ODVLSDYwK1BEY3VzbEh4MXNTbk9kQ3BWU05DZWZz?=
 =?utf-8?B?dU5hQ1V5MTkzd3dQSnN2WWpkMWRpMk1mdWdDNGJmWEtFU1lNMDhVQzllZzhI?=
 =?utf-8?B?QnByTWJ1NTA5aUZab3pCSWJHNzBzZ2lTdThiUDNuRjBkNlN0ZEdreU1aejQr?=
 =?utf-8?B?T0wycE9IUWJQMVpJVlB0M2NMd1VpVzh4R1lwM0RzVmw4ZlJFRStZZnZtYlNR?=
 =?utf-8?B?cU9OSWdqZzdBSEIvZEtXODFmd3piK3AwY282RzJ0eXlWamlsQVhSU1hZaUhX?=
 =?utf-8?B?cEx1UkJWeitoNFVvZHMyOEg3M0k4aEVpTWdJVkUvaGFXZnpVcVNmZlQ1MG1G?=
 =?utf-8?B?M2J5YzlmbndGVm4yVDJWdDYyVmRPcWhMdE1xTmovb21iSHFkRnI0UlJqMklT?=
 =?utf-8?B?SnR4WkRCSTdPVmk4WHVNa3Rwck1ZdkhyM3BNUDVQcHFkMUUyQzBHcEVNQ2p6?=
 =?utf-8?B?UXVxRytOY1B0cW0rOWZLNzRHMTQ5SnR4bzU1VGQvQm1seERxNld3djluMXI4?=
 =?utf-8?B?UFkvTE01TE9JNG1nTFBORkcyVlVhZWtNei9nckxpRjFUQ3BJbXliZXU5TlpH?=
 =?utf-8?B?N2w1NUsxOVRhQlNTZWV4OXk4cGlobWZnK1ZYUGRWWWNjTEU4eXlzWXpsVFd1?=
 =?utf-8?B?dmxGVXFyYys4TitzUEJzNnlQRWpSN3B3NW4wOEVoU1JIL3RCUzgrZU5ZSitz?=
 =?utf-8?B?NmdXZXNYU2d0SG9malNNYTNLVlE2OE4yMGhHM3dtMlI2NklmNXBrWG9vS2tW?=
 =?utf-8?B?V0g1amFKMklhLzNScjRkZ0dCQ3NSQXlCL0dIb3EzbGhJZjdTUFJiNVF5d2xB?=
 =?utf-8?B?dFc5czhraE1WYVlYMUtzOEhscWs3ZmtQZ0JhUzlaYk83bWthMGV4cnBsVmll?=
 =?utf-8?B?WmJnMm56ZmNxZ3RsQTNLNVFLYU9raEQ1OXNtdUxkRGFYNUo0bEd4eC9pK1pQ?=
 =?utf-8?B?Z1oreUtLYzBpYjdHUnhsWC9QcVY4anUrdEJ4MXZFb3d2d2czTm0yOFhXaE5F?=
 =?utf-8?B?SklFNVJVK1dNc2JYbmFFRVZCd1dkV21kS1FraWxydCtZck9LZ015bG1teXdV?=
 =?utf-8?B?ZTJCODFkaEdGeUhYbjVXQTNGODcrU09WTytZd3l0cC9vQUNCanFSRzZtQ203?=
 =?utf-8?B?aVE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9602cb82-3fa4-4ab3-0d8d-08dc11c0f009
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8531.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:45:54.0837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7q9H3yZDivhDtTdANlvmpwWfwSUwllX9Nm1YOtNn1lGqbojQlxRFeh6r0u+QdHSU5OWEglbpgeusGGD8brXyKh+QVOEu8yTg/b4Ht2pvODg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6374
X-Proofpoint-GUID: QHUN2qIw1g2TEREo7WSrRqqZSqVqduS7
X-Proofpoint-ORIG-GUID: TnKd7vnav6XqXpz3K_ePxZnuYl98KR7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401100079
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by mx0a-0064b401.pphosted.com id 40A7F2XE023712
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Jan 2024 09:46:07 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15777

Hi Christop,

On 1/10/24 6:08 AM, Christop her Larson wrote:
> This does look like a good idea, though I wonder if injecting newlines =
is truly=20
> the best approach. SyntaxError is a bit of a special case, since it occ=
urs=20

Injecting newlines are much simple, and it also can catch more errors suc=
h as
IndentationError, now the IndentationError can be reported correctly:


ERROR: Unable to register event handler 'defaultbase_eventhandler':
   File "/path/to/poky/meta/classes-global/base.bbclass", line 259
     d.setVar("ORIGNATIVELSBSTRING", d.getVar("NATIVELSBSTRING", False))
                                                                        ^
IndentationError: unindent does not match any outer indentation level


Such errors were very hard to debug. The _syntaxerror_offset may work, bu=
t it is
much more complicated than inject newlines.

// Robert


> before we have the ast to adjust the lineno, but it can be corrected wi=
thout=20
> string manipulation if you catch and re-raise SyntaxError. Ex:
>=20
> def _syntaxerror_offset(value, lineoffset):
>  =C2=A0 =C2=A0 """Adjust the line number in a SyntaxError exception"""
>  =C2=A0 =C2=A0 if lineoffset:
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 msg, (efname, elineno, eoffset, badline) =3D=
 value.args
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 value.args =3D (msg, (efname, elineno + li=
neoffset, eoffset, badline))
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 value.lineno =3D elineno + lineoffset
>=20
> =E2=80=94
> Christopher Larson
> chris_larson@mentor.com,=C2=A0chris.larson@siemens.com,=C2=A0kergoth@gm=
ail.com
> Principal Software Engineer,=C2=A0Embedded Linux Solutions,=C2=A0Siemen=
s=C2=A0Digital=20
> Industries Software
>=20
>> On Jan 9, 2024, at 12:45=E2=80=AFAM, Robert Yang via lists.openembedde=
d.org=20
>> <https://urldefense.com/v3/__http://lists.openembedded.org__;!!AjveYdw=
8EvQ!YGDlH3GcpHwxON5oeaacPDSvoRd4ElezyHIHZpb7-vl5gV_Ip6p6zmPaMM2MO9LWGJTK=
Qza6t0DNEMRXmNnO$> <liezhi.yang=3Dwindriver.com@lists.openembedded.org> w=
rote:
>>
>> From: Robert Yang <liezhi.yang@windriver.com>
>>
>> Add test_lineno_in_eventhandler to test lineno in eventhandler.
>>
>> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
>> ---
>> bitbake/lib/bb/tests/event.py=20
>> <https://urldefense.com/v3/__http://event.py__;!!AjveYdw8EvQ!YGDlH3Gcp=
HwxON5oeaacPDSvoRd4ElezyHIHZpb7-vl5gV_Ip6p6zmPaMM2MO9LWGJTKQza6t0DNENKyLy=
m7$> | 24 ++++++++++++++++++++++++
>> 1 file changed, 24 insertions(+)
>>
>> diff --git a/bitbake/lib/bb/tests/event.py=20
>> <https://urldefense.com/v3/__http://event.py__;!!AjveYdw8EvQ!YGDlH3Gcp=
HwxON5oeaacPDSvoRd4ElezyHIHZpb7-vl5gV_Ip6p6zmPaMM2MO9LWGJTKQza6t0DNENKyLy=
m7$> b/bitbake/lib/bb/tests/event.py <https://urldefense.com/v3/__http://=
event.py__;!!AjveYdw8EvQ!YGDlH3GcpHwxON5oeaacPDSvoRd4ElezyHIHZpb7-vl5gV_I=
p6p6zmPaMM2MO9LWGJTKQza6t0DNENKyLym7$>
>> index d959f2d95db..ef61891d302 100644
>> --- a/bitbake/lib/bb/tests/event.py=20
>> <https://urldefense.com/v3/__http://event.py__;!!AjveYdw8EvQ!YGDlH3Gcp=
HwxON5oeaacPDSvoRd4ElezyHIHZpb7-vl5gV_Ip6p6zmPaMM2MO9LWGJTKQza6t0DNENKyLy=
m7$>
>> +++ b/bitbake/lib/bb/tests/event.py=20
>> <https://urldefense.com/v3/__http://event.py__;!!AjveYdw8EvQ!YGDlH3Gcp=
HwxON5oeaacPDSvoRd4ElezyHIHZpb7-vl5gV_Ip6p6zmPaMM2MO9LWGJTKQza6t0DNENKyLy=
m7$>
>> @@ -13,6 +13,7 @@ import pickle
>> import threading
>> import time
>> import unittest
>> +import tempfile
>> from unittest.mock import Mock
>> from unittest.mock import call
>>
>> @@ -468,6 +469,8 @@ class EventClassesTest(unittest.TestCase):
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0def setUp(self):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bb.event.worker_pid =3D=
 EventClassesTest._worker_pid
>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0self.d =3D bb.data.init()
>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bb.parse.siggen =3D bb.sig=
gen.init(self.d)
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0def test_Event(self):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0""" Test the Event bas=
e class """
>> @@ -950,3 +953,24 @@ class EventClassesTest(unittest.TestCase):
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0event =3D bb.event.Fin=
dSigInfoResult(result)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0self.assertEqual(event=
.result, result)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0self.assertEqual(event=
.pid=20
>> <https://urldefense.com/v3/__http://event.pid__;!!AjveYdw8EvQ!YGDlH3Gc=
pHwxON5oeaacPDSvoRd4ElezyHIHZpb7-vl5gV_Ip6p6zmPaMM2MO9LWGJTKQza6t0DNENhxa=
d__$>, EventClassesTest._worker_pid)
>> +
>> + =C2=A0=C2=A0=C2=A0def test_lineno_in_eventhandler(self):
>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0# The error lineno is 5, n=
ot 4 since the first line is '\n'
>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0error_line =3D """
>> +# Comment line1
>> +# Comment line2
>> +python test_lineno_in_eventhandler() {
>> + =C2=A0=C2=A0=C2=A0This is an error line
>> +}
>> +addhandler test_lineno_in_eventhandler
>> +test_lineno_in_eventhandler[eventmask] =3D "bb.event.ConfigParsed"
>> +"""
>> +
>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0with self.assertLogs() as =
logs:
>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f =
=3D tempfile.NamedTemporaryFile(suffix =3D '.bb')
>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f.=
write(bytes(error_line, "utf-8"))
>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0f.=
flush()
>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0d =
=3D bb.parse.handle(f.name=20
>> <https://urldefense.com/v3/__http://f.name__;!!AjveYdw8EvQ!YGDlH3GcpHw=
xON5oeaacPDSvoRd4ElezyHIHZpb7-vl5gV_Ip6p6zmPaMM2MO9LWGJTKQza6t0DNEDC-ZnzD=
$>, self.d)['']
>> +
>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0output =3D "".join(logs.ou=
tput)
>> + =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0self.assertTrue(" line 5\n=
" in output)
>> --=20
>> 2.35.5
>>
>>
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>> Links: You receive all messages sent to this group.
>> View/Reply Online (#15756):=20
>> https://lists.openembedded.org/g/bitbake-devel/message/15756=20
>> <https://urldefense.com/v3/__https://lists.openembedded.org/g/bitbake-=
devel/message/15756__;!!AjveYdw8EvQ!YGDlH3GcpHwxON5oeaacPDSvoRd4ElezyHIHZ=
pb7-vl5gV_Ip6p6zmPaMM2MO9LWGJTKQza6t0DNEHCVD821$>
>> Mute This Topic: https://lists.openembedded.org/mt/103616263/3617123=20
>> <https://urldefense.com/v3/__https://lists.openembedded.org/mt/1036162=
63/3617123__;!!AjveYdw8EvQ!YGDlH3GcpHwxON5oeaacPDSvoRd4ElezyHIHZpb7-vl5gV=
_Ip6p6zmPaMM2MO9LWGJTKQza6t0DNEIbsb3Sa$>
>> Group Owner: bitbake-devel+owner@lists.openembedded.org
>> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub=20
>> <https://urldefense.com/v3/__https://lists.openembedded.org/g/bitbake-=
devel/unsub__;!!AjveYdw8EvQ!YGDlH3GcpHwxON5oeaacPDSvoRd4ElezyHIHZpb7-vl5g=
V_Ip6p6zmPaMM2MO9LWGJTKQza6t0DNEG8cswfl$> [kergoth@gmail.com]
>> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>>
>=20

