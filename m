Received: from mail-vw0-f41.google.com ([209.85.212.41])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1R1N6a-000379-3f
	for bitbake-devel@lists.openembedded.org;
	Wed, 07 Sep 2011 20:44:12 +0200
Received: by vwm42 with SMTP id 42so6477895vwm.28
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 07 Sep 2011 11:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=UKkK7MfuJJHgSAydDwf/Te6FyoZBf1BcajCah/ixmbk=;
	b=n/Bg79oE3TxPy6dDF8F/OQv7r2otnZP8BRSiPTqvElWoCDPRmedKEsx5r+BVh48vq0
	Sq9m0kep+Rc+1Dx/dNqCEvVcWJhQNROrq2PToQqFT7/HETl6dyKz+TRsrljTxAHQgP6I
	T0cLpJFpFyOcgfd4DhQyeSFJTugm7oCdf6PT0=
Received: by 10.52.22.237 with SMTP id h13mr3131091vdf.228.1315420749093; Wed,
	07 Sep 2011 11:39:09 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.52.107.134 with HTTP; Wed, 7 Sep 2011 11:38:49 -0700 (PDT)
In-Reply-To: <1315417400.13021.20.camel@ted>
References: <1315417400.13021.20.camel@ted>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 7 Sep 2011 11:38:49 -0700
X-Google-Sender-Auth: 4zy837AlHVHFnXgWrL7ZMGnXPWY
Message-ID: <CABcZANkp2JLJJ4G1J1dcRkNSqiEqWqnv5Qav-5F=EAzD0UxJ3w@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: runqueue: Ensure task environment is correct
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
X-List-Received-Date: Wed, 07 Sep 2011 18:44:12 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 7, 2011 at 10:43 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> This fixes two problems:
>
> a) Variables which were in the parent environment but not set as "export"
> =C2=A0 variables in the datastore could end up in the task environment
>
> b) oe.environ.update() can't cope with the generator returned by
> =C2=A0 bb.data.exported_vars()
>
> Whilst the updated code isn't as neat, it does do the expected thing,
> sets the environment correctly and stops unwanted values leaking into
> the task environment.
>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
>
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 5a4321f..72e6845 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -1136,7 +1136,12 @@ class RunQueueExecute:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for h in self.rqd=
ata.hash_deps:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 the=
_data.setVar("BBHASHDEPS_%s" % h, self.rqdata.hash_deps[h])
>
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os.environ.updat=
e(bb.data.exported_vars(the_data))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# exported_vars(=
) returns a generator which *cannot* be passed to os.environ.update()
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0# successfully. =
We also need to unset anything from the environment which shouldn't be ther=
e
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0exports =3D bb.d=
ata.exported_vars(the_data)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bb.utils.empty_e=
nvironment()
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for e, v in expo=
rts:
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0os=
.environ[e] =3D v

os.environ.clear()
os.environ.update(bb.data.exported_vars(the_data))
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


