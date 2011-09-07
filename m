Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1R1PU9-0000Yr-Oo for bitbake-devel@lists.openembedded.org;
	Wed, 07 Sep 2011 23:16:41 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p87LHSov027483; Wed, 7 Sep 2011 22:17:29 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id uIGhQQMmg9hI; Wed,  7 Sep 2011 22:17:28 +0100 (BST)
Received: from [192.168.1.40] (tim [93.97.173.237]) (authenticated bits=0)
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p87LHMAs027468
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 7 Sep 2011 22:17:25 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
In-Reply-To: <CABcZANkp2JLJJ4G1J1dcRkNSqiEqWqnv5Qav-5F=EAzD0UxJ3w@mail.gmail.com>
References: <1315417400.13021.20.camel@ted>
	<CABcZANkp2JLJJ4G1J1dcRkNSqiEqWqnv5Qav-5F=EAzD0UxJ3w@mail.gmail.com>
Date: Wed, 07 Sep 2011 22:11:19 +0100
Message-ID: <1315429879.13021.23.camel@ted>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.2 
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: runqueue: Ensure task environment is correct
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
X-List-Received-Date: Wed, 07 Sep 2011 21:16:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-09-07 at 11:38 -0700, Chris Larson wrote:
> On Wed, Sep 7, 2011 at 10:43 AM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > This fixes two problems:
> >
> > a) Variables which were in the parent environment but not set as "export"
> >   variables in the datastore could end up in the task environment
> >
> > b) oe.environ.update() can't cope with the generator returned by
> >   bb.data.exported_vars()
> >
> > Whilst the updated code isn't as neat, it does do the expected thing,
> > sets the environment correctly and stops unwanted values leaking into
> > the task environment.
> >
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> >
> > diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> > index 5a4321f..72e6845 100644
> > --- a/bitbake/lib/bb/runqueue.py
> > +++ b/bitbake/lib/bb/runqueue.py
> > @@ -1136,7 +1136,12 @@ class RunQueueExecute:
> >                 for h in self.rqdata.hash_deps:
> >                     the_data.setVar("BBHASHDEPS_%s" % h, self.rqdata.hash_deps[h])
> >
> > -                os.environ.update(bb.data.exported_vars(the_data))
> > +                # exported_vars() returns a generator which *cannot* be passed to os.environ.update()
> > +                # successfully. We also need to unset anything from the environment which shouldn't be there
> > +                exports = bb.data.exported_vars(the_data)
> > +                bb.utils.empty_environment()
> > +                for e, v in exports:
> > +                    os.environ[e] = v
> 
> os.environ.clear()
> os.environ.update(bb.data.exported_vars(the_data))

I tried this when testing and when I read os.environ back, it was not
correct. There is something odd occurring if you pass the generator into
update() directly.

Cheers,

Richard



