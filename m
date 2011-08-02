Received: from mail-vw0-f47.google.com ([209.85.212.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>)
	id 1QoFoZ-000356-1X; Tue, 02 Aug 2011 16:19:23 +0200
Received: by vws2 with SMTP id 2so5655758vws.6
	for <multiple recipients>; Tue, 02 Aug 2011 07:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type
	:content-transfer-encoding;
	bh=MI8XseQW219Sop7PPqmioFFMomV/G72UwPKEz47G8r8=;
	b=B7DIAcBl/UNxe/0ZX5m3p5rs808mMbaYEC9c/04kTISRASKNQLX0W5YafCw9sKiKGk
	gR+PVjBpThH/vKpkAkD4tzf1EdiP9sSIgpn54er0dStoGTcaSUllFLSSbza7o3Y2tCNd
	vyBx0qv6dzmKBBrsyGgNp5Mqf1GxvNTo/Fld0=
Received: by 10.52.24.16 with SMTP id q16mr6041088vdf.227.1312294501090; Tue,
	02 Aug 2011 07:15:01 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.52.112.194 with HTTP; Tue, 2 Aug 2011 07:14:41 -0700 (PDT)
In-Reply-To: <1312293167.4325.38.camel@phil-desktop>
References: <201108021226.34560.paul.eggleton@linux.intel.com>
	<1312292735.2344.597.camel@rex> <1312293167.4325.38.camel@phil-desktop>
From: Chris Larson <clarson@kergoth.com>
Date: Tue, 2 Aug 2011 07:14:41 -0700
X-Google-Sender-Auth: S-NSV0iloZwX3xq4t1G1gwtK954
Message-ID: <CABcZAN=rG0acoqcV6s-gNvvziM0ON97BzNwtZkESu+wz7vQO-g@mail.gmail.com>
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [OE-core] Layer priorities influencing default version selection
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
X-List-Received-Date: Tue, 02 Aug 2011 14:19:23 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 2, 2011 at 6:52 AM, Phil Blundell <philb@gnu.org> wrote:
> Actually, to some extent I consider it a bit of a misfeature that the
> layer priority is specified by the layer rather than by the user in
> bblayers.conf, since this makes it harder to vary the stack-up order
> without local hackery to the layer files. =C2=A0For example, meta-oe
> currently sets itself to a higher priority than oe-core, but I've found
> that it generally seems to suit me better if meta-oe is actually the
> lower-priority layer.

Agreed. It also means that the priority knowledge is split between
layer.conf and bblayers.conf today, as config/class priority is
determined by order of entries in BBLAYERS, whereas recipe priority is
determined by layer.conf.
--=20
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


