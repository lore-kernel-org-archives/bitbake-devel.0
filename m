Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 8D6E7600B3
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  4 Jan 2016 23:59:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u04NxQ2O028194; Mon, 4 Jan 2016 23:59:26 GMT
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id hJ0jRGlN1m7l; Mon,  4 Jan 2016 23:59:26 +0000 (GMT)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	u04NxMig028188
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 4 Jan 2016 23:59:23 GMT
Message-ID: <1451951962.7598.26.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Christopher Larson <clarson@kergoth.com>
Date: Mon, 04 Jan 2016 23:59:22 +0000
In-Reply-To: <CABcZANn67KvtNe8PUtdVJX_z5bOGmEjEztEcfK5Rr9LmVO=e_Q@mail.gmail.com>
References: <1451928842.7598.16.camel@linuxfoundation.org>
	<CABcZANn67KvtNe8PUtdVJX_z5bOGmEjEztEcfK5Rr9LmVO=e_Q@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Mime-Version: 1.0
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] utils: Remove double compile from better_compile
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
X-List-Received-Date: Mon, 04 Jan 2016 23:59:30 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Mon, 2016-01-04 at 11:06 -0700, Christopher Larson wrote:
> 
> On Mon, Jan 4, 2016 at 10:34 AM, Richard Purdie <
> richard.purdie@linuxfoundation.org> wrote:
> > Poking around the ast to correct linenumbers works well for runtime
> > failures
> > but not for parsing ones. We can use blank linefeeds to correct the
> > line
> > numbers instead, with the advantage that we don't need to double
> > compile.
> > 
> > Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> > 
> > diff --git a/bitbake/lib/bb/utils.py b/bitbake/lib/bb/utils.py
> > index cd5fced..9a3efb2 100644
> > --- a/bitbake/lib/bb/utils.py
> > +++ b/bitbake/lib/bb/utils.py
> > @@ -292,7 +292,7 @@ def _print_trace(body, line):
> >              error.append('     %.4d:%s' % (i, body[i-1].rstrip()))
> >      return error
> > 
> > -def better_compile(text, file, realfile, mode = "exec", lineno =
> > None):
> > +def better_compile(text, file, realfile, mode = "exec", lineno =
> > 0):
> >      """
> >      A better compile method. This method
> >      will print the offending lines.
> > @@ -301,10 +301,9 @@ def better_compile(text, file, realfile, mode
> > = "exec", lineno = None):
> >          cache = bb.methodpool.compile_cache(text)
> >          if cache:
> >              return cache
> > -        code = compile(text, realfile, mode, ast.PyCF_ONLY_AST)
> > -        if lineno is not None:
> > -            ast.increment_lineno(code, lineno)
> > -        code = compile(code, realfile, mode)
> > +        # We can't add to the linenumbers for compile, we can pad
> > to the correct number of blank lines though
> > +        text2 = "\n" * int(lineno) + text
> > +        code = compile(text2, realfile, mode)
> > 
> A SyntaxError can have its line numbers adjusted fairly easily, if
> that's your concern. Afaik that's the usual case which
> ast.increment_lineno isn't  sufficient to handle. See 
> https://gist.github.com/kergoth/743677#file-compile-py-L67-L86.

I did start to wonder about catching specific exceptions and then
adjusting the line numbers. It seemed unlikely that we'd catch all the
right cases and adjust them correctly though and when there is a much
easier workaround with a few blank lines that likely performs better
than the existing double compile, I concluded that whilst not that
architecturally pleasing, it is simple and effective...

Cheers,

Richard

