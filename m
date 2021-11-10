Return-Path: <quentin.schulz@theobroma-systems.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99C9C433F5
	for <webhook@archiver.kernel.org>; Wed, 10 Nov 2021 18:42:50 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.84])
 by mx.groups.io with SMTP id smtpd.web10.279.1636569769072169428
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 10 Nov 2021 10:42:49 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify"
 header.i=@cherrycloud.onmicrosoft.com
 header.s=selector2-cherrycloud-onmicrosoft-com header.b=gzp3hjpg;
 spf=pass (domain: theobroma-systems.com, ip: 40.107.8.84,
 mailfrom: quentin.schulz@theobroma-systems.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/40tNNizr1yfCgGuVcFEnexg/3/nK/Kk0yEJHk/IXYwOmmxHxDqv10t/NMHyMdOqivY+3gXImFRI3Vm8awKYKOBTZupmeLVK4+vrUlze/+ZdzOgIO6ouDYab80cHSvTHZI/mlcqHq9Jks9UTQqo9P8OWZ7wena4xNXvOA1Ss3eXWSgr3c1osGuB6ZO/QdxcrMlRolCqhQycDU8d73N+uitL16i2NkF3B4cCXZWA9UtTkfKuSyzf6/c0ZacmcJXSRZBtfMTaHhmCDc2zPhpSU6oDkD9blXcfscd5Qw2HEZg9JC7kz+6DFw9ywZREf8gb+jdIm7nUhGCVkFBPslOKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSO1JWDOaL2/6+YiBR9y2dXj6i0ep0H1zdpEbl1mka8=;
 b=SzzY3/J9f2HoQw/pf4hr4eXg52mNq+prNIX+xfyRejP2zSuGgbrJ9X3b98JH6o0kGUOfQdhsGfiGv9cJWGLOFRgAXVC2VibccodiUQWncXpoTxOF+nBhQ/N3IS2Hm/uw7vR9hFPM7QPhstQR1LpGtaGBJJ4NBGOisRn5/81JiEJqnweAnQzUtMhkaKs6g2jDuBzzFfuObwS/VP/13iBRhLR6eComVE8TTt1Z6NCIMbrMmq9QiQOcGkLcy1eNOZMt9UMIlr0zrQSwknvqe7ZEtjMQ+Sf5iZRlFPm1LYa9gsx6BApDoBouquxUXcQ2461M2Ko8GPiuaHOoBt7/L/FNaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherrycloud.onmicrosoft.com; s=selector2-cherrycloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSO1JWDOaL2/6+YiBR9y2dXj6i0ep0H1zdpEbl1mka8=;
 b=gzp3hjpggNDNBwjXyCUUk4i563raPVyAySoy883VYrDeXagWfQtEdKRSxmhw9OmuqDqgP/aYapZrb32M6+mqG9UJnlMtsVIgQfnN+UkNabQBxxq6Uwgpt51bnhpU30jRASq0BugK+5UFJpAF5BWRyuEY8DUKyBtvK6WUKwInnLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24) by AM0PR04MB5937.eurprd04.prod.outlook.com
 (2603:10a6:208:119::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Wed, 10 Nov
 2021 18:42:46 +0000
Received: from AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a]) by AM0PR0402MB3348.eurprd04.prod.outlook.com
 ([fe80::d56f:ec59:3bd0:6d7a%5]) with mapi id 15.20.4669.016; Wed, 10 Nov 2021
 18:42:46 +0000
Date: Wed, 10 Nov 2021 19:42:43 +0100
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
To: Marius Kriegerowski <marius.kriegerowski@gmail.com>
CC: bitbake-devel@lists.openembedded.org
Subject: Re: [bitbake-devel] bitbake style/workflow
Message-ID: <20211110184243.jtmbi3ulzomgfssj@fedora>
References: 
 <CAMaS9hNh8iztUquiPddua-6Lu0nLzU832YwHG+rw284zqUzEZQ@mail.gmail.com>
 <CAMaS9hPB=273mfQ4eZp32tsy3DrsqX3x0sKmxSaZ2CbsvaYYxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
 <CAMaS9hPB=273mfQ4eZp32tsy3DrsqX3x0sKmxSaZ2CbsvaYYxA@mail.gmail.com>
X-ClientProxiedBy: AS8PR05CA0015.eurprd05.prod.outlook.com
 (2603:10a6:20b:311::20) To AM0PR0402MB3348.eurprd04.prod.outlook.com
 (2603:10a6:208:24::24)
MIME-Version: 1.0
Received: from fedora (92.42.140.82) by
 AS8PR05CA0015.eurprd05.prod.outlook.com (2603:10a6:20b:311::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16 via Frontend
 Transport; Wed, 10 Nov 2021 18:42:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba3b80e1-580d-4e92-a83f-08d9a479e32b
X-MS-TrafficTypeDiagnostic: AM0PR04MB5937:
X-Microsoft-Antispam-PRVS: 
	<AM0PR04MB5937623531A05EFB58A10FBCC2939@AM0PR04MB5937.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Dq1EU2woAbKTnc7X8D7QFfReAsakAll8sklqXGLv7TlOlNnNCYzVv8sMs18cfTC/vNwiJh6sosM+2CiUoCElyILoCYt1ubM87N9iI3fTiUx+Oi5+lxsU2yu/EYl6j8fQLEbjglLi6S7phVdsA/SHIe5UuTKrQ47aJC6rTpjpZpYyuBf7jqS38urpSkFdLy8gzoEopXXDMCV3ODxzazJMTM+OLxDUKYZMwYZn2hXZQx19LagKM6esHDYm2+c4CRIphym+JntOVsOY1jk0vhe0E139VQ1OCHsK9PZCod+eVoxI9xFN+SQdIgJw+hr/dpbMGYHGRXvnGQUYrYfj93tcSbQZoImzJPncr0b1TqyBl2ewyfrgW+ncYv7PMbqTHtSH8aqb8tbt/EcXUjS6SdGuXFevwZzUZRGZFqwMe8q5zzPXVL8C+GD/MCrIqljs7/7Uc7Lj7a1sJ1nMaEDGzkPDSOd2P+8aOUc/MuFEusabqJGzffzkuQ5s9IDnKmIdlPTymjNmrDd5kvyx9JWVdGDRUsHvvAp3TnMHxjMHLg7cgOL6etBjbHx9umMZCtiY3gVEY+SIs6SuICpHwZ/B5oqAwB/yPYFoSlVzRoGxz1ZkvboUO7FoPbLXMW/ZX7moCeC4QeI/sGL+6lvhR6p7Ly9HNPSrzsXJvx9HSGY9GW+kFNYJoA0BKNBaVWhjG9qUIMSNTjaQF0aupXr0qQ8416w3nGkLyjW+egIp+vjN+cB4Ae9m39isum6IwHm23Etxc+d6q2luTMbwpt4W41DLk5HqyQZUllzLOEukPpkDh0jPif4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3348.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66946007)(5660300002)(6496006)(86362001)(45080400002)(52116002)(4326008)(316002)(1076003)(508600001)(9576002)(8676002)(38350700002)(8936002)(2906002)(38100700002)(956004)(66574015)(55016002)(966005)(9686003)(66556008)(44832011)(66476007)(83380400001)(33716001)(26005)(6916009)(30864003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Wa8HITh8nLTz4i4Fr2dRDDD0Ki78S9seZU9AY1mscSmxNYpwNl5oQk2tibRW?=
 =?us-ascii?Q?TD9UgW/i11TmfhMFV4BtrNXJBvOR/+R2NGz8RILExfyzkSJQHQZjBvTLif8Z?=
 =?us-ascii?Q?BGsVhDQsMMtqbbgFSpM8BM1gVc1Qnoxj1LB74HpJW9UfYfxWzRzT0qB3lU8M?=
 =?us-ascii?Q?R/KpikvV+79rZcOHIUK5qe5A/L3v+4aesLGJFYin/ZZWl3A0gXzVNvRmnTgB?=
 =?us-ascii?Q?0xhi35f7W5hexUPHts9SY7ZalOlvQh7hGMXqDuwqN0uIYvN72FUdg+rlNcpr?=
 =?us-ascii?Q?1ZqRNMZzCnZSiH+8lO62ISLAplxZlHKFOSsH/NEK+jQpJ8pY+L/CHQMjKJ2n?=
 =?us-ascii?Q?50M9m9g+8R9wkdmP38DF+gM2AxeLbbeZ+sPdvuRuYRKX52qjYZ53lOICkuqT?=
 =?us-ascii?Q?Qgem2B4MxpSE98+94oG4AETUO+5ZkOqv9Lt8BK93ejp41IZl0Mu4MSTfJDna?=
 =?us-ascii?Q?JOcC5FDjoA5HkJjTFCAEHh+9LWLMl0V+LTWos6sLlVvZAeHB7u2KHvVV9DnO?=
 =?us-ascii?Q?7jt5Df9N+YBPqGRp4/0VYZmEhIdU58xk1cYOJUygCxxp8FMcjANdxnfqLuCF?=
 =?us-ascii?Q?aI8nZ/RnQ+NZL292wrFreIa3ecBPJ68j/wJVVTCyM6o7B8jnXSDU3NEZVZD0?=
 =?us-ascii?Q?o22v8spdnWmQBw3sxBM9XCq8oEWUWdMZ2srn8fuODfhdqVTEAeHYUY+OYmja?=
 =?us-ascii?Q?FiBHycf4NsKi/02KfbywZzzI9VDq2enZPUusjuZPoXX9iJhBYsnahRSmBdX2?=
 =?us-ascii?Q?hNw62aFSHJBS6Wfbrgk9qVXl1SvhBfl1NuEOca+/X+kDpro++euWdKaQEzXx?=
 =?us-ascii?Q?x6/0WiheMP13CYfI6rGPwygaZLgjChSRCd+0iVgB4kig+dVIfc9r81nh4hlp?=
 =?us-ascii?Q?qv+SnNuEVc/8Snt6MPrX9Q1ieT6S6LrG6dYBJY9tpwWuZQdJyohU0PrD1Ttb?=
 =?us-ascii?Q?eQLAHE3yueX9HU4dp8I0htkKw3OTRC2XCmpKSkuTMesDnbuXmX/Tb1dCtXTO?=
 =?us-ascii?Q?9ImTXgYWVchSCTarXmkrI5zzaJkbQIj9Y3iWOphcr9UyT8UGXTgYJKFS6KgP?=
 =?us-ascii?Q?xLbmHVvsXiRcTmun6SkiODE1++FzyYPZmTk4M5/ZC4eiXY4ACU+YwDNekO50?=
 =?us-ascii?Q?4qtdTZsM7nxKXQGGsjSBhHeSMCBGbi+lxTq5cqdQbsrgx+UxEEOXNhJL6v9m?=
 =?us-ascii?Q?VGn+ry4BRWAGIpH/+OeL14gYijcxchkwIHgc0ErWPACu+Vbv4uHkZFjocHps?=
 =?us-ascii?Q?cUchWIDQ3vWr0iOT/m8VqjuHWMQ5vL+BbKAKyWSRz+tz0WduVX/fkNKQt9td?=
 =?us-ascii?Q?p2wkG4ekZ4dZfUcTg5iAf9h6L/xH27d3gtlBeD5ls7oxQSRvOEIF7CTCSgRv?=
 =?us-ascii?Q?tkhjtVhRt+CIGqGti0lppbbwxV+8ULRhHeoxz8Nj0hQ5BmAcguS0OVxQVC0b?=
 =?us-ascii?Q?Pb0DkJ0ZFzS272UIP2WKi0IWHlKdlzdCGvY69yrul7ntCVEJWUJsUgI5nBbw?=
 =?us-ascii?Q?HG0tkRDSRvqjcBq8N6awtA3alspbGDyO5KgFYOlee2Wa1l7+hdI0Y4aQAnSJ?=
 =?us-ascii?Q?yh0Q10pKAYJ6Qwq0V/Ei8ZcgNvMJxNP/znlCTyuIluadSd/QBVErCdK33FE8?=
 =?us-ascii?Q?nenHnSwgLgrf7UbUN4irVvhTkpF6oSPRt9SN8DO8RN4KscQNQ2t8AC5y7EKP?=
 =?us-ascii?Q?y2PUW5fbALemXPLBHT0z/5Rv5RqtL7+cGo7mDDXv2YJaTJCPd6pmdO0u99/K?=
 =?us-ascii?Q?XIzrlvFOGQ=3D=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ba3b80e1-580d-4e92-a83f-08d9a479e32b
X-MS-Exchange-CrossTenant-AuthSource: 
 AM0PR0402MB3348.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2021 18:42:46.0732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 8OoCDHSqkA1HqfOu89kb/wjJgVUMVV9xOnf4POmdUO6hPCgMGFGextEYP6r9nAhcBNpghX5h0Up/9quC9Hd8CIWLkoOE+zbX+L7Cmms2u9wLkaj1zYuw2gvT04fyoX0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5937
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 10 Nov 2021 18:42:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12995

Hi Marius,

Too many mails gone in too many different directions so answering here.

On Mon, Nov 08, 2021 at 06:37:42PM +0100, Marius Kriegerowski wrote:
> Hey there,
>=20
> Is there a plan to switch to some more modern ways to collaborate on
> bitbake, you know, like, gitlab/github/gitea with issues, PRs and so fort=
h?
> I mean=E2=80=A6 it=E2=80=99s late 2021 and sending MRs/Issues via email f=
eels reaaaally
> outdated, slow, intransparent, ineffective (how to you do reviews, code
> comparisons during reviews, insert suggestions, etc.) and indirect (where
> is the CI pipeline that I trigger when pushing something somewhere?). I

Do you have some data to support the claim that MRs via email are slow?

Intransparent? There are mail archives available with all patches
posted and their reviews. Same for issues sent on the mailing list. Though =
I
have to say that I do miss the "Merged, thanks" mail that Buildroot and mos=
t
of the kernel subsystems are sending. Though you can fetch the git repo and
check by yourself. AFAIU, the patchwork should be fixed some time soon
and make this a bit more explicit.

Ineffective? Yocto, Buildroot, Busybox, most kernel subsystems are using
mail-based patch sending/reviews. I would have imagined that if that way
of collaborating was so ineffective we/they would have switched by now.

How do we do reviews? You send a mail whose body is the patch and only
the patch. We receive your patch as a mail in our mailbox in plain text
and we then split the mail where we need to insert a comment. Just like
I did here, you can see that some of your message is above the first
part of my answer and some after this paragraph.

We could probably have the same mechanism that the kernel has with build
bots directly sending a mail as an answer to a patch if it fails.
However that is not the case today, I do not know if it is an
infrastructure limitation or not (builds are very expensive in terms of
CPU resource and time).

> threw a search engine at =E2=80=98yocto bitbake CI=E2=80=99 (and similar)=
 but didn=E2=80=99t find
> it. I=E2=80=99m 110 % sure that there is a CI pipeline but it would make
> contributions, reviews, etc. so much more efficient if I as the
> (hypothetical) contributor would see the outcome of just a linter*. Maybe

There seems to be only one linter available and I cannot say how good it
is since I don't use it. I see that you're already a contributor to it
but I'll link here anyway: https://github.com/priv-kweihmann/oelint-adv

> it=E2=80=99s somewhere documented where the CI is hosted but then: No oth=
er project
> I contribute to needs documentation about these things. They are just the=
re
> and obvious.
>=20
> Don=E2=80=99t get me wrong: bitbake is awesome. I=E2=80=99d just love to =
contribute but the
> burden for collaboration here is not really up to date. So, is there a
> strategy to improve the on-boarding and workflow?
>=20
> Greetings
> Marius
>=20
>=20
> * side-note on bitbake style/linting: It=E2=80=99s violating PEP8 in a co=
uple of
> ways and TBH PEP8 is the bare minimum I would accept these days for
> collaboration on projects the dimension of bitbake. So an additional
> question: Would you be up for a PEP8 compatibility overhaul of the source
> code? I=E2=80=99d volunteer if I don=E2=80=99t have to send a patch via e=
mail ;)

Sorry to hear that sending a mail is that much of a hassle for you that
we won't get patches from you. I hope this changes in the future.

Now, to get to the bottom of the topic. You asked in another mail for
<35yo people. I'm one. I'm working only in "low-level" BSP (understand
kernel, bootloader and basic recipes in Yocto or packages in Buildroot).
All the projects I contribute to are using the mail submission
mechanism. This works great for me. You can have SIEVE filters (or
client side filters) to filter the mails that are touching a specific
area of a project or you being directly cc'ed or to'ed. I receive all my
mails in the same folder right now, meaning I can spot some interesting
patches every now and then in-between internal mails.
Submission of a new version of a patchset is easy to understand and the
status of said patchset isn't going to change overtime. It is a mail, you
don't edit a mail once it's been sent. GitHub and GitLab are updating the
merge requests every time you push/force-push to the branch used in the
merge request. How as I maintainer do I know if the new version of the
branch is ready to be reviewed and that active development/debugging is
finished?

I also don't care about differences between older and newer versions of
a branch, you're not merging a diff between versions but a patch, in its
Nth version, therefore you should take the time to re-read the patch in
its entirety or at least skim through it. I can say it is VERY common
in the kernel community to have reviews on code that wasn't changed,
just because the reviewer had time to think about the patchset between
versions or just misread it the first time they went through the code.

I use GitHub and GitLab for personal projects and Gerrit for some
projects at work. I prefer the mail based review and merging process by
far. Maybe because I'm just use to it. Maybe if you were to try
submitting patches via mail you'd get use to it?

You cannot (as a user) make backups of GitHub and GitLab issues and MRs
to have them accessible in the event that the website would shutdown or
lose data. This has happened before, see:
https://about.gitlab.com/blog/2017/02/10/postmortem-of-database-outage-of-j=
anuary-31/

Though GitHub is owned by Microsoft which apparently loves Linux, and is
a sponsor of the Linux foundation which sponsors the work on Bitbake/OE
IIRC, their source code is still not publicly available. I already
complained about the use of Zoom for conferences held by the Linux
Foundation, I'm not sure a move to GitHub would be well received by
everyone. GitLab does not have this issue though.

Both GitLab and GitHub require accounts to contribute to projects. This
is a big issue to me. Everyone has a mail account, every one can get
one. You can even use temporary ones if you want to. Just as a reminder,
Github shut down access to Iranian people for some time, see
https://github.blog/2021-01-05-advancing-developer-freedom-github-is-fully-=
available-in-iran/
and https://github.blog/2019-09-12-global-software-collaboration-in-the-fac=
e-of-sanctions/
Also, they both have their Terms of Service you have to comply with.
They can change over time and you can also disagree with the ToS which
would then prevent you from contributing. There are plenty of mail
providers, I suppose one would be able to find one whose ToS would be
acceptable to them.

I don't think this is something we would be okay with. I do not want my
or any other people's contribution to YP/OE/Bitbake depend on what the US
decides for the rest of the world.

Also.. GitHub (and probably GitLab) have some down time, like most
website do every now and then. I've yet to see a global disruption of
the mail servers world wide that would prevent us from reviewing or
contributing. See:
https://hackaday.com/2017/02/02/fotw-gitlab-goes-down/
https://www.theverge.com/2020/6/29/21306674/github-down-errors-outage-june-=
2020

Also on the Linux-geeky-nerdy side, I don't need to click on links to do
reviews within my CLI-based mail client (neomutt) as opposed to web-based
ones.

GitHub and GitLab or any web-hosted solution require Internet access to
review patches, this is inconvenient at best, or an important limitation
for developing countries. I do not have numbers to back this up. I have
heard a few kernel maintainers doing reviews offline (in the plane to
conferences for example or while working remotely, off-grid), piling up
mails and sending them as batch once they do have access to Internet
again.

We could host our own instance of GitLab but compared to the current
cgit web interface and git servers, this brings additional maintenance
cost and security issues. Adding financial and time cost to a field in
which the project is already struggling to find resources.

In addition, the migration is not an easy process and takes time and
effort from many, during which the development of new features and fixes
will most likely suffer.

Having 2+ ways of contribution is a nightmare and a time-bomb just
waiting to explode. Where are the reviews done, would most reviewers
review on the 2+ media where the MR and issues are reported? I wouldn't
do it for example, not by choice particularly, just that I'll forget
about one.

Bitbake and YP/OE are successful projects. A project does not survive
for more than a decade if it's not any good or useful. It is backed by
the Linux foundation for a few years now at least. Most embedded SoC
vendors are providing some sort of Yocto-based images. Despite this
apparent barrier to contribution, the project is doing ok.

You also cannot compare meta-openembedded with Bitbake for two reasons:
as far as my understanding goes, meta-openembedded is community maintained,
it is not really part of the core of YP/OE. This means that it *could*
(I'm not saying it is) be less reviewed or of worse quality.
Second, meta-openembdded is a layer.. it has recipes, classes,
configuration files. Those are much more accessible than Bitbake. I can
write recipes, classes and configuration files with my current knowledge
as a user of YP/OE. Bitbake is what's making use of the metadata
provided by meta-openembedded, it is python-based and is what makes
YP/OE YP/OE. I for example wouldn't be able to contribute right now to
bitbake because I do not have any knowledge of it nor do I and most
users need to. A kernel analogy would be: kernel drivers vs kernel
subsystems. Yocto layers are receiving much more updates than Bitbake
do, as would be expected. You can check poky/openembedded-core too, for
example Alex Kanavin to name him regularly updates recipes in there. We
see many patches, this would be a fairer comparison.

Now, YP and Bitbake projects are struggling to find regular contributors
that is true, public and known. Lowering the barrier to contribution
should be among our goals. However there's another problem with changing
the contribution process directly... we do have regular contributors and
changing the contribution process is taking a risk that those
contributors stop contributing or contribute less jeopardizing the
project as a whole. Considering that the change also does not
necessarily nor immediately bring new, regular, long-term and
"in-quantity" contributors, it is a big risk for an already established
project.

I can hear your side of the argument, I can agree with some parts but
you also have to understand that this is a risk for the project that is
non-negligible, for just a hope that it'll be a positive change in the
short, mid and long-term.

I have to finish this mail by stating that I'm a mere contributor to
Yocto Project (and not Bitbake) so all of the above are my opinions and
my own only. I do not speak for the Yocto project, OE or Linux
foundation even though I regularly use "we" to define the YP/OE/Bitbake
community of which I am a "member".

I hope you'll review your stance on contributing via mail, we're looking
forward to receiving your patches.

N.B.: We now have a description on https://github.com/openembedded/bitbake
reflecting that no issue or pull request should be opened there.
Hopefully this makes the contributing over Github clearer now :)

On a side note, there was similar discussion about moving our IRC
channel to Matrix. We've decided for now to stay on IRC though a bridge
is provided by some Matrix servers IIRC (we do have some people using
Matrix on our IRC channel). I for example wouldn't move to Matrix
because I had a very bad experience with it for a few months which made
me stop using it entirely (and also it's hard to find the ToS of Matrix
servers and matrix.org's wasn't acceptable to me).

And finally, having a rude or harsh tone is deserving your cause, it
triggers people and does not start the discussion the correct way. As
the saying goes, if you smell your own sweat, it's been long since
others have been bothered by it. Same goes for the tone of your mail,
if you think it is harsh, it probably is more than you think. You
probably would have received better answers were the tone a bit tamer.
We'll never know :)

Have a nice day,
Cheers,
Quentin

