Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Syr5K-0000jw-O5 for bitbake-devel@lists.openembedded.org;
	Tue, 07 Aug 2012 23:13:02 +0200
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q77L1AK6015863;
	Tue, 7 Aug 2012 22:01:10 +0100
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 13903-09; Tue,  7 Aug 2012 22:01:06 +0100 (BST)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q77L10AS015856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 7 Aug 2012 22:01:01 +0100
Message-ID: <1344373262.9756.300.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Date: Tue, 07 Aug 2012 22:01:02 +0100
In-Reply-To: <16599840.OqlgMUDr4l@helios>
References: <cover.1344346253.git.liezhi.yang@windriver.com>
	<16599840.OqlgMUDr4l@helios>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 0/1] bitbake-whatchanged: print what is about to happen
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 07 Aug 2012 21:13:03 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Tue, 2012-08-07 at 18:12 +0100, Paul Eggleton wrote:
> On Tuesday 07 August 2012 23:48:55 Robert Yang wrote:
> > The following changes since commit c86d26cb976e665b1516e72153f3f686f62dedf9:
> > 
> >   subversion: Add missing build dependency on sqlite3 (2012-08-06 16:14:06
> > +0100)
> > 
> > are available in the git repository at:
> > 
> >   git://git.pokylinux.org/poky-contrib robert/whatchanged
> >   http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/whatchanged
> > 
> > Robert Yang (1):
> >   bitbake-whatchanged: print what is about to happen
> > 
> >  bitbake/bin/bitbake-whatchanged | 334
> > ++++++++++++++++++++++++++++++++++++++++ 1 file changed, 334 insertions(+)
> >  create mode 100755 bitbake/bin/bitbake-whatchanged
> 
> I tried this on top of latest master, unfortunately what I got was the
> following:
> 
> -------------- snip ----------------
> Figuring out the TMPDIR ...
> Moving the stamps to stamps.old ...
> Generating the new stamps ... (need several minutes)
> ERROR occurred!!! Recovering the stamps dir ...
> Removing the newly generated stamps ...
> Moving the stamps.old back to stamps ...
> Traceback (most recent call last):
>   File "/home/paul/poky/poky/bitbake/bin/bitbake-whatchanged", line 333, in <module>
>     sys.exit(main())
>   File "/home/paul/poky/poky/bitbake/bin/bitbake-whatchanged", line 291, in main
>     old_recon = recon_dict(old_dict)
>   File "/home/paul/poky/poky/bitbake/bin/bitbake-whatchanged", line 82, in recon_dict
>     full_path_pre = "%s/%s" % (dict_in.get(dict_out.get(pn_task).get(fn)).get('path'), k)
> NameError: global name 'fn' is not defined
> -------------- snip ----------------
> 
> A couple of other things:
> 
> 1) We ought to be able to assume that TMPDIR is the same regardless of 
> the recipe specified; this avoids having to parse all of the recipes just to
> get the value of this variable.
> 
> 2) I'm a little concerned with the general approach - is there no way of
> avoiding having to copy and move around the stamps directory? It seems
> a little risky if nothing else.

I think adding a parameter to -S would be a good move for this, its
something people likely want in conjunction with that.

Cheers,

Richard






