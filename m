Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119D5C433F5
	for <webhook@archiver.kernel.org>; Tue, 25 Jan 2022 13:10:06 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.83])
 by mx.groups.io with SMTP id smtpd.web08.6747.1643116203758172251
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 25 Jan 2022 05:10:05 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=H5dLT7/J;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.22.83,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y2NSJZGkNzg6z2EmpkWq8fE3/8e+Ccng+FES/qonaX7d/K44y/uzux3dD7ZnvdLxN22nTNxMR53aD+LubrYW/4+lG+a9TXI/sXsXpyyklDksemugUE7WNdJgv6ZPYhfSW4Z5H4nhcMufa3SzAEQyneQAbtM7ocRVQu/jIOXkIHDoXMz2vhXl7sMocb1G3lNoSln/olhftuZM5UQ6V9DVQGZaMDqXWVL0fviZwUaB3wZLv+cD6RtPm3hZ0EMZ0bxdJsgy36d/AA2gsKdep+f5rlONleGyDhuWmVdawnetfL8QALwOSvE5zKolAW4G5v8NE7cuY+VCtsf/cGV/hbzjuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bI3XLeo8Dubi/ZVQwFYWgzJmVoQynJZ+hhyjuluEX18=;
 b=lyr4eyX+iS7VmpeGj23s53j66KZUerUiqHckF3qKBXD1uwVbXTUBrBtmcf5gp9UW4S/0iB6MHArQwRjogc5f7wWyLlWnQ1H2OUzwJ09+zQvfP7SASupCpieABgjusKYCjx2lIecB7t2/cGt6AGrjNSQxXK0u+a4YqXaaCfOi8wnp427h2/mnWfQFlWbTC6WDEdZTxeKmcSKMuyMDfzcWGufwEy7bnZTgrLtEAJJL1fAeS14dAh40ACcxXSG7GFYDLDzHNMPPujDw0fg/O208LsN0jBfTaP5CKNcFi9iBNuMzskqhAdB0qthoUrRqlmBVNjRsWRoQ2JaqlXTw0eVZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bI3XLeo8Dubi/ZVQwFYWgzJmVoQynJZ+hhyjuluEX18=;
 b=H5dLT7/J8G2kYZK7P/KgMTdOKqMrHgVyMrJLjCQyeO0P3CjzqVW0Dee4UGCuZftQjht1iifDyy9lOdeR7bR99a59KxB/3nOTFpyNxO5WFW3+P3OEP3tnHtf/ZfW7S05fPSMuywT2YqfWHN7qmI78sMReJdGZPg5OVOCMznv12jY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7)
 by AM6PR04MB6101.eurprd04.prod.outlook.com (2603:10a6:20b:b7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Tue, 25 Jan
 2022 13:10:00 +0000
Received: from PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::a8e8:87d3:e868:cc93]) by PA4PR04MB9367.eurprd04.prod.outlook.com
 ([fe80::a8e8:87d3:e868:cc93%8]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 13:09:59 +0000
Message-ID: <065a7bcf-5fa6-8261-a2db-df85a839b1b1@theobroma-systems.com>
Date: Tue, 25 Jan 2022 14:09:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [bitbake-devel] [PATCH]] checksum: Support uri formatted file
 list
Content-Language: en-US
To: Paulo Neves <ptsneves@gmail.com>,
 Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20220121153905.1701521-1-ptsneves@gmail.com>
 <db3861e842d22d49b7c834d9fbc9a5ca613bab01.camel@linuxfoundation.org>
 <eb092645-2fbd-675e-078d-9dd464ca64ef@gmail.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <eb092645-2fbd-675e-078d-9dd464ca64ef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VI1PR02CA0075.eurprd02.prod.outlook.com
 (2603:10a6:802:14::46) To PA4PR04MB9367.eurprd04.prod.outlook.com
 (2603:10a6:102:2aa::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9e63322-35ca-456f-e8ef-08d9e003fdbf
X-MS-TrafficTypeDiagnostic: AM6PR04MB6101:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR04MB61019E966D231D0E99321EBFC25F9@AM6PR04MB6101.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	E1s7LKdljy8hMSu1GdYrpjiMj/qCH2NZYMnDa+PliirKmQ8ysgReuDS6eYuijDDGohz7NY+ZJyl3WnszQbAHgLTIUsvj7MJODE3FJLzr5LfuqGvWhG2k4UC2VlL5i8gLwSOQq3OxYhQrwyj8xLWeKBbgi1nMw2yTX+sKLOj8ap0p9LP5wEX5Jqjlv+CnNSKAuarOPC64atpNnrk0B1/ouKwRt63TtpyOmKn+ta5CJQcuO9k8xra3hp/Og1EOG8V2qzMFFf/SNdMvqOVm3uZypUuZBPG0d4oRqa3V/HXxt95mppwZSpbxrX4sCr4TCswLuvWeEczLQsWXlS0jvrEFRWrWYjoeJuUNCRmLoIhK9VI/izuSux7WkkfLlJ0iCjLIy0mHxq3Uv0W6xERedWEw4uvQc7dWQNDttEG9fqLgUEqsn5JCgBwPwxq9QJeuOPYRlncs3lZxLIAxloi8qmub1LXNQmtU9nCs+CKGNWsS1FqmsKBE8QnScZN9RIbl/jDaTiKtaMUTKqm3YEtX59ReE7x/UIeL/JFyflbgBOmsK3xqNjCU9FveFbAW88OradxfTq6MxFSvtcMO8XyMMmFK51k/94Xyb0DkhZS096xgsiinv6Juh9sdzI0Uf0gs9O7/XdMlycA0PDyc+MiuLXYD33uv7WmyLWk3Oy7vnjlkDn3Xhuwh52Q9eIIazLCD5RqicGC3h6kb9cxgDWY3+9Pxd5aPmyP0q1jeF+w4IJ9p6bUJ3tyeS4ehMhyDUTJM+zGsDwGCFT9JYTtAWx80Qmhs6WAsWXCtiBhXKmtPtOuC1ig0FtxY9QN+ThUKl1YYECc+
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9367.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(966005)(2616005)(66556008)(6512007)(36756003)(8676002)(316002)(44832011)(66946007)(86362001)(38100700002)(66476007)(83380400001)(6486002)(110136005)(6506007)(2906002)(53546011)(186003)(5660300002)(31686004)(31696002)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UtISAaY432lHS8Hd13w9gnArMe+XqN7ZHUitD+yGORucJd71GxTyN0m9JO9P?=
 =?us-ascii?Q?isbW3rqeJ8dQTqse/15fdBgLPP7BLx7goVHhFjSVR3DN7ZsL9u4xjGqcwBNi?=
 =?us-ascii?Q?mELSEhzP+ZR7Zx1APLc0aZ6M5NODJ54wTFdiOTGNhHiPEqKVf6J0GQjxhGIO?=
 =?us-ascii?Q?lHUx9xhrTehr6afkaEOwVsl5AbHBjppFJgBTNeqqizfjxBq8PBzF8byFqKiM?=
 =?us-ascii?Q?U2SWZNbWSekdnrZhHeDsWS/oh/tKX+A8sBHt4hnWuCUWxDfDHAJQfvNCBgOF?=
 =?us-ascii?Q?0uCg8yc4xSNOok8AGTfmVatBOgFUaK3ckkbc5ItFPrMNPZE38h8SoEap3B8X?=
 =?us-ascii?Q?xggKeZLPSEUzwkAH9h31A85U7GsSU+oyNjHNst3YrlA4N3Oao3ZL7U0H0tlA?=
 =?us-ascii?Q?l2HOrMSLF+bhu4ns0jFa8M6AUfVlL8bE4vadYETCeBP0HnkR8kTp5uSpkhaQ?=
 =?us-ascii?Q?N15wmCHhnrdDTHz7f4+S7fusolrmG5HFuTtHzpVYBgXtwW7tOSPgEpigURug?=
 =?us-ascii?Q?uXFUVlhxmBDNGal4C8fku2UMN+zHl6iw6K2lCRtpuOVJRrKSD9etFlrBqHob?=
 =?us-ascii?Q?u1EP4cEHmYygeguVbJzchhMkZf94jLftIsNvd2zJuxaFkM/orsTCp0Usouab?=
 =?us-ascii?Q?oQxOomJV9S1tbP9Fc7gG3yr9tcF/J4hRTpGsJ2Ou1lZ7/wDokS9KAo5goWIj?=
 =?us-ascii?Q?O/riJ2jmH8NfqMxB0CXg38EGqU9uMKj0u0E2trg+Hmo1XH76y7+JbB3M4cAb?=
 =?us-ascii?Q?eKm0ydS8tqelhp3aFHRg2RBL//5sX1LqJMZlJLJtZP1b/0A4MoFfS4xqHgmy?=
 =?us-ascii?Q?+8mvTaupbvd2JCdWgZz/gLMkWeK/KdUDaQwgVTYVwecNkUe9+JiFDDLp43MR?=
 =?us-ascii?Q?iN0qw1VXNEGvz5SXLcST1VwQr6gagmvt+9SXsjYdNpMFfFb2vCPAqkb0FTJm?=
 =?us-ascii?Q?UM7K4zoReKfXs3D+r5JPp8B0XEmmM9iSMzpZWZG51mfV9JyqscOhe1xEJ5+1?=
 =?us-ascii?Q?A0Qu9fVBYiRnvnXi5trXg7G8gBtgsfhpQTnWbnzfpdg2i1MJRR3XODb0GiB/?=
 =?us-ascii?Q?OaLd9Z916cLIwPA6vKONiOzvleWfgVn0Xquts12W9H9W2nK3dQO3RArxcupV?=
 =?us-ascii?Q?aH3qZQMDqv+GM+QHidj2YO6TwVZx8qGrLaCCN2fIC6WfOwOl+z7Bbn1TfJxO?=
 =?us-ascii?Q?vi2N+IM40GyKxogE8JJvzWmuZN65fn1y5zJh+Z2xCMVcMp+/EM2yyhsodiJW?=
 =?us-ascii?Q?9Uwf4A5y0t6decE7ZOEfAKhBJbWIcFEwcCB+r9uCVRbiGOhdriWuthK7yDZE?=
 =?us-ascii?Q?d9qsAnfDeSpYkoH5jOKEaKjqlRryOT/oOHrHNzVOd2imHtXju47oshyr77hC?=
 =?us-ascii?Q?2bBFxo+hA6XW0ChrNdkiwEKDPGXY42Bb5JaGFhDUlr6Y101xJ9m542x/SsGF?=
 =?us-ascii?Q?Yzje5FmjZ+6EGXBLOTYlgK3PRiKKXaMWTtQBRXpo6sXjGD5hbT482kWTvl56?=
 =?us-ascii?Q?SxkVPE4XGk4ClX13bzYbks2/fJjJCmCwlgbRA8mm765ysbpPPE8hXZ7TflI7?=
 =?us-ascii?Q?ashdAcrWKMENYXStiB+3aNEJlFyZFCOuP9fk7uo/4sShaDdyeL4HdP6FQrmx?=
 =?us-ascii?Q?CgkNjTQguci8V/W0bSfPfzfmtKnREe4qOausjYHuQSGRgdQy5tjaPDXFBEwZ?=
 =?us-ascii?Q?J/QmebQ92jj7QPgxvlia1tZjR28el7L5/3XD/eqNLMFUPLOcZsjgTTrywGM/?=
 =?us-ascii?Q?7/+jIyhun9yYPmqQ2+w5A98pFvPk0ZY=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a9e63322-35ca-456f-e8ef-08d9e003fdbf
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9367.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 13:09:59.8403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 tYfjA324unnLct34Ux4EqoplmaEOgdM+/8ECcEfyyaLR0tgmTOC5nig+Q4ErzhZHtYXFmfpIhR2Ga9suaynNtUDF57XJE+V9FPc6ubU7hK+xJUgdDFaxl4srP3WxRSQz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6101
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 25 Jan 2022 13:10:06 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13281

Hi all,

On 1/25/22 13:55, Paulo Neves wrote:
> I am not aware of it directly being done anywhere but files declared in=20
> the recipe are in URI form as far as i know. Where in the self test=20
> should i add such tests?
>=20
> Paulo Neves
>=20
> On 1/25/22 1:20 PM, Richard Purdie wrote:
>> On Fri, 2022-01-21 at 16:39 +0100, Paulo Neves wrote:
>>> Before this commit, if the file list for checksumming had
>>> files names with spaces there would be a crash. This happened
>>> due to filelist.split breaking on the file names instead of
>>> on k:v boundaries. Now we validate this case and emit a fatal
>>> error if such case is found. This needs to be fatal as the split
>>> will generate broken k:v from then on.
>>>
>>> Instead of putting literal spaces in the file list the user
>>> should urlencode the file names and if they contain coded spaces
>>> they will be decoded. This is consistent with the current
>>> practice where file names are urlencoded. A reproducer of the
>>> issue this commit fixes, was to pass a do_compile[file-checksums]
>>> list with files containing spaces in their names, urlencoded or
>>> literal.
>>>
>>> Change-Id: I6ac4f1cffbb86e913883491d46e8cc69a028e992
>>> Signed-off-by: Paulo Neves <ptsneves@gmail.com>
>>> ---
>>> =C2=A0 bitbake/lib/bb/checksum.py | 9 +++++++--
>>> =C2=A0 1 file changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/bitbake/lib/bb/checksum.py b/bitbake/lib/bb/checksum.py
>>> index fb8a77f6ab..97cf10825e 100644
>>> --- a/bitbake/lib/bb/checksum.py
>>> +++ b/bitbake/lib/bb/checksum.py
>>> @@ -8,6 +8,7 @@
>>> =C2=A0 import glob
>>> =C2=A0 import operator
>>> =C2=A0 import os
>>> +import urllib.parse
>>> =C2=A0 import stat
>>> =C2=A0 import bb.utils
>>> =C2=A0 import logging
>>> @@ -110,10 +111,14 @@ class FileChecksumCache(MultiProcessCache):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 checksums =3D []
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for pth in filel=
ist.split():
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exi=
st =3D pth.split(":")[1]
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spl=
 =3D pth.split(':')
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
len(spl) !=3D 2:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bb.fatal("found unformatted path in filelist " + pth)
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exi=
st =3D spl[1]
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if exist =3D=3D "False":
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pth=
 =3D pth.split(":")[0]
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pth=
 =3D urllib.parse.unquote(spl[0])
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 if '*' in pth:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Handle globs
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for f in glob.glob(pth):
>> Does any code currently urlencode the filepaths into this flag?
>>

Not sure it's related in any way but I've had issues with spaces in=20
filenames in externalsrc recipes in thud.

Wanted to fix it instead of opening a bug and I forgot. Been a few years=20
already :/

May be a way to provide a reproducer for this and check this patch fixes it=
.

Cheers,
Quentin

>> I think we may also need to add some tests around this to=20
>> bitbake-selftest...
>>
>> Cheers,
>>
>> Richard
>>
>=20
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#13280): https://urldefense.proofpoint.com/v2/url?u=3D=
https-3A__lists.openembedded.org_g_bitbake-2Ddevel_message_13280&d=3DDwIFaQ=
&c=3D_sEr5x9kUWhuk4_nFwjJtA&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4=
njZguQhZhkI_-172IIy1t&m=3DpncegqWmjAxc9HxxMkfqtewvKngB2W_pcdgejWkzwLKvGFKmf=
r6uVcaphu-SiuwN&s=3DmLKHnmnxJkR7swGcar1oHE6xSVtMIr693Gcm7foIKTo&e=3D
> Mute This Topic: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__l=
ists.openembedded.org_mt_88585130_6293953&d=3DDwIFaQ&c=3D_sEr5x9kUWhuk4_nFw=
jJtA&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=
=3DpncegqWmjAxc9HxxMkfqtewvKngB2W_pcdgejWkzwLKvGFKmfr6uVcaphu-SiuwN&s=3Dh2H=
L5U0BZSx3nzTr6VH_57MEWt3w5l1rMfSOQem3A1Q&e=3D
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lists=
.openembedded.org_g_bitbake-2Ddevel_unsub&d=3DDwIFaQ&c=3D_sEr5x9kUWhuk4_nFw=
jJtA&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=
=3DpncegqWmjAxc9HxxMkfqtewvKngB2W_pcdgejWkzwLKvGFKmfr6uVcaphu-SiuwN&s=3DuFE=
WtQO2c-QNbOVQsu7jvNWbudDEpbbuWtZHwy_ZFJ8&e=3D  [quentin.schulz@theobroma-sy=
stems.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20

