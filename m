Return-Path: <kergoth@gmail.com>
Received: from mail-oi0-f44.google.com (mail-oi0-f44.google.com
	[209.85.218.44])
	by mail.openembedded.org (Postfix) with ESMTP id 92F506FF7B
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2016 14:59:57 +0000 (UTC)
Received: by mail-oi0-f44.google.com with SMTP id l203so29504571oib.1
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 30 Aug 2016 07:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc;
	bh=2BCDgDuWTGbBJCmn2prq9RGblqN6bX0jzKGPYC2c7g8=;
	b=ofb2bFSnmq8vQAn3EMnJ3lS7Gsvo7Atp4a0xOOhmD5yUhbj81zOmzqgKyCmxdzjMXA
	tOFh5jEKRIGYqf6ZrYioFvK+/W+rEz3v5aA4tj6CztfivuOgOFfqTX8iKVzA0fxq/S2Y
	kdCPGoW0/rAiI8AN4JXjDc6M4YAE3tWgf0ogw1Un5BaeOqmdLjDytRMM1o7WbUedY3YC
	FWt0HI9/Zpf2XwcckccwpemMyPvJL0ommp/Uc8mlfqBps4T5HSnHSurGx1cjK+HHkDjB
	cfrFUYUzCIEW/9EW+8yf+nUInASE74Fk4kYiVQDmM0hARdCW2y4PpU+Y4RfJIrtO0jUw
	0FfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20130820;
	h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
	:date:message-id:subject:to:cc;
	bh=2BCDgDuWTGbBJCmn2prq9RGblqN6bX0jzKGPYC2c7g8=;
	b=WnWdyJ3Z+ATof+OBYpa3YiHhg4DvhonEMMoH7OyMmI4hUrijJTYxu8q8AWaqgiybvu
	WFTNYQqhFDvdUuzvGvLxlnpS93Ny9CFp7rEpEV5eJUhSTxMA3iCB7AeBuYvquRWLNm/K
	9ZLeTTiDiqoM/pIAP+UbxNWWBlCa3niB9aUW81C8oP83L12KUuK8rUVHTaXoXHS63s6r
	WQCJy7UdoJZ3GEOOqXQLHqmSgAcZV93tdRHJ+ZhbnDrms5ei1tK/szLvuSU70JGEleXG
	Zj1NorDH3i2CvSLxzSk6omHaqJTjrpCvMDTDOTjL3VYewvJ7frWiN6vcFy+KVIAvw1Yh
	kVYg==
X-Gm-Message-State: AE9vXwO6DEeGaVrvngkL+pNYxXcH0CHFWtdOfL+vWUkaDUqkMX+0Vi5KMSLLDtXWyeC0KXW22g3Yh2dGjDLkVA==
X-Received: by 10.157.17.72 with SMTP id p8mr4661785otp.120.1472569197624;
	Tue, 30 Aug 2016 07:59:57 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.157.44.7 with HTTP; Tue, 30 Aug 2016 07:59:37 -0700 (PDT)
In-Reply-To: <CAJ86T=UnA3cUU80pdTfgAvc0Ht-Pc9sJJoUK5rjdvuoUKa+4sw@mail.gmail.com>
References: <CAJ86T=UnA3cUU80pdTfgAvc0Ht-Pc9sJJoUK5rjdvuoUKa+4sw@mail.gmail.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Tue, 30 Aug 2016 07:59:37 -0700
X-Google-Sender-Auth: _A4FoQBqBshz4OLyJUWafyndIIs
Message-ID: <CABcZANm8Uxn=WVzgsyPimB3a-pM3_c+piVtzZVFMJLFW+THwbQ@mail.gmail.com>
To: Andre McCurdy <armccurdy@gmail.com>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: How to prevent expansion of bitbake variables inside tasks?
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
X-List-Received-Date: Tue, 30 Aug 2016 14:59:57 -0000
Content-Type: multipart/alternative; boundary=001a113e243cee866b053b4b3b8b

--001a113e243cee866b053b4b3b8b
Content-Type: text/plain; charset=UTF-8

On Mon, Aug 29, 2016 at 7:12 PM, Andre McCurdy <armccurdy@gmail.com> wrote:

> Say I want to create a do_install() task which does:
>
>   do_install() {
>     echo '${BP} was ${BP}' > ${D}/test
>   }
>
> but I don't want first ${BP} bitbake variable to be expanded. ie after
> the task has run I want ${D}/test to contain the string "${BP} was
> foo-1.0".
>
> What's the recommended way to escape the first ${BP} in do_install()?
>

Sadly this was an oversight when the file format was originally created, so
there's no real way to escape the variable reference to make bitbake not
expand it. There are workarounds, of course. You could do some or all of
the work in python rather than shell, since python functions don't get
their variable references of that sort expanded, for example, or you could
construct the output / break up the reference, i.e. echo '$' >, echo '{BP}'
>, or easier, use printf to do it with format strings, i.e. printf '${%s}
was ${%s}\n' BP BP >${D}/test.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a113e243cee866b053b4b3b8b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Mon, Aug 29, 2016 at 7:12 PM, Andre McCurdy <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:armccurdy@gmail.com" target=3D"_blank">armccurdy@gmail.com</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div id=3D":cc" class=
=3D"a3s aXjCH m156d9384c025706b">Say I want to create a do_install() task w=
hich does:<br>
<br>
=C2=A0 do_install() {<br>
=C2=A0 =C2=A0 echo &#39;${BP} was ${BP}&#39; &gt; ${D}/test<br>
=C2=A0 }<br>
<br>
but I don&#39;t want first ${BP} bitbake variable to be expanded. ie after<=
br>
the task has run I want ${D}/test to contain the string &quot;${BP} was<br>
foo-1.0&quot;.<br>
<br>
What&#39;s the recommended way to escape the first ${BP} in do_install()?</=
div></blockquote></div><br>Sadly this was an oversight when the file format=
 was originally created, so there&#39;s no real way to escape the variable =
reference to make bitbake not expand it. There are workarounds, of course. =
You could do some or all of the work in python rather than shell, since pyt=
hon functions don&#39;t get their variable references of that sort expanded=
, for example, or you could construct the output / break up the reference, =
i.e. echo &#39;$&#39; &gt;, echo &#39;{BP}&#39; &gt;, or easier, use printf=
 to do it with format strings, i.e. printf &#39;${%s} was ${%s}\n&#39; BP B=
P &gt;${D}/test.<br>-- <br><div class=3D"gmail_signature" data-smartmail=3D=
"gmail_signature">Christopher Larson<br>clarson at kergoth dot com<br>Found=
er - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Tslib<br>Senior Soft=
ware Engineer, Mentor Graphics</div>
</div></div>

--001a113e243cee866b053b4b3b8b--
