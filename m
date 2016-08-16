Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by mail.openembedded.org (Postfix) with ESMTP id B7E9973199
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 16 Aug 2016 22:30:06 +0000 (UTC)
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
	by orsmga103.jf.intel.com with ESMTP; 16 Aug 2016 15:30:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,529,1464678000"; d="scan'208";a="749643453"
Received: from ylaguna-mobl.amr.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.219.128.51])
	by FMSMGA003.fm.intel.com with ESMTP; 16 Aug 2016 15:30:06 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
Date: Tue, 16 Aug 2016 17:30:05 -0500
Message-ID: <4342847.8xnkOvCtZZ@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
User-Agent: KMail/4.14.10 (Linux/4.6.6-200.fc23.x86_64; KDE/4.14.20; x86_64; ;
	)
In-Reply-To: <9d8bf4573bf44f78975f7bc8241f13ba@XBOX02.axis.com>
References: <cover.1470886482.git.paul.eggleton@linux.intel.com>
	<3c460ccdf61654f7d74713e10c305476c5db1aee.1470886482.git.paul.eggleton@linux.intel.com>
	<9d8bf4573bf44f78975f7bc8241f13ba@XBOX02.axis.com>
MIME-Version: 1.0
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 4/4] siggen: properly close files rather than opening them inline
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
X-List-Received-Date: Tue, 16 Aug 2016 22:30:06 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Tue, 16 Aug 2016 21:16:17 Peter Kjellerstedt wrote:
> > -----Original Message-----
> > From: bitbake-devel-bounces@lists.openembedded.org [mailto:bitbake-
> > devel-bounces@lists.openembedded.org] On Behalf Of Paul Eggleton
> > Sent: den 11 augusti 2016 05:37
> > To: bitbake-devel@lists.openembedded.org
> > Subject: [bitbake-devel] [PATCH 4/4] siggen: properly close files
> > rather than opening them inline
> > 
> > If you don't do this, with Python 3 you get a warning on exit under some
> > circumstances.
> > 
> > Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>
> > ---
> > 
> >  lib/bb/siggen.py | 15 +++++++++------
> >  1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> > index 5d8a253..9b2f658 100644
> > --- a/lib/bb/siggen.py
> > +++ b/lib/bb/siggen.py
> > 
> > @@ -363,10 +363,12 @@ def clean_basepaths_list(a):
> >  def compare_sigfiles(a, b, recursecb = None):
> >      output = []
> > 
> > -    p1 = pickle.Unpickler(open(a, "rb"))
> > -    a_data = p1.load()
> > -    p2 = pickle.Unpickler(open(b, "rb"))
> > -    b_data = p2.load()
> > +    with open(a, 'rb') as f:
> > +        p1 = pickle.Unpickler(ff)
> 
>                                  ^^
> Shouldn't that be:
> 
>         p1 = pickle.Unpickler(f)
> 

Oops - yes it should be. I guess it just proves that even "simple, obvious" 
changes like this one do actually need to be tested. I'll send a v2.

Thanks,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre

