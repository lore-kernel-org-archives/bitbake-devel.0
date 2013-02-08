Received: from mail-lb0-f182.google.com ([209.85.217.182])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1U3ci5-00006E-NS
	for bitbake-devel@lists.openembedded.org;
	Fri, 08 Feb 2013 02:25:01 +0100
Received: by mail-lb0-f182.google.com with SMTP id gg6so2617802lbb.13
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 07 Feb 2013 17:09:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=x9RiW+Q70Ejm3EXa99xARdxoX5Hb9jbvfv9C1vzpynI=;
	b=N2Bd2XLjNRln3ooEZzUgEVW1oKgx3WNqh6nf4vpbT9fGehWablEB/ZLY3RFb72tAsP
	Y5cYGcRtZvaLn11CbEZK67kVee36cxvJxlX4owq6C5yCECmD+izNUUjW0pToZs10+E9F
	StZtzrVvvBQrIsM/B2NU3OxiS5JUsVeAs/LLAsNpxi5XlEukz4cYXW5haDrMLyUC+E0M
	DArQvVCF+iwiHbbhrYwGOZL7b8/wS6guZ4tzNw+zBw9CB5VMKkKzGJT9pFdF7CcoUeWg
	vXG78WNuBKn44Y3ztZP9DLuauD46iXGz4HZrGpyTVwqDok/18KFm8j2/CO8G1WZb/lnS
	yyJQ==
X-Received: by 10.112.44.164 with SMTP id f4mr1594274lbm.43.1360285748372;
	Thu, 07 Feb 2013 17:09:08 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Thu, 7 Feb 2013 17:08:48 -0800 (PST)
In-Reply-To: <1360281302.10722.68.camel@ted>
References: <1360281302.10722.68.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Thu, 7 Feb 2013 18:08:48 -0700
X-Google-Sender-Auth: Ve8dPnXNe_qVqrl0zt6TfU7YhwM
Message-ID: <CABcZANmd9_bcAUizAR3JiSX368HJsKhzGrGPkqAsbMsw2G9=ig@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] utils: Use rm -rf in remove()
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
X-List-Received-Date: Fri, 08 Feb 2013 01:25:02 -0000
Content-Type: multipart/alternative; boundary=f46d0401229fd3254504d52c34d6

--f46d0401229fd3254504d52c34d6
Content-Type: text/plain; charset=UTF-8

On Thu, Feb 7, 2013 at 4:55 PM, Richard Purdie <
richard.purdie@linuxfoundation.org> wrote:

> -                shutil.rmtree(name)
> +                # shutil.rmtree(name) would be ideal but its too slow
> +                subprocess.call('rm -rf %s' % path, shell=True)
>

This is a good idea, but I'm curious about forking off a shell process for
it. I'd think this would work as well: subprocess.call(['rm', '-rf', path])
-- 
Christopher Larson

--f46d0401229fd3254504d52c34d6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Feb 7, 2013 at 4:55 PM, Richard Purdie <span dir=3D"ltr">&lt;<a hre=
f=3D"mailto:richard.purdie@linuxfoundation.org" target=3D"_blank">richard.p=
urdie@linuxfoundation.org</a>&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":24s">- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0shutil.rmtree(name)<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# shutil.rmtree(na=
me) would be ideal but its too slow<br>
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0subprocess.call(&#=
39;rm -rf %s&#39; % path, shell=3DTrue)</div></blockquote></div><br>This is=
 a good idea, but I&#39;m curious about forking off a shell process for it.=
 I&#39;d think this would work as well: subprocess.call([&#39;rm&#39;, &#39=
;-rf&#39;, path])</div>

<div class=3D"gmail_extra">-- <br>Christopher Larson</div></div>

--f46d0401229fd3254504d52c34d6--
