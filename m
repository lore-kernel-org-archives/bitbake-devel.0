Received: from mail-oa0-f47.google.com ([209.85.219.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1Tfhzk-0001u9-7A
	for bitbake-devel@lists.openembedded.org;
	Tue, 04 Dec 2012 03:12:51 +0100
Received: by mail-oa0-f47.google.com with SMTP id h1so3406816oag.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 03 Dec 2012 17:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=z1pnxmllbKA0CJaXGUFG+kNi1/z980vf84dEY9gbjFY=;
	b=FYnro9lYWI7hdkm5fDfb3bzT/2AM34iLQqcKi3psWQNkHM0MlP0GEF2+DNzYfX9N56
	EsB0p+lJtbi7YqvaIfXp+lam8k4VRror4eFFuZtDnsio45Z7Tt/Wva7p728FiayBgNpr
	OndWfqR5t0wv7ocyeMpJNeSuCSi+Quz5JAghjqNzLiXOaGErWazy8c1hzkiVFVbQqjLs
	1IcSrnnltwEUmwloqnSLbV/7L/EqJ6Elu6tR2nWQ/qWmoJbVwnJ2Hxp/MQTCWoUkfiOt
	1kneZQv9i/cZQV7329F82s8fnxgPLGhxV5DarTftMOzqZZdwH6zn38lzIb2zlPPM/NQ8
	IBKg==
Received: by 10.60.0.228 with SMTP id 4mr9837809oeh.88.1354586272170; Mon, 03
	Dec 2012 17:57:52 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.76.35.37 with HTTP; Mon, 3 Dec 2012 17:57:31 -0800 (PST)
In-Reply-To: <alpine.DEB.2.02.1212031731330.5149@heron.softorchestra.com>
References: <alpine.DEB.2.02.1212031731330.5149@heron.softorchestra.com>
From: Chris Larson <clarson@kergoth.com>
Date: Mon, 3 Dec 2012 18:57:31 -0700
X-Google-Sender-Auth: j-FJm8JGteuZMZrOBxjj_4th6fk
Message-ID: <CABcZAN=T_auryBtu1KSduKdKDx9Dx1v+O6HNTPbkeG447zmuDw@mail.gmail.com>
To: Alan DuBoff <aland@softorchestra.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: autotools project won't install
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
X-List-Received-Date: Tue, 04 Dec 2012 02:12:52 -0000
Content-Type: multipart/alternative; boundary=e89a8fb1fd8092041104cffd3130

--e89a8fb1fd8092041104cffd3130
Content-Type: text/plain; charset=UTF-8

On Mon, Dec 3, 2012 at 6:40 PM, Alan DuBoff <aland@softorchestra.com> wrote:

> I created a recipe for an autotools project I'm working on.


Unfortunately, this isn't the right mailing list for this. This issue is
with use of classes from the metadata, but this list is for the bitbake
tool specifically. I'd suggest contacting the angstrom mailing lists, or
for specific issues with specific bits of metadata, the appropriate lists
for the layers in question.
-- 
Christopher Larson

--e89a8fb1fd8092041104cffd3130
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_extra">On Mon, Dec 3, 2012 at 6:40 PM, Alan DuBoff <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:aland@softorchestra.com" target=3D"_bla=
nk">aland@softorchestra.com</a>&gt;</span> wrote:<br><div class=3D"gmail_qu=
ote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex">

I created a recipe for an autotools project I&#39;m working on.</blockquote=
></div><br>Unfortunately, this isn&#39;t the right mailing list for this. T=
his issue is with use of classes from the metadata, but this list is for th=
e bitbake tool specifically. I&#39;d suggest contacting the angstrom mailin=
g lists, or for specific issues with specific bits of metadata, the appropr=
iate lists for the layers in question.<br>

-- <br>Christopher Larson<br>
</div>

--e89a8fb1fd8092041104cffd3130--
