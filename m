Received: from mail-qw0-f47.google.com ([209.85.216.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>)
	id 1QQ4CZ-0007DN-5L; Fri, 27 May 2011 23:04:11 +0200
Received: by qwh5 with SMTP id 5so1124123qwh.6
	for <multiple recipients>; Fri, 27 May 2011 14:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:references:in-reply-to:mime-version
	:content-transfer-encoding:content-type:message-id:cc:x-mailer:from
	:subject:date:to;
	bh=7KPHx8Sjj7xl2oafWmU8TmkyYaF2HzCFRXronzCIens=;
	b=ZF/2x46N0bgiLC2T+nKJ4p72oiv/geMyerAITd6Ydder4dxD2Z/lwYnuRfSY66DK21
	8zGwidFEaak7ciwdiULh2+GYcrb2BILuEBTKNPlAUDOSgybgUz+cf+ywYBArecABB79v
	xzPIUNmb7uXakFb74RYp+ihQ6aUmF+KIgJVxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=references:in-reply-to:mime-version:content-transfer-encoding
	:content-type:message-id:cc:x-mailer:from:subject:date:to;
	b=xYEAA8Eg8D8UzQzcodKEIX1ZDch6VLZU2R1DiAx5H4FF0Akn+BiKVzqcbgo67iDqiw
	rc7rpkTBclWMBJQUI8qwRNFllYc3nafhwZxueg8196Hr4xHQ4wUvxzm12lHIa0dPnFpI
	BSoclz9jAkQoqPukoRrmz3GCxJEZyGFQdOUQA=
Received: by 10.229.26.203 with SMTP id f11mr1969572qcc.16.1306530065202;
	Fri, 27 May 2011 14:01:05 -0700 (PDT)
Received: from [192.168.22.104] (ns-visitor-nsrp.juniper.net [208.223.208.242])
	by mx.google.com with ESMTPS id t28sm1301500qcs.5.2011.05.27.14.01.03
	(version=TLSv1/SSLv3 cipher=OTHER);
	Fri, 27 May 2011 14:01:04 -0700 (PDT)
References: <cover.1306477652.git.lianhao.lu@intel.com>
	<1306515635.27470.284.camel@rex>
	<7DC6724C-BF20-4EA1-A87D-32FBEEECDA3B@dominion.thruhere.net>
	<1306526949.1747.8.camel@vorpal> <1306530057.1747.11.camel@vorpal>
In-Reply-To: <1306530057.1747.11.camel@vorpal>
Mime-Version: 1.0 (iPad Mail 8J2)
Message-Id: <03D2A4C3-146E-4611-B730-8199ED9984DD@gmail.com>
X-Mailer: iPad Mail (8J2)
From: Khem Raj <raj.khem@gmail.com>
Date: Fri, 27 May 2011 14:01:40 -0700
To: Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>,
	"openembedded-core@lists.openembedded.org"
	<openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] [PATCH 00/11] Add PR service and integrate PKGV/PKGR from OE
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
X-List-Received-Date: Fri, 27 May 2011 21:04:11 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii



On May 27, 2011, at 2:00 PM, Joshua Lock <josh@linux.intel.com> wrote:

> On Fri, 2011-05-27 at 13:09 -0700, Joshua Lock wrote:
>> Upstream BitBake still has the xmlrpc server removed. The version in
>> Poky's BitBake is functional (I use it daily).
>>=20
>> Attached are two patches against BitBake master to add back the xmlrpc
>> server (copied from Poky's tree) and fix the uievent.
>=20
> Something in the pipeline is eating patches.
>=20
> I'll send them as replies to this message.

I think it's the mailing list setup. When I attach a patch it never goes thr=
ough
Inlining the patch does go through
>=20
> Joshua
> --=20
> Joshua Lock
>        Yocto Project Build Monkey
>        Intel Open Source Technology Centre
>=20
>=20
> _______________________________________________
> Openembedded-core mailing list
> Openembedded-core@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/openembedded-core


