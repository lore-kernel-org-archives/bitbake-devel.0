Received: from mail-we0-f175.google.com ([74.125.82.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <martin.jansa@gmail.com>) id 1TitRI-0000T0-08
	for bitbake-devel@lists.openembedded.org;
	Wed, 12 Dec 2012 22:02:07 +0100
Received: by mail-we0-f175.google.com with SMTP id z53so494367wey.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Dec 2012 12:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:date:message-id:subject:from:to
	:cc:content-type:content-transfer-encoding;
	bh=vx679MOhv5JogdVWqLfWn+UJQotDrnaiSYDzGd7QCO8=;
	b=gvqgWgAteJUNb3uZHhGIqciTU8HDXIXwrU7EZFU2dgWU2k2e/V6+xP8wgopF3m5rmf
	VC5WZuUcqlLRfm08oMB91LBY+4MD/MkJHfLveXgKxl50stJuR+jpW55WLRlvR3D00jcx
	fP737EQDttrwfpJWvbWWjalf3XZBCvfIdH2jPSJdtm6WpbMZEUP5KwqscBE6NmHACqAX
	eOVYtGwQ6Ci9rFZeA7ZO8r9VeNClA/ZSJ/yBOtj4YoCpBe/UWfYD7VStb41Wk6XJj13P
	Oq0qmxXMIgX3226jAbj+cOMXvEgflMkpfdkjiQcqac95kOOLdSVBas1XrkBCMgRGT87d
	ClQg==
MIME-Version: 1.0
Received: by 10.180.93.40 with SMTP id cr8mr25025044wib.15.1355345246231; Wed,
	12 Dec 2012 12:47:26 -0800 (PST)
Received: by 10.194.84.103 with HTTP; Wed, 12 Dec 2012 12:47:26 -0800 (PST)
In-Reply-To: <20121212203550.GD743@gmail.com>
References: <20121212203550.GD743@gmail.com>
Date: Wed, 12 Dec 2012 21:47:26 +0100
Message-ID: <CA+chaQdi0E-4ZtsaiAweAFU5PcYYjnMKAeA-cT3eK+tcJOe_Dg@mail.gmail.com>
From: Martin Jansa <martin.jansa@gmail.com>
To: =?UTF-8?B?RXJlbiBUw7xya2F5?= <eren@hambedded.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH v2] bitbake.vim: detect *.bbappend files in ftdetect automatically
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
X-List-Received-Date: Wed, 12 Dec 2012 21:02:14 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 12, 2012 at 9:35 PM, Eren T=C3=BCrkay <eren@hambedded.org> wrot=
e:
> Currently, *.bb and *.bbclass files are automatically highlighted and
> detected as a bitbake file. Since *.bbappend files are also bitbake
> files, vim plugin should automatically detect and highlight it as well.
> ---
>  contrib/vim/ftdetect/bitbake.vim |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/vim/ftdetect/bitbake.vim b/contrib/vim/ftdetect/bitb=
ake.vim
> index 179e4d9..b9529e6 100644
> --- a/contrib/vim/ftdetect/bitbake.vim
> +++ b/contrib/vim/ftdetect/bitbake.vim
> @@ -10,8 +10,8 @@ if &compatible || version < 600
>      finish
>  endif
>
> -" .bb and .bbclass
> -au BufNewFile,BufRead *.b{b,bclass}    set filetype=3Dbitbake
> +" .bb, .bbappend and .bbclass
> +au BufNewFile,BufRead *.{bb,bbappend,bbclass}  set filetype=3Dbitbake

fwiw: you can probably add .inc too, but some people will probably
find it conflicting with some other ftdetect.. :/


