Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1QrsuX-0005lZ-7K
	for bitbake-devel@lists.openembedded.org;
	Fri, 12 Aug 2011 16:40:33 +0200
Received: by vxj14 with SMTP id 14so2672330vxj.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 12 Aug 2011 07:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=9u08zsYxlE2LrHlGhdDju+IM5oEtBgGXAObq1pJ21Xs=;
	b=Q6wgE8UaB2YBXUl4cCXNV1woM94tYArgTJiAe1hpfqpchB2H3mzGIFI0+l4h8tRIYI
	x3NFzfuixXOP58Zjv81p3giqBsV42vGnYFxHY7pQemUjljOwaGhvz+FCih32r9z8PPUM
	/njcbALJzqXOxgjZSTQMdJm77YBJdd4vGytgs=
Received: by 10.52.117.101 with SMTP id kd5mr828371vdb.364.1313159757038; Fri,
	12 Aug 2011 07:35:57 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.52.112.194 with HTTP; Fri, 12 Aug 2011 07:35:37 -0700 (PDT)
In-Reply-To: <1313159106.14274.490.camel@rex>
References: <1313159106.14274.490.camel@rex>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 12 Aug 2011 07:35:37 -0700
X-Google-Sender-Auth: kRLCkwhm1uVomIAzkDo-Ggd_KxY
Message-ID: <CABcZAN=zSAB5pgVk_F2pqgQEu1D=G_aG-rrrm3g8BOGZw2GvjQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: bitbake/logging: Overhaul internal logging process
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
X-List-Received-Date: Fri, 12 Aug 2011 14:40:33 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 12, 2011 at 7:25 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> -def set_debug_level(level):
> - =C2=A0 =C2=A0for log in loggers.itervalues():
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0log.setLevel(logging.NOTSET)
> +loggerDefaults =3D [0, False, []]

This line is meaningless at first glance. It's impossible to tell what
these values are intended to mean without finding its usages. Have you
considered using a different container than a list for this, or just
using separate variables?
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


