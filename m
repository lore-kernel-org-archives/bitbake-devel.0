Return-Path: <jaipaul.cheernam@est.tech>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5590CC55838
	for <webhook@archiver.kernel.org>; Tue,  4 Aug 2026 12:16:04 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.38])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14971.1785845758839696532
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 04 Aug 2026 05:15:59 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@est.tech header.s=selector1 header.b=PqIJuCO9;
 spf=pass (domain: est.tech, ip: 52.101.66.38, mailfrom: jaipaul.cheernam@est.tech)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=akwKtahx3dJm1aTLwEzDanRmOYvHyXt5G4swnwDEB9G4asOjMj1xmc7Yfexczjz5ugZ3T3C6NOBE9NX8ccdbrJBTN/MwiZhCutd9+/0PRjPBxvNBMMIJk1slQJ9f9TuGq6TGpueTRZMMWlGwjebFV5XQ7ZIbwzBQLkSDNhzkP44BgYH6A1Rcd7WbQ8AbRDdY+UeXOOYyYuqHwmvcdw1xL+k5RDkzhuRR+QMJdfxou0EXhicRTAG79NviiOGGZmwa2MsamcvWLhGOst2OpuaERXq/5q6SsyUCaQ8DZdV50gdufZhUWyfLu/sOhZbKSQSuaw4FivgUFqmMbQuHxgwBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfZxg3cTVWlh0TBXntJ7qleFp6WJCKseq48pxBkri0c=;
 b=fUA5vysMdHn9OLRoRcKbmmnpz1VKsrrSlPbn/uj441YnS0vj7xRCFO43j/e4HTDKM8J3Q3AFEISnuz8sX7uQT+avk63HwrExUCG961pe060Tofn4n9br1ADbjzQ9WSbtt+ejsFGpRoEKQvfIjQ8Fzk3dMjR/mCXjpz3VkrAntyk2eNCx8cl94hXanxyEJfBCk0ACpydvoHTTP/8SKWLZJevhTrGI/rXd2wfj7GgJZv66VjnzTN8mFfRNVBgUtAJCcTB5vlpST6czqNjbP837ycZ++j/il9wRrwVLiJelQpumbdhOVDeDmrx6zuX3lnY3vSlCTaC3bMAVoUG+BHj7hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfZxg3cTVWlh0TBXntJ7qleFp6WJCKseq48pxBkri0c=;
 b=PqIJuCO9z7ZktAg4SUqZFeN3eS3J+aFPKOoJoWQYRhSb7YcaCmTPBIgn8aaBmcG+7y7M49XNfrpkLzGB2YoDwoaxI4XO83pvbdv8T7JxnIU4Fc3jDH2T3h4cwZN6zMRx3oLxMLI7ypRxlzo/GkeIcg3kJY4OeghpdwSLrhaTqxnX6mw+o4B09Gm7e7PwwlpFh1IyOS2vzXAEkejMotuGVxm9OYuls3TcTYo4NeO8x0aMIWMsqtH/LB8bpinwjCL48hnsBH66Dfw1SiH8MqRLTpvriFPd8RkuLkhUaFNI+WKC7lclBIfNXfuNYgmFC1dWSls6Y6CmJfpPX4t7Gd7FxA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM (2603:10a6:18:3::ad4)
 by VI1P18901MB0640.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:12c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Tue, 4 Aug
 2026 12:15:54 +0000
Received: from DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::7ab2:c6af:6760:5c85]) by DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 ([fe80::7ab2:c6af:6760:5c85%7]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 12:15:53 +0000
Message-ID: <30ef1b6c-cdce-42e9-8bc8-c94c67fa5b68@est.tech>
Date: Tue, 4 Aug 2026 14:15:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH] parse: warn on trailing whitespace after
 line continuation backslash
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20260804090834.99906-1-jaipaul.cheernam@est.tech>
 <056c55ee98f7d48caa6bf45152cd63115b9d3132.camel@linuxfoundation.org>
 <9a3bc50b-89a8-439c-aa44-1b2707a88ca4@est.tech>
 <34211867d74a9757b5b0ff10e7ac3c0b4811ceda.camel@linuxfoundation.org>
Content-Language: en-US
From: Jaipaul Cheernam <jaipaul.cheernam@est.tech>
In-Reply-To: <34211867d74a9757b5b0ff10e7ac3c0b4811ceda.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: DUZPR01CA0296.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b7::25) To DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:18:3::ad4)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PPF66507B2D7:EE_|VI1P18901MB0640:EE_
X-MS-Office365-Filtering-Correlation-Id: a3982f11-4171-41ba-86e8-08def22220ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|11063799006|4143699003|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	0GRJme/8QNydyx/v7fs0BP9lZesdSwJmrM/rCOcp87N+iuY6FQDRnJYh6l3KXiVwWvRrZwBbEcGK8YLxQUlM3yPISoCVu2wDQ+F3X6Bp8rm/XsxZv6mjShGSJW/os6BWh0CTQUe7sAq7ObObBR8FndK6vUSVJxFeA7ZSpyag6rX2DwYGb89ZOmBWz0oD1pXxlCwBs3xuvBzTV0RSSHjXc+2WTENhBJVwti2IeeCrbapEngABP8wVOQVnAoGbrnzyfYA3wcpAlWDtukF5pIJnx0mWZe/REia+QJp/63dyd6Uo6uuuiU7q4m7ihSzk2sAjzKo5mVxFlDc1nk5hNRgoQGQ4k84Sg8Ku3DKDU70mBd3bmiKRSS4rpc0wbnHCrCZH3JyR+RiZX6NSE5bzc2x905IHG+zr5DTMZ+dK4vNjp66+AD36O+EXiUBN3mQFDBQTdMm+ZBQtSwBB7GjGDBEF2tlSddQaLZDM8uz6vdZwQGxmlQpg6AVBlpEApYD5J5dAKrX3/mDGSMJNpIexBMXugw+97cXICAx+16+p/hBUfnNnngf+jPEMPbb0sWiKcJGb1ZNDbIg3LZhPvOCL5zb7VoVe3UVUvtLXc6+b1iAGCbAFm5eHaBozmP5hppHwHcv07N/pQd/mbKekaC8mUJikVwTJ2snJhjQYwCPQ6/2avkU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?KzxqxlB1l6uoG0q36ovOe1EN7aeI8RDTp9vSOTJoReL6/3r18dMvfzqX7okG?=
 =?us-ascii?Q?YFdGjQxmPl8trk8XnkGF+Mena9sgksvtbftWAM6avY0JeMLyssWAhWsu8HHl?=
 =?us-ascii?Q?iaMfVt06sr43dXdtJytC9tmpyATwRieQ31mQ5SWK6jExy/ufZrpTLe/YRFEY?=
 =?us-ascii?Q?2yO7vkrERyEvlFAhhwuh3EUtPTwqApRqHCaVMmChmRZZjopObAkQK9l8ncNu?=
 =?us-ascii?Q?fW4AioH4kHIohmo+T1cisXgX+O06h+xeItMQseMKHDRzPo+LoIBw/v8qBA5y?=
 =?us-ascii?Q?5ZPzyWDABL7zuaDilUbJfMK/yx2mo5Y+kOT8+0YMI7GVpMpBOa83CQ/CLTLl?=
 =?us-ascii?Q?oyXOVq1xkYZHziN9nbzrR6t51qoc1ZunOqEC+rrqczAt4FijrK9mmd14U6Cy?=
 =?us-ascii?Q?eWigqNSU/QExps/qPqaEoVZ4ai+V5tQk3eUrXvn5uBfvRMNW58C3/xdRouME?=
 =?us-ascii?Q?velAXaNjB54JRzsRDCRMo6AWz1ymMNk2gcXpmQCpQui8nqsAC0zxDU1t0qfi?=
 =?us-ascii?Q?vKbI9e/tjrTizfLHU/XocHV3wRJ/elGY4PE4zJ1P1hG/oDOvS6gcbONtDNpy?=
 =?us-ascii?Q?3arESy1gTF8a9aazUnFlx2bypsWiyj+dXTGQlqlemcQhojdP0GouugahnzJu?=
 =?us-ascii?Q?x2jsJwSbipIyLgnBpKKPv43Eg/wUTr48vFWAph7sZtjfBfL9BmFSWoBytLgv?=
 =?us-ascii?Q?+MQmv03gDIF3Wf+8S6EoXfLtdSqTDnrdopc3lUJ/72k29o6CXlT8YlbTd6WS?=
 =?us-ascii?Q?bOxUtnsb4hraIoqncowjY7k5NORX/fvAT+kCBhM3MAgWTTtycq99+bzbcBil?=
 =?us-ascii?Q?FmHovqZGfZ4ks1WjAZJ+HBJ4fcWCu3iyBJHHDjIJZT03X53FYIRF9ZP4FB83?=
 =?us-ascii?Q?LIzN1MgxxpuJ/deMeBjUVNW0dhAWMpDWukwIQ8de50+D0LVndUpJrv5KaGf9?=
 =?us-ascii?Q?arJ/ZQHr4xF8tt8MFqcoM4V8nNKjFRtcYKFlnTn06I6BEgXvJ6nZKHKy4/HU?=
 =?us-ascii?Q?r8v0vLACxoA352PAu8oY3GO7QPspo2PGIOFQCQjAFF0oFKAiARpfhYomi0SC?=
 =?us-ascii?Q?+haUyYg0dULIxnSADYjsASzaRbcaZXcwLGHft3N546PVCM3Vo/99fWd6IzE5?=
 =?us-ascii?Q?OfHNyrlcCBCggW77Lo6SR7fxkqBcFVfbEio5bbuyAde8R55RB8DKdl9cBY7c?=
 =?us-ascii?Q?ruQKoN0kJzUCFRF9zaEXAjbHFjYvYVHGiuSPvUdHXzs09qROO/1tXv2gjPkA?=
 =?us-ascii?Q?Fldxs8KiPmFpmroDyYNfI9lIVWdVYCRWExW4gM+46ApTs71NfonWumUA1PyJ?=
 =?us-ascii?Q?TNZSBQsR6gCWTEW2wKfoVxExdMbs0j2J75Fvjl45uMEfkZFSJXY0HJfniNvX?=
 =?us-ascii?Q?qaZJ7dSeQNcXevSHawRnRJYo/xfuArw3F7zB0R1GPeiTHNtuJj9vBlocHzoY?=
 =?us-ascii?Q?wJ2O6OumUlkTqMb4LMnvRsUqF5yFBs3lK9UKe6JJfvqZIknMVSZ+zeHsHB6X?=
 =?us-ascii?Q?9rFut9j776CR5nzdh3MMz3+yEeDXFVwZgh6WAeT45bUPj2t3EO0hr+m1oqKt?=
 =?us-ascii?Q?Ssp+FbfTCez///PvXVj5i5F4sMvnOs30NsEIVMDo3R0xBo06AHbN1R+IAE9F?=
 =?us-ascii?Q?3jTB5wZWgKhTzfmHCmZsB+6jA+GP0vx15X9NqcbQBm3T3lUxGWQ4gsIYCE0w?=
 =?us-ascii?Q?l1Y8Sw+ifQNPIPenSF/IejVfx+zpJbLDj+zlahSjcaX6a/0laTMKZT/7gKkD?=
 =?us-ascii?Q?IltW23fY0D88CkwQXYcwntxfNbwdqco=3D?=
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-Network-Message-Id: a3982f11-4171-41ba-86e8-08def22220ee
X-MS-Exchange-CrossTenant-AuthSource: DU7PPF66507B2D7.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 12:15:52.9568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +vGPTysyr15oenhAJdDnxG7SL/0SjZzbJbMuYrIqaDkemGmxAJAdOGtJyepGfWYbWeUsPiGsYRmAcEOeUqh56LVwo+TKAuJNhwr0hS3TriI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P18901MB0640
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 04 Aug 2026 12:16:04 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/19901


On 2026-08-04 13:37, Richard Purdie wrote:
> On Tue, 2026-08-04 at 12:37 +0200, Jaipaul Cheernam wrote:
>>  =C2=A0=C2=A0Hi Richard,
>>
>>  =C2=A0=C2=A0 Fair point =E2=80=94 it doesn't break parsing itself and t=
he code churn is
>> larger than ideal for a warning.
>>
>>  =C2=A0=C2=A0 Would you prefer if I just submitted the oe-core fixes to =
clean up
>> the affected recipes instead and dropped this bitbake change? That
>> solves the immediate problem without adding complexity to the parser.
> You should definitely send that clean up for oe-core.
 =C2=A0 Hi Richard,

 =C2=A0 Thanks for the detailed feedback.

I will send a clean-up patch.

> I was toying with the idea we just make whitespace after a line break
> character a fatal parsing error. Most of the fatal errors are inside
> feeder() rather than where you changed the code.
 =C2=A0That would be the cleanest long-term. A fatal error for whitespace=20
after \ makes sense since the backslash must be the last character =E2=80=
=94=20
anything after it is always wrong.
> I then looked at the code further and it isn't just trailing whitespace
> after "\" that is an issue. For example, after "}" closing a function
> could also be an issue in the same way. I didn't look in detail beyond
> that, there will be further similar issues though and that does mean
> your patch is incomplete :/.
 =C2=A0Good point, I hadn't considered that.
>>  =C2=A0 Alternatively, I could reduce this to a bb.note() (debug-level) =
so
>> it's only visible with -v, keeping it minimal.
> I think this needs further thought and some wider testing of how
> widespread trailing whitespace is.
>
> We might just want to make any trailing spaces a warning since we
> currently just swallow and hide it unconditionally?
I tried this =E2=80=94 warned on any trailing whitespace in all parsed line=
s=20
(comparing raw line minus newline against rstrip'd version). Running=20
core-image-minimal:

 =C2=A0 - 1665 total warnings (due to repeated re-parse of same files)
 =C2=A0 - 59 unique (distinct file:line)
 =C2=A0 - 31 files affected (.bbclass, .bb, .inc, .conf)

Most are in bbclass files like sanity.bbclass, buildstats.bbclass,=20
useradd.bbclass, kernel-yocto.bbclass, libc-package.bbclass etc. The=20
duplication from re-parsing makes it noisy without some form of dedup.

A few options for v2:

 =C2=A01. Keep it narrow =E2=80=94 only warn after \ and } (the cases that =
actually=20
cause patch conflicts). Around 10 unique warnings.
 =C2=A02. Warn on everything but with dedup (a module-level set). Cleaner=20
output but adds state to the parser.
 =C2=A03. Warn on everything and send a cleanup series fixing all 59=20
instances in oe-core. Then the warning stays as a guard for future=20
submissions.

What would you prefer?


Thanks,

Jaipaul


>
> Cheers,
>
> Richard
>

