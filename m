Received: from mail-la0-f43.google.com ([209.85.215.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TqpSo-0005Ax-Fa
	for bitbake-devel@lists.openembedded.org;
	Thu, 03 Jan 2013 19:24:44 +0100
Received: by mail-la0-f43.google.com with SMTP id eg20so8435385lab.30
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 03 Jan 2013 10:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=hr8HxoJQmuwBnxOdO5v+FEMAYHZhwvL2MnsmVAsURnk=;
	b=Itg5NLk8mNBazV8ddAs1BMKuXYUn7V7dlUSw+g/blzIvSmwEDtPyVQgu+u2CPvmbHI
	6l1U0IAkoAN1qgyfESSYyqmTwB6ZX6H4qdGfJt39QVmd0LwV6z5NyGJ8n48YYfgAfuso
	b5nOF4PdnwqtIYOs8A3aoWHqb5C1yDJhle03NZq+f5xC04bz2EVBx+sceLhrJOYTkxva
	SAQ457NpF0Wj40S6vrftkfauH8KdmaFIMeqMlEoKcmWldi2cSYCj620pu8O/QRxXLolu
	XzDWSgXCDgZQszFWfxP92n25I0gTDHKcYJZ51ouFRacpDaTWBkuGG7mMfxPeiY/ihZaW
	hNpQ==
Received: by 10.152.114.66 with SMTP id je2mr46847449lab.40.1357236558294;
	Thu, 03 Jan 2013 10:09:18 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Thu, 3 Jan 2013 10:08:58 -0800 (PST)
In-Reply-To: <CAHUNapRE-wRQpPhGOJDFcUkAMERKcGJNaoWcN7jZFOmkwbr60Q@mail.gmail.com>
References: <alpine.DEB.2.02.1301010855180.18858@oneiric>
	<CAHUNapRE-wRQpPhGOJDFcUkAMERKcGJNaoWcN7jZFOmkwbr60Q@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Thu, 3 Jan 2013 11:08:58 -0700
X-Google-Sender-Auth: qEVfkM6VAdQ3TtqF_i3f4ze8hAY
Message-ID: <CABcZAN=2yTpvQosjZNmAh2h5CdV7SwdEVeiyxc1Ahja70QAjEA@mail.gmail.com>
To: Trevor Woerner <twoerner@gmail.com>
Cc: Richard Purdie <rpurdie@rpsys.net>,
	BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: still confused about _append and OVERRIDES and = and +=, argh
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
X-List-Received-Date: Thu, 03 Jan 2013 18:24:44 -0000
Content-Type: multipart/alternative; boundary=90e6ba309926eeee7a04d2664222

--90e6ba309926eeee7a04d2664222
Content-Type: text/plain; charset=UTF-8

On Thu, Jan 3, 2013 at 9:43 AM, Trevor Woerner <twoerner@gmail.com> wrote:

> On Tue, Jan 1, 2013 at 9:12 AM, Robert P. J. Day <rpjday@crashcourse.ca>
> wrote:
> > and started playing with chris larson's "bitbake-env" utility
>
> Is there any chance of, or interest in, including "bitbake-env" in the
> Yocto Project?


Personally, my intent is for it to become part of a subcommand-based
bitbake command, which could then be integrated into bitbake, but that
depends on interest from Richard. See
https://github.com/kergoth/bb#readmefor the very early prototype, with
bitbake-env as its 'show' subcommand.

If there's no interest in that sort of thing, I'd certainly be open to
bitbake-env being pulled into the bitbake repository, as there's certainly
value/convenience there. For reference, Robert has put together information
on it at http://www.crashcourse.ca/wiki/index.php/OE_bitbake-env_utility.
-- 
Christopher Larson

--90e6ba309926eeee7a04d2664222
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">On Thu, Jan 3, 2013 at 9:43 AM,=
 Trevor Woerner <span dir=3D"ltr">&lt;<a href=3D"mailto:twoerner@gmail.com"=
 target=3D"_blank">twoerner@gmail.com</a>&gt;</span> wrote:<br><div class=
=3D"gmail_quote">

<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex"><div class=3D"im">On Tue, Jan 1, 2013 at 9:12 AM, Robert P=
. J. Day &lt;<a href=3D"mailto:rpjday@crashcourse.ca">rpjday@crashcourse.ca=
</a>&gt; wrote:<br>


</div><div class=3D"im">&gt; and started playing with chris larson&#39;s &q=
uot;bitbake-env&quot; utility<br>
<br>
</div>Is there any chance of, or interest in, including &quot;bitbake-env&q=
uot; in the<br>
Yocto Project?</blockquote></div><br>Personally, my intent is for it to bec=
ome part of a subcommand-based bitbake command, which could then be integra=
ted into bitbake, but that depends on interest from Richard. See=C2=A0<a hr=
ef=3D"https://github.com/kergoth/bb#readme">https://github.com/kergoth/bb#r=
eadme</a> for the very early prototype, with bitbake-env as its &#39;show&#=
39; subcommand.</div>

<div class=3D"gmail_extra"><br></div><div class=3D"gmail_extra">If there&#3=
9;s no interest in that sort of thing, I&#39;d certainly be open to bitbake=
-env being pulled into the bitbake repository, as there&#39;s certainly val=
ue/convenience there. For reference, Robert has put together information on=
 it at=C2=A0<a href=3D"http://www.crashcourse.ca/wiki/index.php/OE_bitbake-=
env_utility">http://www.crashcourse.ca/wiki/index.php/OE_bitbake-env_utilit=
y</a>.<br>

-- <br>Christopher Larson</div></div>

--90e6ba309926eeee7a04d2664222--
