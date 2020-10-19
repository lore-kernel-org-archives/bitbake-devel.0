Received: from EUR01-DB5-obe.outbound.protection.outlook.com (EUR01-DB5-obe.outbound.protection.outlook.com [40.107.15.128])
 by mx.groups.io with SMTP id smtpd.web10.11226.1603106740801631177
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Oct 2020 04:25:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@prevas.dk header.s=selector1 header.b=d8ynkrX/;
 spf=pass (domain: prevas.dk, ip: 40.107.15.128, mailfrom: rasmus.villemoes@prevas.dk)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ArjEGbQ66j4WnkSlbOpWp1htp5MAxUYWLqxTVfinrRfNoAKKUV6WG70EI5QcnEzj5i/brdClCrlwiJyd8kUrCRkBt9DaaVbURm7VvKbh4tw/AuPs/ygl8+EP2wBi2a0SR48+ir/57DvfqB3/JDWm/oeS/0Wuw58056RUSgeHQkOTd8+Ti54EGWMIfeEXTLaVdywNWtxw04wpTDCtT8kAfhohl3rngUU8BfSXCXvTb3fTO2TT6dV0uDe29VTYLHcd3ukTzCQHt4gno09U4V3kUMriOdEhRAcIBdlSAQcZbgaxGB3Fwbd/ho8WYu5UYgFdWzUkChLHoe81CDwMd06AIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMHAPnZQBIPBrP4YbYIe4ZfNeWpdqO7cdUmG1CwHkMs=;
 b=Pn96ez8ZZO5qx0C+gSjdNeo0DuajbVHo1FBdMPD5aeFq4Q/WccvaM7QfOQb9GgRkumvzJrLPxTJ1JouKIiuyL3tGd6O1kkZ/UCIYnqkT41m3NLViDujbY3uXL1tR/Cwd/ULvUADBg3iBArGzSAl6ds8rguQ9eYlTD/MKQE55K6As9QbRg3605lBDKwcMqyhCJzWBV9PXp7qpLOqaCSCOOeyuqtZyPNAOJXDXs/Zi8f9+5fO0TgEOUFmQXpds3M+1XDQRQo0q2vrrVr6xTET6lrVn7on47PuQhkW8M6OpCDMS69sTzLaGWsKBt0xnNBdWH8iqKfr2W9hOBokJzpn0mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uMHAPnZQBIPBrP4YbYIe4ZfNeWpdqO7cdUmG1CwHkMs=;
 b=d8ynkrX/xxtKJ6XgdlsPyBtdLLrglyl5AVpHa1uKgLfnTS+1ebqEiHBpCI0crflQqvMR0sGkcWLLgvJ4wMWpls0v22c5WppLHfY/DlfpUR8y6/GUwXYC+ke53aSMZWFPmS1GYgwGeX9vCtZW8JHx3dBNGKVrl0/8qyNzNT0a3BA=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM8PR10MB4164.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1eb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 19 Oct
 2020 11:25:35 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62%6]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 11:25:35 +0000
Subject: Re: [PATCH] fetch: git: add reference parameter
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20201018213352.32692-1-rasmus.villemoes@prevas.dk>
 <5654d90cef29064a898f279d73c6deb6f6f91052.camel@linuxfoundation.org>
 <419c5a91-a38b-5b87-31c9-b1dc72adf1be@prevas.dk>
 <5db6530fb6bf4bb39c9e5bbe4b44e57fb30c02e9.camel@linuxfoundation.org>
From: "Rasmus Villemoes" <rasmus.villemoes@prevas.dk>
Message-ID: <194b0b91-dad8-e355-b290-e27141995d6b@prevas.dk>
Date: Mon, 19 Oct 2020 13:25:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <5db6530fb6bf4bb39c9e5bbe4b44e57fb30c02e9.camel@linuxfoundation.org>
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: AM4P190CA0006.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:200:56::16) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
Return-Path: rasmus.villemoes@prevas.dk
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.11.132] (81.216.59.226) by AM4P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:200:56::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20 via Frontend Transport; Mon, 19 Oct 2020 11:25:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39a137ec-ef7d-4e07-ae85-08d87421b2db
X-MS-TrafficTypeDiagnostic: AM8PR10MB4164:
X-Microsoft-Antispam-PRVS: 
	<AM8PR10MB41643EA590FA34770C2C3236931E0@AM8PR10MB4164.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aA6Lz7iSDTmZhOBDA9TGxbKVpJiBho9nsFx6j0NaF6z9FbE6v9/E7SltRrnj90Mvxoq4dzDI6LcKJ0Q0oesAkiVCgVggMf+dAtTPZgIVYIArl6EqdCIKEcNqMw66kO53SId243kfrSRYCgoEOzhK9ARKqGfj9GfKnMBBVUygMvchGXhZJisX2Sce/FD3ob2T2aZo+dLkDOm62Mt3pQ4XEdSVD8iiuUKdyGJGyMIadm9f5l0u3KS3gRJXOMbMSKk2Let7NjyeNDUGt+E3mOVYMdrgAYkF/hq/nSd/8VWa1/0VI/a8PboCNMgJ1UNB0pS2RPzZjA+Thu8aZrPas8RKVb+2rRJWDy7FHAeZZYAbLMCyluaRSpTCX4QvvMZeynAr
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(346002)(136003)(366004)(39850400004)(376002)(6486002)(16526019)(8936002)(26005)(186003)(83380400001)(8676002)(4001150100001)(36756003)(478600001)(31696002)(86362001)(2906002)(44832011)(66556008)(66946007)(16576012)(52116002)(66476007)(316002)(5660300002)(956004)(2616005)(8976002)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 
	cr8c2vWJRaJTu1fRlpTle1scNENgqiFn7kaAHZbjcwdrxn0tTaOwlH1XU/9sN9XSIAs+7MuuvtF3wZa6ErP7h/dZWv/kWtLtS14VqGOTXWgAQkISs0oX7yYtCb/TIztpg5bu9o6m/sQtaYMqy1Y4+lozBJ50WKApET4nevVkrhjKCbf8AYnDJO+siVH46ecvMg9Wa6FC4I3FM9pHUlBjeOnZNTksBuxUkGqIQ+nnhGcS1eqMAnggMsVKSPaFWtxuwcbW7fzg+cpyFBwFSR9nSP16UKDDWlMFBnk2DdRIA/LdlDtL5j4l+fvP8K/NnBpWCsrbRtrUXlhbmY0tb6rkFvJzwKrRB9hDDfI43KtG5epHcjBtXH9H6zJPgwAhOE4rWZgTaz9MTYP0GzTgBRT4asD+NATKdfCuNK241qckAoxhbQjnaJ5W3ZgygZHUUad42wlUnEUVNhQpWLsJ8+dSwLhYIjyfkmruq+uaNGAGW6TaMaJAr4vMBGvpX+qWm/9t1EqOYIZ3jwcAowahHqdiyFNCr/wN6mX5UpvamTvzTcSP1oB4tF7Q8d5qK22j1uBjee5eMvU+TFMXx2jGJE6VqAavpfttj65O52MRcsCKpiwBL083fBaHRQFHL0uBX9II+QVMeUPrKagzNFKK5KhywA==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a137ec-ef7d-4e07-ae85-08d87421b2db
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 11:25:35.7998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ilN5og19vV4hHThFkyr7vJFYKk/71GDpXdvbFlzZXfR415kKhcozeB1X52KmxWRjwJPZPgfnQS4zHOnSct6wdRQX16Jh1fP82hAWSgYWdYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4164
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 19/10/2020 12.43, Richard Purdie wrote:
> On Mon, 2020-10-19 at 12:25 +0200, Rasmus Villemoes wrote:
>> On 19/10/2020 11.09, Richard Purdie wrote:
>>> On Sun, 2020-10-18 at 23:33 +0200, Rasmus Villemoes wrote:
>>>> The --reference(-if-able) option to git clone can significantly
>>>> speed
>>>> up the initial do_fetch if one is able to point git at a local
>>>> repository containing a large number of the objects that would
>>>> otherwise need to be downloaded.
>>>>
>>>> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
>>>> ---
>>>>  lib/bb/fetch2/git.py | 11 +++++++++++
>>>>  1 file changed, 11 insertions(+)
>>>
>>> Whilst I can see why this is useful, it is going to end up causing
>>> problems when you share that recipe using this term with others :(.
>>> I
>>> don't think we should add API which will cause scaling issues end
>>> "encourage" behaviour which leads to problems.
>>>
>>> Clone by reference also causes problems for the archiver.
>>
>> How? Note that I unconditionally add the --dissociate, so that after
>> the download, there's absolutely no link between the referenced and
>> the cloned repository. Also, I use the -if-able variant which will
>> just silently ignore the given repo if it cannot be used (often,
>> because it doesn't exist). So I don't think the presence of absence
>> of ;reference= can ever affect the correctness or end result. But see
>> below;
> 
> Ok, I'd missed that dissociate was available. I think that is new since
> the last time I looked at this (its been a while) and that helps
> simplify things.

Well, yes, I glossed over the git version requirements. --dissociate is
from v2.3 (Feb 2015, fb1d6dab), while the -if-able variant requires 2.11
(Nov 2016, f7415b4d711). It would probably be nice if this was all just
silently ignored when git is too old. Do we have some way to get the git
version? I suppose a simple "git --version" subprocess isn't really that
costly given that we're about to spawn a "git clone" anyway. And we'd
only have to do it in the case where a reference is actually given. But
then, since the developer must have opted in by providing some path
(through whichever means we can agree on), perhaps the documentation
should just mention that requirement.

>>  I don't think any recipes should/would ever grow a ;reference=
>> directly, as it's really a local opt-in optimization, so the recipe
>> should just be written to allow that easily.
> 
> You know how this works, why and what it means. Most people won't so it
> will get added to public recipes and it will cause problems. I've been
> a maintainer long enough to know how this kind of works out
> unfortunately.
> 
> I realised there is also a bigger problem. You're changing SRC_URI to
> be specific to local paths. This will affect the sstate checksums and
> break sstate reuse. We don't want to do that.

Competely agreed, and I oversimplified. I'd expect the LINUX_SRC_URI_REF
to have a vardepvalue of "". But yeah, it's easy to forget to add that.

 My counter-proposal of an
> identifier in SRC_URI like ";reference=linux-kernel" won't cause a
> problem with checksums.

Perhaps, but where would you get the information on what linux-kernel
should result in? I guess one could have the user set

SRC_URI_GIT_REFERENCE[linux-kernel] = "/some/path"

and then in urldata_init() do d.getVarFlag() to get the path. With
SRC_URI_GIT_REFERENCE having whatever appropriate magic necessary to
avoid its flags affecting checksums.

But, do we even need that indirection through a keyword? What if
bitbake.conf (or whatever more appropriate place there might be) grew a

SRC_URI_GIT_REFERENCE ?= ""
SRC_URI_GIT_REFERENCE[vardepvalue] = ""

Recipes where one wants to support this could then just be written

  SRC_URI +=
"git://:some.where/foo/bar;protocol=https;reference=${SRC_URI_GIT_REFERENCE}"

[an empty reference= parameter is equivalent to none at all],
and the way for a developer to opt-in and specify a reference would be
the usual pn overrides

SRC_URI_GIT_REFERENCE_pn-the-kernel-recipe = "/my/local/path"

?

> As I said, I totally understand the need/usage. I just don't think the
> implementation can be merged as is for various reasons, we need
> something more generic. I've tried to give some hints on a better
> "interface" which would allow something to be merged.

I can certainly try doing it with the keyword approach, but could you
put a few more words on what you were thinking? I.e., am I right about
how you thought the path should be stored and retrieved?

I'll have to respin for the git version issue anyway I think, so what do
you prefer?

Rasmus
