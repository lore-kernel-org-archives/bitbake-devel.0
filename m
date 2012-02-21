Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1Rzy8E-0002vz-FG; Tue, 21 Feb 2012 23:24:22 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1LMG2p4020542;
	Tue, 21 Feb 2012 22:16:02 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 20289-03; Tue, 21 Feb 2012 22:15:58 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1LMFrps020535
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 21 Feb 2012 22:15:55 GMT
Message-ID: <1329862553.20261.74.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Chris Larson <clarson@kergoth.com>
Date: Tue, 21 Feb 2012 22:15:53 +0000
In-Reply-To: <CABcZANmS1TK6p3VD-GQv34X=sPmMOQo8ik370CrnH6qa=rbNUA@mail.gmail.com>
References: <1329608182.4436.48.camel@ted> <1329746700.22425.2.camel@lenny>
	<CABcZANmS1TK6p3VD-GQv34X=sPmMOQo8ik370CrnH6qa=rbNUA@mail.gmail.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] Bitbake Memory Usage
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
X-List-Received-Date: Tue, 21 Feb 2012 22:24:22 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2012-02-20 at 12:57 -0700, Chris Larson wrote:
> On Mon, Feb 20, 2012 at 7:05 AM, Colin Walters <walters@verbum.org> wrote:
> > On Sat, 2012-02-18 at 23:36 +0000, Richard Purdie wrote:
> >> As soon as the child starts trying to remove
> >> things from memory, we lose the benefits of CoW and USS and PSS rise.
> >
> > Note that even leaving out the garbage collector, the cPython VM
> > incrementing/decrementing the refcount of objects will force the copy.
> >
> > The python multiprocessing module has some classes which allow
> > explicitly sharing memory.  Certainly for various caches e.g. if
> > they're just read-only after a certain point it might make sense
> > to wrap them in e.g. a multiprocessing.Value.
> 
> Hmm, that's quite interesting, thanks for that tidbit. We should
> consider looking into that.

Its interesting but my tests are suggesting the reference counting isn't
hurting in at least our common "execute a shell task" use case. With the
way CoW and the data store works, I can believe that.

On the other hand, the serialisation that multiprocessing puts around
its variables looked potentially problematic (and slow) last time I
looked. The manual page specifically says those structures are slow if I
remember rightly.

>  On a related note, I think we should sit
> down and basically review every use of a cache anywhere in bitbake and
> rethink their operation. We still have multiple caches stored as
> globals with no expiration policy of any sort, they accrue
> indefinitely, until process exit. As we review them, we could consider
> this as well on a case-by-case basis.

I agree we need to resolve some of the life cycle issue and remove the
globals. The ones I'm aware of do give significant speed benefits though
and I'm not sure there will be much scope for removing them :/.

Cheers,

Richard



