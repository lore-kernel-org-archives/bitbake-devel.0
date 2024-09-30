Return-Path: <kweihmann@outlook.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACFBCF6497
	for <webhook@archiver.kernel.org>; Mon, 30 Sep 2024 11:13:30 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.92.58.79])
 by mx.groups.io with SMTP id smtpd.web11.52163.1727694807162888589
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 30 Sep 2024 04:13:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@outlook.com header.s=selector1 header.b=JRUriVem;
 spf=pass (domain: outlook.com, ip: 40.92.58.79, mailfrom: kweihmann@outlook.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okI3Md9wKSbWXDD1rO8wHECfKnKH7mDr/gmciMY8zC3oTZZ7JUe8aX17IYi+FHD9/qwt0aKk2mQIU8OONad7YAhY2bAlDOBPegzFD+uLx8tlFAhAUcfEWL815ZVdgKZRM7b8VUJGi4QMQntQHS2teihmPKDcKPSRRgiSowQ4DHFBopi0k/f/sCiFEqT33isRY44uHln7w/TRuUrQrVQ4AsKQSHYHKNJXf03DM6bJiSwly67S/W/KMPKnOoYi3kWh+XJFfEx+9JTn6PUlnAgUQADd7QUrx+5jU6Ujpvnc0M4KwnBcmYuWGqScATTmdX4hKe/RyqYoN0u/lXHl1DltTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bYOJbitGgt0CMpE2HLnQvMdiNN9Lh9b323DxaxJf/A=;
 b=pnScH60UdegsazE/I1QWYr6mS5V8THyt668NNkqevylxAuck6HPC++QMWC/rXrp+Z7KKLRA54rRVxYAOYUSHrOwYB3TnMFpGVDCET/5I/AftRtsyj8DPT2t650jM344XpmiRLeUmRN7WS31kXV0OrqtbHXY5apLfsrwTNr+eh0MTnhLYIRvpZ3hnbHeGst4/Xfq8I2YuPunZjweTwpCTOG2UylDvY798f+zY6bNWYIOq0nu/XqXkO7Q3sWe7+p9RAdjzap/qaZuZaXy7gSW1mY0vue48+LiSkH+PJ4fVNN/d+oNBiJu501ejs9Xn9ehk+4swHj2F/336gDKbhV8Ryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bYOJbitGgt0CMpE2HLnQvMdiNN9Lh9b323DxaxJf/A=;
 b=JRUriVemp20LpRPOZIe/U7O8G+bEoNgdDy05w0kfmVSfo2Ik6DJUFbZmnaLsQk5cg6geMgI/PklKLjLP14H5mWCaNp4TifXWL83FvdFxN7Suwdl4DTSrl+Mov2JfAUY7FyOHKS3N9mMgnaAeAXS18+HeG3zJXdsqm9rLXxrxPbKIK+DP0PC53Ijl58XydLAFYqY8QfWWTiPhc8byt2uWr2bciKc2y4u+UHpMSZiZ4aipS/pga0kB2TUHyC1vKM/O1ut6rl3GCsJHA/5CtvzOhk3kvd6YcSgI9TrXcwEAzslkGqHrLqfUlLhDb1oo0IqGx6f8vi6e4Wr0AzpQIw2fRw==
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com (2603:10a6:150:80::7)
 by AM7PR07MB6514.eurprd07.prod.outlook.com (2603:10a6:20b:1a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 11:13:24 +0000
Received: from GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a]) by GV1PR07MB9120.eurprd07.prod.outlook.com
 ([fe80::a630:7019:63e4:a48a%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 11:13:23 +0000
Message-ID: <GV1PR07MB91202E0541450DC69A204E4FA8762@GV1PR07MB9120.eurprd07.prod.outlook.com>
Date: Mon, 30 Sep 2024 13:13:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v3 2/3] bb/data_smart: fix override syntax
 warning
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <GV1PR07MB91208FE4BD9DE31DFD4A7318A8742@GV1PR07MB9120.eurprd07.prod.outlook.com>
 <e6694732a1e929e0a33aeba62713433019ea1dc4.camel@linuxfoundation.org>
Content-Language: en-US
From: Konrad Weihmann <kweihmann@outlook.com>
In-Reply-To: <e6694732a1e929e0a33aeba62713433019ea1dc4.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0438.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:81::18) To GV1PR07MB9120.eurprd07.prod.outlook.com
 (2603:10a6:150:80::7)
X-Microsoft-Original-Message-ID: <3837c7b9-e4e9-4f72-946e-59181eb4ed0a@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9120:EE_|AM7PR07MB6514:EE_
X-MS-Office365-Filtering-Correlation-Id: 71f6a698-8472-4c69-8947-08dce140e633
X-Microsoft-Antispam: 
	BCL:0;ARA:14566002|6090799003|19110799003|461199028|8060799006|15080799006|5072599009|7092599003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info: 
	QOuJcPeW/HkGQAlbdsKwV6mEbO49svTL7Z9XfuDigG9CW93cJgia4KVZTvgpJY3Q3botw4hIk2IheHeDUdhDA892Dz/rpIX1An1tiZLiTS6YYKpo6sXmUKTGqERNfH1nRwOWXt9vWjAwZfL0/nk3+sPSA7+XtUNU0VV/PLWI3MVE0KbUzo8KGuzE5yIl/i/D99LBO7o5Yk258wZ/MBMOAZFjF9IjVH12k/YAfUfmtNl7C31+0fvcblrVP4QKqXC3vRDq/hOTj+IsS2MdgrLtmQ2rq2+S2gR/lZt7k+6PDDNKHdFPYm3xtuH/3YLcK5DJoGG0Mdwnf9N+/38KoXZzC0FiJ1XqctrCOWOyuqHFzH3XXXCLmiroy9fSw628q75QmoqWsTDktQ182uqjMVUjFL5XoESlXH88o+Y3RT11t34q0lMIky4Xra7xZGL9/IzrAawAwTyOX2CQI/TWUuJ98I5Z90xDIKtLHSaOIZJwi0qXAwWigSY5nedj5Xi55cbjIT7244n5/8uey3KJp9KIsSAImETA7TPAjUNJ9DFRv/D3hrC5GNeauwPiinNzXe/JxwBTFpnmkddlMqzCkuFg+LBnS83N3BIoep5XoLMA6oYf7QCJvPzGBUFJQffWEfSAIoCsdwPGdcoYlkiNYzn90uloQP8jBboBtKMH6ddeyjO6GoxedcpPEcmwGtIXmzBO9F2i3oVd9hCvjcRourPbDt3hVgVovoT+vootkmjdzNf2wnPRfX8BsK9NB1ubQhL8+7eZQZNgWawQzsX8MSn5KQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?VnAEleN7ndnpOrFXvxEuk92XINqgywY6v3vwYrm/re/0Xw7VW41y1ttZCzBY?=
 =?us-ascii?Q?TeJrZR2q7ynLN0t9V7AAokw4vDu6gsvl8cQYs31KnKYocFlTvlqz+8VAf9Ki?=
 =?us-ascii?Q?0zJ5oRmVEQrS6rRdEywWlmQct/NTSx25AibDEFP5Viy0ppxDnC0zLInat+x2?=
 =?us-ascii?Q?jkG/zSvgSMaEV1Y6mCC2bT6u3wrWXfy6O68e1d3rygboQB+AniFHOaQIxNyU?=
 =?us-ascii?Q?gXdPp0j7jGIJ6ENf/MdlcDA9w+WXTDoRcnmvJoWoJ4B4Wk8iLDQ9O9TpgdOy?=
 =?us-ascii?Q?nnOTW9RzbiQv02qqc5yBwtWtFuJB7hccU/+Jnw98TgHg8IPs8KNC7t9i1iGK?=
 =?us-ascii?Q?sRRCgBLdYuXE3UICWBgPMA+amZYsWfH1ca9XOKNlkrQzmEg7soaM5kqNsggD?=
 =?us-ascii?Q?TNJ9jZDugwnbViuQiJCr3wZWVKBalZSW91nW3EHEhNAPO2Ol61YjpazGP3Pf?=
 =?us-ascii?Q?deX6BzjaXBHUSNPu2gGC20S552TZYDppfFTS6wsO3bRTXWTZASRiljnTI5T8?=
 =?us-ascii?Q?gkU6odIeyKBQo8GzAIUar8gQ1pTufQ1lyqFJLGl4dXeUntWlVKLueLTRg/Eu?=
 =?us-ascii?Q?fBDBLS18HoSDeVvygc9sWMUJIHmogALsFDFqJRJsdj5yWTVDHKwKmOwwv8wC?=
 =?us-ascii?Q?bobpWOCw6mlo6kFP60OLM50zde5GvgxJDV+RBESPulXzUE3S8QZOMPnDjBFq?=
 =?us-ascii?Q?ZGFiaMaqxD4WtPxWiJcTmjY7qaTpUxeBH5y1moHOXdwA+6Y15KFYK5lNljR+?=
 =?us-ascii?Q?AgLrERU7EQNnFw3J76fCAOxJ9XbLlgi1ExacBGybXux+9HwUwoeE3M1OllXc?=
 =?us-ascii?Q?2jA3/fK2akdbmqb8ermLKNnOOKNvrNg4mYBeZm1tN9g0slfalwDVc+vN92ok?=
 =?us-ascii?Q?g+BXKyTVlXTAJ7gBBP0z4CWahPOvw8JSwX8qYCscn8cfBCNR+xCzFbr2M28b?=
 =?us-ascii?Q?Kxba8f0Rci1WFidZoR7XhpvLT6Jc6lLBBJtls+bPGb/vrKEguv6jvEjq7/Hy?=
 =?us-ascii?Q?VHzTiDTenlKzjGcWJkR62fzMCtkdrZbaPemcna4AoGOQULvpu3klQsAWP5AD?=
 =?us-ascii?Q?exRQ4C2N1yspUEkpkG2/2prUWtmNU/e0HAC8DTh7mPTvzuYsAYR50lV3epnT?=
 =?us-ascii?Q?nuS6hP5OdmNLe9N+nou+vyUGVHtK4x/HROph6B8STtz9i9UF5tAlJiijfzaw?=
 =?us-ascii?Q?btLQtdrm7hTD7fM6Ao59tWBVlzAjfT+RC1HtOJsc2dAfHgqo73XlkkzM4fQT?=
 =?us-ascii?Q?qxXJdDOcm05WFoB/Ydh+hNCbWgSVlWrLdlwOUIpP24kaSd+gbaU91xzECtOP?=
 =?us-ascii?Q?lJU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71f6a698-8472-4c69-8947-08dce140e633
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9120.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 11:13:23.7896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6514
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 30 Sep 2024 11:13:30 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16617



On 30.09.24 11:13, Richard Purdie wrote:
> On Sat, 2024-09-28 at 09:00 +0200, Konrad Weihmann via
> lists.openembedded.org wrote:
>> when defining a function do_removesomething,
>> the parser warned about
>>
>> Variable do_removesomething contains an operation using the
>> old override syntax. Please convert this layer/metadata before
>> attempting to use with a newer bitbake
>>
>> correct it would be to search for a override operator at the end
>> of the string or for the next operator.
>>
>> To avoid running the expensive regex search on every setVar call
>> the current "cheap" check would be have to be triggered,
>> before the more precise check is run.
>>
>> Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
>> ---
>>  =C2=A0 lib/bb/data_smart.py | 14 +++++++-------
>>  =C2=A0 1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
>> index 4e15a43c2..0523744de 100644
>> --- a/lib/bb/data_smart.py
>> +++ b/lib/bb/data_smart.py
>> @@ -539,14 +539,14 @@ class DataSmart(MutableMapping):
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return var in se=
lf.overridedata
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def setVar(self, var, value, **log=
info):
>> -
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not var.start=
swith("__anon_") and ("_append" in var or
>> "_prepend" in var or "_remove" in var):
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info=
 =3D "%s" % var
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if "=
file" in loginfo:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 info +=3D " file: %s" % loginfo["file"]
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if "=
line" in loginfo:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 info +=3D " line: %s" % loginfo["line"]
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.f=
atal("Variable %s contains an operation using the
>> old
>> override syntax. Please convert this layer/metadata before attempting
>> to
>> use with a newer bitbake." % info)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if r=
e.search(r"(_append|_prepend|_remove)(_|$)", var) is
>> not None:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 info =3D "%s" % var
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if "file" in loginfo:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info +=3D " file: %s" % login=
fo["file"]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if "line" in loginfo:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info +=3D " line: %s" % login=
fo["line"]
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 bb.fatal("Variable %s contains an operation using
>> the
>> old override syntax. Please convert this layer/metadata before
>> attempting to use with a newer bitbake." % info)
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 shortvar =
=3D var.split(":", 1)[0]
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if shortvar in s=
elf._var_renames:
>=20
> The patch appears line wrapped unfortunately (it appears as quoted
> above).

O_O - okay that might have been my mail client.
Ever since Microsoft decided to drop plain TLS access to SMTP, I don't=20
have any other way of contributing any kind of patches, but to pipe them=20
into a client that supports oauth :-(.
(P.s. before anyone jumps in gmail is not an option for me ;-) )

>=20
> Also, I would still prefer a pre-compiled regex. I appreciate python
> just have a last used cache but I'd prefer not to rely on python's
> implementation details which can and do change.

Wouldn't that have an overall penalty on the runtime behavior (I know=20
it's only once)?
With this inline expression, it would actually only be applicable on the=20
pattern in question, so for an already converted layer set it runtime=20
penalty is +/- 0, while with the precompiled expression we would add=20
something on top for all users.
Just want to make sure that is would be acceptable for you, as my=20
understanding was that any penalty should be avoided

>=20
> Cheers,
>=20
> Richard

