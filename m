Return-Path: <ticotimo@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE59C433F5
	for <webhook@archiver.kernel.org>; Fri, 26 Nov 2021 16:10:24 +0000 (UTC)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com
 [209.85.166.43])
 by mx.groups.io with SMTP id smtpd.web10.25807.1637943023859672784
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Nov 2021 08:10:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20210112 header.b=UVY40Mv0;
 spf=pass (domain: gmail.com, ip: 209.85.166.43, mailfrom: ticotimo@gmail.com)
Received: by mail-io1-f43.google.com with SMTP id 14so11954083ioe.2
        for <bitbake-devel@lists.openembedded.org>;
 Fri, 26 Nov 2021 08:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YZNdKYkz/QdykZZa6iSccvcpLxiYyAPvUerYClXGqaM=;
        b=UVY40Mv0xKTz9sAX3rKgFGzJVPa2/ndKs78Q18P7dOqexbiQ26B8xEXFLdWWlj/ftd
         9kzOQRgcROqs1nqMsSY8w2VgrKTgWJ5Gnd08Fgr0lJgDZ6SsMjMheTvQsat1IFDVCw8a
         zIgp0S71LM45/d5kx2vw2h7HcNI3UZ5DKyiSKRTWBnfAaa5rlbKu6t3cDT+lNIgcnmHP
         GTbGPPx3GdBztKUpnQH488T/YttC6osf4IACvPEd52eYccZFls+hzMf84ehNyZB40i5S
         Z187FdgmCkKWHf/kO0Jx4hkNi4gk9KWvLuX4u/tm7NYQfyWhb7wE33RqazH7YyohhMGM
         mzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YZNdKYkz/QdykZZa6iSccvcpLxiYyAPvUerYClXGqaM=;
        b=GVovMxZ1uiXMzNLddXo8oJhbXjAGxr/420SNmszPWYaM/CLUbQQrRSM/JJEcXa5eWF
         1FxrXLoEj0/6Cx1/RbSECjaSrcEWg0oKXkv2odVxq05JdS7YATVMmz9s3Husb8Dro62X
         b8R2G46ithd7Ox6ZeEbJvThD9o2xBwQR6O4ZzbCRKrcfS0lNwsPoCCNjv6aK9up/lV//
         Ge7wE1FhTd2+ElUrREinzuxh9XA+GqVZGbr/w5fAvLUeSou+HOWrxwFYyHEai+hfhfXm
         EBhHe3WDruXf5lkM1gkgQ3wtuY2HFjSjXWTzKXfCa56MihTNTQg1KnZGG9Bmxm7PkAm9
         h7Gg==
X-Gm-Message-State: AOAM5311AfBe+wK68LhAa79zF0Q3UYPSe/RX046V/7D35zmZs97E+8zb
	p0u10TrCj61rA+vMuNTPv4Hxj04rAlIIJYEi3n8Nx8On
X-Google-Smtp-Source: 
 ABdhPJy4cQU/p7nSUJtg2bz5As/TpfHhjgEjlOJRkQlRKx6zuAFX3krwmNmpju8BQBYEIO7bw7llu4JG3WTYtLz2bAM=
X-Received: by 2002:a05:6602:2c50:: with SMTP id
 x16mr36552305iov.114.1637943023190;
 Fri, 26 Nov 2021 08:10:23 -0800 (PST)
MIME-Version: 1.0
References: <20211126051800.2364615-1-timothy.t.orling@intel.com>
 <AM9PR09MB46420ABAACE5B920960660EFA8639@AM9PR09MB4642.eurprd09.prod.outlook.com>
In-Reply-To: 
 <AM9PR09MB46420ABAACE5B920960660EFA8639@AM9PR09MB4642.eurprd09.prod.outlook.com>
From: Tim Orling <ticotimo@gmail.com>
Date: Fri, 26 Nov 2021 08:10:11 -0800
Message-ID: 
 <CANx9H-BM3niMFxTSwbyxoHz=GkiEH5APOEi86p3z9uMWUxMzrg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH] lib/bb/version.py: add from
 distutils.version
To: Konrad Weihmann <kweihmann@outlook.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Tim Orling <timothy.t.orling@intel.com>
Content-Type: multipart/alternative; boundary="0000000000000f4a3405d1b35491"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 26 Nov 2021 16:10:24 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13114

--0000000000000f4a3405d1b35491
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 25, 2021 at 11:41 PM Konrad Weihmann <kweihmann@outlook.com>
wrote:

>
>
> On 26.11.21 06:18, Tim Orling wrote:
> > In places like sanity.bbclass we currently use
> > distutils.version.LooseVersion, but distutils is deprecated in Python
> > 3.10 and will be removed in Python 3.12 (~October 2023).
> >
> > The recommended replacement for for distutils.version.LooseVersion is
> > packaging.version.Version, but this implies 'packaging' be installed on
> > the host. It is also not the same functionality as LooseVersion.
> >
> > [YOCTO #14610]
> >
> > Signed-off-by: Tim Orling <timothy.t.orling@intel.com>
> > ---
> >   lib/bb/version.py | 347 ++++++++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 347 insertions(+)
> >   create mode 100644 lib/bb/version.py
> >
> > diff --git a/lib/bb/version.py b/lib/bb/version.py
> > new file mode 100644
> > index 00000000..510582b5
> > --- /dev/null
> > +++ b/lib/bb/version.py
> > @@ -0,0 +1,347 @@
> > +#
> > +# distutils/version.py
> > +#
> > +# Implements multiple version numbering conventions for the
> > +# Python Module Distribution Utilities.
> > +#
> > +# SPDX-License-Identifier: PSF-2.0
>
> If we now ship PSF licensed code, it might be worth mentioning that as
> an external component in LICENSE in the root dir
>
> Yes, I meant to do that. I wanted to get feedback on whether this is the
direction we want to go.

> > +#
> > +
> > +"""Provides classes to represent module version numbers (one class for
> > +each style of version numbering).  There are currently two such classes
> > +implemented: StrictVersion and LooseVersion.
> > +
> > +Every version number class implements the following interface:
> > +  * the 'parse' method takes a string and parses it to some internal
> > +    representation; if the string is an invalid version number,
> > +    'parse' raises a ValueError exception
> > +  * the class constructor takes an optional string argument which,
> > +    if supplied, is passed to 'parse'
> > +  * __str__ reconstructs the string that was passed to 'parse' (or
> > +    an equivalent string -- ie. one that will generate an equivalent
> > +    version number instance)
> > +  * __repr__ generates Python code to recreate the version number
> instance
> > +  * _cmp compares the current instance with either another instance
> > +    of the same class or a string (which will be parsed to an instance
> > +    of the same class, thus must follow the same rules)
> > +"""
> > +
> > +import re
> > +
> > +class Version:
> > +    """Abstract base class for version numbering classes.  Just provides
> > +    constructor (__init__) and reproducer (__repr__), because those
> > +    seem to be the same for all version numbering classes; and route
> > +    rich comparisons to _cmp.
> > +    """
> > +
> > +    def __init__ (self, vstring=None):
> > +        if vstring:
> > +            self.parse(vstring)
> > +
> > +    def __repr__ (self):
> > +        return "%s ('%s')" % (self.__class__.__name__, str(self))
> > +
> > +    def __eq__(self, other):
> > +        c = self._cmp(other)
> > +        if c is NotImplemented:
> > +            return c
> > +        return c == 0
> > +
> > +    def __lt__(self, other):
> > +        c = self._cmp(other)
> > +        if c is NotImplemented:
> > +            return c
> > +        return c < 0
> > +
> > +    def __le__(self, other):
> > +        c = self._cmp(other)
> > +        if c is NotImplemented:
> > +            return c
> > +        return c <= 0
> > +
> > +    def __gt__(self, other):
> > +        c = self._cmp(other)
> > +        if c is NotImplemented:
> > +            return c
> > +        return c > 0
> > +
> > +    def __ge__(self, other):
> > +        c = self._cmp(other)
> > +        if c is NotImplemented:
> > +            return c
> > +        return c >= 0
> > +
> > +
> > +# Interface for version-number classes -- must be implemented
> > +# by the following classes (the concrete ones -- Version should
> > +# be treated as an abstract class).
> > +#    __init__ (string) - create and take same action as 'parse'
> > +#                        (string parameter is optional)
> > +#    parse (string)    - convert a string representation to whatever
> > +#                        internal representation is appropriate for
> > +#                        this style of version numbering
> > +#    __str__ (self)    - convert back to a string; should be very
> similar
> > +#                        (if not identical to) the string supplied to
> parse
> > +#    __repr__ (self)   - generate Python code to recreate
> > +#                        the instance
> > +#    _cmp (self, other) - compare two version numbers ('other' may
> > +#                        be an unparsed version string, or another
> > +#                        instance of your version class)
> > +
> > +
> > +class StrictVersion (Version):
> > +
> > +    """Version numbering for anal retentives and software idealists.
> > +    Implements the standard interface for version number classes as
> > +    described above.  A version number consists of two or three
> > +    dot-separated numeric components, with an optional "pre-release" tag
> > +    on the end.  The pre-release tag consists of the letter 'a' or 'b'
> > +    followed by a number.  If the numeric components of two version
> > +    numbers are equal, then one with a pre-release tag will always
> > +    be deemed earlier (lesser) than one without.
> > +
> > +    The following are valid version numbers (shown in the order that
> > +    would be obtained by sorting according to the supplied cmp
> function):
> > +
> > +        0.4       0.4.0  (these two are equivalent)
> > +        0.4.1
> > +        0.5a1
> > +        0.5b3
> > +        0.5
> > +        0.9.6
> > +        1.0
> > +        1.0.4a3
> > +        1.0.4b1
> > +        1.0.4
> > +
> > +    The following are examples of invalid version numbers:
> > +
> > +        1
> > +        2.7.2.2
> > +        1.3.a4
> > +        1.3pl1
> > +        1.3c4
> > +
> > +    The rationale for this version numbering system will be explained
> > +    in the distutils documentation.
> > +    """
> > +
> > +    version_re = re.compile(r'^(\d+) \. (\d+) (\. (\d+))?
> ([ab](\d+))?$',
> > +                            re.VERBOSE | re.ASCII)
> > +
> > +
> > +    def parse (self, vstring):
> > +        match = self.version_re.match(vstring)
> > +        if not match:
> > +            raise ValueError("invalid version number '%s'" % vstring)
> > +
> > +        (major, minor, patch, prerelease, prerelease_num) = \
> > +            match.group(1, 2, 4, 5, 6)
> > +
> > +        if patch:
> > +            self.version = tuple(map(int, [major, minor, patch]))
> > +        else:
> > +            self.version = tuple(map(int, [major, minor])) + (0,)
> > +
> > +        if prerelease:
> > +            self.prerelease = (prerelease[0], int(prerelease_num))
> > +        else:
> > +            self.prerelease = None
> > +
> > +
> > +    def __str__ (self):
> > +
> > +        if self.version[2] == 0:
> > +            vstring = '.'.join(map(str, self.version[0:2]))
> > +        else:
> > +            vstring = '.'.join(map(str, self.version))
> > +
> > +        if self.prerelease:
> > +            vstring = vstring + self.prerelease[0] +
> str(self.prerelease[1])
> > +
> > +        return vstring
> > +
> > +
> > +    def _cmp (self, other):
> > +        if isinstance(other, str):
> > +            other = StrictVersion(other)
> > +        elif not isinstance(other, StrictVersion):
> > +            return NotImplemented
> > +
> > +        if self.version != other.version:
> > +            # numeric versions don't match
> > +            # prerelease stuff doesn't matter
> > +            if self.version < other.version:
> > +                return -1
> > +            else:
> > +                return 1
> > +
> > +        # have to compare prerelease
> > +        # case 1: neither has prerelease; they're equal
> > +        # case 2: self has prerelease, other doesn't; other is greater
> > +        # case 3: self doesn't have prerelease, other does: self is
> greater
> > +        # case 4: both have prerelease: must compare them!
> > +
> > +        if (not self.prerelease and not other.prerelease):
> > +            return 0
> > +        elif (self.prerelease and not other.prerelease):
> > +            return -1
> > +        elif (not self.prerelease and other.prerelease):
> > +            return 1
> > +        elif (self.prerelease and other.prerelease):
> > +            if self.prerelease == other.prerelease:
> > +                return 0
> > +            elif self.prerelease < other.prerelease:
> > +                return -1
> > +            else:
> > +                return 1
> > +        else:
> > +            assert False, "never get here"
> > +
> > +# end class StrictVersion
> > +
> > +
> > +# The rules according to Greg Stein:
> > +# 1) a version number has 1 or more numbers separated by a period or by
> > +#    sequences of letters. If only periods, then these are compared
> > +#    left-to-right to determine an ordering.
> > +# 2) sequences of letters are part of the tuple for comparison and are
> > +#    compared lexicographically
> > +# 3) recognize the numeric components may have leading zeroes
> > +#
> > +# The LooseVersion class below implements these rules: a version number
> > +# string is split up into a tuple of integer and string components, and
> > +# comparison is a simple tuple comparison.  This means that version
> > +# numbers behave in a predictable and obvious way, but a way that might
> > +# not necessarily be how people *want* version numbers to behave.  There
> > +# wouldn't be a problem if people could stick to purely numeric version
> > +# numbers: just split on period and compare the numbers as tuples.
> > +# However, people insist on putting letters into their version numbers;
> > +# the most common purpose seems to be:
> > +#   - indicating a "pre-release" version
> > +#     ('alpha', 'beta', 'a', 'b', 'pre', 'p')
> > +#   - indicating a post-release patch ('p', 'pl', 'patch')
> > +# but of course this can't cover all version number schemes, and there's
> > +# no way to know what a programmer means without asking him.
> > +#
> > +# The problem is what to do with letters (and other non-numeric
> > +# characters) in a version number.  The current implementation does the
> > +# obvious and predictable thing: keep them as strings and compare
> > +# lexically within a tuple comparison.  This has the desired effect if
> > +# an appended letter sequence implies something "post-release":
> > +# eg. "0.99" < "0.99pl14" < "1.0", and "5.001" < "5.001m" < "5.002".
> > +#
> > +# However, if letters in a version number imply a pre-release version,
> > +# the "obvious" thing isn't correct.  Eg. you would expect that
> > +# "1.5.1" < "1.5.2a2" < "1.5.2", but under the tuple/lexical comparison
> > +# implemented here, this just isn't so.
> > +#
> > +# Two possible solutions come to mind.  The first is to tie the
> > +# comparison algorithm to a particular set of semantic rules, as has
> > +# been done in the StrictVersion class above.  This works great as long
> > +# as everyone can go along with bondage and discipline.  Hopefully a
> > +# (large) subset of Python module programmers will agree that the
> > +# particular flavour of bondage and discipline provided by StrictVersion
> > +# provides enough benefit to be worth using, and will submit their
> > +# version numbering scheme to its domination.  The free-thinking
> > +# anarchists in the lot will never give in, though, and something needs
> > +# to be done to accommodate them.
> > +#
> > +# Perhaps a "moderately strict" version class could be implemented that
> > +# lets almost anything slide (syntactically), and makes some heuristic
> > +# assumptions about non-digits in version number strings.  This could
> > +# sink into special-case-hell, though; if I was as talented and
> > +# idiosyncratic as Larry Wall, I'd go ahead and implement a class that
> > +# somehow knows that "1.2.1" < "1.2.2a2" < "1.2.2" < "1.2.2pl3", and is
> > +# just as happy dealing with things like "2g6" and "1.13++".  I don't
> > +# think I'm smart enough to do it right though.
> > +#
> > +# In any case, I've coded the test suite for this module (see
> > +# ../test/test_version.py) specifically to fail on things like comparing
> > +# "1.2a2" and "1.2".  That's not because the *code* is doing anything
> > +# wrong, it's because the simple, obvious design doesn't match my
> > +# complicated, hairy expectations for real-world version numbers.  It
> > +# would be a snap to fix the test suite to say, "Yep, LooseVersion does
> > +# the Right Thing" (ie. the code matches the conception).  But I'd
> rather
> > +# have a conception that matches common notions about version numbers.
> > +
> > +class LooseVersion (Version):
> > +
> > +    """Version numbering for anarchists and software realists.
> > +    Implements the standard interface for version number classes as
> > +    described above.  A version number consists of a series of numbers,
> > +    separated by either periods or strings of letters.  When comparing
> > +    version numbers, the numeric components will be compared
> > +    numerically, and the alphabetic components lexically.  The following
> > +    are all valid version numbers, in no particular order:
> > +
> > +        1.5.1
> > +        1.5.2b2
> > +        161
> > +        3.10a
> > +        8.02
> > +        3.4j
> > +        1996.07.12
> > +        3.2.pl0
> > +        3.1.1.6
> > +        2g6
> > +        11g
> > +        0.960923
> > +        2.2beta29
> > +        1.13++
> > +        5.5.kw
> > +        2.0b1pl0
> > +
> > +    In fact, there is no such thing as an invalid version number under
> > +    this scheme; the rules for comparison are simple and predictable,
> > +    but may not always give the results you want (for some definition
> > +    of "want").
> > +    """
> > +
> > +    component_re = re.compile(r'(\d+ | [a-z]+ | \.)', re.VERBOSE)
> > +
> > +    def __init__ (self, vstring=None):
> > +        if vstring:
> > +            self.parse(vstring)
> > +
> > +
> > +    def parse (self, vstring):
> > +        # I've given up on thinking I can reconstruct the version string
> > +        # from the parsed tuple -- so I just store the string here for
> > +        # use by __str__
> > +        self.vstring = vstring
> > +        components = [x for x in self.component_re.split(vstring)
> > +                              if x and x != '.']
> > +        for i, obj in enumerate(components):
> > +            try:
> > +                components[i] = int(obj)
> > +            except ValueError:
> > +                pass
> > +
> > +        self.version = components
> > +
> > +
> > +    def __str__ (self):
> > +        return self.vstring
> > +
> > +
> > +    def __repr__ (self):
> > +        return "LooseVersion ('%s')" % str(self)
> > +
> > +
> > +    def _cmp (self, other):
> > +        if isinstance(other, str):
> > +            other = LooseVersion(other)
> > +        elif not isinstance(other, LooseVersion):
> > +            return NotImplemented
> > +
> > +        if self.version == other.version:
> > +            return 0
> > +        if self.version < other.version:
> > +            return -1
> > +        if self.version > other.version:
> > +            return 1
> > +
> > +
> > +# end class LooseVersion
> >
> >
> >
> > -=-=-=-=-=-=-=-=-=-=-=-
> > Links: You receive all messages sent to this group.
> > View/Reply Online (#13111):
> https://lists.openembedded.org/g/bitbake-devel/message/13111
> > Mute This Topic: https://lists.openembedded.org/mt/87314237/3647476
> > Group Owner: bitbake-devel+owner@lists.openembedded.org
> > Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [
> kweihmann@outlook.com]
> > -=-=-=-=-=-=-=-=-=-=-=-
> >
>

--0000000000000f4a3405d1b35491
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Nov 25, 2021 at 11:41 PM Konr=
ad Weihmann &lt;<a href=3D"mailto:kweihmann@outlook.com">kweihmann@outlook.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x"><br>
<br>
On 26.11.21 06:18, Tim Orling wrote:<br>
&gt; In places like sanity.bbclass we currently use<br>
&gt; distutils.version.LooseVersion, but distutils is deprecated in Python<=
br>
&gt; 3.10 and will be removed in Python 3.12 (~October 2023).<br>
&gt; <br>
&gt; The recommended replacement for for distutils.version.LooseVersion is<=
br>
&gt; packaging.version.Version, but this implies &#39;packaging&#39; be ins=
talled on<br>
&gt; the host. It is also not the same functionality as LooseVersion.<br>
&gt; <br>
&gt; [YOCTO #14610]<br>
&gt; <br>
&gt; Signed-off-by: Tim Orling &lt;<a href=3D"mailto:timothy.t.orling@intel=
.com" target=3D"_blank">timothy.t.orling@intel.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0lib/bb/version.py | 347 ++++++++++++++++++++++++++++++++++=
++++++++++++<br>
&gt;=C2=A0 =C2=A01 file changed, 347 insertions(+)<br>
&gt;=C2=A0 =C2=A0create mode 100644 lib/bb/version.py<br>
&gt; <br>
&gt; diff --git a/lib/bb/version.py b/lib/bb/version.py<br>
&gt; new file mode 100644<br>
&gt; index 00000000..510582b5<br>
&gt; --- /dev/null<br>
&gt; +++ b/lib/bb/version.py<br>
&gt; @@ -0,0 +1,347 @@<br>
&gt; +#<br>
&gt; +# distutils/version.py<br>
&gt; +#<br>
&gt; +# Implements multiple version numbering conventions for the<br>
&gt; +# Python Module Distribution Utilities.<br>
&gt; +#<br>
&gt; +# SPDX-License-Identifier: PSF-2.0<br>
<br>
If we now ship PSF licensed code, it might be worth mentioning that as <br>
an external component in LICENSE in the root dir<br>
<br></blockquote><div>Yes, I meant to do that. I wanted to get feedback on =
whether this is the direction we want to go.=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
&gt; +#<br>
&gt; +<br>
&gt; +&quot;&quot;&quot;Provides classes to represent module version number=
s (one class for<br>
&gt; +each style of version numbering).=C2=A0 There are currently two such =
classes<br>
&gt; +implemented: StrictVersion and LooseVersion.<br>
&gt; +<br>
&gt; +Every version number class implements the following interface:<br>
&gt; +=C2=A0 * the &#39;parse&#39; method takes a string and parses it to s=
ome internal<br>
&gt; +=C2=A0 =C2=A0 representation; if the string is an invalid version num=
ber,<br>
&gt; +=C2=A0 =C2=A0 &#39;parse&#39; raises a ValueError exception<br>
&gt; +=C2=A0 * the class constructor takes an optional string argument whic=
h,<br>
&gt; +=C2=A0 =C2=A0 if supplied, is passed to &#39;parse&#39;<br>
&gt; +=C2=A0 * __str__ reconstructs the string that was passed to &#39;pars=
e&#39; (or<br>
&gt; +=C2=A0 =C2=A0 an equivalent string -- ie. one that will generate an e=
quivalent<br>
&gt; +=C2=A0 =C2=A0 version number instance)<br>
&gt; +=C2=A0 * __repr__ generates Python code to recreate the version numbe=
r instance<br>
&gt; +=C2=A0 * _cmp compares the current instance with either another insta=
nce<br>
&gt; +=C2=A0 =C2=A0 of the same class or a string (which will be parsed to =
an instance<br>
&gt; +=C2=A0 =C2=A0 of the same class, thus must follow the same rules)<br>
&gt; +&quot;&quot;&quot;<br>
&gt; +<br>
&gt; +import re<br>
&gt; +<br>
&gt; +class Version:<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;Abstract base class for version numbe=
ring classes.=C2=A0 Just provides<br>
&gt; +=C2=A0 =C2=A0 constructor (__init__) and reproducer (__repr__), becau=
se those<br>
&gt; +=C2=A0 =C2=A0 seem to be the same for all version numbering classes; =
and route<br>
&gt; +=C2=A0 =C2=A0 rich comparisons to _cmp.<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __init__ (self, vstring=3DNone):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if vstring:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.parse(vstring)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __repr__ (self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;%s (&#39;%s&#39;)&quot; % (s=
elf.__class__.__name__, str(self))<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __eq__(self, other):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 c =3D self._cmp(other)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if c is NotImplemented:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return c<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return c =3D=3D 0<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __lt__(self, other):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 c =3D self._cmp(other)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if c is NotImplemented:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return c<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return c &lt; 0<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __le__(self, other):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 c =3D self._cmp(other)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if c is NotImplemented:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return c<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return c &lt;=3D 0<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __gt__(self, other):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 c =3D self._cmp(other)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if c is NotImplemented:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return c<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return c &gt; 0<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __ge__(self, other):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 c =3D self._cmp(other)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if c is NotImplemented:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return c<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return c &gt;=3D 0<br>
&gt; +<br>
&gt; +<br>
&gt; +# Interface for version-number classes -- must be implemented<br>
&gt; +# by the following classes (the concrete ones -- Version should<br>
&gt; +# be treated as an abstract class).<br>
&gt; +#=C2=A0 =C2=A0 __init__ (string) - create and take same action as &#3=
9;parse&#39;<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (string parameter is optional)<br>
&gt; +#=C2=A0 =C2=A0 parse (string)=C2=A0 =C2=A0 - convert a string represe=
ntation to whatever<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 internal representation is appropriate for<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 this style of version numbering<br>
&gt; +#=C2=A0 =C2=A0 __str__ (self)=C2=A0 =C2=A0 - convert back to a string=
; should be very similar<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 (if not identical to) the string supplied to parse<br>
&gt; +#=C2=A0 =C2=A0 __repr__ (self)=C2=A0 =C2=A0- generate Python code to =
recreate<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 the instance<br>
&gt; +#=C2=A0 =C2=A0 _cmp (self, other) - compare two version numbers (&#39=
;other&#39; may<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 be an unparsed version string, or another<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 instance of your version class)<br>
&gt; +<br>
&gt; +<br>
&gt; +class StrictVersion (Version):<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;Version numbering for anal retentives=
 and software idealists.<br>
&gt; +=C2=A0 =C2=A0 Implements the standard interface for version number cl=
asses as<br>
&gt; +=C2=A0 =C2=A0 described above.=C2=A0 A version number consists of two=
 or three<br>
&gt; +=C2=A0 =C2=A0 dot-separated numeric components, with an optional &quo=
t;pre-release&quot; tag<br>
&gt; +=C2=A0 =C2=A0 on the end.=C2=A0 The pre-release tag consists of the l=
etter &#39;a&#39; or &#39;b&#39;<br>
&gt; +=C2=A0 =C2=A0 followed by a number.=C2=A0 If the numeric components o=
f two version<br>
&gt; +=C2=A0 =C2=A0 numbers are equal, then one with a pre-release tag will=
 always<br>
&gt; +=C2=A0 =C2=A0 be deemed earlier (lesser) than one without.<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 The following are valid version numbers (shown in the o=
rder that<br>
&gt; +=C2=A0 =C2=A0 would be obtained by sorting according to the supplied =
cmp function):<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0.4=C2=A0 =C2=A0 =C2=A0 =C2=A00.4.0=C2=A0=
 (these two are equivalent)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0.4.1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0.5a1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0.5b3<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0.5<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0.9.6<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 1.0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 1.0.4a3<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 1.0.4b1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 1.0.4<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 The following are examples of invalid version numbers:<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 2.7.2.2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 1.3.a4<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 1.3pl1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 1.3c4<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 The rationale for this version numbering system will be=
 explained<br>
&gt; +=C2=A0 =C2=A0 in the distutils documentation.<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 version_re =3D re.compile(r&#39;^(\d+) \. (\d+) (\. (\d=
+))? ([ab](\d+))?$&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 re.VERBOSE | re.ASCII)<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def parse (self, vstring):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 match =3D self.version_re.match(vstring)<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if not match:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise ValueError(&quot;inva=
lid version number &#39;%s&#39;&quot; % vstring)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 (major, minor, patch, prerelease, prerele=
ase_num) =3D \<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 match.group(1, 2, 4, 5, 6)<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if patch:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.version =3D tuple(map(=
int, [major, minor, patch]))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.version =3D tuple(map(=
int, [major, minor])) + (0,)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if prerelease:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.prerelease =3D (prerel=
ease[0], int(prerelease_num))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.prerelease =3D None<br=
>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __str__ (self):<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.version[2] =3D=3D 0:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vstring =3D &#39;.&#39;.joi=
n(map(str, self.version[0:2]))<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vstring =3D &#39;.&#39;.joi=
n(map(str, self.version))<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.prerelease:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 vstring =3D vstring + self.=
prerelease[0] + str(self.prerelease[1])<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return vstring<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def _cmp (self, other):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if isinstance(other, str):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 other =3D StrictVersion(oth=
er)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif not isinstance(other, StrictVersion)=
:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NotImplemented<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.version !=3D other.version:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # numeric versions don&#39;=
t match<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # prerelease stuff doesn&#3=
9;t matter<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.version &lt; other.=
version:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # have to compare prerelease<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # case 1: neither has prerelease; they&#3=
9;re equal<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # case 2: self has prerelease, other does=
n&#39;t; other is greater<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # case 3: self doesn&#39;t have prereleas=
e, other does: self is greater<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # case 4: both have prerelease: must comp=
are them!<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (not self.prerelease and not other.pre=
release):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif (self.prerelease and not other.prere=
lease):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif (not self.prerelease and other.prere=
lease):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif (self.prerelease and other.prereleas=
e):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.prerelease =3D=3D o=
ther.prerelease:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 elif self.prerelease &lt; o=
ther.prerelease:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 else:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 assert False, &quot;never g=
et here&quot;<br>
&gt; +<br>
&gt; +# end class StrictVersion<br>
&gt; +<br>
&gt; +<br>
&gt; +# The rules according to Greg Stein:<br>
&gt; +# 1) a version number has 1 or more numbers separated by a period or =
by<br>
&gt; +#=C2=A0 =C2=A0 sequences of letters. If only periods, then these are =
compared<br>
&gt; +#=C2=A0 =C2=A0 left-to-right to determine an ordering.<br>
&gt; +# 2) sequences of letters are part of the tuple for comparison and ar=
e<br>
&gt; +#=C2=A0 =C2=A0 compared lexicographically<br>
&gt; +# 3) recognize the numeric components may have leading zeroes<br>
&gt; +#<br>
&gt; +# The LooseVersion class below implements these rules: a version numb=
er<br>
&gt; +# string is split up into a tuple of integer and string components, a=
nd<br>
&gt; +# comparison is a simple tuple comparison.=C2=A0 This means that vers=
ion<br>
&gt; +# numbers behave in a predictable and obvious way, but a way that mig=
ht<br>
&gt; +# not necessarily be how people *want* version numbers to behave.=C2=
=A0 There<br>
&gt; +# wouldn&#39;t be a problem if people could stick to purely numeric v=
ersion<br>
&gt; +# numbers: just split on period and compare the numbers as tuples.<br=
>
&gt; +# However, people insist on putting letters into their version number=
s;<br>
&gt; +# the most common purpose seems to be:<br>
&gt; +#=C2=A0 =C2=A0- indicating a &quot;pre-release&quot; version<br>
&gt; +#=C2=A0 =C2=A0 =C2=A0(&#39;alpha&#39;, &#39;beta&#39;, &#39;a&#39;, &=
#39;b&#39;, &#39;pre&#39;, &#39;p&#39;)<br>
&gt; +#=C2=A0 =C2=A0- indicating a post-release patch (&#39;p&#39;, &#39;pl=
&#39;, &#39;patch&#39;)<br>
&gt; +# but of course this can&#39;t cover all version number schemes, and =
there&#39;s<br>
&gt; +# no way to know what a programmer means without asking him.<br>
&gt; +#<br>
&gt; +# The problem is what to do with letters (and other non-numeric<br>
&gt; +# characters) in a version number.=C2=A0 The current implementation d=
oes the<br>
&gt; +# obvious and predictable thing: keep them as strings and compare<br>
&gt; +# lexically within a tuple comparison.=C2=A0 This has the desired eff=
ect if<br>
&gt; +# an appended letter sequence implies something &quot;post-release&qu=
ot;:<br>
&gt; +# eg. &quot;0.99&quot; &lt; &quot;0.99pl14&quot; &lt; &quot;1.0&quot;=
, and &quot;5.001&quot; &lt; &quot;5.001m&quot; &lt; &quot;5.002&quot;.<br>
&gt; +#<br>
&gt; +# However, if letters in a version number imply a pre-release version=
,<br>
&gt; +# the &quot;obvious&quot; thing isn&#39;t correct.=C2=A0 Eg. you woul=
d expect that<br>
&gt; +# &quot;1.5.1&quot; &lt; &quot;1.5.2a2&quot; &lt; &quot;1.5.2&quot;, =
but under the tuple/lexical comparison<br>
&gt; +# implemented here, this just isn&#39;t so.<br>
&gt; +#<br>
&gt; +# Two possible solutions come to mind.=C2=A0 The first is to tie the<=
br>
&gt; +# comparison algorithm to a particular set of semantic rules, as has<=
br>
&gt; +# been done in the StrictVersion class above.=C2=A0 This works great =
as long<br>
&gt; +# as everyone can go along with bondage and discipline.=C2=A0 Hopeful=
ly a<br>
&gt; +# (large) subset of Python module programmers will agree that the<br>
&gt; +# particular flavour of bondage and discipline provided by StrictVers=
ion<br>
&gt; +# provides enough benefit to be worth using, and will submit their<br=
>
&gt; +# version numbering scheme to its domination.=C2=A0 The free-thinking=
<br>
&gt; +# anarchists in the lot will never give in, though, and something nee=
ds<br>
&gt; +# to be done to accommodate them.<br>
&gt; +#<br>
&gt; +# Perhaps a &quot;moderately strict&quot; version class could be impl=
emented that<br>
&gt; +# lets almost anything slide (syntactically), and makes some heuristi=
c<br>
&gt; +# assumptions about non-digits in version number strings.=C2=A0 This =
could<br>
&gt; +# sink into special-case-hell, though; if I was as talented and<br>
&gt; +# idiosyncratic as Larry Wall, I&#39;d go ahead and implement a class=
 that<br>
&gt; +# somehow knows that &quot;1.2.1&quot; &lt; &quot;1.2.2a2&quot; &lt; =
&quot;1.2.2&quot; &lt; &quot;1.2.2pl3&quot;, and is<br>
&gt; +# just as happy dealing with things like &quot;2g6&quot; and &quot;1.=
13++&quot;.=C2=A0 I don&#39;t<br>
&gt; +# think I&#39;m smart enough to do it right though.<br>
&gt; +#<br>
&gt; +# In any case, I&#39;ve coded the test suite for this module (see<br>
&gt; +# ../test/test_version.py) specifically to fail on things like compar=
ing<br>
&gt; +# &quot;1.2a2&quot; and &quot;1.2&quot;.=C2=A0 That&#39;s not because=
 the *code* is doing anything<br>
&gt; +# wrong, it&#39;s because the simple, obvious design doesn&#39;t matc=
h my<br>
&gt; +# complicated, hairy expectations for real-world version numbers.=C2=
=A0 It<br>
&gt; +# would be a snap to fix the test suite to say, &quot;Yep, LooseVersi=
on does<br>
&gt; +# the Right Thing&quot; (ie. the code matches the conception).=C2=A0 =
But I&#39;d rather<br>
&gt; +# have a conception that matches common notions about version numbers=
.<br>
&gt; +<br>
&gt; +class LooseVersion (Version):<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;Version numbering for anarchists and =
software realists.<br>
&gt; +=C2=A0 =C2=A0 Implements the standard interface for version number cl=
asses as<br>
&gt; +=C2=A0 =C2=A0 described above.=C2=A0 A version number consists of a s=
eries of numbers,<br>
&gt; +=C2=A0 =C2=A0 separated by either periods or strings of letters.=C2=
=A0 When comparing<br>
&gt; +=C2=A0 =C2=A0 version numbers, the numeric components will be compare=
d<br>
&gt; +=C2=A0 =C2=A0 numerically, and the alphabetic components lexically.=
=C2=A0 The following<br>
&gt; +=C2=A0 =C2=A0 are all valid version numbers, in no particular order:<=
br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 1.5.1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 1.5.2b2<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 161<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.10a<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 8.02<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.4j<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 1996.07.12<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.2.pl0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 3.1.1.6<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 2g6<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 11g<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 0.960923<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 2.2beta29<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 1.13++<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"http://5.5.kw" rel=3D"noreferr=
er" target=3D"_blank">5.5.kw</a><br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 2.0b1pl0<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 In fact, there is no such thing as an invalid version n=
umber under<br>
&gt; +=C2=A0 =C2=A0 this scheme; the rules for comparison are simple and pr=
edictable,<br>
&gt; +=C2=A0 =C2=A0 but may not always give the results you want (for some =
definition<br>
&gt; +=C2=A0 =C2=A0 of &quot;want&quot;).<br>
&gt; +=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 component_re =3D re.compile(r&#39;(\d+ | [a-z]+ | \.)&#=
39;, re.VERBOSE)<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __init__ (self, vstring=3DNone):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if vstring:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.parse(vstring)<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def parse (self, vstring):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # I&#39;ve given up on thinking I can rec=
onstruct the version string<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # from the parsed tuple -- so I just stor=
e the string here for<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 # use by __str__<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.vstring =3D vstring<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 components =3D [x for x in self.component=
_re.split(vstring)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if x and x !=3D &#39;.&#39;]<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for i, obj in enumerate(components):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 try:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 components[i]=
 =3D int(obj)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 except ValueError:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pass<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.version =3D components<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __str__ (self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return self.vstring<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def __repr__ (self):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return &quot;LooseVersion (&#39;%s&#39;)&=
quot; % str(self)<br>
&gt; +<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 def _cmp (self, other):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if isinstance(other, str):<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 other =3D LooseVersion(othe=
r)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 elif not isinstance(other, LooseVersion):=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NotImplemented<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.version =3D=3D other.version:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.version &lt; other.version:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.version &gt; other.version:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1<br>
&gt; +<br>
&gt; +<br>
&gt; +# end class LooseVersion<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; Links: You receive all messages sent to this group.<br>
&gt; View/Reply Online (#13111): <a href=3D"https://lists.openembedded.org/=
g/bitbake-devel/message/13111" rel=3D"noreferrer" target=3D"_blank">https:/=
/lists.openembedded.org/g/bitbake-devel/message/13111</a><br>
&gt; Mute This Topic: <a href=3D"https://lists.openembedded.org/mt/87314237=
/3647476" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.o=
rg/mt/87314237/3647476</a><br>
&gt; Group Owner: <a href=3D"mailto:bitbake-devel%2Bowner@lists.openembedde=
d.org" target=3D"_blank">bitbake-devel+owner@lists.openembedded.org</a><br>
&gt; Unsubscribe: <a href=3D"https://lists.openembedded.org/g/bitbake-devel=
/unsub" rel=3D"noreferrer" target=3D"_blank">https://lists.openembedded.org=
/g/bitbake-devel/unsub</a> [<a href=3D"mailto:kweihmann@outlook.com" target=
=3D"_blank">kweihmann@outlook.com</a>]<br>
&gt; -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-<br>
&gt; <br>
</blockquote></div></div>

--0000000000000f4a3405d1b35491--

