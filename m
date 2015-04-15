Return-Path: <kergoth@gmail.com>
Received: from mail-qk0-f174.google.com (mail-qk0-f174.google.com
	[209.85.220.174])
	by mail.openembedded.org (Postfix) with ESMTP id 5BF516AC1E
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Apr 2015 19:38:25 +0000 (UTC)
Received: by qkx62 with SMTP id 62so98173828qkx.0
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 15 Apr 2015 12:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date:message-id
	:subject:to:cc:content-type;
	bh=Oj7YFfO3tnYUYCEoInaE29cA3L3Sbg+7BIe8DV1ixLA=;
	b=08KlG/rlNl7RTx5cwUVNyQuxm9DCSAYfuPjNWI94BowMgcRYCcK6kyn6IIc3fKyL2y
	fV+sso7ziAHbZVSvReWFiOgVntG4hEIdCWoW64lhzVsB9JP/dE5g0EXBbZLZee2AZ4Qy
	YM4tfhqPP2WbHmC95IBrmC7dxX4dg1ORJf6MZoix4GBXJ1rOCbHUvjNhHAgkxCtx9ZyP
	SGkYvfJSYwWVy6VkwkunMb9Bi+sLdgrOq0dIwcq6dm6YdkqtAZAhKeFm86kCT2YpPPJu
	OQvreQ8Gncu3mLM13HqNTvfBAz7YW3kI6ezr4gQQxB1sN3rpgYgYYE8G6vkB4ENRmG9B
	qWNg==
X-Received: by 10.55.22.23 with SMTP id g23mr54141026qkh.4.1429126679130; Wed,
	15 Apr 2015 12:37:59 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.140.108.34 with HTTP; Wed, 15 Apr 2015 12:37:38 -0700 (PDT)
In-Reply-To: <1427827190-10442-1-git-send-email-Liam.Howlett@WindRiver.com>
References: <1427827190-10442-1-git-send-email-Liam.Howlett@WindRiver.com>
From: Christopher Larson <clarson@kergoth.com>
Date: Wed, 15 Apr 2015 12:37:38 -0700
X-Google-Sender-Auth: CI97W2bQh5lAL3OTZtpP86k0Y9k
Message-ID: <CABcZANkKhGMkjxWj1QcJDLtWZ+B3TKqR_JLSSw3nfze+Qet+3g@mail.gmail.com>
To: "Liam R. Howlett" <Liam.Howlett@windriver.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] fetch2: Add BB_TRUSTED_NETWORK support
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
X-List-Received-Date: Wed, 15 Apr 2015 19:38:28 -0000
Content-Type: multipart/alternative; boundary=001a114749ce0c7b600513c87c41

--001a114749ce0c7b600513c87c41
Content-Type: text/plain; charset=UTF-8

On Tue, Mar 31, 2015 at 11:39 AM, Liam R. Howlett <
Liam.Howlett@windriver.com> wrote:

> This patch adds support for a new local.conf variable called
> BB_TRUSTED_NETWORK.  BB_TRUSTED_NETWORK holds a list of hostnames that the
> user
> trusts as a source for downloading content.  If network access is enabled
> and
> the user has configured trusted hosts, then any hosts that are not in the
> list
> will cause an error to occur at fetch.  Any mirrors and pre-mirrors that
> are
> not in the list will result in warnings that these locations will not be
> used.
>
> The BB_NO_NETWORK variable still stops all network access.
>
> Please see the comments in the patch for more details and example usage.
>

Hmm, looks like this might be useful with an internal mirror coupled with
PREMIRRORS, so fetches from the internal host are allowed, but anything
missing from there would be immediately caught?
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics

--001a114749ce0c7b600513c87c41
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Mar 31, 2015 at 11:39 AM, Liam R. Howlett <span dir=3D"ltr">&lt;<a =
href=3D"mailto:Liam.Howlett@windriver.com" target=3D"_blank">Liam.Howlett@w=
indriver.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div i=
d=3D":1o5" class=3D"a3s" style=3D"overflow:hidden">This patch adds support =
for a new local.<span class=3D"il">conf</span> variable called<br>
BB_TRUSTED_NETWORK.=C2=A0 BB_TRUSTED_NETWORK holds a list of hostnames that=
 the user<br>
trusts as a source for downloading content.=C2=A0 If network access is enab=
led and<br>
the user has configured trusted hosts, then any hosts that are not in the l=
ist<br>
will cause an error to occur at fetch.=C2=A0 Any mirrors and pre-mirrors th=
at are<br>
not in the list will result in warnings that these locations will not be us=
ed.<br>
<br>
The BB_NO_NETWORK variable still stops all network access.<br>
<br>
Please see the comments in the patch for more details and example usage.</d=
iv></blockquote></div><br>Hmm, looks like this might be useful with an inte=
rnal mirror coupled with PREMIRRORS, so fetches from the internal host are =
allowed, but anything missing from there would be immediately caught?<br>--=
 <br><div class=3D"gmail_signature">Christopher Larson<br>clarson at kergot=
h dot com<br>Founder - BitBake, OpenEmbedded, OpenZaurus<br>Maintainer - Ts=
lib<br>Senior Software Engineer, Mentor Graphics</div>
</div></div>

--001a114749ce0c7b600513c87c41--
