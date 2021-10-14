Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059A8C433F5
	for <webhook@archiver.kernel.org>; Thu, 14 Oct 2021 08:00:13 +0000 (UTC)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.84])
 by mx.groups.io with SMTP id smtpd.web08.6386.1634198410407398148
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 14 Oct 2021 01:00:12 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=n36MHXIn;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.15.84,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhkSFqY9lUxjCvpQET1O7UDFWRJ+4dq0fuhlf2vcnA4G52u8j2ocqIkRAlS0uSBiHV8IqCgE0duoF7MxtXAYLE3q2ETdntw6p5XhFwTe7a9dmr8QpfcosLximR9fLENYcf8ZruQdN9mu50H8WxrjTdoPCBMhASCXuimyBwVQv428lvB18oHqr70VQGrkunbzV6LcnGEg2AEBEJOcs1Kjts4WM5vDUOvjW5ofnEfko3ii5JFOlqR6hMB3bEzr2DSYojjZOBY8fBOSEgixwgqlQfbT2ES9AUg6zHRJqjyOM0Qow7068Yn8nevILWl7EXDs0rlI342OFUBTFm+9VnPW9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iw5fK/2E+UL7iWpRZY+fQbcLcB1ihKdSVM8Q3QV+8r8=;
 b=fZp9N0XQZYMwh13kqM9ybe0GuvNSmNxjLjeDlHSck4561uHE3/KjCBEepjWgRygLOw4wHSPJx57fHm4e4QNuQqAO0NR2JEe9IXIMPeECohrHlc98FRMTwMaJKrWC06Z08p9uec5aY+X4oLTmDoCl/Qr1eIitq6e0/ybw4nnHqhA1KN+9PB60+IBWc4ot665nstqJF0dQm1e6fQbOS5Tbe1ox3fR/DtcGpCmn3cWnU1KGHUI5dss3aaZPlmk1OlkHq9b1CUDptnpnCFmo+j0Pf4q+NoKEhj5uay41UAuXQiRbNF7TQYa9U744bxkY3HwG1/OGFomun6in9U1LllJZ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iw5fK/2E+UL7iWpRZY+fQbcLcB1ihKdSVM8Q3QV+8r8=;
 b=n36MHXIneQg5J8a+cyNsRdKE6T46tbJ3ByhBoBwikcUVBvtYvrUrXrbbBJKFopVl5mKEd4O1/lkYuXfOb7DY7SBw2SUZQcgaQLX3hG8eVORZwz9XCevm/N+og6M7aDQwF1yOG5JHMPDkSkUI0DhQZ1S9qFZt3qOPwn94eqs2wF0=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM0PR0402MB3841.eurprd04.prod.outlook.com
 (2603:10a6:208:e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Thu, 14 Oct
 2021 08:00:06 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a%5]) with mapi id 15.20.4587.024; Thu, 14 Oct 2021
 08:00:06 +0000
Date: Thu, 14 Oct 2021 10:00:04 +0200
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
CC: Quentin Schulz <foss@0leil.net>, bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] [PATCH 2/2] siggen: Change file format of
 siginfo files to use zstd compressed json
Message-ID: <20211014080004.wsunpbrhfxhzlz7n@fedora>
References: <20211013153540.2873636-1-richard.purdie@linuxfoundation.org>
 <20211013153540.2873636-2-richard.purdie@linuxfoundation.org>
 <EFA30A03-8DEA-4751-A51B-851C9B9EE7BB@0leil.net>
 <44a0906e6279b9ab34d29f8129d54b598b783397.camel@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
 <44a0906e6279b9ab34d29f8129d54b598b783397.camel@linuxfoundation.org>
X-ClientProxiedBy: AM5PR1001CA0013.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:2::26) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
MIME-Version: 1.0
Received: from fedora (92.42.140.82) by
 AM5PR1001CA0013.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:2::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend
 Transport; Thu, 14 Oct 2021 08:00:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c607c561-632d-49e2-e708-08d98ee8a295
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3841:
X-Microsoft-Antispam-PRVS: 
	<AM0PR0402MB3841821BBED827DBD6E123A2C2B89@AM0PR0402MB3841.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	I6CDtOvvOzuVIQ8VT7G1l5YfFPBcJ6BvFteJJyjDbOD3lpZbRyu1zKjpXzsYK6YJ9i3VYglIf5RCPBAgaFJ5DxLOcI22oma8mL0NF17ir/0KKTjOH/2BWvc1O1Hy+NsezZYHDDALcSwC0ddShTOxCQAv2Gy5jcDodvBUVjfp2MiZWLZLRlrGYX2TyWG8y06Io95IqKnAUQYHCiCKl8iOXlm0PZRif0z5Tt1dRgdR7NN+8hQyTwbj+bBAXo0xq+qKEsvRZeFZZTtlL3odjWzch4YuRqrfkMx1PyJOOcAABZXwwImGSFHq8icfEUkzdzVDu5Y/WH+4DDY0Wq4/dLWZeaSGzY6ai9a/k0Hzpu/X8oeo7zOl6eorTrc6ExTKjIMu3WwDjbGZtxcZbjjUNN7Q4muA+58iOGaRj9mUjUepeEO92cz7nseHqmdczdICZFRy8rTj0z4pOqtSWAUFhL92tER1zeK1mwOdjsEMDcFIIpGsCrI1++4G+/u6/eJn7KbsWIrmn9XeXzpIwFtzMbluBi8RjN/II0iPBC3uyTouS5RlYA6tOj8crMS9Cxrk10xmwzNAuBOjVY0Jyr+imTAlBZCfceXQj37/VwceZdiDu+jByDBfpgaCckrSjIdrmx2tORNPF0cQvmZH1fynsqFQOXf8HxFxQpRE41VnLrmfT8B+YmAPp2LIMm4KimVBokrFI6aNWPiOhaEYvTBgSN79xJn78GbP8xJmNDtTPBrdpEtGAXn35NkGbO9tu3ObYqn3O9epaQvOkBSatevBp96ULXvSwwRbD4R7/QSY6acnTIU=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(2906002)(5660300002)(55016002)(38100700002)(9686003)(66476007)(66556008)(6496006)(86362001)(508600001)(52116002)(966005)(4001150100001)(83380400001)(1076003)(66946007)(8676002)(9576002)(956004)(8936002)(186003)(44832011)(316002)(33716001)(38350700002)(26005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LuKoeTHGaT7vaMMQ1SktFYTeWfUy7q906K4fjeD80skwLKaCY5H3dJX+WETY?=
 =?us-ascii?Q?bIb/VAHkH+QYCgVYN+xq3eqArogkXfOdzMjcRub+f5c7V8DJy4xLHhg9ge6+?=
 =?us-ascii?Q?pfs37ioeZrHb7P+uw0OCz5o7W24dDPLnJQ1qbC59wNyx0wm6gep469HFsS3T?=
 =?us-ascii?Q?LgOdM5eLs4sq1CMhZb/Qnro/k6qtng6mdswrUwsPyxintmxJtWb4mQRFeiZj?=
 =?us-ascii?Q?hk/CiIq5ezT4tXOYBbTY5uIhQFd+wAe2GoMJmpn8V+aVWyP+14n4blPzmPL+?=
 =?us-ascii?Q?SyHjPwsbWUEvvZdte3fv+yD6kit24y6WfP57pJvNn8dVdah9bqzSJcquELrB?=
 =?us-ascii?Q?MukuL0VQlK/pn8v65b1on04yOpR/GLO/QQMRR/+kG6N0rCV+cJeoRAFd2CjL?=
 =?us-ascii?Q?nQg3SFiW/mAasTg2GUryyzgS2MFg8739gTG/P0YNVLA+vL9k3tlEiFJMVz73?=
 =?us-ascii?Q?3v8MpJOYkpv6xZpANBy5ZnPnlukl2h2buCMvsahEFQUfPAb0a5H6PXu5hoBj?=
 =?us-ascii?Q?afBIQV1fMEYuglGhFkMMoX9BtZhk/+XwPXkElYqDVN7wSzYW/gRm1CrXFrMF?=
 =?us-ascii?Q?RyPBePVqvI3HglBNKy4u+on2xhY+1wjpkmF1d93w1gVnITUO1M866uHj0aG7?=
 =?us-ascii?Q?gv2fHw2uZ0duUXEazqYpZBsTk2ufT8zOH8TxHMWlGoNQTDHnnhqVcchnPWy9?=
 =?us-ascii?Q?5WHj4yTYL5va56+R7ksi836t7C+WrowPUzga96cyIqBv4zF1mqhNkMPg95AX?=
 =?us-ascii?Q?exd1isIPCo7y+gOh7v7ObBm84rdvv2nteApLMZ8kFKYO+QEtnbOU/HPBxWx9?=
 =?us-ascii?Q?U/MHrANeM6nQALI9qAHcQPgAVsRIOd3n+O1rJe9yXanFZj2daXUTCOFn0u5L?=
 =?us-ascii?Q?9ddgVpb5UHV5u8vSRmqMeduDbeheNzVnO+DsAPVHrtI/1HGkFH1L1TY7irPO?=
 =?us-ascii?Q?94X8XVU5iTVSm4Pb0yB+LhLe7NHMjVcFhLyo+D/U5jBF/y1LFM/gp3BmCzLI?=
 =?us-ascii?Q?hqrU80jSQ+FZ4mo7LXSLoujGE32vu57i2sUdNKQhSdlhm6l7rL4GBcQT9s5E?=
 =?us-ascii?Q?FayHSOG0pbRu8FLXGEML8QG9KsdLcSYv9ir9iBikrFmQupY1XDeaxSelyi49?=
 =?us-ascii?Q?RV003zldzicS74PWbYg2R1FZGA6+27UC+agfyaDUJCjJvtDBUrWRTb9kJh4E?=
 =?us-ascii?Q?h32qXG4hzd/0t+I1gXNVPA34Y/EG+k3zoonB0uvbSuXqeUeK7Q1ag20fidRf?=
 =?us-ascii?Q?tVZOp12JKeMJVJcL0VRsiHQpnBxGaWb42x2jrOyc9JDRc5i8Jl9U71BSZGeq?=
 =?us-ascii?Q?hAYjyjaq2vbWrwPtonRn3D/d?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c607c561-632d-49e2-e708-08d98ee8a295
X-MS-Exchange-CrossTenant-AuthSource: 
 AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2021 08:00:06.2764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 mPELCahn09+S7Gn3G8u9tLjNUabVN4WUA936iPjZWgRIuR2oV931J+3HxZhmMiS6Qn8wIXowB9LT/MYEnN/HdFkzF9moUETwFjAWStPRhrJfachCgtVAvc6RXHW2/SXR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3841
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 14 Oct 2021 08:00:13 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12774

Hi Richard,

On Wed, Oct 13, 2021 at 11:02:39PM +0100, Richard Purdie wrote:
> On Wed, 2021-10-13 at 23:08 +0200, Quentin Schulz wrote:
> > Hi Richard,
> >=20
> > On October 13, 2021 5:35:40 PM GMT+02:00, Richard Purdie
> > <richard.purdie@linuxfoundation.org> wrote:
> > > Since OE is about to change to zstd compression of sstate, it would m=
ake it
> > > timely to convert the siginfo files from pickle which isn't reproduci=
ble
> > > to json which is both reproducible and also human readable. At the sa=
me time
> >=20
> > I'm not sure this is actually true for python 3.6 according to my readi=
ng of
> > the docs.
> >=20
> > """
> > Note
> >=20
> > This module=E2=80=99s encoders and decoders preserve input and output o=
rder by
> > default. Order is only lost if the underlying containers are unordered.
> >=20
> > Prior to Python 3.7, dict was not guaranteed to be ordered, so inputs a=
nd
> > outputs were typically scrambled unless collections.OrderedDict was
> > specifically requested. Starting with Python 3.7, the regular dict beca=
me
> > order preserving, so it is no longer necessary to specify
> > collections.OrderedDict for JSON generation and parsing.
> >=20
> > """
> >=20
> > C.f. second note https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A_=
_docs.python.org_3.8_library_json.html&d=3DDwIDaQ&c=3D_sEr5x9kUWhuk4_nFwjJt=
A&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-172IIy1t&m=3D=
9L-zhcxLgvsuEdoQhhdpX3Wl2Kq17Ua7Dv0zjWLo3x8FrOOKUrlGj0SSwTEs8huq&s=3DeutqZs=
apNnq6RK-NosLiiqHQX8xc-U5riHIjtk4nbrY&e=3D=20
> >=20
> > C.f. https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__docs.python=
.org_3_whatsnew_3.6.html-23whatsnew36-2Dcompactdict&d=3DDwIDaQ&c=3D_sEr5x9k=
UWhuk4_nFwjJtA&r=3DLYjLexDn7rXIzVmkNPvw5ymA1XTSqHGq8yBP6m6qZZ4njZguQhZhkI_-=
172IIy1t&m=3D9L-zhcxLgvsuEdoQhhdpX3Wl2Kq17Ua7Dv0zjWLo3x8FrOOKUrlGj0SSwTEs8h=
uq&s=3DWTUEXJ-RwwYdmjzjvsTMIdd7V1CPnbqozRu1Xo3MMAQ&e=3D=20
> > Says it is behaving this way but shouldn't be relied upon.
> >=20
> > It seems we need to make sure dict are ordered by using
> > collections.OrderedDict instead?
> >=20
> > In json.load, object_hook_pairs=3Dcollections.OrderedDict should do the=
 trick
> > afaiu?
> >=20
> > Or I guess we could do the same thing as for sets but for dicts?
> >=20
> > Note that OrderedDict is not alphabetically ordered but ordered by "tim=
e-of-
> > insertion". I assume that with sort_keys=3DTrue passed to JSON.dump, if
> > OrderedDict is used for JSON.load, the function will return a fully
> > reproducible dictionary which will happen to be alphabetically sorted t=
oo.
> >=20
> > I'm not entirely sure of my reading and understanding of the docs but w=
anted
> > to bring this up.
> >=20
> > Hope this isn't just noise :)
>=20
> My understanding is that by having sort_keys=3DTrue passed to json, the d=
ict's=20
> keys are sorted and this does make things reproducible for our uses?
>=20

I know nothing of the code you're modifying so it is possible I'm
voicing concern for something that does not apply to bitbake in this
scenario.

Serializing seems ok, I have my doubts on deserializing though. However,
I'm not sure non-reproducible deserialized dict is an issue if the
serialized dict is the only thing we care about (well, dict into reproducib=
le
serialized JSON). If we only care about reproducibility of the JSON
file, then you can probably safely ignore the rest of this mail :)

You're using json.load without any argument, therefore this is the code
you're using:
https://github.com/python/cpython/blob/3.6/Lib/json/__init__.py#L274-L354
The last line being the decoder you're using, the default decoder
instanciated here:
https://github.com/python/cpython/blob/3.6/Lib/json/__init__.py#L241

https://github.com/python/cpython/blob/3.6/Lib/json/decoder.py#L291-L298
is what I'm worried about.

Specifically:

"""
This feature can be used to implement custom decoders that rely on the
order that the key and value pairs are decoded (for example,
collections.OrderedDict will remember the order of insertion).
"""

This seems to indicate that the resulting dict after a JSON
deserializing is not guaranteed to be reproducible. Therefore, depending
on the logic applied to this deserialized-from-JSON dict, that might be
an issue, re-serializion not being an issue there.

Cheers,
Quentin

