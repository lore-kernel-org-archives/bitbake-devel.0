Return-Path: <kergoth@gmail.com>
Received: from mail-io0-f177.google.com (mail-io0-f177.google.com
	[209.85.223.177])
	by mail.openembedded.org (Postfix) with ESMTP id 428BA7728C;
	Tue,  2 Feb 2016 15:28:24 +0000 (UTC)
Received: by mail-io0-f177.google.com with SMTP id f81so20828598iof.0;
	Tue, 02 Feb 2016 07:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=cnLdC9L+ZX2VlHC9MZnsIK9oGPzratiQMdnMGHq+AWM=;
	b=ru3NGv27v+rgxKCj5HAkdDVMB3jqS2h4XR7I8RRyxNq1JByj3itHGzoN/8S0H5LTuV
	zfrR4FgPTbt0OiNYeJzZjcV7EKvl+kUdBWyrcoxr4qjiSBMNxMYYNTPFgOk5FJE35bUs
	/Mf6ZeJfzC0eovjPiTmMAj+YUMv77ZHTDnXf1jWTPy9CmvD/A00JlFE6Yvr+NOmLaA/l
	aRWKGr9mZf7BYTURGGtOfcAhxYGEqZlaCGg2ijoFgZATkaMYQkjOQL79Rv9bfai/VP+h
	AjYn01vGa/sfZRk8e++9ipCU0YiE8BmBMoxGC99N6ctJ6l3MAGlD2HbOHJpE5Qps7C38
	biEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:in-reply-to:references:date
	:message-id:subject:from:to:cc:content-type;
	bh=cnLdC9L+ZX2VlHC9MZnsIK9oGPzratiQMdnMGHq+AWM=;
	b=UzN40kJVmrQdZtdo2mPXaNbdq12FeBBKgTyYE1C3fzVKsUWxVQ/PYgdw42WbM+Ak0v
	+hooKHE6ctaPPi+6jCekTLesIOrcsyOtQz5EpJ/dAlvcJqQFNHuteW9Zaclqv4CGbmm4
	8mTDP+9fUti4Y+aidYAQ2oQ4cl8bK9KSblhAFfHisX3ZmJw3H0694dSfnAfIi79QLBh0
	kjrek1hF4iS7Jo1anMKWHDJZ+kt5j+rk/tesHHbsKfJDiAthS8FE+aBhTST7rRwqOii2
	XVQZV24dpCSNj+D8F+NegjhaSOGaR7bq5S7EDXLGHrIQFCWw7/Uu5Xq5WW2SrIS6yI1F
	RggA==
X-Gm-Message-State: AG10YOS8rFh1AYfkjH5Il0g4MkW1lLCQ/R8Fj32sAw5Sl3WqRLMPEXrBMwzsXh4fOFlh9OJbHu2T/CT49C5gyw==
MIME-Version: 1.0
X-Received: by 10.107.29.209 with SMTP id d200mr29329362iod.27.1454426905614; 
	Tue, 02 Feb 2016 07:28:25 -0800 (PST)
Received: by 10.79.91.133 with HTTP; Tue, 2 Feb 2016 07:28:25 -0800 (PST)
In-Reply-To: <1454422078.27087.76.camel@linuxfoundation.org>
References: <1454422078.27087.76.camel@linuxfoundation.org>
Date: Tue, 2 Feb 2016 08:28:25 -0700
Message-ID: <CABcZANnhUi4vvmoPTQu0Khzwt8fPLXu2kSdjBB2yPuFrMX4eqw@mail.gmail.com>
From: Christopher Larson <kergoth@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: openembedded-architecture
	<openembedded-architecture@lists.openembedded.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] build/data: Don't expand python functions before execution [API change]
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
X-List-Received-Date: Tue, 02 Feb 2016 15:28:25 -0000
Content-Type: multipart/alternative; boundary=001a11408e9e0fa24c052acb27a5

--001a11408e9e0fa24c052acb27a5
Content-Type: text/plain; charset=UTF-8

On Tuesday, February 2, 2016, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Right now, if you have some python code like:
>
> X = "a"
>
> def somefunction(d):
>     d.setVar("X", "b")
>     d.setVar("Y", "${X}")
>
> then any sane person would expect that Y = "b" at the end of the
> function. This is not the case, Y = "a".
>
> This is due to the python function being expanded before execution, the
> executed code would read d.setVar("Y", "a"). This understandably
> confuses people, it also makes it near impossible to write ${} in a
> python function without unintended things happening.
>
> I think there is general agreement we should fix this and standardise
> on non-expansion of python functions. We already don't expand anonymous
> python (mostly).
>
> I've checked OE-Core with buildhistory before and after this change and
> there were a small number of issues this exposed which I've sent
> patches for.
>
> I propose we default to not expanding python code and then deal with
> any consequences from that if/as/where identified. This will improve
> new user understanding and usability of the system, it also allows
> several long standing weird expansion issues to be fixed.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org
> <javascript:;>>
>

I absolutely support this. It should reduce confusion with no loss of
functionality.

Acked-by: Christopher Larson <kergoth@gmail.com>


-- 
Christopher Larson
kergoth at gmail dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a11408e9e0fa24c052acb27a5
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, February 2, 2016, Richard Purdie &lt;<a href=3D"mailto:richard.=
purdie@linuxfoundation.org">richard.purdie@linuxfoundation.org</a>&gt; wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">Right now, if you have some python cod=
e like:<br>
<br>
X =3D &quot;a&quot;<br>
<br>
def somefunction(d):<br>
=C2=A0 =C2=A0 d.setVar(&quot;X&quot;, &quot;b&quot;)<br>
=C2=A0 =C2=A0 d.setVar(&quot;Y&quot;, &quot;${X}&quot;)<br>
<br>
then any sane person would expect that Y =3D &quot;b&quot; at the end of th=
e<br>
function. This is not the case, Y =3D &quot;a&quot;.<br>
<br>
This is due to the python function being expanded before execution, the<br>
executed code would read d.setVar(&quot;Y&quot;, &quot;a&quot;). This under=
standably<br>
confuses people, it also makes it near impossible to write ${} in a<br>
python function without unintended things happening.<br>
<br>
I think there is general agreement we should fix this and standardise<br>
on non-expansion of python functions. We already don&#39;t expand anonymous=
<br>
python (mostly).<br>
<br>
I&#39;ve checked OE-Core with buildhistory before and after this change and=
<br>
there were a small number of issues this exposed which I&#39;ve sent<br>
patches for.<br>
<br>
I propose we default to not expanding python code and then deal with<br>
any consequences from that if/as/where identified. This will improve<br>
new user understanding and usability of the system, it also allows<br>
several long standing weird expansion issues to be fixed.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"javascript:;" onclick=3D"_e(ev=
ent, &#39;cvml&#39;, &#39;richard.purdie@linuxfoundation.org&#39;)">richard=
.purdie@linuxfoundation.org</a>&gt;<br></blockquote><div><br></div><div>I a=
bsolutely support this. It should reduce confusion with no loss of function=
ality.</div><div><br></div><div>Acked-by: Christopher Larson &lt;<a href=3D=
"mailto:kergoth@gmail.com">kergoth@gmail.com</a>&gt;</div><br><br>-- <br><d=
iv dir=3D"ltr">Christopher Larson<br>kergoth at gmail dot com<br>Founder - =
BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Software =
Engineer, Mentor Graphics</div><br>

--001a11408e9e0fa24c052acb27a5--
