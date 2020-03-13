Return-Path: <jpewhacker@gmail.com>
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
	[209.85.221.65])
	by mail.openembedded.org (Postfix) with ESMTP id 578FC6058C
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 13 Mar 2020 01:42:33 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id s5so10132682wrg.3
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 12 Mar 2020 18:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=mU23rheHRfEB4VnNzf4RPDbG0twL8RifMoKXs/VfRWc=;
	b=MmHqYQJEpMTmhAIdwXkA/jXLhOdDo/z7kGNSjt0aNLmde2ANOAzETYQ5g6meCEtFHs
	BbuWkW/MZirzq1PZM2hYzKZ1R/Zpo/kAZBK00ODKMjZ3QgdEMJ1My0Llvr4x2nHnDGzm
	F+0sQWelOgv5EtfctBrZ2ADKJblLMeTp/df4qvK/XUQKD3XsoOODkstdA+bdJi/o4lUC
	+8bWKvDLTL6+nJFeSZLe6D+uriaWEeYxTtAQW99fJpJX5X9CbpfOXvzwwoFuek/htMUN
	Vz4trdpwVVEza+cFb6gMNDMXVrvu5vMPAuQqToXowGNeqCLS1lNuDXoQlMwCKp1Ozhnm
	jjxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=mU23rheHRfEB4VnNzf4RPDbG0twL8RifMoKXs/VfRWc=;
	b=ja+3Nt3zTb+Omu4uCEKTAkQn++cdHiLyqp/3p79pVU6VAyWdHXjb6DK6rJ+pQsUeKD
	oH9a6JST0XYY+BTj4pWsf65nps1TxqzrwUtoikI7Jdirr9E/4cegCRrFqzk+cox1ElCq
	M64Omw5q1Is+3CCrfHcnfvURfu1MDPUxpdJQt3Z5q31X5WojxP3XeeF/ByRky9HqJcpl
	cuE3uww5GPIjqEdPSxhwQw89ro64bsDFWQ4Y9Y7i5H5n0oEtdr5cMhQF/CkfuMkTPb06
	FZaURm0JtEV/DDXJOWm37N5Mq2zEPPaVlqBjYMJszIipGbBcOKC3VsWD4+4hdrHH2IZP
	XCuA==
X-Gm-Message-State: ANhLgQ3wibIPS83+lhQ9TjW0HOE2gFuX6MR7dLekLHpcIZiijvnWK3UO
	iMukRG+pUjGuRimYVNg7qIFg9vTknOBe3XxjCOzk24apAyA=
X-Google-Smtp-Source: ADFU+vuzaV6mpUsjY3KavOJmm6BTNxkgTslLKrCUhm96sCts+GFjZDKP6V1Q8kTTTiLZMBmbI2GY6FDBuMk7xg8rGAg=
X-Received: by 2002:adf:e742:: with SMTP id c2mr14142118wrn.361.1584063754508; 
	Thu, 12 Mar 2020 18:42:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200309163353.15362-16-JPEWhacker@gmail.com>
	<172109D8-BB79-48CB-93EB-C65C07EAE62A@stacktrust.org>
In-Reply-To: <172109D8-BB79-48CB-93EB-C65C07EAE62A@stacktrust.org>
From: Joshua Watt <jpewhacker@gmail.com>
Date: Thu, 12 Mar 2020 20:42:23 -0500
Message-ID: <CAJdd5GZgyC5fgfEuB6XeO3wD6_fpf1dsR=gVaV66+v8EG9=OEA@mail.gmail.com>
To: Rich Persaud <rp@stacktrust.org>
Cc: docs@lists.yoctoproject.org,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [docs] [PATCH 15/15] bitbake-user-manual: Add documentation for BB_LOGCONFIG
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
X-List-Received-Date: Fri, 13 Mar 2020 01:42:34 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2020 at 6:50 PM Rich Persaud <rp@stacktrust.org> wrote:
>
> On Mar 9, 2020, at 12:34, Joshua Watt <jpewhacker@gmail.com> wrote:
> >
> > =EF=BB=BFAdds documentation describing how to use the BB_LOGCONFIG vari=
able to
> > enable custom logging.
> >
> > Signed-off-by: Joshua Watt <JPEWhacker@gmail.com>
> > ---
> > .../bitbake-user-manual-execution.xml         | 97 +++++++++++++++++++
> > .../bitbake-user-manual-ref-variables.xml     | 11 +++
> > 2 files changed, 108 insertions(+)
> >
> > diff --git a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execut=
ion.xml b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
> > index 8f606676b4..3b31f748cc 100644
> > --- a/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
> > +++ b/bitbake/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
> > @@ -929,4 +929,101 @@
> >             section.
> >         </para>
> >     </section>
> > +
> > +    <section id=3D"logging">
> > +        <title>Logging</title>
> > +        <para>
> > +            In addition to the standard command line option to control=
 how
> > +            verbose builds are when execute, bitbake also supports use=
r defined
> > +            configuration of the
> > +            <ulink url=3D'https://docs.python.org/3/library/logging.ht=
ml'>Python logging</ulink>
> > +            facilities through the
> > +            <link linkend=3D"var-bb-BB_LOGCONFIG"><filename>BB_LOGCONF=
IG</filename></link>
> > +            variable. This variable defines a json or yaml
> > +            <ulink url=3D'https://docs.python.org/3/library/logging.co=
nfig.html'>logging configuration</ulink>
> > +            that will be intelligently merged into the default configu=
ration.
> > +            The logging configuration is merged using the following ru=
les:
> > +            <itemizedlist>
> > +                <listitem><para>
> > +                    The user defined configuration will completely rep=
lace the default
> > +                    configuration if top level key
> > +                    <filename>bitbake_merge</filename> is set to the v=
alue
> > +                    <filename>False</filename>. In this case, all othe=
r rules
> > +                    are ignored.
> > +                </para></listitem>
> > +                <listitem><para>
> > +                    The user configuration must have a top level
> > +                    <filename>version</filename> which must match the =
value of
> > +                    the default configuration.
> > +                </para></listitem>
> > +                <listitem><para>
> > +                    Any keys defined in the <filename>handlers</filena=
me>,
> > +                    <filename>formatters</filename>, or <filename>filt=
ers</filename>,
> > +                    will be merged into the same section in the defaul=
t
> > +                    configuration, with the user specified keys taking
> > +                    replacing a default one if there is a conflict. In
> > +                    practice, this means that if both the default conf=
iguration
> > +                    and user configuration specify a handler named
> > +                    <filename>myhandler</filename>, the user defined o=
ne will
> > +                    replace the default. To prevent the user from inad=
vertently
> > +                    replacing a default handler, formatter, or filter,=
 all of
> > +                    the default ones are named with a prefix of
> > +                    "<filename>BitBake.</filename>"
> > +                </para></listitem>
> > +                <listitem><para>
> > +                    If a logger is defined by the user with the key
> > +                    <filename>bitbake_merge</filename> set to
> > +                    <filename>False</filename>, that logger will be co=
mpletely
> > +                    replaced by user configuration. In this case, no o=
ther
> > +                    rules will apply to that logger.
> > +                </listitem></para>
> > +                <listitem><para>
> > +                    All user defined <filename>filter</filename> and
> > +                    <filename>handlers</filename> properties for a giv=
en logger
> > +                    will be merged with corresponding properties from =
the
> > +                    default logger. For example, if the user configura=
tion adds
> > +                    a filter called <filename>myFilter</filename> to t=
he
> > +                    <filename>BitBake.SigGen</filename>, and the defau=
lt
> > +                    configuration adds a filter called
> > +                    <filename>BitBake.defaultFilter</filename>, both f=
ilters
> > +                    will be applied to the logger
> > +                </listitem></para>
> > +            </itemizedlist>
> > +        </para>
> > +
> > +        <para>
> > +            As an example, consider the following user logging configu=
ration
> > +            file which logs all Hash Equivalence related messages of V=
ERBOSE or
> > +            higher to a file called <filename>hashequiv.log</filename>
> > +            <literallayout class=3D'monospaced'>
> > +    {
> > +        "version": 1,
> > +        "handlers": {
> > +            "autobuilderlog": {
> > +                "class": "logging.FileHandler",
> > +                "formatter": "logfileFormatter",
> > +                "level": "DEBUG",
> > +                "filename": "hashequiv.log",
> > +                "mode": "w"
> > +            }
> > +        },
> > +        "formatters": {
> > +                "logfileFormatter": {
> > +                    "format": "%(name)s: %(levelname)s: %(message)s"
>
> What's the syntax for including a timestamp in the log message?  Or is th=
at implicit?

It's not implicit, but you can add it easily with %(asctime)s. There
are also several other options:
https://docs.python.org/3/library/logging.html#logrecord-attributes

>
> Rich

