Return-Path: <quentin.schulz@cherry.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED7CCF856F
	for <webhook@archiver.kernel.org>; Thu,  3 Oct 2024 08:56:42 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.78])
 by mx.groups.io with SMTP id smtpd.web11.6910.1727945794614118996
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 03 Oct 2024 01:56:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@cherry.de header.s=selector1 header.b=A4L05+4F;
 spf=pass (domain: cherry.de, ip: 40.107.105.78, mailfrom: quentin.schulz@cherry.de)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceWz4PQAH/WhuhKn+dSDZ0cRpRyfyIHi2Um88TfzBpO5TMfV/zX9gg0IeVTCOqHXJWMfWJaBAysg4f4BkzbVAoM07m7QV1B1AraeqoZHroF1aH1o4HhLtHXUuBFp3hM2KKHJ101R/SgaCaE4Up4zM+UJbJcaPSEBavRZg6JxBxD66fX2IKvy+8+io/xpWI3GGGIs0W5xr3zuOlGXnagAyp8lhlKtQNb0BuZRoXBLXDy+pcV3pbWIPfEUndI6R+r/FmYjnnVb+pcR8q9kY0BCcJqVbyTFvES/ywJCbb1a2exN5FIIr5U43D64rnn+8DHRm8OgskIvQBHGxK2iyfWqww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHTWoltVWoLB/iRe7Y6yi7NVGF2ueDgE4Mpdir9iN6c=;
 b=EF/SgoG1lSHRPBJze4mRK4dcaHJSrlw35rGfTMqSVM2gb6ouEW4PjqCPonpoX7iXX5EZ7zDHWU9JiaAVo9TxnxdHE1MbEjcJ2XAJ0vr/FgjnG0L1+JSCUzw8BH5qqxpHx6VFJs+sYqfTHzs9k+0ohoAqqYaPZ9v0Wf08L4I5/MO42n9ezaTi68SBvdyKFKGloIP0N711dun0E7LXnTnDt1OISlhl1Xi3SZjlZbh59PL3AxwJaYQdSavzGNgicJ7d7rII1IA/bl8Jdx9iobFC+zwRJRZqqBvuql/hiZ4wTIqkOD5s6cKepkc+WWzTomPbog2qGsbxcStrHsvgyzGKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHTWoltVWoLB/iRe7Y6yi7NVGF2ueDgE4Mpdir9iN6c=;
 b=A4L05+4FB3h2BaP7k3DqeW5RxWeT/VWC8GcPVGf7c2EKtClu5rLE5tP6cKKsS5eHS9gnS5kw29QV/pJfKP0QYU7q8+BvH4k2OhqDtHNDalHR7698/KEa7UkMvdTBpmgmVS+3qbENG/r9Km483EAoOA1Pjb3LdtZb2DEs/uAQ3gU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV1PR04MB10800.eurprd04.prod.outlook.com (2603:10a6:150:203::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 08:56:28 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 08:56:28 +0000
Message-ID: <d6fd65fc-1e12-44a8-a80e-0016867ec3dc@cherry.de>
Date: Thu, 3 Oct 2024 10:56:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [bitbake-devel] [PATCH v3 2/3] bb/data_smart: fix override syntax
 warning
To: Konrad Weihmann <kweihmann@outlook.com>,
 bitbake-devel@lists.openembedded.org
CC: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <GV1PR07MB91208FE4BD9DE31DFD4A7318A8742@GV1PR07MB9120.eurprd07.prod.outlook.com>
 <e6694732a1e929e0a33aeba62713433019ea1dc4.camel@linuxfoundation.org>
 <GV1PR07MB91202E0541450DC69A204E4FA8762@GV1PR07MB9120.eurprd07.prod.outlook.com>
 <342c2498-9580-4692-b5b2-1e3c3779d6ba@cherry.de>
 <GV1PR07MB9120BCEECD7A2BD204CF72A7A8712@GV1PR07MB9120.eurprd07.prod.outlook.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <GV1PR07MB9120BCEECD7A2BD204CF72A7A8712@GV1PR07MB9120.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0104.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9c::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV1PR04MB10800:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c00ba15-32e3-4e67-a01a-08dce38944bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?R2nmEswJN10x3We/SPi1OkWatt8iXTq6o5Mnm2cDeYANQtJD6mXEAq1tI/gI?=
 =?us-ascii?Q?h06youSOyJBBCJB0DFwxetC4U4fjfsu5QcEiCKEWX/xC29POcNZ7bOOWrCfa?=
 =?us-ascii?Q?uUkD9jlZkNwNc0kTAzXv8rTjPEB+OM6zV0tFRvUpRclUfazk4rcQ2GCaOp+I?=
 =?us-ascii?Q?GgeFXR6FypAzqorlTNGBy8npszYGkaRg9ULb784yIkXFYrYI3VAlpDFcOR+t?=
 =?us-ascii?Q?cknJFgV6FB1rcUTzwbnKBTEmr96t/KL3UaAMZ+/nL/BN6For2SdtoKkcNN5f?=
 =?us-ascii?Q?Pj2wHwiUjWxQOllM8yd+GqY6VTmymygDmSBvH75tMVTzasV7HWkmtko5oe8Z?=
 =?us-ascii?Q?ifc2/qpNs9cKxI6qoYAdwVxrrlsyAs6JJjK4R5OUC/rGvFcADc4skhm02zxx?=
 =?us-ascii?Q?YZvho4WJGrmoDSKkkfzdxMdNJEcP6uIsGJZeJ+Lb9rqFhtNHSRgXvuXZJ5He?=
 =?us-ascii?Q?6fbHmVnXqUvOhUFBTWPPhLt3sVGH7gajwuyasQQiAOJLxJijnRN9abcoUFTs?=
 =?us-ascii?Q?hXitBPx5D3DA2xCEpeNtMAKT6Wp5arlMrNGzyto/dRZRPMidbbLL+VLaSa+J?=
 =?us-ascii?Q?X6Z7zd/56tuM3y8Kk3K//uVyIdeLzqYmam8fUowQaJQDDRCYRApW15qPRDyy?=
 =?us-ascii?Q?53jf58hhwrsW7fs4+KLUvtlKSi9Z1ymAMiOe7cXgVFIF3rB4BI2WZ1CODANr?=
 =?us-ascii?Q?Ama1CWzuzMkAZ1B6of9c3aEh6JXRt9jDux7SP6ool+Jsao7X6Oq2iVCuERPs?=
 =?us-ascii?Q?WuregSMXL3xFi6/tJ2MrCB0rQjo2Um7zz82jCTtlKCrgrbT3ma/v27Nu+qM/?=
 =?us-ascii?Q?TY/FGHDIF2SDEKfn7KuKR36x5+4HryJSyBVtxHlOI+dfCk7xHBM478/eQ8K3?=
 =?us-ascii?Q?VQjK+DMXAPCH9GRCw1MzMeAFsXnIx5VkVm6PP8La5kthbdWTLTH05DzcwSQr?=
 =?us-ascii?Q?b+euiBJzm95xlS5eVJf/kAQX7QsHhjw7DmgdT8OJUjbeJaYoo1TgTW4RxnHg?=
 =?us-ascii?Q?IiprQRakqnXHu/UlG0a9HvyJRcECtrRSoFNy1IBSDMknzuTnd2oR6ydxTFSk?=
 =?us-ascii?Q?ta1PJzGb5pET+19yCXkUsR2MOzDSo5sANN6Hu6n7ezmmTQ5CzIRGHqFoB/xX?=
 =?us-ascii?Q?ZOOmpXH4ec8u0ZtibIk3a6mX9cau0cQ2Au9oE3WxLTydly6VEO5SnwQEibek?=
 =?us-ascii?Q?/N9BBwoHOvWRYzK9aAUN8UMvjeXuPXR2fiDqpVTqJH0h8xwQDRrv9w+QcQI?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8897.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?HAAhc+6NSH5hSVA8nPhuLidc9SSuYrCw1R4ECzNrolBk9gxE+f3A+JLYBjNW?=
 =?us-ascii?Q?lf7CEC+r1pcsATECih2hNXKsK6U1Z45KJ1ASfyjfkO1h78KGJi6z474CSzFx?=
 =?us-ascii?Q?WmJvtprHyV0LvASks9Ee+cE5PYwCrz4stgMc+weGG89kZRstDJN/i4lAi4dv?=
 =?us-ascii?Q?PuvgLpZGqWp76WPgJiSfXD4KLyecRY65IaGDa3RQHw48/TVbRSyJ/MgFuPVg?=
 =?us-ascii?Q?pE89sXgCEbn3Ve6e7XDXThy9mcynn5897I11arwW63WXat8ti8P5ZAqmhnUb?=
 =?us-ascii?Q?Ou02mHoanWFU7levLyKCLlntnjm9qaLHB5LIW3rBQuE0TNTcTYFd9C8T1g6F?=
 =?us-ascii?Q?yPEarHJ9VKgJPEXxTRvDM51TJXair5Ey8G0txTZpj8tA7a7hWBVzwM7gFY3j?=
 =?us-ascii?Q?ymDepLetbHeWSVrc2T0gc/mQ5R+Qh7p4YdW+RS8pwVfjxErD/kkW5SJrgsCo?=
 =?us-ascii?Q?bqFC0fBGIkwLUBMYA2l9EaVFB1zRWly1s0LnfdnJVLiwC0tPXvEdxjHQSMIW?=
 =?us-ascii?Q?23UTgNFvaWH+/B+1jHnVwscdido9NDUAgKqjTMfdHCeTT8HWI6ZH/bAEIy5Y?=
 =?us-ascii?Q?fiAex7H+47Yh8SQ/MUwekvHZG/8cUcIsRopcBl3mmHL/8w1xnnVTv8Gdm4P6?=
 =?us-ascii?Q?4mIfdK/H3iw6yxnLzpslcvALFHO8/Wj6WD7W0AMNVxRCbGS1MH5EOozALnLV?=
 =?us-ascii?Q?lLkw3IGxwcUYtGb7jzVDL7HXS9ttq8vIv0s7FWydiFACCPxr7CAB2BmDFLaj?=
 =?us-ascii?Q?/AZngSVidi0H9bLzkA2jYnqEFz01S+Yo95/tMp5rZBCkXLlbqy7kLvAZ/T14?=
 =?us-ascii?Q?LIdkqHDK3ANn8DLXZmELsZrTf4dxG4SDfzaT6vcj7Fg1etIqmYxkG2YvFT0s?=
 =?us-ascii?Q?oEYuc21OTIqL2eMddmHVg/60z4+XGgAo8NGIv4n9TKQTI4v76oIZoJTJidT4?=
 =?us-ascii?Q?ZYW2ThZx+tDpeyERpZJV+y7gIKT01AskcpDanxFsBzJ7aVaHr1aBeQQgVhMd?=
 =?us-ascii?Q?3QBnyAa+Py78aw4Qo8KO8ZofL8RY1oZ7fMNyF5rgIMrXLbXB+raMb+dGPI6F?=
 =?us-ascii?Q?Q63AnKQ1DmGZtVObw3qMVOH6bri8idFIYSZjUlR5y/FiIcVTN2hKV4o6jpp6?=
 =?us-ascii?Q?Ls+cgjtrj45ctKxholX0CrpXauSbiH3vdIM5nqmk44k1cVGycUPZQsNKgFC2?=
 =?us-ascii?Q?g2+66r165QBfTX4aWebZOXViv9vHRl6BVEjg9/SEJy2dCI18EK4oZ7rfue7o?=
 =?us-ascii?Q?ZJOuKLNzCVL/Uhml+5goCuhR7L2cb3afU6iJxi1umBFs0+/t59/0Be7ZfW6V?=
 =?us-ascii?Q?kJ60uQxy/Jguw7EEi2hv3rm2bNsqZi4KeFyuIgyhCQ6HshZG8CM4iK9tgVeD?=
 =?us-ascii?Q?9E+wzojZeNNZWSkDb7iG/plsw6WNkDyJ8Dj5SNPJ33QVN6RTf3a7oRwFitFh?=
 =?us-ascii?Q?u8gcUaQb+bp+zBCtUaz7DpZJFcIzG6RM6ROiLzD8G2csmMJefcni3hVbNZ6N?=
 =?us-ascii?Q?3yL7FTj5Qy2mQGvQKK4EDrTELRgjo531JANlwpTgkWSHPrW/A4e7o7C36ngA?=
 =?us-ascii?Q?UjHXiouSZp3s7CRy7IL98GeBkBoAxm9f8yStDHU+tuzV/snC+VjZYXVk6LtE?=
 =?us-ascii?Q?x5YnLEmtkQi2L0yJRYXXUAQ=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c00ba15-32e3-4e67-a01a-08dce38944bd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 08:56:28.4912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +n4YopY4Ufwx5JrMKOQVhfFyb8uSGv8avX3LKznI/B1q1frIhCy08zQh9oumGv9612oKeQXhD53UTBkCRqNxHTNXANZqDy6vhmSe8OBlV6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10800
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 03 Oct 2024 08:56:42 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16631

Hi Konrad,

On 10/3/24 10:18 AM, Konrad Weihmann wrote:
>=20
>=20
> On 30.09.24 13:19, Quentin Schulz wrote:
>> Hi Konrad,
>>
>> On 9/30/24 1:13 PM, Konrad Weihmann via lists.openembedded.org wrote:
>>>
>>>
>>> On 30.09.24 11:13, Richard Purdie wrote:
>>>> On Sat, 2024-09-28 at 09:00 +0200, Konrad Weihmann via
>>>> lists.openembedded.org wrote:
>>>>> when defining a function do_removesomething,
>>>>> the parser warned about
>>>>>
>>>>> Variable do_removesomething contains an operation using the
>>>>> old override syntax. Please convert this layer/metadata before
>>>>> attempting to use with a newer bitbake
>>>>>
>>>>> correct it would be to search for a override operator at the end
>>>>> of the string or for the next operator.
>>>>>
>>>>> To avoid running the expensive regex search on every setVar call
>>>>> the current "cheap" check would be have to be triggered,
>>>>> before the more precise check is run.
>>>>>
>>>>> Signed-off-by: Konrad Weihmann <kweihmann@outlook.com>
>>>>> ---
>>>>> =C2=A0=C2=A0 lib/bb/data_smart.py | 14 +++++++-------
>>>>> =C2=A0=C2=A0 1 file changed, 7 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/lib/bb/data_smart.py b/lib/bb/data_smart.py
>>>>> index 4e15a43c2..0523744de 100644
>>>>> --- a/lib/bb/data_smart.py
>>>>> +++ b/lib/bb/data_smart.py
>>>>> @@ -539,14 +539,14 @@ class DataSmart(MutableMapping):
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return v=
ar in self.overridedata
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 def setVar(self, var, valu=
e, **loginfo):
>>>>> -
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if not v=
ar.startswith("__anon_") and ("_append" in var or
>>>>> "_prepend" in var or "_remove" in var):
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
nfo =3D "%s" % var
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f "file" in loginfo:
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 info +=3D " file: %s" % loginfo["file"]
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f "line" in loginfo:
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 info +=3D " line: %s" % loginfo["line"]
>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
b.fatal("Variable %s contains an operation using the
>>>>> old
>>>>> override syntax. Please convert this layer/metadata before attempting
>>>>> to
>>>>> use with a newer bitbake." % info)
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 i=
f re.search(r"(_append|_prepend|_remove)(_|$)", var) is
>>>>> not None:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 info =3D "%s" % var
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if "file" in loginfo:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info +=3D " file: %s" % lo=
ginfo["file"]
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if "line" in loginfo:
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info +=3D " line: %s" % lo=
ginfo["line"]
>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 bb.fatal("Variable %s contains an operation using
>>>>> the
>>>>> old override syntax. Please convert this layer/metadata before
>>>>> attempting to use with a newer bitbake." % info)
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sh=
ortvar =3D var.split(":", 1)[0]
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if short=
var in self._var_renames:
>>>>
>>>> The patch appears line wrapped unfortunately (it appears as quoted
>>>> above).
>>>
>>> O_O - okay that might have been my mail client.
>>> Ever since Microsoft decided to drop plain TLS access to SMTP, I=20
>>> don't have any other way of contributing any kind of patches, but to=20
>>> pipe them into a client that supports oauth :-(.
>>> (P.s. before anyone jumps in gmail is not an option for me ;-) )
>>>
>>
>> bitbake-devel is available on lore.kernel.org so you should be able to=20
>> send patches via the web endpoint, c.f. https://=20
>> eur02.safelinks.protection.outlook.com/?=20
>> url=3Dhttps%3A%2F%2Fb4.docs.kernel.org%2Fen%2Flatest%2Fcontributor%2Fsen=
d.html%23web-endpoint&data=3D05%7C02%7Cquentin.schulz%40cherry.de%7C57edcb2=
8fe7347f1e4d308dce383eb7f%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C6386=
35402949492410%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi=
LCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3D9kIULshRlYhS%2F35Q6PKX%=
2B9wotgKIx%2B92SVKRXtbCa5s%3D&reserved=3D0 (I have not used it this setup, =
as I use my personal mail address for sending patches because I got tired o=
f MS and my IT deciding what's best for me :) ).
>=20
> Looks promising, but I couldn't get it to work for now.
> Also I read of the limitation that the web endpoint applies only for=20
> projects hosted on kernel.org, not sure if that is the case for=20
> openembedded projects.
>=20

https://lore.kernel.org/?q=3Dyocto
https://lore.kernel.org/?q=3Dopenembedded

That should cover most of our repos? If a repo you want to contribute to=20
doesn't appear there, I guess we could ask for its ML to be mirrored to=20
lore.kernel.org via our and their sysadmins.

> If there is a _b4_submit endpoint available, this might be worth=20
> documenting in the contributors guide.
> I saw various projects starting to add .b4-config files to their repos,=20
> maybe that's the way to go.
>=20

Yes, but poky is making everything difficult by being a collection of=20
source code from other repos.

When one writes something to bitbake/ directory it should go to the=20
bitbake ML, meta/ to OE-Core, docs/ to yocto-docs and most of the rest=20
to poky. We also want to make sure that a patch doesn't make changes in=20
multiple repos at the same time. I haven't looked at it in depth so far,=20
I think it might be doable with some script(s) and a few .b4-config in=20
the appropriate places.

But having started to use b4 for every project with contribution by=20
mail, I find it VERY helpful. Once we get that working for poky, it does=20
make a lot of sense to document it everywhere it can be used :)

Cheers,
Quentin

