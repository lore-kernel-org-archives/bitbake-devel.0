Received: from dan.rpsys.net ([93.97.175.187])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1R1QP3-000286-2i for bitbake-devel@lists.openembedded.org;
	Thu, 08 Sep 2011 00:15:29 +0200
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p87MGLXn029683; Wed, 7 Sep 2011 23:16:21 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1ZCPel3SSBrt; Wed,  7 Sep 2011 23:16:21 +0100 (BST)
Received: from [192.168.1.40] (tim [93.97.173.237]) (authenticated bits=0)
	by dan.rpsys.net (8.14.2/8.14.2/Debian-2build1) with ESMTP id
	p87MGHK8029677
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 7 Sep 2011 23:16:19 +0100
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
In-Reply-To: <CABcZANk18Pf6ZR5Pe3rAK7Lo=87__8gPU2n9yCv3JdO_XeznVw@mail.gmail.com>
References: <1315417400.13021.20.camel@ted>
	<CABcZANkp2JLJJ4G1J1dcRkNSqiEqWqnv5Qav-5F=EAzD0UxJ3w@mail.gmail.com>
	<1315429879.13021.23.camel@ted>
	<CABcZANk18Pf6ZR5Pe3rAK7Lo=87__8gPU2n9yCv3JdO_XeznVw@mail.gmail.com>
Date: Wed, 07 Sep 2011 23:10:14 +0100
Message-ID: <1315433414.13021.34.camel@ted>
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
X-List-Received-Date: Wed, 07 Sep 2011 22:15:29 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2011-09-07 at 14:43 -0700, Chris Larson wrote:
> On Wed, Sep 7, 2011 at 2:11 PM, Richard Purdie
> <richard.purdie@linuxfoundation.org> wrote:
> > On Wed, 2011-09-07 at 11:38 -0700, Chris Larson wrote:
> >> On Wed, Sep 7, 2011 at 10:43 AM, Richard Purdie
> >> <richard.purdie@linuxfoundation.org> wrote:
> >> > This fixes two problems:
> >> >
> >> > a) Variables which were in the parent environment but not set as "export"
> >> >   variables in the datastore could end up in the task environment
> >> >
> >> > b) oe.environ.update() can't cope with the generator returned by
> >> >   bb.data.exported_vars()
> >> >
> >> > Whilst the updated code isn't as neat, it does do the expected thing,
> >> > sets the environment correctly and stops unwanted values leaking into
> >> > the task environment.
> >> >
> >> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> >> >
> >> > diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> >> > index 5a4321f..72e6845 100644
> >> > --- a/bitbake/lib/bb/runqueue.py
> >> > +++ b/bitbake/lib/bb/runqueue.py
> >> > @@ -1136,7 +1136,12 @@ class RunQueueExecute:
> >> >                 for h in self.rqdata.hash_deps:
> >> >                     the_data.setVar("BBHASHDEPS_%s" % h, self.rqdata.hash_deps[h])
> >> >
> >> > -                os.environ.update(bb.data.exported_vars(the_data))
> >> > +                # exported_vars() returns a generator which *cannot* be passed to os.environ.update()
> >> > +                # successfully. We also need to unset anything from the environment which shouldn't be there
> >> > +                exports = bb.data.exported_vars(the_data)
> >> > +                bb.utils.empty_environment()
> >> > +                for e, v in exports:
> >> > +                    os.environ[e] = v
> >>
> >> os.environ.clear()
> >> os.environ.update(bb.data.exported_vars(the_data))
> >
> > I tried this when testing and when I read os.environ back, it was not
> > correct. There is something odd occurring if you pass the generator into
> > update() directly.
> 
> Odd. It works fine in my local testing. Maybe there's a python bug
> lurking -- I can't imagine it's supposed to work this way. Guess we
> have to do it this way, but I really think you should consider
> isolating the problem and reporting it upstream to the python project.

Agreed, it does seem to be something about my machine/python version
since this is not the first time I've had issues with os.environ :(.

Which version did you test with? I was seeing this with Ubuntu's python
"2.7.1+" whatever that is. I did try and write a small test case and
that works which is odd/worrying/annoying...

Cheers,

Richard







