Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.137])
 by mx.groups.io with SMTP id smtpd.web11.12688.1603112176078759836
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 19 Oct 2020 05:56:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@prevas.dk header.s=selector1 header.b=C+1lQDJO;
 spf=pass (domain: prevas.dk, ip: 40.107.8.137, mailfrom: rasmus.villemoes@prevas.dk)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADasisIw3mXiniKYKmow/52tYfZBNOtPZrJS3kO2Z9lg+5yEzRJtDRe9RZSbBzLMVtfn0UDrjmiof4u5FCWBV/T8teX3NTl2LRqBQBoisAgsEV74Q/vNL1EZ5zl05pFjp33J3OB0ngthG4Ra0c3K5vWDUwYO/bZRLyE178x30DTiy0QVMOvHekW3Pvw20NG2j2uk0EABnOEBfanhLnjhmNhPMGipXdHoCbaRNMqBj7G/D+5zRZsfROg4GqkhCS10HVC4lqv6oMACp3nhoyiu4d7s4wjp3/CO1Kx46QrPS0zuoIUDWE3/1luuk+MzRYMDfWbzO4eX2AnH4n1pgqJG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32mmGsNxL83ukGFEZuW4Nl7He1BodP+BumvewZtRTbY=;
 b=h49XXliKyhqaeMe+kJVgcp4ypMLSyNx43dREwgyDOZfrK4L1k95wb5C5cVDZp7zHArti09/VYWqfYG84ssAXQFFFlD9e4r1rRq1VmqFLFANZmtJIr/aKxqfFR/UvwUy9Hw90fbSFzOhChQfQSDUnTlAcw3NI3+XUOCHRKITVee+9UlzEsOrntDtUhHH2RJWk/pyy+I+W5cCwt66DsbkSAr5ajNO3zjmqAJsiO8y/CQCt7cTL+qs6nR+gc7xlUDLfhNYWFChGc0vm9KcEwucaOeKoFLHOfiKnKps9nHixFJ3XIgRc93wQwYlnJJuKb2jJOG1sh41bVSST+hOfLelfnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=32mmGsNxL83ukGFEZuW4Nl7He1BodP+BumvewZtRTbY=;
 b=C+1lQDJORBQSIFx9Sgzm0yWkzBzMTklnTLLrVz6vgeh1x3uolcDc6qHwvc6jhG1Eg/CzWiKmmKO5lJgteL2/c9eIM5QByhJw9zxk7k7hKVuOkCd05AalSsFHulr03L6TsCqmLP4Nau80D4p7d5NvOBG66ZyXpRhU10Ai/qJP2ss=
Authentication-Results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=prevas.dk;
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:3f::10)
 by AM9PR10MB4310.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Mon, 19 Oct
 2020 12:56:13 +0000
Received: from AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62]) by AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9dc3:9785:dc4e:ad62%6]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 12:56:13 +0000
Subject: Re: [PATCH] fetch: git: add reference parameter
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 bitbake-devel@lists.openembedded.org
References: <20201018213352.32692-1-rasmus.villemoes@prevas.dk>
 <5654d90cef29064a898f279d73c6deb6f6f91052.camel@linuxfoundation.org>
 <419c5a91-a38b-5b87-31c9-b1dc72adf1be@prevas.dk>
 <5db6530fb6bf4bb39c9e5bbe4b44e57fb30c02e9.camel@linuxfoundation.org>
 <194b0b91-dad8-e355-b290-e27141995d6b@prevas.dk>
 <0b4b27c9446be03e2bc6f9df61345b34bafc8721.camel@linuxfoundation.org>
 <7190c343-b802-8f3d-4e38-7441a917ff0b@prevas.dk>
 <2fbcea24573fdc126923d99cce73590c57283fb7.camel@linuxfoundation.org>
From: "Rasmus Villemoes" <rasmus.villemoes@prevas.dk>
Message-ID: <e5368445-2d7d-511f-d6ff-41c323aac7d2@prevas.dk>
Date: Mon, 19 Oct 2020 14:56:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <2fbcea24573fdc126923d99cce73590c57283fb7.camel@linuxfoundation.org>
X-Originating-IP: [81.216.59.226]
X-ClientProxiedBy: AM4PR0202CA0022.eurprd02.prod.outlook.com
 (2603:10a6:200:89::32) To AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:3f::10)
Return-Path: rasmus.villemoes@prevas.dk
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.16.11.132] (81.216.59.226) by AM4PR0202CA0022.eurprd02.prod.outlook.com (2603:10a6:200:89::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21 via Frontend Transport; Mon, 19 Oct 2020 12:56:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6e9e0cb-64fe-4ecd-5f4b-08d8742e5c21
X-MS-TrafficTypeDiagnostic: AM9PR10MB4310:
X-Microsoft-Antispam-PRVS: 
	<AM9PR10MB4310C5CC8DFA7FE2CD513C9E931E0@AM9PR10MB4310.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EnlMerA6H/k8wVDCfV64XYfMLMbtQ+xPtyXGqA3ygFuF0VbgKpgRpUGrAyGzpRLuw2MTfAkQWkijKLxmI0d84402WGHItJOIxHlgx+H493/6H7ZnheqtBB6bfJILC01woh9Hw5WTYvuAPq+ior41SFSWBaKYa9QVo/04TPZZx25jKX9Tl6/TE7rKpgP8jLUskBGWo2aphwtPqk7BIDo7O5LhQ2v+ifCmPZ6SPDakzbdC7iuEO5AVdZisMWOgW7C1qggdmEQLGRyFcYF8ZvIDivufBESk6iD+wdWhcRUwFJiIb/6BtAUao9Fd0ABlwV1R+ET7HI1iCxTXeXz0pxcH2w/eE8IRY1L4di6C1f2q6DyQ9SGUgiZHAFZvDY5j87ps
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(39850400004)(376002)(396003)(136003)(346002)(366004)(44832011)(316002)(31696002)(66946007)(52116002)(66556008)(66476007)(16576012)(4001150100001)(6486002)(8936002)(186003)(16526019)(31686004)(26005)(956004)(8676002)(2616005)(36756003)(5660300002)(86362001)(83380400001)(478600001)(8976002)(2906002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 
	NAJnxK0sf7vWTQimCUBxhY9EKC9OXB0SXvzBIuR3sHP2DS48gTP3+3zCLKRxxM70ZkcetJI9+EZkb1IzTnBEDTXOR8KA2MGw4XBZ+BFiVhruQhGyt8VGjiPdnKWaimqNbvHxezQhkTCctKzk/DsGdCWEWjbWEv6MAfS+Y064dqFG5Sf4nnwVPnnvsq5Xtm23kFH9TsNHsAsLpe5q7o3iRH+wzdrHGYV14ezpauyr8o7kZthNGCvZqHNOTqviYaX8h1B5X1Cd9WejgT/ntaPoIhWU+HtegksIfyGr8wmNLXfXIdzK0VZgd7CSxZFlp03YoOCsOd5WZwD3fZngrBOhcRhkyp+PTgionUDA7SIlOffE+W/j3A2vYxtOZ1F56oRBxyxWgC8BCbFph6s0xM4KN4XIQBBoaQftacw/nI4NWNsdvYwvp4NcK7lV9vA++WY8TN+ARAXy3Jxfpu1ZisoGNrW92J7+QFa7MRwBuzl3eXW71kgyFy64eaBELLekh4IhjEzULxADszr4yQn6NdtIvjNLRCZzbeq6JAC9SESjXHViOIxcz373PHX4qpGxxcdmLHFMn+g8EdqfXbJsG5DDrW4+pUvWnoGMVwazuwUVVftyHVRxPCjRQb3imoO7zyUH2uxKBDibD5jz4yIi/FBCEQ==
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e9e0cb-64fe-4ecd-5f4b-08d8742e5c21
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB1874.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2020 12:56:13.7093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDIYa9G298oa02Fsgoxvo7vpUAPVi4Mvkc6wy0dz/CGuNTOabUTCKEmbzQLu/U4QSvWzzMAxKhsLo27rDVlsLwHZRUzohrAlsDF/jNM6dGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4310
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 19/10/2020 14.28, Richard Purdie wrote:
> On Mon, 2020-10-19 at 14:11 +0200, Rasmus Villemoes wrote:
>> On 19/10/2020 13.37, Richard Purdie wrote:
>>> On Mon, 2020-10-19 at 13:25 +0200, Rasmus Villemoes wrote:
>>>> I'll have to respin for the git version issue anyway I think, so
>>>> what
>>>> do you prefer?
>>>
>>> How about we just have the user set:
>>>
>>> BBFETCH_GIT_REFERENCEDIR = "${DL_DIR}/git-reference-mirrors/"
>>>
>>> and then unconditionally mark up recipes with:
>>>
>>> ;reference=linux-kernel
>>>
>>> then the fetcher code looks in
>>> ${BBFETCH_GIT_REFERENCEDIR}/<reference>
>>> for reference clones if and only if BBFETCH_GIT_REFERENCEDIR is
>>> set?

Yes, as I said, we can make the use of the --reference-if-able etc.
conditional on the user having opted in in the first place, then if the
host provided git is not new enough it will just fail.

> Right, DL_DIR would likely work well for most users but its
> configurable to anywhere.
> 
>> But, uh, how does this avoid the checksum/sstate issue?
>> BBFETCH_GIT_REFERENCEDIR will need to be exempt somehow, right? I
>> mean, I do want to be able to use sstate artifacts generated by our
>> CI, but not setting up BBFETCH_GIT_REFERENCEDIR (at least not
>> necessarily setting it up in exactly the same way).
> 
> The dependency code would have no idea the variable is being used as it
> doesn't know how to peek that deeply inside the fetcher.

Which is of course totally non-obvious for everybody but a handful of
people. But that means one might as well make it slightly more flexible
and not force every reference repo to live in the same directory, and go
back to the keyword-style

BBFETCH_GIT_REFERENCEDIR[linux-kernel] = "/some/path"
BBFETCH_GIT_REFERENCEDIR[chromium] = "/totally/different/place"

But if you insist, it doesn't matter much, testing suggests that git is
fine with the reference actually being a symlink to the real repo.

>>> This avoids all the messing with vardeps, keeps the SRC_URIs simple
>>> and
>>> should generally be much more usable/scalable?
>>>
>>> If BBFETCH_GIT_REFERENCEDIR is set, we'd also probably want to make
>>> successful clones push references into that directory to cache
>>> them?
>>
>> Absolutely not, the referenced repository is not to be modified in
>> any way.
> 
> I'd like something which can be used by others so we need a way to
> populate/update it. If its read-only in your case, fine, we can detect
> and not update but in the general case I'd like others to be able to
> benefit and use this too.

I really don't see the point of doing that (pushing "references" into
the referenced repo). Why do you claim that we need a way to
populate/update it? Keeping a  mirror of the upstream is exactly what we
do under DL_DIR/git2/munged-path-to-upstream, why should some other
local, but completely external to bitbake, repository also act like
that? The purpose is just to speed up the initial clone (say, by having
a clone of Linus' upstream repo lying around). I really don't get it.

Rasmus
