Return-Path: <david.partain@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C34C88E50
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 09:04:54 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.51])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.34610.1789113184307642702
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 11 Sep 2026 00:53:04 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@est.tech header.s=selector1 header.b=bdW7L/2A;
 spf=pass (domain: est.tech, ip: 52.101.83.51, mailfrom: david.nystrom@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NLtoJEd7FZ40m8CyeBuEGQ5t1j+e+hWMNSQifYHfwb38Zd7lU+bEZym4hllK1qZt7+eRYnW0/dYyWmJQ9989keGN69AA2QyXsHYqJ6UjeMLGrVBuQdW+PzyofDUFqW3oqrvP0YO6aOtLfNkfpFOmFzXQdBXOEdzqjYUt5c0r5dbeBle+0nsc5PO2SZLBl8xJ49QYittlCfGFtd444HRvOjuhtvGHf84szhHLStr2pvIddgm5DSohJJqUHZMfBLQmW2HjzT2WnuBRyNYJ7OfGrep8AjcDsZ2WDCTLz+SNCCzSzuJSiG0QjYAEuBShsqSVG80Jgdtc8gRSDfsi+dkEMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4FauS92oghSSJicsBTeMP+Nf4HBANbTG9AJVsxLpOM=;
 b=Tei1wJut9a3jQ58OXVdNJYSSXYwH8tS8Mm6+aBDJjP+8QHnFRD6v1KGXjMDCeezDvnr9TGyzj7CY6AdF6dpvA1gjvybcqjsmxF5/vwNy+GVI2d1Gt2jJoor3btLpk/lrIho07KLBPByezJfaFvodtH4jzZzbhptywYF0b1QDeISujxi8kI1EgAZwjjCEHWdhJlpvSa5unc8oKXH8pBSpYp0+Z0hpPZqY1vDDidEAoVp6bZoXPmtHuf4V4mnYDMs2zQqilGubFaJtbOMwVVHriUAM3NefTdLJRCrsYfbXJXj9RQqcCNohRtoWihOfSsHMaTWGDwF8v62KdGN7PT0qAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M4FauS92oghSSJicsBTeMP+Nf4HBANbTG9AJVsxLpOM=;
 b=bdW7L/2AnM9lvYjToU0aViJ/jPauYGlv70tJBacdJ5L8y86U4TbVzbvPW2gFak79YzAUgl4wTIt90C2SCINOuCShhG+DP9aMwACu7HWaBDk6yiu2pST4nc+PD1/XgbHxuYpYMXGSMohsY1HXdYndhdcBABM9uGo9aX+u/HilCxqMuifyAKK5X6tEY2wi4nPK099wp+mydvrOjrvPJw/d6GX7eoRjSuf1lNp089LZlI+Q1+VMl8bs00tp4GgNqXF6RFMJsMmb10hrxgRoRoz3Y5IY9g8FJH5pVdItarbkPEBSxszwb/ubDY6ZEbjEC5jWTFPmXt1W7cixNcwtDCmYsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:2db::9)
 by GV1P189MB2265.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:9b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 07:52:57 +0000
Received: from VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec]) by VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 ([fe80::149:d9cc:d017:c9ec%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 07:52:56 +0000
Date: Fri, 11 Sep 2026 09:52:53 +0200 (CEST)
From: =?UTF-8?B?RGF2aWQgTnlzdHLDtm0=?= <david.nystrom@est.tech>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
cc: =?ISO-8859-15?Q?David_Nystr=F6m?= <david.nystrom@est.tech>, 
    bruce.ashfield@gmail.com, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH RFC 0/2] bitbake: Add basic landlock support
In-Reply-To: <be7db34b8490d72d362af3eb7b82cc43b086ea4f.camel@linuxfoundation.org>
Message-ID: <4a8a1458-c0a0-0408-6956-67f7b7437298@est.tech>
References: <20260612-landlock-v1-0-77891f63ed7f@est.tech>  <a4ad8dcdef504155bebebe81125b68bb66692c2e.camel@linuxfoundation.org>  <9c697498-9771-31c3-667c-32a038e3d8ed@est.tech> <be7db34b8490d72d362af3eb7b82cc43b086ea4f.camel@linuxfoundation.org>
X-ClientProxiedBy: AS8PR04CA0007.eurprd04.prod.outlook.com
 (2603:10a6:20b:310::12) To VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:800:2db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0P189MB3589:EE_|GV1P189MB2265:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b72472-766c-43ee-936c-08df0fd9b10c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|10070799003|376014|1800799024|4143699003|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	nhp1DeVzdqLrkAVn1MzltczkABms+MAqAPETjDQ+/2/Jtp63JGI1iAFy7ZGMhSV0ZCHWpAVsMMsJfhTQ59X44lcbWReV6lPNQr/nAaVrxLutMBeglKrZNXZMiRGNI9tGDk8h5VbnM0Nh31ELO5/6acyls2RUFiAh3UEEs3ZKxWHkSMS77V5ClvZyrRrZ9zcrz9EQrH5MFa599MlR6+ZV1lm5YhQiXuxla5cY8tlGHZSJamHNb2GfXckzmHfUVg9G9mHucPrc5xHnd0W9hXzb27++PCFnXncdhEaIFeyzqHfQY5yH+RG4xM5cK0rjAI7Ga2KhgxhNxDnU2TPQ2J1hEmt8Lol9vwj27/MjzKUi/Y/lmImMM6fZLpqaOXh+dwhMpx4mUXbsmhNK929FJmagJP5KD+pg6BRK5PnSDY6F200j3ZFve+hb77sD3SzTx4R1uMeoz7S5n8n7kK7NDq3DaqmWc+flXi/1PQsUYBB5h65nNHBoiRm4ARVCG3oSwxMqvSxqb8FBGnyqoNFCORYen0c7p9JvWhsFN1bdLVTWhMbwY1wlTWsflpdOBFsA82KPwRAHYGD//zfKbmnXOeEL9QsaJXmneMFqa/qEhCXRhjiXkpbNG6w4lgdXEv6eVazyy+tGIkxJcyFkzckVMt6gau6Q9J2gHzB65l6SIn2T3zg=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0P189MB3589.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(10070799003)(376014)(1800799024)(4143699003)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MmdEVHhGMDNHWXRkM0ppNEt6eEtLa3BDUEQvUjhRdEtKbTFJdDY0ZHhvYkR3?=
 =?utf-8?B?c0tDNFViQjlXTjVoTjJEenhGL2lSQnRPV25Hc0ZubzVVMkxxazVkaVplcEJI?=
 =?utf-8?B?eGRQVDRodEZySnozVVorZG9VK0RVYit3Ukp6OFRqS1BHellKenF5UU9qR1l3?=
 =?utf-8?B?R2tUOXNqSWIrQ0pXclNtckZZQksyM2xrSm9ORFpmSWRXbGVQYkNBUC9nZjJP?=
 =?utf-8?B?eVRjT1J6QTk5ZTUvS2pJdkt0Sk1tOTZ1VjQ4c2Y4cEtKSUdLMVNOYzVpWDVK?=
 =?utf-8?B?dFRETCtURkFkNnlZMUZSU1Z0bjFHQXNILzAwbHluaVNEMVhaQVZRc1craWZ0?=
 =?utf-8?B?cFpROEFIbXhoVzRadTdRV0J1MmZSS2E5WW5XU256MC9QWENPZENEaWNodVNG?=
 =?utf-8?B?eG9pMzhTbks1WHdIazhhVHJ2VTdEdDlxUmdHdm53T1pIK05JbG9oYnFpS3Ri?=
 =?utf-8?B?dnFoOWFjdExNdEt5bmRRNyt1OVppTDdrRTN3WmNlWmVDaXhrSEhoZ3pzM3RO?=
 =?utf-8?B?ODR5OUxyeWVTLzVUUGRXN1VsYUpBdUxxbVVPckFwZlh5RzdYVnh0NnBGbnNB?=
 =?utf-8?B?eFIrVTVnYXlFVXROaEVFZXRqbFFFd2VDK2FRdm8yTCtWOEZxVDlsRUwwaDBW?=
 =?utf-8?B?VVppYXlHOXpTVmVYQ3h0RHdhNTIzUlp2VlNVZWJjaEttOUp1c3FCOE1zYVFB?=
 =?utf-8?B?a0JXb0IwQjVpWkt3TUZ5d1o5bEZ4RjhmSmN1TmpWWGZ5WW1jUDVRb1FmZ3pU?=
 =?utf-8?B?M3VrNHZnNmZRZFNscjFMREhvZDEvZzh0Vmt0OU9CeWVGT2FrNWRuQnppMnh2?=
 =?utf-8?B?VytBYjZKZ2pVN3NjZlRBV1RvdFhYNFM5VmNlL2lwRDZ0N3h2dlBQYUNoMmFP?=
 =?utf-8?B?QlhEaTYxcHU1djNaSWFiRTdIaExVWDNpTnFUallqRWUzWE5DbVdyQ3BOcEJ5?=
 =?utf-8?B?ZnhyazVpWFJpbzViTHRIa2cvNW95QXpGVGtDbC9ZWTVuWmpxUHNENnBoeFdX?=
 =?utf-8?B?UEdlTmQ2WHZDZTZVTE5OMGFlZWlrbTl4MWRNTit0WnpjM3owZGMxK2t4M1dn?=
 =?utf-8?B?ZkZvUG85YzAyVUJhTVd1NHFMa3dBOE9GRzFJVEZpcGdvSXoxem9INUlYNmxv?=
 =?utf-8?B?QnFEZi85aktQSU1aZGg5djYvbjljRmtybXhwWkZRRW52SUhFTERWdnFVczB3?=
 =?utf-8?B?clp4aFFySC9qaFY0ZHE4ZnZsMXJFV3RWQytwempBc3pOS1Q5dVN5YnVxNWo2?=
 =?utf-8?B?eFZ2RFZ3QURPR1dpeENocHBwdXdEczF1YXBlV01sc3FQV0t5Z1grS3JrbDFR?=
 =?utf-8?B?UFVrUGJLbzIvd0R2NmZKb1pDTGhSYmF4aXhEcDNob0RhblpVUXRkMkd6RUxq?=
 =?utf-8?B?Y2JKWlE2YVZnazBHOUF0NWVvWWJBWDA2VHZQMjZ5blVXeGhmeUk3b1NiQmE3?=
 =?utf-8?B?N0hlTERsNEV3NVpRUWxOaG9nU2hTVW9PejF0YmZUK2puUlUyR3NqdTdCL25J?=
 =?utf-8?B?NWZjQmxKOUhHRjRpT0Y3d09zcjNYVGkwUzMrbUlvL1N4Y1FkT3FYSWFFN1BM?=
 =?utf-8?B?MGxUalNEV1pZMWhPU0xOZG1rR0R6ZmM4Ly9XSUdYcGtvSERocWozSXFyRWJj?=
 =?utf-8?B?ZW5CanhxRk45QmF3OStQMmg4dE1IalNuK2FWa0FNaWM0WjlRS1BWN0xmdVVQ?=
 =?utf-8?B?dkFNTlBJN3BJRERXNERoenhERk9WU0JnQ0MvK0dNdW1sOXFGU2hqK3hMd3FT?=
 =?utf-8?B?aWdjSHpWOVFVb0p1RTlwbDBFdTVBVXZBMithT0RVSi8xY1RPQngwSFBkY2ll?=
 =?utf-8?B?RVN3YzlpWG9IbHJVYkJ2WnFnaGtYc2YyQS9ZUzhTNWlvcGJDc3Jwelc4SDlq?=
 =?utf-8?B?Q29VTHRsb3lDdDNnSnFPdE5RU2ppZzYxQXVYY292SlpqM29ldzB4K2VkT3U1?=
 =?utf-8?B?cUlTanVRY1IweUp5YXllZnlYVUpvejk4dS9RWWRWcm1tdS9QQUhpZURwM2pE?=
 =?utf-8?B?dU9KUDlmQlFSLzJabVNzbW9pdVQwRFpiTEkydkg5Q09vKzh1aFlTMEVUR1NT?=
 =?utf-8?B?ZSs0Vi9UWlpwb1JoM0pTeWpNWHBleUZFekZwZm1odDJ3VTUrcENPR0dIMGx2?=
 =?utf-8?B?N052bXhyRlhWTHBMWXhHUy8zNEJmbEtBc0t3akRMY0cwTkwzNGk2QW9pMjkx?=
 =?utf-8?B?TmtVVlBlQkY4TUlrYkFsMXh1ZEFjNlJpNko1WmVuVmMwOGZaMmRFZEczbkZ1?=
 =?utf-8?B?N0tKWVIxeWpQcHR2S243bmJjZldBRDRqbTFMTk1ZRkpDNWM1RWtzVytudWFT?=
 =?utf-8?B?UFlyUHI5cVlkSENDTGpJa3NUUzE5SmRnTWwvZTNTamREV2VqM242UjkxWTlJ?=
 =?utf-8?Q?W+glWDYDGi79veniJ5bIchy7Yjm2UoJhUf3uDO8Mq+H9J?=
X-MS-Exchange-AntiSpam-MessageData-1: XIN6ko89DJ0yCg==
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b72472-766c-43ee-936c-08df0fd9b10c
X-MS-Exchange-CrossTenant-AuthSource: VI0P189MB3589.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 07:52:56.4440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aA2vF0sT2bxr6b8K5GFDPGmnTJopVSFkbkA9KpX+l6/scks+L8C8DmY3hNzfcjTQ+rWTImovAoyy70xzBmf1Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P189MB2265
Content-Type: multipart/mixed; boundary=832332921261772441789113173416590
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 11 Sep 2026 09:04:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/20180

--832332921261772441789113173416590
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



On Wed, 9 Sep 2026, Richard Purdie wrote:

> Hi David,
>
> On Thu, 2026-07-16 at 17:50 +0200, David Nystr=C3=B6m wrote:
>> On Thu, 16 Jul 2026, Richard Purdie wrote:
>>> On Fri, 2026-06-12 at 13:38 +0200, David Nystr=C3=B6m via lists.openemb=
edded.org wrote:
>>>> When current implementation runs in an unprivileged docker container,
>>>> basic networking will be allowed by default in all steps, ignoring the
>>>> network varflags intention.
>>>> Introduce support for landlock blocking of bind and connect, providing
>>>> basic support for blocking TCP.
>>>> UDP is corrently beeing worked on upstream, but not yet supported.
>>>>
>>>> Landlock requires PR_SET_NO_NEW_PRIVS to prevent escape,
>>>> which is also attempted, this prevents privilege escalation from child=
.
>>>> devshell and related are already tagged with network varflag and
>>>> can sudo at will.
>>>>
>>>> syscall ABI is asm-generic, 5.13+ for all archs except alpha.
>>>> On alpha, we leak 2 fd:s in the childs context before graceful exit,
>>>> which is cleaned up at child termination.
>>>> Don't have an alpha target, so this is not tested, evaluated via
>>>> static analysis only.
>>>>
>>>> Landlock also provides a future possibility for filesystem
>>>> limitations with the purpose of catching bugs, and preventing
>>>> persistance of supply chain releated payloads. writes to f.ex.
>>>> .bashrc and friends.
>>>>
>>>> Signed-off-by: David Nystr=C3=B6m <david.nystrom@est.tech>
>>>> ---
>>>> David Nystr=C3=B6m (2):
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 utils: Add landlock_restrict_network fu=
nction
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bitbake-worker: Call landlock_restrict_=
network for tasks without network
>>>>
>>>> =C2=A0bin/bitbake-worker |=C2=A0 2 ++
>>>> =C2=A0lib/bb/utils.py=C2=A0=C2=A0=C2=A0 | 26 +++++++++++++++++++++++++=
+
>>>> =C2=A02 files changed, 28 insertions(+)
>>>
>>> I think this has generally has positive comments, we just need to take
>>> Paul's review comments into account about the magic numbers. Would you
>>> be able to send a version with those tweaks?
>>
>> Yes, thanks for the review, and sorry for the late reply.
>> Will reroll with comments.
>
> These still are in the queue and desired, do you think you'll get a
> chance to look at them?

I did a v2, but have been hesitating to send a non-RFC, since the=20
test-scope for this is bit overwhelming.

This due to the change of default task behaviour in regards
to no_new_privs. I'm not too worried at about
LSMs running beeing parent to bitbake, but there will likely be=20
unintended fallout for sublayer tasks, where I've managed to test only a=20
tiny subset of them.

Problematic tasks can of course be flagged with "network", to avoid=20
no_new_privs, but that seems a bit wrong, but I failed to find a better=20
solution. f.ex. The only reason the tap setup still works for do_testimage=
=20
is due to its "network" tag.

Adding Bruce to CC, since I found some fusermount usage in=20
vrunner(meta-virtualization)=20
when probing through sub-layers, which usually is setcap:ed.
There are likely other cases downstream.

Whats scope was tested during its time in master-next ?

> Cheers,
>
> Richard
>=

--832332921261772441789113173416590--

