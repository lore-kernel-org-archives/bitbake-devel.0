Received: from mail-iy0-f175.google.com ([209.85.210.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <andrei@gherzan.ro>) id 1T51qz-0007FE-JW
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Aug 2012 23:55:45 +0200
Received: by iaky10 with SMTP id y10so4236358iak.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Aug 2012 14:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:x-originating-ip:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type:x-gm-message-state;
	bh=uXDrZzQit3rYlHbzNQuZNuMtnGGOcxa6TWcv3QG7mYw=;
	b=AuXBepTJQEy/JrJux+5QtdNrpgZKFiCtGvgdeFXi+8u4wTaeobUTowzJan24YdzuRu
	71qbfxlJwcW8TGm39cXAjUHpNd/MSbR8KZvZpqKX9S+OaPM/49vsD0CLnEl9dRAQUudV
	wXOxJbaLQfi9o7VEtYhH/su5F7pR7ex7QXhL83lOWpPAxMMJmb9RuozY+T09Sq6kkjJz
	3TJl2Yu4j11EdBg85H3r5Sf/ZDDreOeQq8B1WNmF4hYW6Y0mgqDw0kkHDto2/8S+MVmS
	3UQI+U9I1cdOEwmgxP6SzpWl3QPqSL4e4BBTkbdVHOmbpYg2TsuDzimvi7gn3Md/Jvae
	VCEQ==
Received: by 10.50.87.227 with SMTP id bb3mr3603192igb.57.1345844616929; Fri,
	24 Aug 2012 14:43:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.63.50 with HTTP; Fri, 24 Aug 2012 14:43:16 -0700 (PDT)
X-Originating-IP: [79.118.181.96]
In-Reply-To: <CAHUNapQnVGUxnNeoQEj8UDZdLWKit9K0RHy5a6t8a9x5cMwxfA@mail.gmail.com>
References: <1345767760-5516-1-git-send-email-twoerner@gmail.com>
	<CAK18fxFmxBPwray4tgs=LsPEs1hy9TEp7=jbw3i5LgCejmEDpw@mail.gmail.com>
	<CAHUNapQnVGUxnNeoQEj8UDZdLWKit9K0RHy5a6t8a9x5cMwxfA@mail.gmail.com>
From: Andrei Gherzan <andrei@gherzan.ro>
Date: Sat, 25 Aug 2012 00:43:16 +0300
Message-ID: <CAK18fxFV7Ekk+SJ20yNKUxsCuf0f963OCHKzsx17osC9j3RTmw@mail.gmail.com>
To: Trevor Woerner <twoerner@gmail.com>
X-Gm-Message-State: ALoCoQnUqkmkmQ+O/kmggS2NbUkl6hvOA/l/R3MVTfei7KLPdc00S9S6ISZjutJwq3QqmpOCtDbJ
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
X-List-Received-Date: Fri, 24 Aug 2012 21:55:45 -0000
Content-Type: multipart/alternative; boundary=e89a8f3ba4d350a0fa04c809de5f

--e89a8f3ba4d350a0fa04c809de5f
Content-Type: text/plain; charset=ISO-8859-1

On Sat, Aug 25, 2012 at 12:35 AM, Trevor Woerner <twoerner@gmail.com> wrote:

> On Fri, Aug 24, 2012 at 5:19 PM, Andrei Gherzan <andrei@gherzan.ro> wrote:
> > Modify the commit subject. to include what you are changing. In your case
> > the subject should be something like:
> > "bitbake: Clarify wording"
>
> Sorry about that, thanks for the feedback. I'll send in a new patch
> for consideration.
>

No problem. Keep up the good work!

ag

--e89a8f3ba4d350a0fa04c809de5f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Sat, Aug 25, 2012 at 12:35 AM, Trevor Woerner=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:twoerner@gmail.com" target=3D"_bla=
nk">twoerner@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_=
quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1=
ex">

On Fri, Aug 24, 2012 at 5:19 PM, Andrei Gherzan &lt;<a href=3D"mailto:andre=
i@gherzan.ro">andrei@gherzan.ro</a>&gt; wrote:<br>
&gt; Modify the commit subject. to include what you are changing. In your c=
ase<br>
&gt; the subject should be something like:<br>
&gt; &quot;bitbake: Clarify wording&quot;<br>
<br>
Sorry about that, thanks for the feedback. I&#39;ll send in a new patch<br>
for consideration.<br>
</blockquote></div><br><div>No problem. Keep up the good work!</div><div><b=
r></div><div>ag</div>

--e89a8f3ba4d350a0fa04c809de5f--
