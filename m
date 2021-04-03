Received: from NAM10-BN7-obe.outbound.protection.outlook.com (NAM10-BN7-obe.outbound.protection.outlook.com [40.107.92.73])
 by mx.groups.io with SMTP id smtpd.web09.25887.1617414285496019872
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 18:44:45 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=XIZnitWs;
 spf=pass (domain: windriver.com, ip: 40.107.92.73, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k464fpgjfTpfh0aUhDUMLEKrzywAoBX3Z/sbEN121IO97XwGW/9zYHniyp/yCNZ1vw/MTz5bTO8cEvsCIKW2F2rL4Ca7Ib+UCgeFMYBjZNGtkwh1VtqsEAIhUzeoUvdxOl/vShr0rLN5wfK9vXXi38nHayl1hH9uNjRmcXDtnOKrvd1dNkgi8J6t63Wuz/mDx1qWbISDlF2wFB6Xi0zx/6fh2IBUNQcbq1t7lx/GMebdc+Kvo5REWonBE6E3LAyA43tOzz+XcxsOU229IEczfBEOh0LhD7kYvhGOCfu8EgVr8oJvcS7IEqBQTI4jwfgkbMDNbpV1Nk9LTQZOPNfLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vud4B/CuJ6hTkz6iziS7cr3J5KKKakAy3m7xADE5KFM=;
 b=lrRwV70OFJvl95sA4N4nZDpwyHkwc0xFAr33bDEa7jiQW9ZbdoRO0BVMkZZAUEn5EPGzHxdyVgDUVU7XIfvDJkoy/lRReN505PQnMjybsX/n/pVaUczL1f/xa0cMPHxU8w42JM2h8fChsibUqPvwEu1lzc+91xoJEHshLmkw2jmDJhuWDkWbJ3QAGR61vqQeEV1iYUF4f8MxxQ2mFYsvikZkDcGAs4KgsfR91cDlThEAPjJPrtCY4YfgJja83lSgALA2BkKYtLUvpRTLlblj3eaiOULry2RB4sOx350B4Nr5HxfS9/oiXkUg2jl9IJuUMdObKmEJpkI5eWxRtiLYIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vud4B/CuJ6hTkz6iziS7cr3J5KKKakAy3m7xADE5KFM=;
 b=XIZnitWs2G3GFymOMLbAHpxHVqKlHSQoVjStoFLOKFzcfynqJovKj3AlFIuvZJdaqwQviMkA1QK1gqJMmeysFqk2vjOjx+JU8obbLjajR3MgJdSNIFXCmPjBbROuFcwcJCLufxtA43sr7VnSFGAZPGFZa6hzrSHIVDcfZWTh0xk=
Authentication-Results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2827.namprd11.prod.outlook.com (2603:10b6:5:c8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Sat, 3 Apr
 2021 01:44:43 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.032; Sat, 3 Apr 2021
 01:44:43 +0000
Date: Fri, 2 Apr 2021 21:44:39 -0400
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
CC: Bruce Ashfield <bruce.ashfield@gmail.com>,
	linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH RFC 00/21] Git repository sharing for kernel (and other) repos
Message-ID: <20210403014439.GA162790@windriver.com>
References: <20210402171557.981599-1-paul.gortmaker@windriver.com>
 <929dcfb2b10aba2ca29d0b1cba44dbc148e0643a.camel@linuxfoundation.org>
In-Reply-To: <929dcfb2b10aba2ca29d0b1cba44dbc148e0643a.camel@linuxfoundation.org>
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: MN2PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:208:fc::24) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
Return-Path: paul.gortmaker@windriver.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by MN2PR02CA0011.namprd02.prod.outlook.com (2603:10b6:208:fc::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Sat, 3 Apr 2021 01:44:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d190d388-3c06-4069-3c93-08d8f6420d5c
X-MS-TrafficTypeDiagnostic: DM6PR11MB2827:
X-Microsoft-Antispam-PRVS: 
	<DM6PR11MB282708F7C759E7297CDEB0C983799@DM6PR11MB2827.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tx8vQ6S4YU1WBxmWUPoqk6/AyDKDsJzelj1HbC1B7HJkLlcDlrTdFn28N5Sb2lUd26lLKIwKzyLv53rUM5LAqS3v6rckE4WjihvC5IDeRup2H2+65JAMbrU5RgtEYnViHq96PcAL7oXhNa55wzEywJgpCMdw6PBlaeBqmNvfKyqCwM9WMbkg+S41tung/2AjhXnNvN3avsixSS5652HZxdfc39m0bAhZImEJVsS/2Y2KjdWYN+cITsLGugbXcACuM1vVWl+yWZvjRk502zijktLbUFmkCgFdWL2311SrEkAWFPSLoQdPFWw3ymorJdoy3XZis/SORNdzZ5rrwU9NB8rgljF3iKwVTgLtPNg0/oARmOAUY/16W9FYuHS2EK7yuAcKpkoKNSftFpJX4tEm2K1BQNjSC1XBb2vdfZaXyFgWXyoDV6JB0SjAvK9SU/ZGgAAwaHQ3hezZKUNX7fHLpua43U5J1KQSO17hiIpo0uP02ykgTHyvxe81P7FbqpaNyXau06XaA2gtekKUhBz0Uq59OdK5HVlLbqhCm0/TAO1KW3Xi2phrpekFCH9TXsvaPoxSAUvSIHYYCONNi7/nKVzShOc1iwSZuMgwdjTqdwTqRlH9xnRBFfoEvGyUShrqZhXgI/4IRbQTFdfrD4z/mG5wqt/ltsbysEQT46Bnp5vc5+5U6YNKRQunHtBuoHnOlPtlORP31rWBqRWS5AZRkHwcNuo7KspnjRCoDlv3LelCgMPsD89m44ml0/eSDbVp
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39850400004)(376002)(396003)(346002)(366004)(6916009)(26005)(44832011)(6666004)(8676002)(66946007)(38100700001)(8936002)(186003)(8886007)(55016002)(2906002)(2616005)(966005)(7696005)(956004)(478600001)(316002)(86362001)(66556008)(66476007)(33656002)(52116002)(16526019)(1076003)(83380400001)(36756003)(4326008)(5660300002)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?lP6oklH7b9Ab50tAFwWC4ijIyCr+WZ5h3YazLlAKDu+th1GOCgjdv4kZy49f?=
 =?us-ascii?Q?Ehu05528YhY/ZP9yCe/96M0pLaOmU0VeokNL3Gnjpj+n2JFIIZCykTeQgmjP?=
 =?us-ascii?Q?yUzitAfCURuAEkPT4An90gdFxR00ewwAhub/9Wevzbj26JABGvX8WeaT60ou?=
 =?us-ascii?Q?+tzhwQX/5xFmhPzVrGCGQV3ZAIzJUHzISlS4lmYAHnmhNpJcAYZKTQo72pX8?=
 =?us-ascii?Q?j8EY0TvsYNX/exvW8OS5kX7MIp/bd9erYu2z7IcwrrLgFHcOtjMoTWnZD/LF?=
 =?us-ascii?Q?RVK3e3XyzVSPZPccX/exV7y+XqBduR5PcAi0yxP/lZIqvB3OK0nt8NLHUiKP?=
 =?us-ascii?Q?2YItmCemTInWcZMuioy0OhchFNErR0ohyDe4ml3CYwZYQl8jmszy4ejNKCDV?=
 =?us-ascii?Q?Rzhvsh6qotEwblK7dPigcv84r7nk1WiomX993TcjzxDYhwZW/jIrLqMCT2gD?=
 =?us-ascii?Q?Quf0qWpPpuqtpPXNS4X3YYg6bgdj6xvaBZemyKhPWnNRKAxm6BXWhU2R3XiK?=
 =?us-ascii?Q?8NPTu2OBtSLHrNB2tYZKuuZ9gacCvxA9/13azV8iID8cGo68SyRdU6NrUKFR?=
 =?us-ascii?Q?lfI+26LkBLYjMZxzn+wS01XR3+oxw+bHA+W9rfKHNHjP1Gd2zO7xSAXMqwWg?=
 =?us-ascii?Q?e+vB7Nm81SKRLnPjZAY1UxD336RuzzdrOf6GFTDWBwDTcrUoiJF3JtzDlfYJ?=
 =?us-ascii?Q?yj/VVUJz0J6Jmu+kD8ysJqKPO2C8FCe+l/4Bja2bMNSiaqMS/txkZUnMCLHG?=
 =?us-ascii?Q?FUOeatHjBgwspGFN26AmKzSvIADOZn9XO7p6Ge1yPvvffy1l4et2NidmrDlc?=
 =?us-ascii?Q?ow3F/3kmXgAKBfLjyzZH/bYKst6PdNGiEGr+dUcJO5DwWo3/Yegp+HZ4oj8x?=
 =?us-ascii?Q?wg4ZGdzfMvlw2H5qrycRYbMOC6CT2zHJVprIBQyuBwfQI5BY6k5RIbiGykD2?=
 =?us-ascii?Q?YPs6DeJIfO4zqgIEFjbMn4LBrBjPOJ6iQlZBJrvSHjQcIm53mvLQLccBybud?=
 =?us-ascii?Q?0n/cCDFOpY+hLuJd0d2bvftMo9rLVH8Mev8gw9BtWe/pdEgOqJlHFPB0ZXQt?=
 =?us-ascii?Q?vOmoASilstsyVPx7X7sq0wFJZGqWgZuWlV8al29vWXTFk1Bsdt9/WeUMshiN?=
 =?us-ascii?Q?BMap2EWL9/3zMr6t+TZpZArzLHvsJ0DfOq02XDeO421v2QURyf1k+pDgIxGb?=
 =?us-ascii?Q?zW9XDT/jL9aBMKdVhPSMqnlztlbXDj7P51S8aLtpMYSOXBEScO9zeX2R9CWG?=
 =?us-ascii?Q?v4FMuj+ZXaN9t1O74MGXXF7jQpJ5ufru0JrS3NBb49puftA9Ta3P63Hk8oyn?=
 =?us-ascii?Q?GTyZrjK2AUmutKGoev/+l3ed?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d190d388-3c06-4069-3c93-08d8f6420d5c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2021 01:44:42.9818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: raBo4mroF7Aa14AJKujhTRkqk18tHsgtY5gzzwfXSe9xRhOKiHI31KfbNb8ShUqXIfnUTy0f+drkvnch4P+s2hGRCPWZhxkMg6q2rTK6Prs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2827
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Re: [PATCH RFC 00/21] Git repository sharing for kernel (and other) repos]=
 On 02/04/2021 (Fri 23:14) Richard Purdie wrote:

> On Fri, 2021-04-02 at 13:15 -0400, Paul Gortmaker wrote:
> > Next Steps:
> > -----------
> > With this being a functional implementation, it seems like a good time =
to
> > get other people looking at it.  Ideally step #1 will be getting genera=
l
> > agreement that this is something we need, something that is overdue,
> > and that the implementation as shown here makes sense in the absence of
> > any similar effort from anyone that does the same but in a better way.
> >=20
> > From there, we'll want more people not just looking at it, but testing =
it
> > as well.   I know I want to write a commit (script?) that will avoid an=
y
> > "transition tax" by prepopulating new repos with "old" already download=
ed
> > git objects where we can.  And to add/do tests with my own popluated mi=
rror
> > and NO_NETWORK, and also try to ensure nothing in BB_SHALLOW gets upset=
,
> > but I wasn't going to hold up starting a review of this any longer.
> >=20
> > I suspect I can get some co-workers using/testing it too, but Yocto get=
s
> > used in a bunch of different ways by different groups, so we'll no doub=
t
> > have to do some additional fixups to ensure everybody gets the benefits=
 of
> > this sharing.  But I'm hopeful that when people see the benefits above,
> > they'll pitch in to help take this the final mile by ensuring it works =
for
> > their use case as well.
> >=20
> > I'm not too worried about pontificating out beyond that until we get pa=
st
> > the acceptance/testing hurdles outlined above.  So, please do have a re=
ad
> > of the commits, kick the tires, put on your bikeshedding clothes and gr=
ab
> > a brush, and lets see where it goes from here...
> >=20
> > https://github.com/paulgortmaker/poky/compare/reference-RC1
>=20
> I've only briefly looked through this but the more I look, the more worri=
ed
> I'm getting which is never a good sign.

Well, firstly thanks for the quick response, and I hope you'll give it
another look when you have more time, because I'm not quite convinced
I've conveyed how it is to be used in a way that got through as intended.

> I totally agree with the use case and agree we need to do something in th=
is=A0
> area. I'm not sure the implementation looks right though, its clever but =
I
> don't think its very usable to end users.

Not sure who you consider "end users".  I don't really consider myself
or Bruce or anyone else crafting up a kernel recipe from scratch as an
end user.  But even if an "end user" wants to do that, everything here
is opt-in.  If you want to go clone 3G of stuff from mysuperkernel.org
in your new recipe, then feel free.  Nothing stops them.

> The warning signs to me are:
>=20
> a) Needing new/confusing "fetch only" recipes

Not sure how they are confusing - and not really new either; I stole the
idea of zeroing out all the tasks from kernel-devsrc if I recall...

> b) A large number of new options and variables to the fetcher

I'd disagree with the characterization of "large" - but if you do have
the time, please go look over the commit logs for each again.  They
all clearly indicate a necessary use case we don't handle well (or at
all) -- and we'll have to solve them one way or another.  I'm open to
considering alternate solutions for any of them.

> c) Needing recipes to change and people to migrate, potentially with scri=
pts
>    between old and new

It feels like we are looking at two different things.  The users or
"people" don't really migrate and the only people changing things would
be a small subset of people who maintain kernel recipes - which is a
small group to begin with.  Recycling old git objects from existing
downloads would most likey be done in a transparent and hands free way.

> d) Variable namespacing needs work

OK - if given specifics it can and will be addressed.

> I'm very worried this confuses up the git fetcher code and nobody will be=
 able
> to tell what is going on any more :/.

That kind of surprises me, to hear that after having looked at the shallow =
clone
changes to the fetcher, but again - I'm listening - what can we change
in the fetcher?  What is off limits?  The "pool" idea below doesn't address
the fact that "--mirror" is simply not viable for some repos, and that
is hard-coded into the fetcher.   Similar for the other fetcher changes.
And the "pool" idea is still going to have to teach the fetcher about
some kind of "--reference" because that *has* to be added at fetch/clone
time and not as some later afterthought post-fetch.

I could simply take over do_fetch for the kernel and leave the fetcher
untouched, but when the problems being solved weren't really kernel
specific, that didn't seem like the right approach.

> What I'd envisaged was git urls having something like a "mainline-linux-k=
ernel"
> tag added in the url as a parameter and a table somewhere which meant the=
 checkout
> for this would share git objects in a common pool. There would be a varia=
ble=A0
> mapping that name to=A0git.kernel.org/pub/scm/linux/kernel/git somewhere =
but that
> should be all that is needed.

I saw this idea floated in the earlier thread that Randy pointed me at,
but I just don't see it being viable or the right solution even if one
could make it work.  How do you decide what lives in the pool?  If it is
just mainline, then it really isn't a pool.  Are we only solving for the
kernel, or are we making a solution for any repo that is unweildy?  What
triggers populating the pool?  Do you stuff all mainline and -rt and all
of stable in the pool?  Or just chunks of rt and stable?  If you aren't
tracking what is in there via encapsulating chunks somehow, how do you
expire stuff from the pool?  If it is one giant blob covering mainline
and linux-yocto objects, with no fetch-on-demand properties, then we are
back to the same old 3G-downloads-from-the-mirror problem.  How do you
split that monster?  The devil is in the details.

> No, this wouldn't cover 100% of artefacts but it should cover a majority =
of them
> and be much simpler for users to comprehend. I haven't gone into this in =
detail
> and perhaps I'm missing some problem that prevents it? :/

Well, I've thought about this a bunch, and I didn't come up with a whole
bunch of options to choose from that deliver what this delivers.

A mainline-only kernel-specific non-pool "pool" would be better than
nothing, but I'd still want to hear you flesh out how you thought it
would look and operate before I went out and tried to guess what you had
in mind.

Also, I'm still confused by this use of  "users" - what is here all
happens transparently in the background and users aren't aware of it any
more than they are aware of what the fetcher is currently doing today.

> The other issue here is there are no tests. The bitbake fetcher code is o=
ne of
> the few pieces of the project where we do have a fairly complete test sui=
te and
> we don't add things there without tests (see bitbake-selftest and lib/bb/=
tests/).

Yes, of course; and I've been told that by several people in advance.
But as you can imagine, I wasn't going to write tests without 1st
floating the general concept as an RFC and seeing how that went.

Anyway, thanks for the initial scan and I do hope you have a chance to
revisit it in more detail and consider the various problems it solves.

Paul.
--

>=20
> Cheers,
>=20
> Richard
>=20
