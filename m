Received: from NAM02-CY1-obe.outbound.protection.outlook.com (NAM02-CY1-obe.outbound.protection.outlook.com [40.107.76.48])
 by mx.groups.io with SMTP id smtpd.web12.19630.1617383773958212525
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 02 Apr 2021 10:16:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@windriversystems.onmicrosoft.com header.s=selector2-windriversystems-onmicrosoft-com header.b=O6paCtbC;
 spf=pass (domain: windriver.com, ip: 40.107.76.48, mailfrom: paul.gortmaker@windriver.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bbAkR2OSVbqq7PwZpZ3Nd+xdRytVqg9GeA8ppxkdH+T1csiCXVCbJlixaF0dL76qGZFpaj7DMdsBcVfI3tCt1pGP7sr9ySd6xK8sepKKoDwjWqDgWZif0CYwyvinEyuZT0fb/LV+uxaBGqHJ53/SbKCkIH0HWUGUcNHuAA+5h+fZZYkyx5FYzc8t/huswFdpoGw65N2xtkVOIUXR9jMb0bCzdvIJ+OGWac3AkTKVsd4lGPhNgQv1B0Ok/hCCjq8QO5Iq0cGWewQQojlh3I5fkPCTQ0cYl5VDbAo53oPldwUJzyig0bOZQ+gt7Ki946msgQSQgkK9voNa1f2Q6UnWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZ3NeMV1Kvz6Rmequ0hA014dJdc8KDslXUT9R6w5mSs=;
 b=Ml4NrEreh5UB4VQwCg1snxhc8gYerijXcpqbbn/jEbhTyliLYH/bZZn2OQfNwYu15IsdUworR+i7zj7BmhDsQRZfMedZDlzdHLodlJ68wMUkxeKDEdwfQiJbPKgAMC50ddKnG57/6A6XDcl9QfR8Gyw4l3aPv8SzzSu3pStsQ/BkFJak+chcI0JyHrssHVqB2GM6N9bLaAK4uz7s84RSVusPbCDfD8TOzifs8PFHvc4dWyNhIyGaZ2A1lxIicr1xTl4SfXFJBfqBUYugaNNBpLBLBjC7yqVCvqPX4jzVurdYvgce58K1YM2+Q0xZf8hLDq0G0Mlc4Ik/vw9dmhuoJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZ3NeMV1Kvz6Rmequ0hA014dJdc8KDslXUT9R6w5mSs=;
 b=O6paCtbCByUlkEyA9U3CTK/I5TyCr9sAYoBCx8WA078U5uONEABADdaGDarQFmcFG7SsLgUTaOS0CYP03bmZdtOsLTk7KbqJAnBTTOt0lip5+doY8x/Pm1vj1A1pmwDATM0ZiFKLd76oLdFsVTONGlmoJ0B3E1IQ+2JLR+1VHKs=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR1101MB2249.namprd11.prod.outlook.com (2603:10b6:4:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Fri, 2 Apr
 2021 17:16:12 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%7]) with mapi id 15.20.3999.029; Fri, 2 Apr 2021
 17:16:12 +0000
From: "Paul Gortmaker" <paul.gortmaker@windriver.com>
To: Bruce Ashfield <bruce.ashfield@gmail.com>,
	Richard Purdie <richard.purdie@linuxfoundation.org>
CC: linux-yocto@lists.yoctoproject.org,
	bitbake-devel@lists.openembedded.org
Subject: [PATCH RFC 00/21] Git repository sharing for kernel (and other) repos
Date: Fri,  2 Apr 2021 13:15:36 -0400
Message-ID: <20210402171557.981599-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: MN2PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:208:134::39) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
Return-Path: paul.gortmaker@windriver.com
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR16CA0026.namprd16.prod.outlook.com (2603:10b6:208:134::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Fri, 2 Apr 2021 17:16:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6a63678e-682b-456a-6c64-08d8f5fb038f
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2249:
X-Microsoft-Antispam-PRVS: 
	<DM5PR1101MB22499653E1456B95189CCE52837A9@DM5PR1101MB2249.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2nVNy6XU94ZjHjN9mEw3MNENnKb19AX+1HHeGBgMCNh1I3dZAaO8Q27fpfDsMYxEQOOkryo5EcUC8WUzNebNdf6LnGPBbgE+CqfcoFRKOEPQBb1Q++nPXvCsXd5kF9NFfvEA8QtJNs7hoScdt/Q/w/U59ZvDdJrD5RbWDVTv6JfW9ANPllSXBJx2a622ohXKOS/gXfBb49IGNrOsROB/WnIKcgwRAo4xQGnLfBF6lWdJULjKiBQOvP3id6HSMt+EMQlhXFivTTUc1ydO5X9JyLzbtv2Wq98iLdkGEtpr3mrJMwVJjaNZpdpxogqVSNZu0gRzuxFtxKwDLSFk16hQ6CWxFqoykFpv4VKxuQDjRaXs29qSK4C/1GzEVvg9UhElqpnX5lE+lxWONbmSaoDF0dx9UgedmPyowcxqsgXroUN6tfl5FXItkdq+TdT7prwZ+3zYJrewr7ndg90FLipsb05w9SHI95243U8UwTK+Cy9CF8l6Pbjx9uYF9Mb/ROer1Yy78P/rPfOxBLBujKSOdc5XXcYenHJ9sQJa4a9sU01jTKIX6Vh/J5WpVHFPokyWWExhtceMXk4hBcAwAXkkOS2K1bQLRui8GXlqqBIi01KOWOQWQMHvsmLCSw3d03KzNduroYB9ueyRM9awpUP6ar1VBWekvM53L/jPB961/s+nfdTeTjdB1dftaIl0L9A8hVPwaGDKBjCV3RXUIaFz/WBBnooieSfU/65FwTUeorw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(366004)(39850400004)(316002)(110136005)(6486002)(66946007)(38100700001)(8676002)(86362001)(956004)(2616005)(16526019)(186003)(26005)(2906002)(4326008)(44832011)(6506007)(30864003)(5660300002)(478600001)(83380400001)(36756003)(52116002)(966005)(1076003)(66476007)(66556008)(6512007)(8936002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 
	=?us-ascii?Q?LxlG7rfwlciiI6djpYmIudX2Egonw6qXO9DQ1Ki/j8q/DvLirH7OmBZTJXw8?=
 =?us-ascii?Q?k+M9ao1Yc0SAo0snmwPjGr2Qt1CzJadyxY3ALTVuuiOyPvBudv0GmAJRpyIA?=
 =?us-ascii?Q?j6PzmfvZGqfIPeN6LTFlt3fSI81JQXcW+l8NDbOwBw16qgAVzMRfy4kOyZ48?=
 =?us-ascii?Q?KFn0ksAA26mHEw3sib8paARC1LXD/B6JAvqN2U6Ydk8ARyMD0VbsXzRKQgl8?=
 =?us-ascii?Q?agHTJj6sYmNLojVXlxz79MIMB+BC0/Ynh3tcPv8+oOcTFpRlev+WM3c6dqW4?=
 =?us-ascii?Q?1MR3OcsKMUCRPeWsnB39LSyc0BvjQQMIJN6bCZMzxOcbmVhobGt66zcqha4m?=
 =?us-ascii?Q?yv3QVD3AQF8c0ZTeBBsMEHrIyojLzdQQD/108y134EXn+aC6nDzZswlAQEE2?=
 =?us-ascii?Q?K0W7mI1EVdpQyJjURP1Sw+OfbGhDxaMrdZ66MqzRVR5+NZMAtESMyBrHIfGJ?=
 =?us-ascii?Q?QiLqAhcDBMFQXdgpihxJU5QnVj9G+Hu5n7vv1gxzNQ4R+tFZymNaqe0/kqKv?=
 =?us-ascii?Q?oqZ/CRiVO9DDYSVRysybFua3pXfi29aMwxaRD21OjIzyKr7P3JcH82ATLDVJ?=
 =?us-ascii?Q?uCvMnioQ93vBT6EKEl8B27q6Q0sibnPP9rwYBfe0j1scwrF0rHet5MQkoiss?=
 =?us-ascii?Q?YLoAnyCkQwk9gS/d5d+X3pgIIaqz4z2mDHq/ShvnBFWyt+CZsyOV3k4pIivV?=
 =?us-ascii?Q?M5WT54ipAYM5XQ5bfTY0EASsLLPl9zGPlU6SV5yPquUbSTUB0OYbA0OJ/urb?=
 =?us-ascii?Q?4/3IPk9VoggA32LQ96lBzJZsFmvMNdeVS/FRKAbEgtJ3tWSLA9oZELFmyaQh?=
 =?us-ascii?Q?oiuLdbK2cR8natW2md6ekPPWOCaSBUEM00emTVGfrdEDjiU8RQQMgbBFKPOu?=
 =?us-ascii?Q?LdOfrU/g05ysR7gTdeIgUMcLe2L4kOQTYLTqpdgkQcn276fpwGLSaT5vWAKO?=
 =?us-ascii?Q?JPkC6GUzN8BL8+gp7TGQXzDK5U7iuroXyDGaHph3FJ04O55X4eqzSGml2OC/?=
 =?us-ascii?Q?0BYNpr80+dBG82CR8BT36nXj8dSZfGuBb2NMuanZr6f8FG6S/bOZyEOCaWFP?=
 =?us-ascii?Q?YBAV+SQl83VyhyX1w3dHGut4yyJwcWSlbXPHWiF/HVBjClAZta9uGxeA9Ru2?=
 =?us-ascii?Q?78u06a0IEFh0xSvOcD4sA+iMvyEyxvzWmwufBTH8WvB5R4Qs72YK2FtWwpjb?=
 =?us-ascii?Q?cnZHLaKrTAEZdhLVin4EoJOhnz1VfQFb4DCt+DaWGFyvFwbbhkoZ7eWDHCwC?=
 =?us-ascii?Q?YSc1phMgbSIQF4MUrlLz8AtvcinznJF9meTD38zbzBKojSF+Ws2VBhRnt9Dd?=
 =?us-ascii?Q?mQefEobShqSzVh/EuSsHWyAt?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a63678e-682b-456a-6c64-08d8f5fb038f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2021 17:16:12.0696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aFDFAwYCDkD3wlVndH/K+Cokdc90n+QyKsBVWwxLnOT3DZyZsIXAX7bnpN2APcP202nwRZSftbxr4+5y7JhaYyQMZI6hw0fLTc8J5RdYq2c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2249
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

It doesn't seem that long ago (kernel 3.x era) that the kernel repo was
less than 1G in size, and while it wasn't actively shared, it was kind of
one of those "we'll deal with that later" type things.

But today, where more people care about CI/CD - if you make use of both
linux-yocto and linux-yocto-dev - well, you are looking at over 3G and
2.2G respectively.  So that is over 5G - and we still don't have any
effective sharing between them, or any formalized method for which another
derived kernel in another layer can share and avoid duplicating downloaded
data.  So, add in a 3rd party kernel, such as a SoC variant (e.g. r-pi
layer) and you've now got another 3G of kernel, and are up to 8G.

What I'm going to show is we can do all that in less than two.

OK, so what are we doing at a relatively high level?  We are treating
external repositories (mainline, stable, preempt-rt) as core building
blocks, and exposing them as "jumping off" reference points for our two
core kernel repositories, and for any other 3rd party kernel derivatives,
so that we never download the same common git objects twice.  In addition,
we selectively download/fetch from the stable and -rt repos so we only
pull a few megs and skip the dead end leaf nodes based on 2.x and 3.x and
4.x kernel versions we simply don't care about anymore.  We use the same
selective approach on our linux-yocto and linux-yocto-dev repos as well.

This is all achieved right at the fetch level, using what are essentially
"fetch-only" meta-packages that establish the core components to be
shared/referenced.  These fetch only recipes are in turn triggered by the
parent recipe having a fetch dependency on their desired reference. =20

Right now, if you do:

     bitbake -c cleanall linux-yocto-dev ; bitbake -c fetch linux-yocto-dev

what will happen is that you will w-get 920M of a pre-mirror tarball of a
2014 copy of a 3.17 yocto-dev kernel and all its useless branches.  It
gets untarred (and deleted) and then a fetch chews and grinds on it doing
the mega uplift from 3.17 --> 5.12 for a final 2.2G repo spread across
five git packs (4 from 2014 and one new one).  This all takes 10-15
minutes even on a well connected fast machine.  Whee!

With this series, the above fetch will take ~30s because we never throw
away the mainline/stable/rt content, and hence only fetch less than 20MB
of yocto-dev specific git objects from the yocto server/repo.

The kernel as components:
-------------------------
Lets look at what we really need, in order to build any BSP on v5.10 from
linux-yocto, and similarly for v5.12 on linux-yocto-dev; showing the sizes
of repacked git bare repos, and references symbolically, with the core
mainline changes up to and including v5.10 as shared:

1.5G    git.kernel.org.torvalds.linux-5.10
35M     |--> git.kernel.org.stable.linux-5.10.y
7.1M         |--> git.kernel.org.preempt-rt.linux-5.10.y
38M               |--> git.yoctoproject.org.linux-yocto.git

        linux-5.10 (shared base)
148M    |--> git.kernel.org.torvalds.linux-master (v5.10 --> latest)
2.9M         |--> git.kernel.org.stable.linux-5.12.y
5.6M              |--> git.kernel.org.preempt-rt.linux-5.12.y
18M                    |--> git.yoctoproject.org.linux-yocto-dev.git

1516+35+7+38+148+3+6+18 =3D 1771.  So that is 1.7G.  Add in ~100MB more for
stable-5.4 and v5.4-rt and yocto v5.4 BSPs if you want them too.  That
would be pretty sweet, right?  A heck of a lot less than 5 gigs!   But can
we do that?  Actually, yes we can.  And we can open the door for other
sharing as well, and even split that big 1.5G chunk into smaller chunks.

A bit more on that sharing, since it is important, and easy to gloss over.
Consider the r-pi kernel repo, for no other reason than everyone is
familiar with it.  As of today, if you clone it w/o making any effort to
share/reference, you'll get just shy of 3G.  Instead, if you selectively
fetch the rpi-5.10 (and reference stable-5.10 above) you'll get 6M and
another 4M for rpi-5.12 (referencing linux-master above).  So you'd be
using 10M of that 3G (about 0.33%) but since we've not made it easy for
sharing, many custom SoC/SDK kernels are similar, and you clone a whole
bunch of stuff with 99% shared DNA with what you already have.

Similar sizes/factors are in play when we consider the linux-stable and
preempt-rt repositories - multiple gigs as a whole, but as we see above,
the selected v5.10 components are only 35M and 7M respectively.

Objectives:
-----------
There were some key goals at play, even if I sort of back-declare them
now with some level of revisionist reflection:

-enable sharing off of key universally public reference repos for everyone

-compartmentalize tech blocks to eliminate overlapping downloads of git obj=
ects

-reduce download size further where possible (exclusion of content/gc/repac=
k)

-be ready to absorb further kernel growth and also EOL dead-end leaf nodes

-make only minimal specific objective based changes to the git fetcher

-remain compatible with the generally accepted Yocto workflows/design.

With that in mind, it makes sense to now consider the above requirements
in a bit more detail.

Consider the 1st and last together - share + compatible.  Adding a one
line patch to the git fetcher to support "--reference" would enable a
level of sharing but we'd have stuff spilling outside the normal download
paths, and absolute paths inside SRC_URIs and non-portable (pre)mirror
tarballs - failing miserably on the compatible goal.  So we start by only
allowing repos to reference others which are peers in the download dir -
no /home/bob/my-super-kernel type stuff.  This goes a long way towards
keeping a portable download dir and SRC_URIs clean of absolute paths, and
remaining compatible with the (pre)mirror type Yocto work flow and use
cases.  As will be seen, we don't even really expose the "--reference"
flag use outside of the internal fetcher code.

Technology blocks -- Looking back ~10 years, we did a lot more "kernel
patching" (via git am) than just using (and merging) pre-applied commits
in a branch of a technology feature - such as "stable" or "preempt-rt".
But now the Yocto tree builds on the -rt tree which builds on stable which
builds on mainline.  We can see how they are chained together in the
ascii nesting diagram above.  If we ignored this internal ordering, we
could end up with the stable content (git objects) duplicated inside the
preempt-rt repo and even duplicated in the linux-yocto repos themselves.
By exposing that building block on building block, we also get the
universally recognized share points (mainline, stable-5.x, rt-5.x) that
can be used by anyone to complete their full git object history.

Reduce/exclude - as time has moived on, more and more repos are of such
size and varying content, that using "--mirror" and "refs/*:refs/*" as a
"grab everything" approach simply doesn't scale.  So instead we allow
a selective clone/fetch of just what we need and exclude everything else.

Reduce/garbage-collect - there are opportunities for "low hanging fruit"
in terms of getting rid of unused references/tags in linux-yocto[-dev] but
since I can't directly control what is in those repos (or tar mirrors of
them) we'll have to pursue that outside of this changeset.

Reduce/repack - most people don't realize but the size of the pack you get
from a server depends on how generous the server is with its CPU time.
And that multiple packs can be significantly larger than one single pack.
While we can't control individual servers, we can (and should) consider
agressively repacking any repo we put into service for a (pre)mirror.  That
includes any repo content we encourage compartmentalizing in this changeset=
.

Growth - The epoch --> v5.10 block of mainline commits is static and need
not ever change from the group of objects we have in its pack today.  The
v5.10 is the effective merge-base between linux-yocto and -dev currently,
and as such makes a sensible line in the sand for sharing.  We currently
have v5.10+ up to mainline/master coverage in the next repo in the chain,
but it is trivial to create/insert a new block of static content covering
v5.10 to v5.13 between v5.10 and master in the future to absorb new growth
in manageable chunk sizes.  We already add/use the same technology here=20
to opptionally "split" the v5.10 block for those who need sub-gigabyte
downloads (and repositories) for infrastructural reasons.

EOL - While the repo sizes for the stable and -rt chunks above may not
seem significant compared to the v5.10 basline size, they are specific to
a particular baseline as leaf-node content.  As such we can simply unlink
them from our SRC_URI driven reference chains after which they won't
appear (or download) for new users/builds but they will remain in people's
old download dirs and build workspaces.

Fetcher - we add support of sharing through a "--reference" like manner,
and enforce our relative path requirements there.  We also see a clear
need for selective clone/fetch as per above, so we allow clone args to
replace "--mirror" with "--single-branch" and an override of the fetch
args and their current default of everything via. "refs/*:refs/*".
Finally, if we want to have the stable-5.4, the stable-5.10 and the
stable-5.12 as separate content for independent introduction and EOL,
then we also have to allow them to be in separate repos in the download
dir, even though they all were sourced from the same server/path/repo.
This is achieved by allowing an optional recipe specified download name.

I won't go into more detail here, since the fetcher commits all have
proper commit logs and make sense in their own right, independent of the
larger overall goals described above.  Similarly, all the kernel recipe
changes provide the working example/context of how all the fetcher changes
are used.  So even though the two groups are separate repos, I've chosen
to present it all together against the poky repo, at least initially.

Next Steps:
-----------
With this being a functional implementation, it seems like a good time to
get other people looking at it.  Ideally step #1 will be getting general
agreement that this is something we need, something that is overdue,
and that the implementation as shown here makes sense in the absence of
any similar effort from anyone that does the same but in a better way.

From there, we'll want more people not just looking at it, but testing it
as well.   I know I want to write a commit (script?) that will avoid any
"transition tax" by prepopulating new repos with "old" already downloaded
git objects where we can.  And to add/do tests with my own popluated mirror
and NO_NETWORK, and also try to ensure nothing in BB_SHALLOW gets upset,
but I wasn't going to hold up starting a review of this any longer.

I suspect I can get some co-workers using/testing it too, but Yocto gets
used in a bunch of different ways by different groups, so we'll no doubt
have to do some additional fixups to ensure everybody gets the benefits of
this sharing.  But I'm hopeful that when people see the benefits above,
they'll pitch in to help take this the final mile by ensuring it works for
their use case as well.

I'm not too worried about pontificating out beyond that until we get past
the acceptance/testing hurdles outlined above.  So, please do have a read
of the commits, kick the tires, put on your bikeshedding clothes and grab
a brush, and lets see where it goes from here...

https://github.com/paulgortmaker/poky/compare/reference-RC1

---

Paul Gortmaker (21):
  bitbake: fetch2/git: allow override of clone args with GITCLONEARGS
  bitbake: fetch2/git: allow limiting upstream fetch refs to a subset
  bitbake: fetch2/git: allow optional git download name overrride
  bitbake: fetch2/git: allow specifying repos as static/unchanging
  bitbake: fetch2/git: ensure static repos have at least one refs/heads
  bitbake: fetch2/git: allow alt references within download dir
  bitbake: fetch2/git: append new altref line if/when SRC_URI changed value
  bitbake: fetch2/git: allow pack references within download dir
  bitbake: fetch2/git: use constant names for packs in static repos
  kernel: add basic boilerplate for fetch-only recipes
  kernel: add a fetch-only recipe for mainline v5.10 source
  kernel: allow splitting mainline v5.10 source download in two
  kernel: allow splitting mainline v5.10 source download in three
  kernel: allow splitting mainline v5.10 source download in four
  kernel: add recipe for linux-master (mainline latest)
  kernel: add stable fetch recipes for v5.4.x, v5.10.x and v5.12.x
  kernel: add preempt-rt fetch recipes for v5.4.x, v5.10.x and 5.12.x
  kernel: make v5.4.x Yocto recipes use shared source
  kernel: make v5.10.x Yocto recipes use shared source
  kernel: make linux-yocto-dev recipe use shared source
  kernel: disable (pre)mirror for linux-yocto and linux-yocto-dev

 .../bitbake-user-manual-fetching.rst          |  24 ++++
 bitbake/lib/bb/fetch2/git.py                  | 135 +++++++++++++++++-
 documentation/ref-manual/variables.rst        |  22 +++
 meta/recipes-kernel/linux/fetch-linux.inc     |  20 +++
 meta/recipes-kernel/linux/fetch-only.inc      |  20 +++
 meta/recipes-kernel/linux/fetch-rt.inc        |  25 ++++
 meta/recipes-kernel/linux/fetch-stable.inc    |  24 ++++
 meta/recipes-kernel/linux/linux-3.3.bb        |   9 ++
 meta/recipes-kernel/linux/linux-3.8.bb        |   9 ++
 meta/recipes-kernel/linux/linux-4.0.bb        |   9 ++
 meta/recipes-kernel/linux/linux-4.12.bb       |  10 ++
 meta/recipes-kernel/linux/linux-4.18.bb       |  10 ++
 meta/recipes-kernel/linux/linux-4.3.bb        |  10 ++
 meta/recipes-kernel/linux/linux-5.10.bb       |  38 +++++
 meta/recipes-kernel/linux/linux-master.bb     |  13 ++
 meta/recipes-kernel/linux/linux-rt-5.10.bb    |   9 ++
 meta/recipes-kernel/linux/linux-rt-5.12.bb    |  12 ++
 meta/recipes-kernel/linux/linux-rt-5.4.bb     |   9 ++
 meta/recipes-kernel/linux/linux-yocto-dev.bb  |  11 +-
 .../linux/linux-yocto-rt_5.10.bb              |   7 +-
 .../linux/linux-yocto-rt_5.4.bb               |   7 +-
 .../linux/linux-yocto-tiny_5.10.bb            |   7 +-
 .../linux/linux-yocto-tiny_5.4.bb             |   7 +-
 meta/recipes-kernel/linux/linux-yocto.inc     |  10 ++
 meta/recipes-kernel/linux/linux-yocto_5.10.bb |   7 +-
 meta/recipes-kernel/linux/linux-yocto_5.4.bb  |   7 +-
 meta/recipes-kernel/linux/stable-5.10.bb      |  10 ++
 meta/recipes-kernel/linux/stable-5.12.bb      |  16 +++
 meta/recipes-kernel/linux/stable-5.4.bb       |  11 ++
 29 files changed, 498 insertions(+), 10 deletions(-)
 create mode 100644 meta/recipes-kernel/linux/fetch-linux.inc
 create mode 100644 meta/recipes-kernel/linux/fetch-only.inc
 create mode 100644 meta/recipes-kernel/linux/fetch-rt.inc
 create mode 100644 meta/recipes-kernel/linux/fetch-stable.inc
 create mode 100644 meta/recipes-kernel/linux/linux-3.3.bb
 create mode 100644 meta/recipes-kernel/linux/linux-3.8.bb
 create mode 100644 meta/recipes-kernel/linux/linux-4.0.bb
 create mode 100644 meta/recipes-kernel/linux/linux-4.12.bb
 create mode 100644 meta/recipes-kernel/linux/linux-4.18.bb
 create mode 100644 meta/recipes-kernel/linux/linux-4.3.bb
 create mode 100644 meta/recipes-kernel/linux/linux-5.10.bb
 create mode 100644 meta/recipes-kernel/linux/linux-master.bb
 create mode 100644 meta/recipes-kernel/linux/linux-rt-5.10.bb
 create mode 100644 meta/recipes-kernel/linux/linux-rt-5.12.bb
 create mode 100644 meta/recipes-kernel/linux/linux-rt-5.4.bb
 create mode 100644 meta/recipes-kernel/linux/stable-5.10.bb
 create mode 100644 meta/recipes-kernel/linux/stable-5.12.bb
 create mode 100644 meta/recipes-kernel/linux/stable-5.4.bb

--=20
2.25.1

