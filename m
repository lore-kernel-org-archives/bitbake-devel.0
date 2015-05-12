Return-Path: <Liam.Howlett@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 795CE7402D
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 12 May 2015 14:28:11 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.9) with ESMTP id t4CESAXN003477
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 12 May 2015 07:28:10 -0700 (PDT)
Received: from yow-lhowlett-d0.wrs.com (128.224.56.215) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server
	(TLS) id 14.3.224.2; Tue, 12 May 2015 07:28:10 -0700
Date: Tue, 12 May 2015 10:28:08 -0400
From: "Liam R. Howlett" <Liam.Howlett@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20150512142807.GB15805@yow-lhowlett-d0.wrs.com>
References: <1429121824-31200-2-git-send-email-Liam.Howlett@WindRiver.com>
	<1429204998-29516-1-git-send-email-Liam.Howlett@WindRiver.com>
	<1431429477.30971.123.camel@linuxfoundation.org>
MIME-Version: 1.0
In-Reply-To: <1431429477.30971.123.camel@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [128.224.56.215]
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH v3] fetch2: Add BB_ALLOWED_NETWORKS support
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
X-List-Received-Date: Tue, 12 May 2015 14:28:15 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

* Richard Purdie <richard.purdie@linuxfoundation.org> [150512 07:18]:
> On Thu, 2015-04-16 at 13:23 -0400, Liam R. Howlett wrote:
> > BB_ALLOWED_NETWORKS is a list of hosts that the fetcher will be allowed
> > to use when BB_NO_NETWORK is not set.
> > 
> > If BB_NO_NETWORK is set, then networking is still disabled.
> > 
> > If BB_ALLOWED_NETWORKS is not set, the behaviour remains the same as
> > today.
> > 
> > If BB_NO_NETWORK is NOT set, and BB_ALLOWED_NETWORKS is configured, then
> > only the hosts in the list are usable by the fetcher.
> > 
> > eg:
> > BB_ALLOWED_NETWORKS="yoctoproject.org git.gnu.org"
> > The fetcher will be able to download from yoctoproject.org, git.gnu.org,
> > but not ftp.gnu.org or any other hostname that is not in the list.
> > 
> > There is also limited support for wildcards on the beginning of the
> > hosts, so BB_ALLOWED_NETWORKS="*.gnu.org" with match git.gnu.org and
> > ftp.gnu.org as well as foo.git.gnu.org
> > 
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@WindRiver.com>
> > ---
> >  lib/bb/fetch2/__init__.py | 53 +++++++++++++++++++++++++++++++++++++++++++++++
> >  lib/bb/tests/fetch.py     | 37 +++++++++++++++++++++++++++++++++
> >  2 files changed, 90 insertions(+)
> 
> I've merged this, however, one of the things we're trying to do is
> improve the documentation of bitbake. Would you be able to work with
> Scott (cc'd) to ensure this is documented in the manual please?
> 
> Cheers,
> 
> Richard
> 

Absolutely, Thanks Richard.

Hello Scott,

If you don't have anything started, we can work from the text below if
you'd like.

--------

BB_ALLOWED_NETWORKS

Specifies a space delimited list of hosts which are allowed to be used
by the fetcher to obtain the required source code.  This list is only
used if BB_NO_NETWORK is not set.  Wildcard matching at the beginning of
hosts is supported.  Mirrors that are not in the list will be skipped
and logged in debug.  Attempts to access networks that are not in the
BB_ALLOWED_NETWORKS will cause a failure.

--------

Thanks,
Liam


