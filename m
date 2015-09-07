Return-Path: <kergoth@gmail.com>
Received: from mail-ig0-f176.google.com (mail-ig0-f176.google.com
	[209.85.213.176])
	by mail.openembedded.org (Postfix) with ESMTP id 4042F60017
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  7 Sep 2015 20:17:44 +0000 (UTC)
Received: by igbkq10 with SMTP id kq10so59390402igb.0
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 07 Sep 2015 13:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=3Ye4OeWiXX/Bg2NGE3ohiG3DbI0NXz4fuqZ4Hf6Gb5c=;
	b=m32KbJsYb3bPS26O59j05lY3o8FBLXb8N+JO9s3RHqye9qHZR8Ulx2sGB8+R2D5r/B
	roYU+2xv0iiKtwmTBC9REyhTpuOZjykE3cGqTmcgUzh/M7LGVVXhczKac3o1H8ecahLg
	apsz3t3aYh9q/+0O0Ni2mUuEMj6K7puSBigKuKgOcf5xa103HN5klo6BQA+DFL+9mgxa
	3D+tTOTGSFSteF5AvSoJJkEiOoaoEPkpt1rJ5p8sEOoeE7ZShek7OqkPKp1PpQpzIqgo
	2Co7tY5imaugyQKtYbbmQm2CEIofD3JmKwDAbCRsBrYo0gW3D/17fYc3Qn1uypAzdu7C
	2O6A==
X-Received: by 10.50.43.170 with SMTP id x10mr31885868igl.68.1441657064956;
	Mon, 07 Sep 2015 13:17:44 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.79.100.71 with HTTP; Mon, 7 Sep 2015 13:17:25 -0700 (PDT)
In-Reply-To: <1441641334.24871.255.camel@linuxfoundation.org>
References: <1441641334.24871.255.camel@linuxfoundation.org>
From: Christopher Larson <clarson@kergoth.com>
Date: Mon, 7 Sep 2015 13:17:25 -0700
X-Google-Sender-Auth: uVO4pYQVP2my-dVOEEdGXl5X4us
Message-ID: <CABcZANnE0SCyeRFfGHHQ-SmGJC+-UX0NmnRD2gEzkYXWSJZXfw@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] server/process: Handle SIGTERM more gracefully
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
X-List-Received-Date: Mon, 07 Sep 2015 20:17:45 -0000
Content-Type: multipart/alternative; boundary=089e01176cad3eadea051f2df1e8

--089e01176cad3eadea051f2df1e8
Content-Type: text/plain; charset=UTF-8

On Mon, Sep 7, 2015 at 8:55 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> Currently if you send a SIGTERM to the bitbake UI process, the system
> basically
> hangs if tasks are executing. This is because the server process doesn't
> actually try any kind of shutdown before exiting.
>
> This patch trys executing a stateForceShutdown command first, which is
> enough to stop any active tasks before the system exits.
>
> I also noticed that terminate can execute multiple times, once at SIGTERM
> from the handler and once from the real exit. Double execution leads to
> stack traces and potential hangs (writes to dead pipes), so ensure
> the code only can run once.
>
> With these fixes, bitbake much more correctly deals with SIGTERM to the
> UI process.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>

Just as an FYI for consideration in the longer term, you can raise an
exception from a signal handler, to handle sigterm the same way as sigint
for consistency. Ex.:

https://github.com/kergoth/oe-test-scripts/blob/master/bb_test.py#L12-L17 +
https://github.com/kergoth/oe-test-scripts/blob/master/bb_test.py#L171-L180

Which reminds me, we don't exit with the correct exit code for
sigint/sigterm, so the calling shell doesn't know the cause of the exit.
See also http://www.cons.org/cracauer/sigint.html -- fantastic article
there, highly recommended.

https://docs.python.org/3/library/signal.html#example has an example of
raising an exception from another signal handler, so it seems to be kosher.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--089e01176cad3eadea051f2df1e8
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote">On M=
on, Sep 7, 2015 at 8:55 AM, Richard Purdie <span dir=3D"ltr">&lt;<a href=3D=
"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdi=
e@linuxfoundation.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-c=
olor:rgb(204,204,204);border-left-style:solid;padding-left:1ex"><div id=3D"=
:10q" class=3D"" style=3D"overflow:hidden">Currently if you send a SIGTERM =
to the <span class=3D"">bitbake</span> UI process, the system basically<br>
hangs if tasks are executing. This is because the server process doesn&#39;=
t<br>
actually try any kind of shutdown before exiting.<br>
<br>
This patch trys executing a stateForceShutdown command first, which is<br>
enough to stop any active tasks before the system exits.<br>
<br>
I also noticed that terminate can execute multiple times, once at SIGTERM<b=
r>
from the handler and once from the real exit. Double execution leads to<br>
stack traces and potential hangs (writes to dead pipes), so ensure<br>
the code only can run once.<br>
<br>
With these fixes, <span class=3D"">bitbake</span> much more correctly deals=
 with SIGTERM to the<br>
UI process.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt;</div></blockquote><=
/div><br>Just as an FYI for consideration in the longer term, you can raise=
 an exception from a signal handler, to handle sigterm the same way as sigi=
nt for consistency. Ex.:</div><div class=3D"gmail_extra"><br></div><div cla=
ss=3D"gmail_extra"><a href=3D"https://github.com/kergoth/oe-test-scripts/bl=
ob/master/bb_test.py#L12-L17">https://github.com/kergoth/oe-test-scripts/bl=
ob/master/bb_test.py#L12-L17</a> +=C2=A0<a href=3D"https://github.com/kergo=
th/oe-test-scripts/blob/master/bb_test.py#L171-L180">https://github.com/ker=
goth/oe-test-scripts/blob/master/bb_test.py#L171-L180</a></div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">Which reminds me, we =
don&#39;t exit with the correct exit code for sigint/sigterm, so the callin=
g shell doesn&#39;t know the cause of the exit. See also=C2=A0<a href=3D"ht=
tp://www.cons.org/cracauer/sigint.html">http://www.cons.org/cracauer/sigint=
.html</a> -- fantastic article there, highly recommended.</div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra"><a href=3D"https://do=
cs.python.org/3/library/signal.html#example">https://docs.python.org/3/libr=
ary/signal.html#example</a> has an example of raising an exception from ano=
ther signal handler, so it seems to be kosher.<br></div><div class=3D"gmail=
_extra">-- <br><div class=3D"gmail_signature">Christopher Larson<br>clarson=
 at kergoth dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maint=
ainer - Tslib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--089e01176cad3eadea051f2df1e8--
