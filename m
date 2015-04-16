Return-Path: <Liam.Howlett@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id C2123605D2
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 16 Apr 2015 14:16:50 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.9) with ESMTP id t3GEGlha014768
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 16 Apr 2015 07:16:47 -0700 (PDT)
Received: from yow-lhowlett-d0.wrs.com (128.224.56.215) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.3.224.2; Thu, 16 Apr 2015 07:16:55 -0700
Date: Thu, 16 Apr 2015 10:16:44 -0400
From: "Liam R. Howlett" <Liam.Howlett@windriver.com>
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>
Message-ID: <20150416141644.GK924@yow-lhowlett-d0.wrs.com>
References: <1427827190-10442-1-git-send-email-Liam.Howlett@WindRiver.com>
	<CABcZANkKhGMkjxWj1QcJDLtWZ+B3TKqR_JLSSw3nfze+Qet+3g@mail.gmail.com>
	<BFA1A96F-292A-434A-8510-E19BE343A6B9@gmail.com>
MIME-Version: 1.0
In-Reply-To: <BFA1A96F-292A-434A-8510-E19BE343A6B9@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [128.224.56.215]
Cc: Christopher Larson <clarson@kergoth.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2: Add BB_TRUSTED_NETWORK support
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Thu, 16 Apr 2015 14:16:52 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

* Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> [150415 15:43]:
> On April 15, 2015 9:37:38 PM GMT+02:00, Christopher Larson <clarson@kergoth.com> wrote:
> >On Tue, Mar 31, 2015 at 11:39 AM, Liam R. Howlett <
> >Liam.Howlett@windriver.com> wrote:
> >
> >> This patch adds support for a new local.conf variable called
> >> BB_TRUSTED_NETWORK.  BB_TRUSTED_NETWORK holds a list of hostnames
> >that the
> >> user
> >> trusts as a source for downloading content.  If network access is
> >enabled
> >> and
> >> the user has configured trusted hosts, then any hosts that are not in
> >the
> >> list
> >> will cause an error to occur at fetch.  Any mirrors and pre-mirrors
> >that
> >> are
> >> not in the list will result in warnings that these locations will not
> >be
> >> used.
> >>
> >> The BB_NO_NETWORK variable still stops all network access.
> >>
> >> Please see the comments in the patch for more details and example
> >usage.
> >>
> >
> >Hmm, looks like this might be useful with an internal mirror coupled
> >with
> >PREMIRRORS, so fetches from the internal host are allowed, but anything
> >missing from there would be immediately caught?
> 

Yes, limiting to a local mirror is the main driving force behind this
patch.  It will also catch any packages getting pulled in from undesired
locations through dependencies, etc.


> That was my thought, too.
> I would find BB_ALLOWED_NETWORKS more intuitive though.
> 
> Cheers,
> 
> 

I had BB_LIMITED_NETWORKS before, but I think BB_ALLOWED_NETWORKS is
better than both of my suggestions.

Please note that I did send v2 of this patch with minor cleanup & a fix
yesterday, 2015-04-15.

Thanks,
Liam

