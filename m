Return-Path: <kergoth@gmail.com>
Received: from mail-it0-f66.google.com (mail-it0-f66.google.com
	[209.85.214.66])
	by mail.openembedded.org (Postfix) with ESMTP id EBAEB601A4
	for <bitbake-devel@lists.openembedded.org>;
	Sat,  9 Jul 2016 18:30:57 +0000 (UTC)
Received: by mail-it0-f66.google.com with SMTP id u186so6948920ita.1
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 09 Jul 2016 11:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=Mf2S9zSx/F3wRrmLx8uvVJFXPJFOxRfsUAiuEZP1eIw=;
	b=QA5SZuu/hKRKlECCXzViFFAZ0niBinaqGmyqsy9mSDt0psNqd6grWahSvY7Dyb7B7k
	IUFzn98L3ja5Ctg6pKX3SiVQ7CIxJj433PQcYJKz/ehEQK9t7LHOXlFsBeCi2mjl4Tqr
	3Bfo/WRd+TjcHOU7gmWRrCtLBljHmgM0u1hd2ji7+fOrMlPHiArVMmbfKDN+6CSGyHsC
	t0ZQha9aqlkfTocf7bcRRQ1wWY9nHw+U+ll4k4pOJbhxQelDGoBS2Yv9FgU7fh/JFsXp
	sI59BimdvbD6J+WRK3sBYx+bnQNItVeg02W/5gS/9MIWkafUKiPmY6fZX3Bs9Pl861h5
	VOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=Mf2S9zSx/F3wRrmLx8uvVJFXPJFOxRfsUAiuEZP1eIw=;
	b=FibBIpQ79YIRi6wZRX58RVCoJBirUFUmKLJK98A7vWFd1BvBQjGC2h5yFJRxVON3jT
	/TTud2gxTKnq0+FRa6YdbWMjEzVbp8waFbXP9eo1/a0q3hAFv4peDnmbBsMZ96xU6wp5
	bafOnS8ptXncgA/WdgL02VBWn1tskYnO68JZFEDsGKoLY8gHX62EpSURGOVtxivZ+awH
	rymMsbG5hKq6q6sU2fPVJrKY7hvfCjVzoa+UwvrLfn3jbQT/ahsqtxqQSPvOUfGbzc4z
	qV3+GDfrnFRoD2mbUg0/rBvGd6FWwk5rPOGZ4bHD4ilLBE0vsZ7h8HhNivbJBAPfu3+2
	+mbQ==
X-Gm-Message-State: ALyK8tJriW2wfV78NsPqMRZ+mBJQ07qEWbgMB7HZg6uP3DVPj/u7r4et7DlyPPvcjf3hUqJCilUo7BrhvprmlQ==
X-Received: by 10.36.216.5 with SMTP id b5mr8931577itg.19.1468089057977; Sat,
	09 Jul 2016 11:30:57 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.19.70 with HTTP; Sat, 9 Jul 2016 11:30:38 -0700 (PDT)
In-Reply-To: <CAKV_0ejAMmB280o9FuHUs8iz5Hwhb=HFY-TKutKuheNCMZ=AzQ@mail.gmail.com>
References: <cover.1468024992.git.brian.avery@intel.com>
	<fb5a436289d7cfd1c86e0308b996e1db36ae63bb.1468024992.git.brian.avery@intel.com>
	<CABcZANnHUGwrvoRdYmmpA_=Z5gfkT3Rbyxc9gnR8U71Ekj7gGg@mail.gmail.com>
	<CAKV_0ejAMmB280o9FuHUs8iz5Hwhb=HFY-TKutKuheNCMZ=AzQ@mail.gmail.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Sat, 9 Jul 2016 11:30:38 -0700
X-Google-Sender-Auth: KmlfYsOL5jZHiiugngX36MXfzqM
Message-ID: <CABcZANkFJnRbRYV83Cwbg_pTQvNLL5hJFvyqbDzqxhRh+DUocw@mail.gmail.com>
To: Brian Avery <avery.brian@gmail.com>
Cc: brian avery <brian.avery@intel.com>, "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>, "Bartosh,
	Eduard" <eduard.bartosh@intel.com>
Subject: Re: [PATCH 1/7] runqueue: improve exception logging
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
X-List-Received-Date: Sat, 09 Jul 2016 18:30:58 -0000
Content-Type: multipart/alternative; boundary=94eb2c05cc14ccac220537381eba

--94eb2c05cc14ccac220537381eba
Content-Type: text/plain; charset=UTF-8

On Sat, Jul 9, 2016 at 10:10 AM, Brian Avery <avery.brian@gmail.com> wrote:

> If you mean something like:
>
>         logger.exception("Ed's message is this err = '%s'"
> %(err),exc_info=err)
>
> or
>
>         logger.exception("Ed's message is this err = '%s'"
> %(err),exc_info=err,stack_info=True) (if we want to see the exception
> stack search)
>
>
> Then, i'd agree your way is better/clearer.
>
That's the idea, but there are a couple issues with those examples.

exc_info doesn't accept the exception, it takes a boolean, and using
exception() with exc_info is redundant. 'exception(foo)' is just shorthand
for 'error(foo, exc_info=True)', and I think stack_info may also be
unnecessary, as exc_info implies traceback.print_exception(), which prints
exception traceback entries already.

But yes, that's the concept. I think this would be sufficient:

    logger.exception('An uncaught exception occurred in runqueue')

Of course we'd want to generate such an exception to test it.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--94eb2c05cc14ccac220537381eba
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Jul 9, 2016 at 10:10 AM, Brian Avery <span dir=3D"ltr">&lt;<a href=
=3D"mailto:avery.brian@gmail.com" target=3D"_blank">avery.brian@gmail.com</=
a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left-width:1px;border-left-style:solid;border-left-=
color:rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">If you mean somet=
hing like:<div>







<p><span>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0logger.exception(</span><span>&qu=
ot;Ed&#39;s message is this err =3D &#39;%s&#39;&quot;</span><span>%(err),e=
xc_info=3Derr</span><span>)</span></p><p><span>or</span></p><p><span>







</span></p><p><span>=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0logger.exception(</spa=
n><span>&quot;Ed&#39;s message is this err =3D &#39;%s&#39;&quot;</span><sp=
an>%(err),exc_info=3Derr,stack_info=3D</span><span>True</span><span>) (if w=
e want to see the exception stack search)</span></p><p><span><br></span></p=
><p><span>Then, i&#39;d agree your way is better/clearer.</span></p></div><=
/div></blockquote></div>That&#39;s the idea, but there are a couple issues =
with those examples.</div><div class=3D"gmail_extra"><br>exc_info doesn&#39=
;t accept the exception, it takes a boolean, and using exception() with exc=
_info is redundant. &#39;exception(foo)&#39; is just shorthand for &#39;err=
or(foo, exc_info=3DTrue)&#39;, and I think stack_info may also be unnecessa=
ry, as exc_info implies traceback.print_exception(), which prints exception=
 traceback entries already.</div><div class=3D"gmail_extra"><br></div><div =
class=3D"gmail_extra">But yes, that&#39;s the concept. I think this would b=
e sufficient:</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail=
_extra">=C2=A0 =C2=A0 logger.exception(&#39;<span style=3D"color:rgb(80,0,8=
0);font-size:12.8px">An uncaught exception occurred in runqueue&#39;)</span=
></div><div class=3D"gmail_extra"><span style=3D"color:rgb(80,0,80);font-si=
ze:12.8px"><br></span></div><div class=3D"gmail_extra"><span style=3D"color=
:rgb(80,0,80);font-size:12.8px">Of course we&#39;d want to generate such an=
 exception to test it.</span></div><div class=3D"gmail_extra">-- <br><div c=
lass=3D"gmail_signature" data-smartmail=3D"gmail_signature">Christopher Lar=
son<br>clarson at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZ=
aurus<br>Maintainer - Tslib<br>Senior Software Engineer, Mentor Graphics</d=
iv>
</div></div>

--94eb2c05cc14ccac220537381eba--
