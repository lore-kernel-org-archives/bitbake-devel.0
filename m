Return-Path: <juro.bystricky@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 1E720731CC
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Jan 2016 20:50:34 +0000 (UTC)
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga101.fm.intel.com with ESMTP; 04 Jan 2016 12:50:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,522,1444719600"; d="scan'208";a="883680643"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
	by orsmga002.jf.intel.com with ESMTP; 04 Jan 2016 12:50:35 -0800
Received: from orsmsx112.amr.corp.intel.com ([169.254.3.83]) by
	ORSMSX109.amr.corp.intel.com ([169.254.11.31]) with mapi id
	14.03.0248.002; Mon, 4 Jan 2016 12:50:35 -0800
From: "Bystricky, Juro" <juro.bystricky@intel.com>
To: "Hatle, Mark G (Wind River)" <mark.hatle@windriver.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 0/1] Add support for 7-Zip compressed
	files
Thread-Index: AQHRRy99633GtSRNa0iahUhY4pIoCJ7r0xBg
Date: Mon, 4 Jan 2016 20:50:34 +0000
Message-ID: <6E51916E4A1F32428260031F4C7CD2B6117CD38E@ORSMSX112.amr.corp.intel.com>
References: <1451933503-25881-1-git-send-email-juro.bystricky@intel.com>
	<568AD79D.80307@windriver.com>
In-Reply-To: <568AD79D.80307@windriver.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.140]
MIME-Version: 1.0
Cc: "Purdie, Richard" <richard.purdie@intel.com>
Subject: Re: [PATCH 0/1] Add support for 7-Zip compressed files
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
X-List-Received-Date: Mon, 04 Jan 2016 20:50:35 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I agree.
I compressed the same tree with tar.xz, the compressed size is:

tar.xz: 88.9 MB

which is quite respectable and markedly better than tar.bz2.
To add bitbake support for this compression format should be quite straight=
forward.

Juro


> -----Original Message-----
> From: Mark Hatle [mailto:mark.hatle@windriver.com]
> Sent: Monday, January 4, 2016 12:36 PM
> To: Bystricky, Juro; bitbake-devel@lists.openembedded.org
> Cc: Purdie, Richard
> Subject: Re: [bitbake-devel] [PATCH 0/1] Add support for 7-Zip compressed
> files
>=20
> On 1/4/16 12:51 PM, Juro Bystricky wrote:
> > 7-Zip offers substantially better compression than other compression
> > formats. In fact, 7-Zip explicitly claims it provides the best compress=
ion
> ratio.
> > To quickly test the claim, I compressed a gcc 5.2 538.8 MB tree snapsho=
t in
> various ways:
> >
> > tar.bz2: 114.0 MB
> > tar.gz:  112.4 MB
> > tar.7z:   70.3 MB
>=20
> I thought 7z was an archive format, that included compression information=
.
>=20
> Since the compression that makes 7z better then bz2 is lzma, and 'xz' use=
s
> lzma as it's compression format.  (In my experience, .xz is really common=
 on
> Linux -- 7z is only common on Windows.)
>=20
> I'm not saying don't support .7z, but adding support for .tar.xz and othe=
rs
> would make equal sense to me.  (There are a number of formats out there
> that could and likely should be added.)
>=20
> --Mark
>=20
> > At present, there is no support for 7-Zip compressed files in Bitbake.
> > Various public Git repositories only allow pushing files of certain
> > max size, AFAIK Github only allows 100MB, so there are cases where it
> > is desirable to use maximum compression possible.
> >
> >
> > Juro Bystricky (1):
> >   bitbake:fetch2/__init__.py: Add support for 7-Zip
> >
> >  bitbake/lib/bb/fetch2/__init__.py | 4 ++++
> >  1 file changed, 4 insertions(+)
> >


