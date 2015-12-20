Return-Path: <holger@freyther.de>
X-Greylist: delayed 598 seconds by postgrey-1.34 at layers.openembedded.org;
	Sun, 20 Dec 2015 17:23:49 UTC
Received: from gandharva.secretlabs.de (gandharva.secretlabs.de [5.9.72.18])
	by mail.openembedded.org (Postfix) with ESMTP id CBB3B70016
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 20 Dec 2015 17:23:49 +0000 (UTC)
Received: from [10.0.1.2] (ip5b41fb99.dynamic.kabel-deutschland.de
	[91.65.251.153])
	by gandharva.secretlabs.de (Postfix) with ESMTPSA id 8F69B5F14F;
	Sun, 20 Dec 2015 17:13:51 +0000 (UTC)
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
From: Holger Freyther <holger@freyther.de>
In-Reply-To: <1450617674.8461.91.camel@linuxfoundation.org>
Date: Sun, 20 Dec 2015 18:13:51 +0100
Message-Id: <CB65A2BB-49A5-499D-8298-82B324B59396@freyther.de>
References: <1450617674.8461.91.camel@linuxfoundation.org>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
X-Mailer: Apple Mail (2.3112)
Cc: bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] BBHandler: Improve IN_PYTHON_EOF handling
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Sun, 20 Dec 2015 17:23:50 -0000
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


> On 20 Dec 2015, at 14:21, Richard Purdie =
<richard.purdie@linuxfoundation.org> wrote:
>=20
> Now we're actively using the line numbers for other thins, having
> magic values like IN_PYTHON_EOF causes problems, in particular, 32
> bit overflow on 32 bit machines.
>=20
> There is a neater way to signal eof to feeder(), just using an extra
> parameter so use this instead and drop the IN_PYTHON_EOF magic values.
>=20
> This has the added bonus that line numbers are then correct for
> python functions at the end of files.
>=20

looks good! thank you for addressing it so quickly!


