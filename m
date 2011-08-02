Received: from mail-pz0-f43.google.com ([209.85.210.43])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>)
	id 1QoH36-0005E3-1v; Tue, 02 Aug 2011 17:38:28 +0200
Received: by pzk1 with SMTP id 1so13454023pzk.16
	for <multiple recipients>; Tue, 02 Aug 2011 08:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=references:in-reply-to:mime-version:content-transfer-encoding
	:content-type:message-id:cc:x-mailer:from:subject:date:to;
	bh=fao9qAe9ytPiequxomyPqWmDp4xPKvsOCnbKqWHD9sI=;
	b=ajYkIiVZiDHtAHT9ex1wXsWIDLki9HI2qh1JYQWU1dYQbjPBm7FKivYQj2kjqT5dkh
	uM/+amGC3lIIuPikwx4iiLICLXU7pyxeLO7mKqnkmcwWAkzRMtJl1Z4rjNDGrhRWyzx+
	53t0CbCQLdR45iEURJ0WY6WbnlUBeHm4Tbn7s=
Received: by 10.68.25.162 with SMTP id d2mr329565pbg.372.1312299245741;
	Tue, 02 Aug 2011 08:34:05 -0700 (PDT)
Received: from [192.168.1.81] (99-57-141-118.lightspeed.sntcca.sbcglobal.net
	[99.57.141.118])
	by mx.google.com with ESMTPS id d1sm6869346pbj.72.2011.08.02.08.34.03
	(version=TLSv1/SSLv3 cipher=OTHER);
	Tue, 02 Aug 2011 08:34:04 -0700 (PDT)
References: <201108021226.34560.paul.eggleton@linux.intel.com>
	<1312292735.2344.597.camel@rex>
	<1312293167.4325.38.camel@phil-desktop>
	<CABcZAN=rG0acoqcV6s-gNvvziM0ON97BzNwtZkESu+wz7vQO-g@mail.gmail.com>
In-Reply-To: <CABcZAN=rG0acoqcV6s-gNvvziM0ON97BzNwtZkESu+wz7vQO-g@mail.gmail.com>
Mime-Version: 1.0 (iPad Mail 8J2)
Message-Id: <A3E3935F-5D98-4208-A45F-DC409F1C97CF@gmail.com>
X-Mailer: iPad Mail (8J2)
From: Khem Raj <raj.khem@gmail.com>
Date: Tue, 2 Aug 2011 08:35:12 -0700
To: Chris Larson <clarson@kergoth.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
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
X-List-Received-Date: Tue, 02 Aug 2011 15:38:28 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



On Aug 2, 2011, at 7:14 AM, Chris Larson <clarson@kergoth.com> wrote:

> On Tue, Aug 2, 2011 at 6:52 AM, Phil Blundell <philb@gnu.org> wrote:
>> Actually, to some extent I consider it a bit of a misfeature that the
>> layer priority is specified by the layer rather than by the user in
>> bblayers.conf, since this makes it harder to vary the stack-up order
>> without local hackery to the layer files.  For example, meta-oe
>> currently sets itself to a higher priority than oe-core, but I've found
>> that it generally seems to suit me better if meta-oe is actually the
>> lower-priority layer.
>=20
> Agreed. It also means that the priority knowledge is split between
> layer.conf and bblayers.conf today, as config/class priority is
> determined by order of entries in BBLAYERS, whereas recipe priority is
> determined by layer.conf.


In my opinion the layer priority for all kind of meta data should be consist=
ent and selected using bblayers.conf=20


> --=20
> Christopher Larson
> clarson at kergoth dot com
> Founder - BitBake, OpenEmbedded, OpenZaurus
> Maintainer - Tslib
> Senior Software Engineer, Mentor Graphics
>=20
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel


