Received: from mail-la0-f46.google.com ([209.85.215.46])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>)
	id 1TwkgK-0005GR-Mg; Sun, 20 Jan 2013 03:30:59 +0100
Received: by mail-la0-f46.google.com with SMTP id fq12so2586842lab.33
	for <multiple recipients>; Sat, 19 Jan 2013 18:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=x-received:mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=IIBlvQXjAkT7+4E/uws6Owz/QHQKImRMEMYGjWxlLjI=;
	b=hP6L9JRfBooDNd3vqq4gSK1cTbjvoQssk1oZYfZWa/eZAf4s14gsW64DMUxiAFRVHn
	sq85pSmpiW6zddWI3u8YvtY+tvjw0t/lLFtBC6TdxuNgV6wrXKC1lky5iJ7GL02eb7rZ
	VSxx9CC5onpfQ6os9pAP/wJDzfSFvNz9WxTQchgnKxOcchninkNWb7RhJcmoRYYYuDJ0
	J+/5kS+ZyOZVdXcMzo/UJPAxFyfYb5lgFjLvxTRr7yr/MGEJWDfGfbEbDPYRhTXMpZhw
	8NMBMtmv3rGZPCqHXXXtA0lsDf2LCcQbJ32RSROds/XvFGfSRatHD6yrek7+m7Yn+dcJ
	2Z4g==
X-Received: by 10.152.144.103 with SMTP id sl7mr13061487lab.23.1358648121901; 
	Sat, 19 Jan 2013 18:15:21 -0800 (PST)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.112.34.10 with HTTP; Sat, 19 Jan 2013 18:15:01 -0800 (PST)
In-Reply-To: <CAHsH0E96h=aT6t-u-ACY7MGFHJv4_TTqSMfCmMpSKiq3NBjciw@mail.gmail.com>
References: <CAHsH0E96h=aT6t-u-ACY7MGFHJv4_TTqSMfCmMpSKiq3NBjciw@mail.gmail.com>
From: Chris Larson <clarson@kergoth.com>
Date: Sat, 19 Jan 2013 19:15:01 -0700
X-Google-Sender-Auth: 3r1xWnOvLhNZGSKgSKIw_cJuWIk
Message-ID: <CABcZANkpo5qMnPkL903SQjfkPhwUF-7rK+i5LaqxTFUdqE3H2Q@mail.gmail.com>
To: lei yang <yanglei.fage@gmail.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: git address in SRC_URI, doesn't works for me
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
X-List-Received-Date: Sun, 20 Jan 2013 02:31:00 -0000
Content-Type: multipart/alternative; boundary=e89a8f22bec1ae444d04d3aeeab1

--e89a8f22bec1ae444d04d3aeeab1
Content-Type: text/plain; charset=UTF-8

On Sat, Jan 19, 2013 at 2:13 AM, lei yang <yanglei.fage@gmail.com> wrote:

> SRC_URI = "git://git.opensvc.com/multipath-tools/.git;protocol=http"
> it doe noting,and trying to find COPING,but it doesn't clone it
>

This is the correct syntax. The URL scheme (git://) determines what bitbake
fetcher, and therefore what tool, is used to fetch. If you use http://,
it'll try to download it with wget, not git.
-- 
Christopher Larson

--e89a8f22bec1ae444d04d3aeeab1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sat, Jan 19, 2013 at 2:13 AM, lei yang <span dir=3D"ltr">&lt;<a href=3D"=
mailto:yanglei.fage@gmail.com" target=3D"_blank">yanglei.fage@gmail.com</a>=
&gt;</span> wrote:<br>

<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div id=3D":13v">SRC_URI =3D &quot;git://<a =
href=3D"http://git.opensvc.com/multipath-tools/.git;protocol=3Dhttp" target=
=3D"_blank">git.opensvc.com/multipath-tools/.git;protocol=3Dhttp</a>&quot;<=
br>


it doe noting,and trying to find COPING,but it doesn&#39;t clone it</div></=
blockquote></div><br>This is the correct syntax. The URL scheme (git://) de=
termines what bitbake fetcher, and therefore what tool, is used to fetch. I=
f you use http://, it&#39;ll try to download it with wget, not git.<br>

-- <br>Christopher Larson</div></div>

--e89a8f22bec1ae444d04d3aeeab1--
