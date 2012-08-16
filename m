Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Peter.Seebach@windriver.com>) id 1T23Hr-0005xc-PA
	for bitbake-devel@lists.openembedded.org;
	Thu, 16 Aug 2012 18:51:12 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q7GGdB7V016894
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Thu, 16 Aug 2012 09:39:12 -0700 (PDT)
Received: from e6410-2 (172.25.40.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Thu, 16 Aug 2012 09:39:11 -0700
Date: Thu, 16 Aug 2012 11:39:04 -0500
From: Peter Seebach <peter.seebach@windriver.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20120816113904.0cb07406@e6410-2>
In-Reply-To: <1345127564.14667.68.camel@ted>
References: <cover.1345079338.git.peter.seebach@windriver.com>
	<3ace2a7bb6a6c03f8e359774caf2f14ae71ee8cd.1345079338.git.peter.seebach@windriver.com>
	<1345127564.14667.68.camel@ted>
X-Mailer: Claws Mail 3.8.0 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] data_smart.py: track file inclusion and variable modifications
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
X-List-Received-Date: Thu, 16 Aug 2012 16:51:12 -0000
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit

On Thu, 16 Aug 2012 15:32:44 +0100
Richard Purdie <richard.purdie@linuxfoundation.org> wrote:

> On Wed, 2012-08-15 at 20:14 -0500, Peter Seebach wrote:

> > 1.  We create a history dict in the data_smart object, the
> > members of which are lists of tuples.  It's three, count them,
> > THREE unrelated data types in a single object!
 
> Do we really need comments like "count them" in the commit message?

Probably not. That commit message dates to the end of a very long
day. It could be altered without much harm.

> > The special file name 'Ignore' indicates that an event need
> > not be logged.
 
> This isn't particularly pythonic but I'm not going to lose sleep over
> it.

I am very open to the idea of a better idiom, I just couldn't think of
a good way to make some suitable value visible. (Actually, I suspect
the right answer is some kind of named-arguments thing, but I don't
know off the top of my head whether that can be adapted here.)

> > +# These are used in dataSmart, here as protection against
> > KeyErrors. +def enableTracking():
> > +    pass
> > +
> > +def disableTracking():
> > +    pass
> > +

> Where would these get called from that would trigger a keyerror?

I honestly don't know. I believe that it happened to me once, but I
can't imagine why. This is from the first pass of the code, and could
well be not particularly useful or correct; I did not have a good
mental map of the relationship between data and data_smart. Come to
think of it, I probably still don't.
 
> > -def setVar(var, value, d):
> > +def setVar(var, value, d, filename = None, lineno = None):
> >      """Set a variable to a given value"""
> > -    d.setVar(var, value)
> > +    filename, lineno = d.infer_file_and_line(filename, lineno)
> > +    d.setVar(var, value, filename, lineno)
> >  

> Changing any of these in data.py looks like a pointless waste of time.
> The parser should be calling the object (dataSmart) variants and that
> is now the preferred mechanism. If some old user does call here, the
> parameters will be unset and the dataSmart setVar will call
> infer_file_and_line for us anyway.

Yes, but in that case it would just report the line inside
data.py/setVar, which is not as useful. Hmm. Well, that is an easy
thing to check on!

Answer: In a bitbake -e (no target), there are 14 instances of hits
on these functions. All of which come from:

    # DONE WITH PARSING... time to evaluate
    if ext != ".bbclass":
        data.setVar('FILE', abs_fn, d)

in BBHandler.py.

So I'd be totally happy with dropping all the data.py changes and
instead fixing BBHandler.

> > +    def includeLog(self, filename):
> > +        """includeLog(included_file) shows that the file was
> > included
> > +        by the currently-processed file or context."""
> > +        if self._tracking_enabled:
> > +            event = (filename, [])
> > +            position = (len(self.include_stack[-1][1]), event[1])
> > +            self.include_stack[-1][1].append(event)
> > +            self.include_stack.append(position)
> > +
> > +    def includeLogDone(self, filename):
> > +        if self._tracking_enabled:
> > +            if len(self.include_stack) > 1:
> > +                self.include_stack.pop()
> > +            else:
> > +                bb.warn("Uh-oh:  includeLogDone(%s) tried to empty
> > the stack." % filename)

> There has to be a better way to write code to do this. This looks
> horrible.

I agree, but I wasn't able to come up with one.

> > +    def setVar(self, var, value, filename = None, lineno = None,
> > op = 'set', details = None):

> As a function prototype, this scares me and shouts that there is
> something going wrong here. The conversion of lineno to details and
> back under a variety of different circumstances doesn't seem
> particularly elegant or easy to understand.

Yes. At a bare minimum, it should probably be done with, say, a dict or
something as a single additional/optional argument.

> Also, I want to hightlight that these changes effectively set our data
> API in stone, making it effectively impossible to ever add sensible
> external facing API changes. We should really change all these calls
> to be named parameters so it doesn't totally freeze the API. I hate
> having to do that but I hate the alternatives more.

Hmm. What if it were
   def setVar(self, var, value, logging = None)

And then logging could be, say, { filename = ..., lineno = ..., op
= ..., deteails = ... } where each component is optional with sane
defaults.

I think that solves a LOT of the problems. It's a single optional
parameter, with named components, and it avoids the addition of four
separate arguments to do a single thing.

> So I do like the intent of this series but I don't like the impact on
> the code base and think it needs some work to improve readability at
> the very least.

Okay. I will do another pass.

BTW, if anyone can think of a clearer way to express that includelog
history, I'd love to hear about it; I spent a while trying to think of
something and came up blank.

-s
-- 
Listen, get this.  Nobody with a good compiler needs to be justified.


