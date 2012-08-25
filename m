Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei@gherzan.ro>) id 1T5PK4-0002HC-UT
	for bitbake-devel@lists.openembedded.org;
	Sun, 26 Aug 2012 00:59:21 +0200
Received: by iaky10 with SMTP id y10so5820907iak.6
	for <bitbake-devel@lists.openembedded.org>;
	Sat, 25 Aug 2012 15:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:x-originating-ip:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type:x-gm-message-state;
	bh=sNsQg+YQRl7JJlKV61wpmOtYUnD2S/4gtiHrPmCpjLI=;
	b=nARUmQE99ZX+qV061PQ+bpIjBrfl6w0aMsTCcUp49COTmHLHqN2K3kmrKvxrLYfAIk
	LhNOd7QflIAy9Y7IaQR7/0BeNc4Z5DGnAgyCK3vYRinlpfS7SN6QL0925IFzr6eejmiJ
	foDENIKLa61J9Gk5fRRVu0ID20pOnx9uQGn0PuokbGKaJH0eGFjzcaoux7P0WJRN2wAf
	vO/p2mBCq1fi8Q3IgMRuKXVmsSjW0PoT0whY0w5KmAGc0RCTU1OlmhL2Bc2liF+H7Dag
	+5OmJUKhW+i6qOjhOna6xYCyVsjy4Hd6N/ZgWauog2XdPmLbRN7iCEg6av7DACwSk24b
	qnOQ==
Received: by 10.50.194.130 with SMTP id hw2mr5991861igc.57.1345934830473; Sat,
	25 Aug 2012 15:47:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.63.50 with HTTP; Sat, 25 Aug 2012 15:46:50 -0700 (PDT)
X-Originating-IP: [79.118.181.96]
In-Reply-To: <CABcZANmumueLTHW5kHerFwqwRLkaPOYea4YRtRswwKwuBZ+OSA@mail.gmail.com>
References: <1345767760-5516-1-git-send-email-twoerner@gmail.com>
	<CAK18fxFmxBPwray4tgs=LsPEs1hy9TEp7=jbw3i5LgCejmEDpw@mail.gmail.com>
	<CAHUNapQnVGUxnNeoQEj8UDZdLWKit9K0RHy5a6t8a9x5cMwxfA@mail.gmail.com>
	<CABcZANm2uL7c40LQWxmvu4q6yTjrymzqth-JmTdPvbC7XAHm_w@mail.gmail.com>
	<CAK18fxEVCYsTypt-qa88Chjhu+qj4ry2FSdU8tUEnAZyCijcCQ@mail.gmail.com>
	<CABcZANmumueLTHW5kHerFwqwRLkaPOYea4YRtRswwKwuBZ+OSA@mail.gmail.com>
From: Andrei Gherzan <andrei@gherzan.ro>
Date: Sun, 26 Aug 2012 01:46:50 +0300
Message-ID: <CAK18fxE=Z_8Yn7scBU-1wWRnoYrv6cY2WyL6sUW=WvztS0TA=g@mail.gmail.com>
To: Chris Larson <clarson@kergoth.com>
X-Gm-Message-State: ALoCoQm+gUSmXss/KQ1v3X0NqhyZwmP6BcNww6pwTIoQmt/YXZzw2FUlsCY7nLeL7b9eYw7hZsxV
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] clarify wording
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
X-List-Received-Date: Sat, 25 Aug 2012 22:59:21 -0000
Content-Type: multipart/alternative; boundary=14dae9340bc776139904c81edf16

--14dae9340bc776139904c81edf16
Content-Type: text/plain; charset=ISO-8859-1

On Sun, Aug 26, 2012 at 12:00 AM, Chris Larson <clarson@kergoth.com> wrote:

> On Sat, Aug 25, 2012 at 3:15 AM, Andrei Gherzan <andrei@gherzan.ro> wrote:
> >> No, this is wrong. When committing to the bitbake repository, there's
> >> no need to prefix it with 'bitbake:'. You should mention what/where
> >> you're clarifying, however. E.g. "clarify wording in help output for
> >> -s"
> >
> > Yes i'm right. When suggesting for adding "bitbake:" i wasn't refering to
> > the repo. I was talking about "what is changed". And that is the bitbake
> > script. The general format is "what: Short log".
> >
> > Here are some examples.
> > bitbake: data-smart: rename the 'content' internal variable to '_content'
> > bitbake: Hob wizard-like reorganization
>
> Wrong. Inside the bitbake repository, it shouldn't and needn't be
> prefixed with 'bitbake:' unless necessary due to it coming from poky.
> Perhaps the only git changelog you read is inside the poky repository,
> but the rest of us pay more attention.
>
>
Ok. I see your point. And you are right. I was talking inside yocto. Thank
you for clarifying this.

ag

--14dae9340bc776139904c81edf16
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sun, Aug 26, 2012 at 12:00 AM, Chris Larson <=
span dir=3D"ltr">&lt;<a href=3D"mailto:clarson@kergoth.com" target=3D"_blan=
k">clarson@kergoth.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">

On Sat, Aug 25, 2012 at 3:15 AM, Andrei Gherzan &lt;<a href=3D"mailto:andre=
i@gherzan.ro">andrei@gherzan.ro</a>&gt; wrote:<br>
&gt;&gt; No, this is wrong. When committing to the bitbake repository, ther=
e&#39;s<br>
&gt;&gt; no need to prefix it with &#39;bitbake:&#39;. You should mention w=
hat/where<br>
&gt;&gt; you&#39;re clarifying, however. E.g. &quot;clarify wording in help=
 output for<br>
&gt;&gt; -s&quot;<br>
&gt;<br>
&gt; Yes i&#39;m right. When suggesting for adding &quot;bitbake:&quot; i w=
asn&#39;t refering to<br>
&gt; the repo. I was talking about &quot;what is changed&quot;. And that is=
 the bitbake<br>
&gt; script. The general format is &quot;what: Short log&quot;.<br>
&gt;<br>
&gt; Here are some examples.<br>
&gt; bitbake: data-smart: rename the &#39;content&#39; internal variable to=
 &#39;_content&#39;<br>
&gt; bitbake: Hob wizard-like reorganization<br>
<br>
Wrong. Inside the bitbake repository, it shouldn&#39;t and needn&#39;t be<b=
r>
prefixed with &#39;bitbake:&#39; unless necessary due to it coming from pok=
y.<br>
Perhaps the only git changelog you read is inside the poky repository,<br>
but the rest of us pay more attention.<br><br></blockquote><div>=A0</div><d=
iv>Ok. I see your point. And you are right. I was talking inside yocto. Tha=
nk you for clarifying this.=A0</div></div><br><div>ag</div>

--14dae9340bc776139904c81edf16--
