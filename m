Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <paul.eggleton@linux.intel.com>) id 1S0cWn-0007lN-Ee
	for bitbake-devel@lists.openembedded.org;
	Thu, 23 Feb 2012 18:32:25 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 23 Feb 2012 09:23:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="111265974"
Received: from unknown (HELO helios.localnet) ([10.252.123.61])
	by orsmga001.jf.intel.com with ESMTP; 23 Feb 2012 09:23:29 -0800
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Chris Larson <clarson@kergoth.com>
Date: Thu, 23 Feb 2012 17:23:28 +0000
Message-ID: <4109374.xIp3Nx6jlj@helios>
Organization: Intel Corporation
User-Agent: KMail/4.8.0 (Linux/3.0.0-16-generic-pae; KDE/4.8.0; i686; ; )
In-Reply-To: <CABcZAN=Q2TqdGABOxHGD1=wfR5Z03-bFjiZJ9EbAhimj8tqV7A@mail.gmail.com>
References: <cover.1330011581.git.paul.eggleton@linux.intel.com>
	<e22cf3ce86bd3e323c67f0b905b2211efdd334a2.1330011581.git.paul.eggleton@linux.intel.com>
	<CABcZAN=Q2TqdGABOxHGD1=wfR5Z03-bFjiZJ9EbAhimj8tqV7A@mail.gmail.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] bitbake: fix parse errors not being reported
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
X-List-Received-Date: Thu, 23 Feb 2012 17:32:25 -0000
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Thursday 23 February 2012 09:14:16 Chris Larson wrote:
> <paul.eggleton@linux.intel.com> wrote:
> >         except Exception as exc:
> > -            etype, value, tb = sys.exc_info()
> > -            logger.error('Unable to parse %s', value.recipe,
> > -                         exc_info=(etype, value, exc.traceback))
> > +            logger.error('Error during parsing %s: %s\n%s' % (exc.recipe,
> > str(exc), ''.join(bb.exceptions.format_extracted(exc.traceback,
> > limit=5))))
> This seems odd to me. Is the UI not displaying the traceback when sent
> to it via the exc_info? Half the point of coming up with the new
> traceback format which is pickleable was to allow us to do exception
> formatting in the UI.

Actually that's odd, I could have sworn when I tried this it broke, but it 
seems to be doing the right thing now. Will send a v2 reverting this part.

Presumably you are happy with the rest of it?

Cheers,
Paul

-- 

Paul Eggleton
Intel Open Source Technology Centre


