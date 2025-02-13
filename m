Return-Path: <bruce.ashfield@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E2FC021A4
	for <webhook@archiver.kernel.org>; Thu, 13 Feb 2025 17:34:36 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
 by mx.groups.io with SMTP id smtpd.web11.2100.1739468069052265978
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 13 Feb 2025 09:34:29 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=YAhezO5O;
 spf=pass (domain: gmail.com, ip: 209.85.214.176, mailfrom: bruce.ashfield@gmail.com)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f7f1e1194so29086645ad.2;
        Thu, 13 Feb 2025 09:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739468068; x=1740072868; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zl6fTYQ0TXtw3HxH05Df1cd9nYm0XUzHpVznz5N5umU=;
        b=YAhezO5OUhJs7Q9SdjRXA7Rx57tB0GBnCmPrgMnZJL/0104Qckh84qtdvQ7jRj/3CM
         EahyrgNZcOf+KMf7dYqf5kuHpJsMLTfDcJb5c5rxz6grB9um+YgtGXyUnzHpaL0ZJ47P
         3I15UNEV96KVA14ZDcqyZIRRjFN56LI047pRPMfU1R9cPWFonZQS5AfXq6j0DMOk1mYI
         FpVwPBfiSNriYSLTcIImBDK9a+6Phkh4A3BV2N+a8ckfnrtcComgk28WgEuo6+qRpu5h
         ZePX27XAKJ0bDf5Qgek1wC/wzX4CCvyok+GISAwK/RtNTawIPuEax9Z/eAMCUcqpp3Hz
         9K8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739468068; x=1740072868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zl6fTYQ0TXtw3HxH05Df1cd9nYm0XUzHpVznz5N5umU=;
        b=s7exwIkVutENO0DF8m7E9QxdwwtTV1tDir7fJFjHmlU5NwcukrRkeZBOQkW1BN58W0
         fDyoDj87eyKGBNfruSh7ADUsiTOFNrhGFUx5J3B1H7Bdluh2O3pvJpROJOWDSCWYJ6m7
         xwbeaIYWh0QZbId1ePucJIda8h5ehvrzs+Ykl5ZfXHkVEwsflnPy+7rcQHDm70K2l61z
         SS1LwjBfbc9g2HCLafBHxSv04ceN5gZaTCD0qCsXDMjBFSEhwhSMTMz1NEbJrb48elCi
         TOQjnzRJ9/Ear8QATJcs4GjSQILBdjzZ0IconDNWOiR+9yK30pxPxV8PlB6bsV+XXQFB
         fThQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnuKdGJxGEGFPZ9XYFdNzg0orUAo6mUPPafmQI7IyOobLz5O3tWlBtvpbqN6nGjBLEx2IKy6pfmwjwIpmP@lists.openembedded.org
X-Gm-Message-State: AOJu0YxzgPYHIR93gO2EjDAoPh3TwTjRI0YwE+Z/71LsdtlYv9ZuL2Ba
	copNUAt4mB9o6/82nRPARMeDWpPQZ3eLAJHBi1cjAhYOZKO9LDj0MGRleMQ75jnpxNMUBtB3Fq0
	ouRFP2mnEYIC103+98aSrhZnJg2o=
X-Gm-Gg: ASbGnctNc3ljMKtz03zBuJr1uix3LmOdyQb+0rIxr1wykVqWWgk0GPOHRj8O9WSUdcX
	MNHTsVxtawZ+tGzE5ka0FcuOyavg1KFrSZj3QI1FiSEzWE3xC+w9slQ2ti3/KFcPAMgdU1X+e
X-Google-Smtp-Source: AGHT+IHZQLZHygs78NcpwjSWHwNcaoPR9AGpv3BrnBk0DHNfCIz9In8GV5f6Nk9ChR0Se+xjPjOPuhtdLdbP1JtKVGs=
X-Received: by 2002:a17:90a:e183:b0:2ee:d63f:d71 with SMTP id
 98e67ed59e1d1-2fbf5bec92bmr14259396a91.14.1739468068174; Thu, 13 Feb 2025
 09:34:28 -0800 (PST)
MIME-Version: 1.0
References: <4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org>
In-Reply-To: <4cea4488ef3181471373f3dca26ac390203a90cb.camel@linuxfoundation.org>
From: Bruce Ashfield <bruce.ashfield@gmail.com>
Date: Thu, 13 Feb 2025 12:34:17 -0500
X-Gm-Features: AWEUYZmz4Verndxkk8c-R-_52UtBLqSfr_my3KcD63htkZDbl6BqIuIx-iQ1Enc
Message-ID: <CADkTA4Ovcd=xtdKDSkLtWvDThuLWk+XvubqJm0-2UHvVyUXnBg@mail.gmail.com>
Subject: Re: 'vendor' fetching discussion cont.
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: openembedded-core@lists.openembedded.org, 
	Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>, 
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Content-Type: multipart/alternative; boundary="0000000000004d43e8062e097813"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 13 Feb 2025 17:34:36 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17218

--0000000000004d43e8062e097813
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I did some replies to the other threads before seeing this, we can feel
free to let those other threads go unanswered, to unify things here.

On Thu, Feb 13, 2025 at 5:43=E2=80=AFAM Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> I've pulled this to a separate email/thread since I'd like to take a
> slight step back and put some different ideas into the mix as well as
> explain where my own thoughts are right now. I'm also doing this so
> that we can focus the discussion and give others a place to catch up
> from. For that reason I may restate some information below.
>
> We have two fundamentally different approaches:
>
> a) a single entry in SRC_URI with magic behind the scenes expanding
> this into a list of dependencies
>
> b) multiple entries in SRC_URI generated with tooling
>
> gitsm is similar to a), partly because it can contain recursive
> references to other submodules so the second approach wouldn't work.
> crates are handled with the b) approach today.
>
> Developers in general are more comfortable with b) since they can more
> easily see what is going on but it is also the harder one since it
> deviates most from the underlying tools and has two sets of data that
> require to be in sync.
>
> Some feel the .inc files enabling b) are effectively machine generated
> and could be removed with the work happening transparently instead,
> simplifying the recipes and commits. This allows easier use of the
> underlying tooling too.
>
> I think firstly, we need to document some key principles. Behind the
> scenes, any given url should expand to a defined list of components and
> that list has to be deterministic and not "floating", i.e. always the
> same regardless of changes in any registry or other upstream. If there
> are changes, they need to be detected and there needs to be a hard
> error. Also, if the code sees things declared in a way they could vary,
> that also needs to be a hard error.
>

And of course be expanded into something that is compatible
with our mirroring, but that was implied, I just wanted to say it :)


> Most of the concerns I've seen are about how easy it is to understand
> what is going on behind the scenes. The move of code to OE and
> splitting everything into multiple tasks/stages does do that to some
> extent but it does it in a way which I think is going to create a new
> and different set of problems.
>
> I'm therefore wondering if there is a different way. The changes I'm
> wondering about would be to:
>
> a) embrace the single SRC_URI entry
>

I still wonder how we'd be able to debug and/or override parts of
the single SRC_URI entry.  Do you consider a lock file or a language
dependency file that could be overwritten from recipe space as
a single SRC_URI entry ? If so, I can get on board with that.

I still prefer the expanded dependencies into some sort of base /
simple fetch format, but a single file that describes all the dependencies
is close enough. As long as there's a way to inspect what the file
was processed into for fetching, then there is some visibility in times
of need.

The remaining question for me is .. how recursive are the dependencies
in the file described on the SRC_URI ? If each line in the single file
is being expanded into multiple different dependencies, then the
visibility into the final list is low, the reproducibility and mirroring of
what
eventually gets fetched need to be guaranteed as well. That of course
isn't different from the issues which could arise with gitsm.


> b) require a checksum of the internal "URL list" that is included
> in SRC_URI, much in the same way that we have checksums of tarballs.
> For better or worse, we have low trust in the underlying tools to get
> this right (they are getting better).
>

This would be a checksum of the fully expanded dependencies of
the SRC_URI entry ?


>
> c) if the checksum doesn't match, we know something went wrong and
> error
>
> d) require the new modules to write the URL list into a known location
> as part of unpack
>

Aha. That answers the question that I had above.


> e) add the ability to add custom hooks in the fetch process to handle
> the cases of needing to alter the flow for patching the components list
>

Or potentially detect the output of d) being somehow supplied and not
do the dependency resolution ?


> f) create new tools that allow the fetcher to be stepped through and
> for example partially run, or run with clear debug output showing what
> was happening at each stage (show the list of components?). This may be
> standalone tools, maybe a devtool module, I don't know. We may want to
> make the fetch/unpack logs more useful in general as right now you
> don't get much useful data about what it is doing.
>
>
> If we do those things, where does that get us? How much buy in do our
> different stakeholders have?
>

I think it is getting closer!

If there's a way to see all of the individual fetches, and change those
fetches,
then it solves most of the issues that I've been using git:// fetches for
in my
go recipes.

Bruce



>
> FWIW I am leaning towards having this code in the bitbake fetcher as a
> first class citizen as to do otherwise is going to create layers of
> abstraction and we probably have enough of those already.
>
> Cheers,
>
> Richard
>
>
>
>
>
>
>
>
>

--=20
- Thou shalt not follow the NULL pointer, for chaos and madness await thee
at its end
- "Use the force Harry" - Gandalf, Star Trek II

--0000000000004d43e8062e097813
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-size:small">I did some replies to the other threads before seeing this, w=
e can feel</div><div class=3D"gmail_default" style=3D"font-size:small">free=
 to let those other threads go unanswered, to unify things here.</div></div=
><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" clas=
s=3D"gmail_attr">On Thu, Feb 13, 2025 at 5:43=E2=80=AFAM Richard Purdie &lt=
;<a href=3D"mailto:richard.purdie@linuxfoundation.org">richard.purdie@linux=
foundation.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">I&#39;ve pulled this to a separate email/thread since I&#39;d=
 like to take a<br>
slight step back and put some different ideas into the mix as well as<br>
explain where my own thoughts are right now. I&#39;m also doing this so<br>
that we can focus the discussion and give others a place to catch up<br>
from. For that reason I may restate some information below.<br>
<br>
We have two fundamentally different approaches:<br>
<br>
a) a single entry in SRC_URI with magic behind the scenes expanding<br>
this into a list of dependencies<br>
<br>
b) multiple entries in SRC_URI generated with tooling<br>
<br>
gitsm is similar to a), partly because it can contain recursive<br>
references to other submodules so the second approach wouldn&#39;t work.<br=
>
crates are handled with the b) approach today.<br>
<br>
Developers in general are more comfortable with b) since they can more<br>
easily see what is going on but it is also the harder one since it<br>
deviates most from the underlying tools and has two sets of data that<br>
require to be in sync.<br>
<br>
Some feel the .inc files enabling b) are effectively machine generated<br>
and could be removed with the work happening transparently instead,<br>
simplifying the recipes and commits. This allows easier use of the<br>
underlying tooling too.<br>
<br>
I think firstly, we need to document some key principles. Behind the<br>
scenes, any given url should expand to a defined list of components and<br>
that list has to be deterministic and not &quot;floating&quot;, i.e. always=
 the<br>
same regardless of changes in any registry or other upstream. If there<br>
are changes, they need to be detected and there needs to be a hard<br>
error. Also, if the code sees things declared in a way they could vary,<br>
that also needs to be a hard error.<br></blockquote><div><br></div><div><di=
v class=3D"gmail_default" style=3D"font-size:small">And of course be expand=
ed into something that is compatible</div><div class=3D"gmail_default" styl=
e=3D"font-size:small">with our mirroring, but that was implied, I just want=
ed to say it :)</div></div><div><br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">
<br>
Most of the concerns I&#39;ve seen are about how easy it is to understand<b=
r>
what is going on behind the scenes. The move of code to OE and<br>
splitting everything into multiple tasks/stages does do that to some<br>
extent but it does it in a way which I think is going to create a new<br>
and different set of problems.<br>
<br>
I&#39;m therefore wondering if there is a different way. The changes I&#39;=
m<br>
wondering about would be to:<br>
<br>
a) embrace the single SRC_URI entry<br></blockquote><div><br></div><div><di=
v class=3D"gmail_default" style=3D"font-size:small">I still wonder how we&#=
39;d be able to debug and/or override parts of</div><div class=3D"gmail_def=
ault" style=3D"font-size:small">the single SRC_URI entry.=C2=A0 Do you cons=
ider a lock file or a language</div><div class=3D"gmail_default" style=3D"f=
ont-size:small">dependency file that could be overwritten from recipe space=
 as</div><div class=3D"gmail_default" style=3D"font-size:small">a single SR=
C_URI entry ? If so, I can get on board with that.</div><div class=3D"gmail=
_default" style=3D"font-size:small"><br></div><div class=3D"gmail_default" =
style=3D"font-size:small">I still prefer the expanded dependencies into som=
e sort of base /</div><div class=3D"gmail_default" style=3D"font-size:small=
">simple fetch format, but a single file that describes all the dependencie=
s</div><div class=3D"gmail_default" style=3D"font-size:small">is close enou=
gh. As long as there&#39;s a way to inspect what the file</div><div class=
=3D"gmail_default" style=3D"font-size:small">was processed into for fetchin=
g, then there is some visibility in times</div><div class=3D"gmail_default"=
 style=3D"font-size:small">of need.</div><div class=3D"gmail_default" style=
=3D"font-size:small"><br></div><div class=3D"gmail_default" style=3D"font-s=
ize:small">The remaining question for me is .. how recursive are the depend=
encies</div><div class=3D"gmail_default" style=3D"font-size:small">in the f=
ile described on the SRC_URI ? If each line in the single file</div><div cl=
ass=3D"gmail_default" style=3D"font-size:small">is being expanded into mult=
iple different dependencies, then the</div><div class=3D"gmail_default" sty=
le=3D"font-size:small">visibility into the final list is low, the reproduci=
bility and mirroring of what</div><div class=3D"gmail_default" style=3D"fon=
t-size:small">eventually gets fetched need to be guaranteed as well. That o=
f course</div><div class=3D"gmail_default" style=3D"font-size:small">isn&#3=
9;t different from the issues which could arise with gitsm.</div></div><div=
><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
b) require a checksum of the internal &quot;URL list&quot; that is included=
<br>
in=C2=A0SRC_URI, much in the same way that we have checksums of tarballs.<b=
r>
For better or worse, we have low trust in the underlying tools to get<br>
this right (they are getting better).<br></blockquote><div><br></div><div><=
div class=3D"gmail_default" style=3D"font-size:small">This would be a check=
sum of the fully expanded dependencies of</div><div class=3D"gmail_default"=
 style=3D"font-size:small">the SRC_URI entry ?</div></div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
c) if the checksum doesn&#39;t match, we know something went wrong and<br>
error<br>
<br>
d) require the new modules to write the URL list into a known location<br>
as part of unpack<br></blockquote><div><br></div><div><div class=3D"gmail_d=
efault" style=3D"font-size:small">Aha. That answers the question that I had=
 above.</div></div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
e) add the ability to add custom hooks in the fetch process to handle<br>
the cases of needing to alter the flow for patching the components list<br>=
</blockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font=
-size:small">Or potentially detect the output of d) being somehow supplied =
and not</div><div class=3D"gmail_default" style=3D"font-size:small">do the =
dependency resolution ?</div></div><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">
<br>
f) create new tools that allow the fetcher to be stepped through and<br>
for example partially run, or run with clear debug output showing what<br>
was happening at each stage (show the list of components?). This may be<br>
standalone tools, maybe a devtool module, I don&#39;t know. We may want to<=
br>
make the fetch/unpack logs more useful in general as right now you<br>
don&#39;t get much useful data about what it is doing.<br>
<br>
<br>
If we do those things, where does that get us? How much buy in do our<br>
different stakeholders have?<br></blockquote><div><br></div><div><div class=
=3D"gmail_default" style=3D"font-size:small">I think it is getting closer!<=
/div><div class=3D"gmail_default" style=3D"font-size:small"><br></div><div =
class=3D"gmail_default" style=3D"font-size:small">If there&#39;s a way to s=
ee all of the individual fetches, and change those fetches,</div><div class=
=3D"gmail_default" style=3D"font-size:small">then it solves most of the iss=
ues that I&#39;ve been using git:// fetches for in my</div><div class=3D"gm=
ail_default" style=3D"font-size:small">go recipes.</div><div class=3D"gmail=
_default" style=3D"font-size:small"><br></div><div class=3D"gmail_default" =
style=3D"font-size:small">Bruce</div><br></div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
FWIW I am leaning towards having this code in the bitbake fetcher as a<br>
first class citizen as to do otherwise is going to create layers of<br>
abstraction and we probably have enough of those already.<br>
<br>
Cheers,<br>
<br>
Richard<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
</blockquote></div><div><br clear=3D"all"></div><div><br></div><span class=
=3D"gmail_signature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_s=
ignature">- Thou shalt not follow the NULL pointer, for chaos and madness a=
wait thee at its end<br>- &quot;Use the force Harry&quot; - Gandalf, Star T=
rek II<br><br></div></div>

--0000000000004d43e8062e097813--

