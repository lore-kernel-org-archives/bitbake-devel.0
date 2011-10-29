Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1RJyJV-0003Ei-0Q
	for bitbake-devel@lists.openembedded.org;
	Sat, 29 Oct 2011 04:06:25 +0200
Received: by wyg19 with SMTP id 19so4814331wyg.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 28 Oct 2011 19:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type:content-transfer-encoding;
	bh=K3cgBffkXwytlIK02V3l8rGbR4KSK7pWykETIko4xyA=;
	b=YJ6ZBZxdYMycZHptXGkW7MJM/U4TpaVnPCX7xZV6KUcOsX+3GncOqVTX7DshWmAQDo
	HVOHk8zne3NENlHlqW1VKOyctPxcAGTLj38VHa8/honqTfKZYz06T2Ioslu8pUU8VR8+
	2JqQB1c78A3ioD2OdfYDUD2GjJhSxlvoOXJMA=
Received: by 10.216.230.83 with SMTP id i61mr1891242weq.39.1319853622198; Fri,
	28 Oct 2011 19:00:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.28.138 with HTTP; Fri, 28 Oct 2011 19:00:01 -0700 (PDT)
In-Reply-To: <1319853466-10277-1-git-send-email-kergoth@gmail.com>
References: <1319853466-10277-1-git-send-email-kergoth@gmail.com>
From: Chris Larson <kergoth@gmail.com>
Date: Fri, 28 Oct 2011 19:00:01 -0700
Message-ID: <CABcZANm4C9_xcYCcjZHXx2PKTQy12cH=3c0ukgCjcRFji_3+jQ@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Cc: Christopher Larson <chris_larson@mentor.com>
Subject: Re: [PATCH] codeparser: accept a name for better messages
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
X-List-Received-Date: Sat, 29 Oct 2011 02:06:25 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2011 at 6:57 PM, Christopher Larson <kergoth@gmail.com> wro=
te:
> From: Christopher Larson <chris_larson@mentor.com>
>
> - If a name is passed to the parser, prepend the messages with "while
> =C2=A0parsing <name>:". This gives a bit more context.
> - Tweak the warning messages slightly (they had to be altered anyway to
> =C2=A0inject the variable being parsed).
>
> Before:
> =C2=A0DEBUG: Warning: in call to 'bb.data.getVar': argument ''%s' % var' =
is \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 not a literal
>
> After:
> =C2=A0DEBUG: while parsing emit_pkgdata, in call of bb.data.getVar, argum=
ent \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 ''%s' % var' is not a string literal
>
> Signed-off-by: Christopher Larson <chris_larson@mentor.com>


Note: applies on top of the previous series. Does this message wording
seem sane to people, or would you prefer it remain more like the
previous one? I rather like the new sentence form. Also, 'Warning'
could unnecessarily scare users looking back at logs.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


