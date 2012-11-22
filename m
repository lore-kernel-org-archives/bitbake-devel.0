Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1Tbd4c-0007kQ-8H
	for bitbake-devel@lists.openembedded.org;
	Thu, 22 Nov 2012 21:08:34 +0100
Received: by mail-lb0-f175.google.com with SMTP id gg13so3645566lbb.6
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 22 Nov 2012 11:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=u2xRnfJHbTQrIvNgS1UNnrcfivYNz86KGqjEmE/A2ak=;
	b=pyBohh83hD4B0LsJhmlC5WoazdlOiVrddn/cM9ZjuIXrxBUC74RopCYIRyM79wR5/M
	07zHurGyq9OcXLlU5EocYkXzUvZXSu8rRpyDh908w7fgkTrd/CK9GdvBCkQdSTWmmO8Y
	nPfl3gjLgFPn5GpU20zCgSJK+cevgcX3Ol70pd0z0BZ2LKRaWenmJqJn/Fn91eAyiOIO
	eE9UgQnB92HeWXuaaXvxT75RL/Fj/vydsZXKVb506R+0/Ij9ChoGvs1qujv+ZE7mNYMr
	fXK96NAtb4cZHnvz7sE/H4QS4egOgRnwJFPV0FOMAKDb9ED4nHjr4hTkYkkWDqd91FAb
	pzcw==
Received: by 10.152.104.148 with SMTP id ge20mr1306299lab.51.1353614067371;
	Thu, 22 Nov 2012 11:54:27 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.42.162 with HTTP; Thu, 22 Nov 2012 11:54:07 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1211221354240.6298@oneiric>
References: <alpine.DEB.2.02.1211221354240.6298@oneiric>
From: Chris Larson <clarson@kergoth.com>
Date: Thu, 22 Nov 2012 12:54:07 -0700
X-Google-Sender-Auth: LNanJIyuj8U3x1PdTeS9LemXl_Y
Message-ID: <CABcZANmiDXzOKYjTrya92D277+4RUtu7o4shR+CJkNfzTDTOoA@mail.gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: how easy to extend "bitbake -e" to print *selected* subset of variables?
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
X-List-Received-Date: Thu, 22 Nov 2012 20:08:34 -0000
Content-Type: multipart/alternative; boundary=f46d04071169a60e7304cf1ad506

--f46d04071169a60e7304cf1ad506
Content-Type: text/plain; charset=UTF-8

On Thu, Nov 22, 2012 at 12:00 PM, Robert P. J. Day <rpjday@crashcourse.ca>wrote:

>   i would find it *massively* useful to have a variation of "bitbake
> -e" print only the values of the variables that i'm interested in;
> this would be incredibly useful in a classroom if i wanted students to
> take a look at just those variables related to, say, the kernel.
>
>   rather than having to hack up something using grep, it would be nice
> if a user could, say, define an extra variable or class and say
> something like:
>
>   $ bitbake -e core-image-minimal --area kernel  (or similar)
>
> where i could define that the "kernel area" represents the variables
> such as MACHINE, KMACHINE, KBRANCH, LINUX_KERNEL_TYPE and whatever
> variables i decide should belong to that "area."  then when i'm
> discussing the kernel, i have a simple command that immediately allows
> the students to see how the kernel was configured.
>
>   i realize this can't be hard -- just add some filtering code to that
> part of bitbake that prints everything.  thoughts?  is there a way to
> do this that i'm not seeing?
>

I would personally like to see something like:

bitbake -E MACHINE,DISTRO,TMPDIR

Rather than having to define additional 'grouping' metadata.

For now, something like this might be convenient:

$ cat ~/bin/bitbake-env
#!/bin/sh
#
# bitbake-env VARIABLE [VARIBLE...]
#
# Filter out particular variables from bitbake -e, including the commented
out
# unexpanded form, and both exported and unexported.

args_pattern () {
    for arg; do
        printf "$arg|"
    done | sed 's,|$,,'
}

bitbake -e | grep -E "^((export )?|(# )?)($(args_pattern "$@"))="
-- 
Christopher Larson

--f46d04071169a60e7304cf1ad506
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra">On Thu, Nov 22, 2012 at 12:00 PM, Robert P. J. D=
ay <span dir=3D"ltr">&lt;<a href=3D"mailto:rpjday@crashcourse.ca" target=3D=
"_blank">rpjday@crashcourse.ca</a>&gt;</span> wrote:<br><div class=3D"gmail=
_quote">

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div id=3D":69b">=C2=A0 i would find it *massively* useful=
 to have a variation of &quot;bitbake<br>


-e&quot; print only the values of the variables that i&#39;m interested in;=
<br>
this would be incredibly useful in a classroom if i wanted students to<br>
take a look at just those variables related to, say, the kernel.<br>
<br>
=C2=A0 rather than having to hack up something using grep, it would be nice=
<br>
if a user could, say, define an extra variable or class and say<br>
something like:<br>
<br>
=C2=A0 $ bitbake -e core-image-minimal --area kernel =C2=A0(or similar)<br>
<br>
where i could define that the &quot;kernel area&quot; represents the variab=
les<br>
such as MACHINE, KMACHINE, KBRANCH, LINUX_KERNEL_TYPE and whatever<br>
variables i decide should belong to that &quot;area.&quot; =C2=A0then when =
i&#39;m<br>
discussing the kernel, i have a simple command that immediately allows<br>
the students to see how the kernel was configured.<br>
<br>
=C2=A0 i realize this can&#39;t be hard -- just add some filtering code to =
that<br>
part of bitbake that prints everything. =C2=A0thoughts? =C2=A0is there a wa=
y to<br>
do this that i&#39;m not seeing?<br></div></blockquote></div><br>I would pe=
rsonally like to see something like:</div><div class=3D"gmail_extra"><br></=
div><div class=3D"gmail_extra">bitbake -E MACHINE,DISTRO,TMPDIR</div><div c=
lass=3D"gmail_extra">

<br></div><div class=3D"gmail_extra">Rather than having to define additiona=
l &#39;grouping&#39; metadata.</div><div class=3D"gmail_extra"><br></div><d=
iv class=3D"gmail_extra">For now, something like this might be convenient:<=
/div>

<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">$ cat ~/bin=
/bitbake-env</div><div class=3D"gmail_extra"><div class=3D"gmail_extra">#!/=
bin/sh</div><div class=3D"gmail_extra">#</div><div class=3D"gmail_extra"># =
bitbake-env VARIABLE [VARIBLE...]</div>

<div class=3D"gmail_extra">#</div><div class=3D"gmail_extra"># Filter out p=
articular variables from bitbake -e, including the commented out</div><div =
class=3D"gmail_extra"># unexpanded form, and both exported and unexported.<=
/div>

<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">args_patter=
n () {</div><div class=3D"gmail_extra">=C2=A0 =C2=A0 for arg; do</div><div =
class=3D"gmail_extra">=C2=A0 =C2=A0 =C2=A0 =C2=A0 printf &quot;$arg|&quot;<=
/div><div class=3D"gmail_extra">=C2=A0 =C2=A0 done | sed &#39;s,|$,,&#39;</=
div>

<div class=3D"gmail_extra">}</div><div class=3D"gmail_extra"><br></div><div=
 class=3D"gmail_extra">bitbake -e | grep -E &quot;^((export )?|(# )?)($(arg=
s_pattern &quot;$@&quot;))=3D&quot;</div></div><div class=3D"gmail_extra">-=
- <br>

Christopher Larson<br>
</div>

--f46d04071169a60e7304cf1ad506--
