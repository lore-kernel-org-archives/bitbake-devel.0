Received: from mail-qc0-f175.google.com ([209.85.216.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SMr9c-0007n0-Gk
	for bitbake-devel@lists.openembedded.org;
	Wed, 25 Apr 2012 03:36:24 +0200
Received: by qcso7 with SMTP id o7so776269qcs.6
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 24 Apr 2012 18:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=fUWlAuF9gEwnKcUk4xdih8sIatwG9vnUPj7kOaTHNDc=;
	b=GWIkuHErn88tlU7ePuxArTSUBYlKsDcJeFG73uhtw4gpwZqasiKRJCoIjpgepQWQaG
	L3E4bEIw43a+BdSoHed7zBrmIV2U5mh+SAdnd391gjUUHoXGBz4GPesJNDSoJa6f+gFL
	7eM9a/9EQK9zHjH476nbRB8DF7GsQbov9jUWKcboM8OKP86SfbmqjdxnFWiG43PRADIE
	UBl2IB6bXoIacWoOnpCvN77lpErvjxOodeFb1NMz0v0RiSBP3RrGdiYzf36vCAcpcBAp
	psHf4ZhYwFMd5iOetQTwA9ZKBnkWAkUVKnso1lPCv6B1NsiXo5+zTrV7ak2LuT+SYWj9
	dfFQ==
Received: by 10.229.135.146 with SMTP id n18mr105730qct.139.1335317208826;
	Tue, 24 Apr 2012 18:26:48 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.229.79.79 with HTTP; Tue, 24 Apr 2012 18:26:28 -0700 (PDT)
In-Reply-To: <2bbdbdf903d6c80f54058bcb5edd8a1e6aa89d15.1335254750.git.dongxiao.xu@intel.com>
References: <cover.1335254750.git.dongxiao.xu@intel.com>
	<2bbdbdf903d6c80f54058bcb5edd8a1e6aa89d15.1335254750.git.dongxiao.xu@intel.com>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 24 Apr 2012 18:26:28 -0700
X-Google-Sender-Auth: jW-t8rq5p3Wezeq6tdSTP35WYV8
Message-ID: <CABcZANkt3RPjL+JQSA5i2UbundQzn=n7xMKG+pwj4rRuyUJ-oA@mail.gmail.com>
To: Dongxiao Xu <dongxiao.xu@intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/3] event.py: Add SanityCheck and SanityCheckPassed events
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
X-List-Received-Date: Wed, 25 Apr 2012 01:36:24 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2012 at 1:16 AM, Dongxiao Xu <dongxiao.xu@intel.com> wrote:
> Signed-off-by: Dongxiao Xu <dongxiao.xu@intel.com>
> ---
> =C2=A0lib/bb/event.py | =C2=A0 10 ++++++++++
> =C2=A01 files changed, 10 insertions(+), 0 deletions(-)
>
> diff --git a/lib/bb/event.py b/lib/bb/event.py
> index bbece58..f3fb521 100644
> --- a/lib/bb/event.py
> +++ b/lib/bb/event.py
> @@ -517,3 +517,13 @@ class PackageInfo(Event):
> =C2=A0 =C2=A0 def __init__(self, pkginfolist):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 Event.__init__(self)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self._pkginfolist =3D pkginfolist
> +
> +class SanityCheck(Event):
> + =C2=A0 =C2=A0"""
> + =C2=A0 =C2=A0Event to issue sanity check
> + =C2=A0 =C2=A0"""
> +
> +class SanityCheckPassed(Event):
> + =C2=A0 =C2=A0"""
> + =C2=A0 =C2=A0Event to indicate sanity check is passed
> + =C2=A0 =C2=A0"""

Sanity checking is not part of bitbake, nor does it belong there. I'd
say to find another way to do this.
--=20
Christopher Larson


