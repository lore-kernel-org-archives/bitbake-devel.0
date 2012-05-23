Received: from mail-wg0-f43.google.com ([74.125.82.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1SXDjz-0007qF-1u
	for bitbake-devel@lists.openembedded.org;
	Wed, 23 May 2012 17:44:47 +0200
Received: by wgbdr1 with SMTP id dr1so6506127wgb.24
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 23 May 2012 08:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=6n0hDApDMcx+07Ro8Ci11s+CsrUSGBsyL6RPOQZ5xbQ=;
	b=kTkjsErNUhqo8fGWvsHjFHVwWD1McK7c1f67IzOpNc+meTm9Ze9G+pNnP1F4O4fD0D
	VIFFzqL+rzPwl5cbA2DihrLaOT3zp40I3YU6Zr10p8ZfSD3ERMr2uSOyFTXrlJ64oMjy
	n54VET8dOPbaUU9klvmzpu9nvJ1v5N8j9VPt7NaMo4GHEiW3lEQFeJxpGWoPqGB67ZUa
	vpzGtw4F94HQS2IHVjfJYWYOTFaGs1ZUENVmPt4F0q/uT39jJBC55wbMa3vrzV/BObTd
	8QpGjhNrXbc+F6gPsewnJycS2xqObVK0StYLKm4alKuGg7my+9tfHZFwzukHUCpTkZPS
	Yabw==
Received: by 10.180.102.9 with SMTP id fk9mr62861419wib.1.1337787276873; Wed,
	23 May 2012 08:34:36 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.216.181.16 with HTTP; Wed, 23 May 2012 08:34:16 -0700 (PDT)
In-Reply-To: <dac2367a09e77d0230e8c2e625484336533ea50e.1337764882.git.kai.kang@windriver.com>
References: <cover.1337764882.git.kai.kang@windriver.com>
	<dac2367a09e77d0230e8c2e625484336533ea50e.1337764882.git.kai.kang@windriver.com>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 23 May 2012 08:34:16 -0700
X-Google-Sender-Auth: Wp3DdOZ5_3uqwyPrsN6BmjtjbN8
Message-ID: <CABcZAN=Rs1HC6dTKOvU4r2cuO04m10f1-hoNtRfox_xgVhbsxg@mail.gmail.com>
To: Kang Kai <kai.kang@windriver.com>
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 1/1] cooker.py: terminate the Parser processes
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
X-List-Received-Date: Wed, 23 May 2012 15:44:48 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

terminate()'ing processes can corrupt any queues those processes have
open, and thereby disrupt any pending log messages in the queues
heading to the ui as a result. If that's not an issue here, so be it,
but be aware of the issues -- we had to remove terminate() from the
shutdown in the past due to this issue.

On Wed, May 23, 2012 at 2:40 AM, Kang Kai <kai.kang@windriver.com> wrote:
> [Yocto 2142]
>
> Force to exit HOB when hob is parsing recipes, the bitbake doesn't stop.
> It hangs on function BitBakeServerConnection::terminate in file
> server/process.py:
> =C2=A0 =C2=A0else:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0self.procserver.join()
> It is waiting for the children process quit.
>
> In stage of parse recipes BBCooker spawns Parser processes as many as
> cpu numbers. When quit the Parser processes they make their internal
> Queue to call cancel_join_thread() to avoid block but don't work at
> this time.
> So force to terminate the Parser processes.
>
> Signed-off-by: Kang Kai <kai.kang@windriver.com>
> ---
> =C2=A0bitbake/lib/bb/cooker.py | =C2=A0 =C2=A09 ++++++---
> =C2=A01 files changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/bitbake/lib/bb/cooker.py b/bitbake/lib/bb/cooker.py
> index dea0aad..4a4dc38 100644
> --- a/bitbake/lib/bb/cooker.py
> +++ b/bitbake/lib/bb/cooker.py
> @@ -1175,7 +1175,7 @@ class BBCooker:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.state in (state.shutdown, state.stop)=
:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.parser.shutdown(clean=3DF=
alse)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0self.parser.shutdown(clean=3DF=
alse, force =3D True)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sys.exit(1)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if self.state !=3D state.parsing:
> @@ -1608,10 +1608,13 @@ class CookerParser(object):
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.parser_quit.=
put(None)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.jobs.cancel_join_thread()
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sys.exit(1)
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 for process in self.processes:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process.join()
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if force:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process.join(.1)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process.terminat=
e()
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process.join()
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.feeder.join()
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 sync =3D threading.Thread(target=3Dself.bb_ca=
che.sync)
> --
> 1.7.5.4
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel



--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


