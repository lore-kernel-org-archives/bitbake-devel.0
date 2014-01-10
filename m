Return-Path: <martin.jansa@gmail.com>
Received: from mail-ea0-f174.google.com (mail-ea0-f174.google.com
	[209.85.215.174])
	by mail.openembedded.org (Postfix) with ESMTP id C28B36066A
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jan 2014 14:14:11 +0000 (UTC)
Received: by mail-ea0-f174.google.com with SMTP id b10so2040237eae.5
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 10 Jan 2014 06:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=date:from:to:cc:subject:message-id:references:mime-version
	:content-type:content-disposition:in-reply-to:user-agent;
	bh=iLPZUCGOQSzqdAuJi80ijb91aE20N8fjTWg2WfOoKwQ=;
	b=eKIq39g7jSZHmm5g86dX/BAeKX0JyMXnvEuk+yWwWP2ltS15uy3ICJ7gxdmQ17uWK1
	K8MPCfpGkoh7l3IyMRP7Qq8ApqhSHnJMWruvFGKgv8g1gNJDZjvYpUGE4OsMhvD9vQav
	jeCK+BXvD0IwXLrsKULXHJ212/8NcQ2AMU4h4tg0XNK0HvqQ9w4OT45JLIPmcKkh9fuf
	jfibs+yZpi2Smcc9HUVhmZskdEsaB/AiKs375Bs3XDTAJbMB6Yz4Vy0CciutOWbwvUXb
	iHw6H5kCRuYBwoNqqs/0H9j1VypwSfV0X8eqRLrC9sjfRLvX0xPuVXkyutDKEGu9aDon
	Uynw==
X-Received: by 10.15.31.196 with SMTP id y44mr10312458eeu.96.1389363245505;
	Fri, 10 Jan 2014 06:14:05 -0800 (PST)
Received: from localhost (ip-89-176-104-107.net.upcbroadband.cz.
	[89.176.104.107])
	by mx.google.com with ESMTPSA id l4sm14861725een.13.2014.01.10.06.14.04
	for <multiple recipients>
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 10 Jan 2014 06:14:04 -0800 (PST)
Date: Fri, 10 Jan 2014 15:14:17 +0100
From: Martin Jansa <martin.jansa@gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Message-ID: <20140110141417.GR3709@jama>
References: <1387383687.6402.49.camel@ted> <20131228132413.GB3706@jama>
	<CABcZANnopy5be2w7k0JRC12bcc6sZ8REsXt9ga0z-qdkHwA2tQ@mail.gmail.com>
	<CABcZANnFCcx7aX=HcfmXvLSYmnS+hwfo7SW4BN0SRwq2BE-Avw@mail.gmail.com>
	<20131230163534.GB3719@jama> <1388441430.11527.80.camel@ted>
	<CABcZANkW_QjvWdEK_5s0pVS4YOrrj+2zjHLg5Oe1Ye13YXaahQ@mail.gmail.com>
	<1388619481.11527.98.camel@ted>
MIME-Version: 1.0
In-Reply-To: <1388619481.11527.98.camel@ted>
User-Agent: Mutt/1.5.22 (2013-10-16)
Cc: Chris Larson <clarson@kergoth.com>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] runqueue: Add output for -S option for listing the changepoints compared with an sstate cache
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
X-List-Received-Date: Fri, 10 Jan 2014 14:14:12 -0000
X-Groupsio-MsgNum: 4308
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aiJlF+TB2UsRxGRQ"
Content-Disposition: inline

--aiJlF+TB2UsRxGRQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 01, 2014 at 11:38:01PM +0000, Richard Purdie wrote:
> So can we find the "least delta" fast? Its not actually that hard
> computationally or on resources, at least in the experiments I've made.
> We know the hashes of the current target's tasks and we can quickly tell
> which are in the cache and which are not (using the same function sstate
> uses for that purpose).

I've finally got some numbers to support my claim that it "feels" slower
with this added functionality.

My script is calling
openembedded-core/scripts/sstate-diff-machines.sh --machines=3D"qemuarm qem=
ux86 qemux86copy" --targets=3Dworld --tmpdir=3Dtmp-eglibc/;

which in turn runs
bitbake -S world
three times (once for each machine).

The script on jenkins doing world builds is completely crazy (I've
killed it in last run assuming it was stuck, but it wasn't just terribly
slow).
http://jenkins.nas-admin.org/job/oe_world_compare_signatures/11/
Running 21 hours already and doing 2nd machine from 3 (maybe because
longer SSTATE_MIRROR?). There is one python process using 100% cpu.

In local builds without SSTATE_MIRROR it's not so bad, but still
significantly slower with each release (dylan-dora-master).

Master builds have that WIP patch included in order to finish.

It's not very accurate, because it was running on my desktop and each one h=
as
different metadata, but at least the layers included are similar (only
systems which got separated in dora and removal
of meta-webos-backports which isn't needed for dora and newer).

At least I've executed each test twice.

dylan:
real   9m37.271s
user   6m37.104s
sys    3m12.625s

real   10m5.787s
user   6m37.832s
sys    3m23.614s

dora:
real   26m11.374s
user   9m7.325s
sys    3m0.048s

real   28m10.606s
user   8m27.895s
sys    2m57.497s

master:
real   38m17.641s
user   17m46.905s
sys    5m12.061s

real    36m12.748s
user    16m32.961s
sys     4m43.103s

master-without-S-changes:
real    27m34.228s
user    8m6.811s
sys     2m53.724s

real    27m49.752s
user    8m25.026s
sys     2m50.921s

--=20
Martin 'JaMa' Jansa     jabber: Martin.Jansa@gmail.com

--aiJlF+TB2UsRxGRQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlLQADkACgkQN1Ujt2V2gBwMKQCgsiVZSMZd6xeO1griORyTmW3f
gJcAnA+IinH4L4QVawxR+KFlBPgcVcdr
=e2IY
-----END PGP SIGNATURE-----

--aiJlF+TB2UsRxGRQ--
