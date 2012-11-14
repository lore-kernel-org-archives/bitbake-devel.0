Received: from mail-ia0-f175.google.com ([209.85.210.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <seth.boll@gmail.com>) id 1TYd4U-0002OY-FH
	for bitbake-devel@lists.openembedded.org;
	Wed, 14 Nov 2012 14:32:05 +0100
Received: by mail-ia0-f175.google.com with SMTP id z3so246639iad.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 14 Nov 2012 05:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type;
	bh=PKUFj9oY/zhZM9MAK8+mTJX5oyBUlzZas9jQN/b9gZo=;
	b=ZYQ7kPoVrY2afXOagxkO9qapVvjr+D3c13S4plKzOdr/5hNQX5uWxfTZgfwIAWH1UB
	+ZCzDUmqcw/w5hUDetTDJmIfuRn0BdaZf1DmlBQeW/4sSr5jqaHWu6Fx5zleurWNUv/Z
	3UcA8BYBlrxebxgbxLHs4ZTrpXBRqEHPqoKcN9Pr5Kft8P0Gutp5UZcwKTStdkuytV7n
	AoKrCd2hw1RXLaLg27CPRInz3BSaceA8fPs1NdxEHf+DmPR4cgkEdQO3G3h1hUe6y1ns
	sa6okh3bd5PlkOL6mbylFG5+Z5snPabw0otN2ZpFvGmaQL6I6OJhxB4y74qZL+EXGepI
	Qqlw==
MIME-Version: 1.0
Received: by 10.50.40.225 with SMTP id a1mr1665416igl.7.1352899086432; Wed, 14
	Nov 2012 05:18:06 -0800 (PST)
Received: by 10.64.35.170 with HTTP; Wed, 14 Nov 2012 05:18:06 -0800 (PST)
In-Reply-To: <50A2CB5E.8030600@windriver.com>
References: <CA+JN8xNzAvDdt4bgS=z536YciYVAvZGE2+Z=qQa1XP4HCE8=gg@mail.gmail.com>
	<1352816623.24487.128.camel@ted>
	<CA+JN8xOF_iVQb30NVdrXEtqieh0E6m2-tSE2uG6UiG+f9C6qHw@mail.gmail.com>
	<1352820166.24487.136.camel@ted> <50A2CB5E.8030600@windriver.com>
Date: Wed, 14 Nov 2012 07:18:06 -0600
Message-ID: <CA+JN8xNDqbvnymb8pOpmEe=P5GV=WYtnLVskCNxmFPxYwkomvQ@mail.gmail.com>
From: Seth Bollinger <seth.boll@gmail.com>
To: Jason Wessel <jason.wessel@windriver.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] bitbake: Colorize knotty interactive console output
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
X-List-Received-Date: Wed, 14 Nov 2012 13:32:05 -0000
Content-Type: multipart/alternative; boundary=14dae9340cb776b81e04ce745dfe

--14dae9340cb776b81e04ce745dfe
Content-Type: text/plain; charset=ISO-8859-1

Thanks!  I've tested this and it works on my dark color scheme (it's better
actually :)).  I also tested on white and it looks fine.  If Richard is ok
with this solution, I'll make the changes and submit another patch.

Seth


On Tue, Nov 13, 2012 at 4:36 PM, Jason Wessel <jason.wessel@windriver.com>wrote:

> On 11/13/2012 09:22 AM, Richard Purdie wrote:
> > On Tue, 2012-11-13 at 08:45 -0600, Seth Bollinger wrote:
> >> I'm not sure how best to resolve this.  Would you like me to add some
> >> code to try and detect background color?  This seems like it might be
> >> more complex than it's worth...
> >>
> >> Or would it be better to have a selectable light background color
> >> set?  If you think light background is more common (I dislike staring
> >> at large blocks of white :)) it could default to the light color set.
> > I have not looked into this and am not an expert on terminals and colour
> > control of them. I don't know how we can solve this but the current
> > situation where it prints white on white on my terminal is clearly
> > unacceptable. This has to be a problem others have run into and solved
> > before though...
>
>
> If you are planning to colorize things, my recommendation would be to take
> the "middle ground" and use the transparency instead of using white which
> should work in general on any modern terminal.
>
> Change the patch a bit like this:
> +    color_enabled = False
> +    BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE = range(30,38)
>
>     BASECOLOR, BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE =
> range(29,38)
>
> +
> +    COLORS = {
> +        DEBUG3  : CYAN,
> +        DEBUG2  : CYAN,
> +        DEBUG   : CYAN,
> +        VERBOSE : BASECOLOR,
> +        NOTE    : BASECOLOR,
> +        PLAIN   : BASECOLOR,
> +        WARNING : YELLOW,
> +        ERROR   : RED,
> +        CRITICAL: RED,
> +    }
>
>
> Most of the time terminals are either "dark" or "light", and default color
> is always set to -1 in the curses interface.  For example, the attached
> patch will allow the patch to work on my "lawngreen" default xterms as well
> as more typical defaults for gnome-terminal or rxvt.
>
> Cheers,
> Jason.
>

--14dae9340cb776b81e04ce745dfe
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div style=3D"font-family:arial,sans-serif;font-size:13px">Thanks! =A0I&#39=
;ve tested this and it works on my dark color scheme (it&#39;s better actua=
lly :)). =A0I also tested on white and it looks fine. =A0If Richard is ok w=
ith this solution, I&#39;ll make the changes and submit another patch.<br>
</div><div style=3D"font-family:arial,sans-serif;font-size:13px"><br></div>=
<div style=3D"font-family:arial,sans-serif;font-size:13px">Seth</div><div c=
lass=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Tue, Nov 13, 201=
2 at 4:36 PM, Jason Wessel <span dir=3D"ltr">&lt;<a href=3D"mailto:jason.we=
ssel@windriver.com" target=3D"_blank">jason.wessel@windriver.com</a>&gt;</s=
pan> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">On 11/13/2012 09:22 AM, Richard Purdie wrote=
:<br>
&gt; On Tue, 2012-11-13 at 08:45 -0600, Seth Bollinger wrote:<br>
&gt;&gt; I&#39;m not sure how best to resolve this. =A0Would you like me to=
 add some<br>
&gt;&gt; code to try and detect background color? =A0This seems like it mig=
ht be<br>
&gt;&gt; more complex than it&#39;s worth...<br>
&gt;&gt;<br>
&gt;&gt; Or would it be better to have a selectable light background color<=
br>
&gt;&gt; set? =A0If you think light background is more common (I dislike st=
aring<br>
&gt;&gt; at large blocks of white :)) it could default to the light color s=
et.<br>
&gt; I have not looked into this and am not an expert on terminals and colo=
ur<br>
&gt; control of them. I don&#39;t know how we can solve this but the curren=
t<br>
&gt; situation where it prints white on white on my terminal is clearly<br>
&gt; unacceptable. This has to be a problem others have run into and solved=
<br>
&gt; before though...<br>
<br>
<br>
If you are planning to colorize things, my recommendation would be to take =
the &quot;middle ground&quot; and use the transparency instead of using whi=
te which should work in general on any modern terminal.<br>
<br>
Change the patch a bit like this:<br>
+ =A0 =A0color_enabled =3D False<br>
+ =A0 =A0BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE =3D range(30=
,38)<br>
<br>
=A0 =A0 BASECOLOR, BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE =
=3D range(29,38)<br>
<br>
+<br>
+ =A0 =A0COLORS =3D {<br>
+ =A0 =A0 =A0 =A0DEBUG3 =A0: CYAN,<br>
+ =A0 =A0 =A0 =A0DEBUG2 =A0: CYAN,<br>
+ =A0 =A0 =A0 =A0DEBUG =A0 : CYAN,<br>
+ =A0 =A0 =A0 =A0VERBOSE : BASECOLOR,<br>
+ =A0 =A0 =A0 =A0NOTE =A0 =A0: BASECOLOR,<br>
+ =A0 =A0 =A0 =A0PLAIN =A0 : BASECOLOR,<br>
+ =A0 =A0 =A0 =A0WARNING : YELLOW,<br>
+ =A0 =A0 =A0 =A0ERROR =A0 : RED,<br>
+ =A0 =A0 =A0 =A0CRITICAL: RED,<br>
+ =A0 =A0}<br>
<br>
<br>
Most of the time terminals are either &quot;dark&quot; or &quot;light&quot;=
, and default color is always set to -1 in the curses interface. =A0For exa=
mple, the attached patch will allow the patch to work on my &quot;lawngreen=
&quot; default xterms as well as more typical defaults for gnome-terminal o=
r rxvt.<br>

<br>
Cheers,<br>
Jason.<br>
</blockquote></div><br></div>

--14dae9340cb776b81e04ce745dfe--
