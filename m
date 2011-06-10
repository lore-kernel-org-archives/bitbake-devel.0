Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>) id 1QVBY1-00031R-CJ
	for bitbake-devel@lists.openembedded.org;
	Sat, 11 Jun 2011 01:55:29 +0200
Received: by wye20 with SMTP id 20so2479606wye.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jun 2011 16:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:content-type:content-transfer-encoding;
	bh=zml59b1+xmXMXwJEftgvTCwK4Hy4uATPW0WVcaS/k9Q=;
	b=dWzfGzxWoj4oVuxQxrtJumdMd9M9w0jf1h4ewMYPuxnda+2A0YZZd5yFMXayofmQBB
	Urqqf/Dnr6xK/jsu7ObLhYHGVmq6SkNv1NlvTJvAD2oXzdorT8c+BHVNKElkY67Vbu7b
	Pa9KpyGnBOT7q/wvSOtq5YKdtTeYZk00Stvqg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:content-type:content-transfer-encoding;
	b=UV/EG1vFnAVK4BVGPADGfuRqksJEuzYuainUH6Qg0LgDUrkj7+2sYaELXy4e4tdtLa
	VicqwYpxL5/ra2Wr5vSYqvU9BWndBTR8B9YEyNVyDHgJygL6ybKi/4rkFYnVG/z1sgme
	N1+/a6OA6t9xYMT0EOnMRampHBFU/hbHQNRpE=
Received: by 10.216.253.215 with SMTP id f65mr2635133wes.14.1307749928134;
	Fri, 10 Jun 2011 16:52:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.28.19 with HTTP; Fri, 10 Jun 2011 16:51:38 -0700 (PDT)
In-Reply-To: <20110610230326.GA20047@sakrah.homelinux.org>
References: <20110610230326.GA20047@sakrah.homelinux.org>
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 10 Jun 2011 16:51:38 -0700
Message-ID: <BANLkTik1j9_BR7qPF1hH-X6t=GXE3v4pmw@mail.gmail.com>
To: bitbake-devel@lists.openembedded.org
Subject: Re: bitbake quitting without parsing or doing anything
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
X-List-Received-Date: Fri, 10 Jun 2011 23:55:29 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 10, 2011 at 4:03 PM, Khem Raj <raj.khem@gmail.com> wrote:
> Hi
>
> I started to experience this error on my machine when I updated bitbake
> in my setup today. bitbake console-image simply quits without doing anyth=
ing
> and it dies pretty early. Same setup worked fine last week I did not chan=
ge
> anything
>
> I could trace it go until
>
> bb.event.fire(bb.event.ConfigParsed(), data) line 693 in lib/bb/cooker.py
> and silently quit after that
>
> Bisecting resulting in this commit being bad for me.
>
> Let me know if I more information is needed
>
>
> d21d5954d0c08b1c80b72c5f37becc2e58ec916a is the first bad commit
> commit d21d5954d0c08b1c80b72c5f37becc2e58ec916a
> Author: Richard Purdie <richard.purdie@linuxfoundation.org>
> Date: =C2=A0 Wed Jun 8 13:08:52 2011 +0100
>
> =C2=A0 =C2=A0bitbake/server: Move server specific code into the server ba=
ckend and create a server API
>
> =C2=A0 =C2=A0Move the server implementation specific code into the server=
 backend where
> =C2=A0 =C2=A0it belongs and replace this with a set of object method call=
s which
> =C2=A0 =C2=A0establish the server, detach it and then connect to it using=
 appropriate
> =C2=A0 =C2=A0IPC.
>
> =C2=A0 =C2=A0Signed-off-by: Richard Purdie <richard.purdie@linuxfoundatio=
n.org>
>

strangely recloning it works fine again. Dont know why

> --
> -Khem
>


