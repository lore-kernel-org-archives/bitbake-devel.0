Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1TbDRM-0003j5-FO
	for bitbake-devel@lists.openembedded.org;
	Wed, 21 Nov 2012 17:46:20 +0100
Received: by mail-lb0-f175.google.com with SMTP id gg13so2776495lbb.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 21 Nov 2012 08:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=m+RDM8hEfoi9tBgSUkANvmoAdhHBzd9edGb8SH/wAR8=;
	b=SAgspQCOa3+4z5SDVw6jran1yzi93+FZjlos8h7EhZL66WwjGXLkJDoBW5C2NF8h3i
	Fre1GwSpkc1lrdtsaZGaJJM5p/Mbv6XAwpAr69/mLWk/6ufgv1vNfvFEdZProJSqKcX5
	HAwOdKqoPbJ83O1nyxD92oJspDhQPMjVpUJ8tu2lvkxxUXXIwEXj3xSg+YCp5tVLtm55
	bmCHiB8htYYluiljsRaVraHxkoD5t0pmzlw7UQISWbIZBP2l3rv+2+WdhmiHlE7Idezu
	LVXvXRjxFVc4PluVfa2VKPcWEaL0/PaYX/HhVLcchGGRVceH7tSSJJaZDcNpobogH1AG
	N5+Q==
Received: by 10.152.104.77 with SMTP id gc13mr18124048lab.16.1353515535181;
	Wed, 21 Nov 2012 08:32:15 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.42.162 with HTTP; Wed, 21 Nov 2012 08:31:54 -0800 (PST)
In-Reply-To: <1353489690.10459.0.camel@ted>
References: <1353489690.10459.0.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 21 Nov 2012 09:31:54 -0700
X-Google-Sender-Auth: AXkF4pmy3Y0bB5NdS4OA3wY4Wms
Message-ID: <CABcZAN=G7OB-SE5py+oDGRc4_OyjP3DBvOfKMMFwWLFzpiKeOQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] server/process.py: Change timeout error handling
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
X-List-Received-Date: Wed, 21 Nov 2012 16:46:20 -0000
Content-Type: multipart/alternative; boundary=f46d04083adbac292604cf03e4fb

--f46d04083adbac292604cf03e4fb
Content-Type: text/plain; charset=UTF-8

On Wed, Nov 21, 2012 at 2:21 AM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> In normal usage, we never hit the timeout issue. If we do, it becomes
> obvious
> that the current error handling is not good enough. The request may have
> made it
> to the server and the answer will get queued. This means the next command
> may get
> the return value from the previous command with suitably puzzling results.
>
> Without rewriting large sections of code, its not possible to avoid this
> problem.
> It is better to increase the timeout to several seconds giving the server
> a chance
> to respond and if it does timeout, hard exit since recovery is not
> possible with the
> code base today.
>
> I'd be happy to see the structure of this code improved but this quick fix
> at least
> stops corrupted builds from happening which has to be a good thing.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>


This code is run in UI context, not server context, no? So the UI should be
checking the return of runCommand, seeing the error, and aborting itself in
whatever clean fashion is appropriate, rather than the rather less so
immediate sys.exit. Given that, I don't really see how switching to
bb.fatal here is buying us much. If we truly want that error path to be
different from that of other command failures, then I would think that
raising an appropriate exception (e.g. something other than SystemExit)
would be better.
-- 
Christopher Larson

--f46d04083adbac292604cf03e4fb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra"><br><br><div class=3D"gmail_quote">On Wed, Nov 2=
1, 2012 at 2:21 AM, Richard Purdie <span dir=3D"ltr">&lt;<a href=3D"mailto:=
richard.purdie@linuxfoundation.org" target=3D"_blank">richard.purdie@linuxf=
oundation.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":3f">In normal usage, we never hi=
t the timeout issue. If we do, it becomes obvious<br>
that the current error handling is not good enough. The request may have ma=
de it<br>
to the server and the answer will get queued. This means the next command m=
ay get<br>
the return value from the previous command with suitably puzzling results.<=
br>
<br>
Without rewriting large sections of code, its not possible to avoid this pr=
oblem.<br>
It is better to increase the timeout to several seconds giving the server a=
 chance<br>
to respond and if it does timeout, hard exit since recovery is not possible=
 with the<br>
code base today.<br>
<br>
I&#39;d be happy to see the structure of this code improved but this quick =
fix at least<br>
stops corrupted builds from happening which has to be a good thing.<br>
<br>
Signed-off-by: Richard Purdie &lt;<a href=3D"mailto:richard.purdie@linuxfou=
ndation.org">richard.purdie@linuxfoundation.org</a>&gt;</div></blockquote><=
/div><br><br clear=3D"all"><div>This code is run in UI context, not server =
context, no? So the UI should be checking the return of runCommand, seeing =
the error, and aborting itself in whatever clean fashion is appropriate, ra=
ther than the rather less so immediate sys.exit. Given that, I don&#39;t re=
ally see how switching to bb.fatal here is buying us much. If we truly want=
 that error path to be different from that of other command failures, then =
I would think that raising an appropriate exception (e.g. something other t=
han SystemExit) would be better.</div>

-- <br>Christopher Larson<br>
</div>

--f46d04083adbac292604cf03e4fb--
