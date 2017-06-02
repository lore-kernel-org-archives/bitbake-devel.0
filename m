Return-Path: <patrick.ohly@intel.com>
Received: from mail-it0-f46.google.com (mail-it0-f46.google.com
	[209.85.214.46])
	by mail.openembedded.org (Postfix) with ESMTP id 52C6D71BF9
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Jun 2017 16:14:56 +0000 (UTC)
Received: by mail-it0-f46.google.com with SMTP id m47so10887905iti.1
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 02 Jun 2017 09:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=message-id:subject:from:to:cc:date:in-reply-to:references
	:organization:mime-version:content-transfer-encoding;
	bh=m8hA/apRbWdDoby6byEq1fp+6HqeYa/a4AAGX4GDboQ=;
	b=QatCv19WxHIv2QZ7AZsN02TFDESH6Buds7oWKjNVt49mso4CtpYNTOSRVL8v2NTgww
	ciibB+NjWiM2d4+i32vl2EXjdkxuBbyE7oNcG9q6ei2UuQX7haLLYleLDxup4jbOGz+m
	WCOvywRFDC44+zU2ZPVB/aK8WtaGwomNLKAJvhlW+VAPlbruz9KGGsTxp/aX3HSVRr5v
	dXnxO5oajpLBzkh1S/Lwdw8n1VXfauLLFNXi41mwrMKX+9O2XNZPCJok9pkXX5iAbkD7
	X0CHT52/0s39kGR6pBeE7OpHxLx8hBJhtpsA9F1JODJP+Tu0R3AxsTPwMIHexgBuBa4a
	SuYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
	:references:organization:mime-version:content-transfer-encoding;
	bh=m8hA/apRbWdDoby6byEq1fp+6HqeYa/a4AAGX4GDboQ=;
	b=mPI5PpVW3Mi+nkKXLC64MNz39F9swjJF4mZ4wStwT3nvl4gjDD+ZEPCOqRE50+wXqt
	KOiF7YYumJnsR5jUI5COnkuAfwRGgxO9d+eSn2vhZfLCdNhbN/PqY2pP+hdZxcqXlxoQ
	AYShl4tzMKYH/nawOWSqYEUtMnV8GWNwbPLNojJAhwl2y5k1tg7Aib6VsIOH2eN3Q7zC
	Kb7PeCVOSl35bUWOLz93ML0Wa4FUvD2ejGrVlWZtQEkcdi2IiH6b4T8T4Xn++aV4ZwqN
	+KXSbmN64mEh3tN8iQuaYBsoACv3NDZd3y7XviSkJ/5ozGr6E1fQSeCe6cLjyH/ndjfu
	19BQ==
X-Gm-Message-State: AODbwcCl41LFVNlZMwOMp6/3Fu+J/JDWGpYfCaOpfyZZUuRGuKmLEJ7x
	vXv+oEofwOOdHGHZ
X-Received: by 10.107.20.213 with SMTP id 204mr8356008iou.226.1496420097250;
	Fri, 02 Jun 2017 09:14:57 -0700 (PDT)
Received: from pohly-mobl1 (p5DE8E6B0.dip0.t-ipconnect.de. [93.232.230.176])
	by smtp.gmail.com with ESMTPSA id
	b18sm10458937ioa.16.2017.06.02.09.14.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 02 Jun 2017 09:14:56 -0700 (PDT)
Message-ID: <1496420093.30163.27.camel@intel.com>
From: Patrick Ohly <patrick.ohly@intel.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Date: Fri, 02 Jun 2017 18:14:53 +0200
In-Reply-To: <1496408295.6630.95.camel@linuxfoundation.org>
References: <cf231a157650f22c55ce6861ce824b74b245af55.1495450175.git-series.patrick.ohly@intel.com>
	<1496408295.6630.95.camel@linuxfoundation.org>
Organization: Intel GmbH, Dornacher Strasse 1, D-85622 Feldkirchen/Munich
X-Mailer: Evolution 3.12.9-1+b1 
Mime-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] cooker.py: allow dangling bbappends if explicitly whitelisted
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
X-List-Received-Date: Fri, 02 Jun 2017 16:14:56 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Fri, 2017-06-02 at 13:58 +0100, Richard Purdie wrote:
> On Mon, 2017-05-22 at 12:50 +0200, Patrick Ohly wrote:
> > Having a .bbappend without corresponding .bb file triggers an error
> > or
> > at least warning, depending on the global
> > BB_DANGLINGAPPENDS_WARNONLY.
> > 
> > Some layers (for example, meta-freescale) avoid that message by only
> > adding .bbappends to the BBFILES when the layers they apply to are
> > present. Others (like intel-iot-refkit) avoid such .bbappends by
> > falling back to global assignments with _pn-<recipe> as override.
> > Both
> > is complicated.
> > 
> > Now the warning code checks BBAPPENDS_DANGLING_WHITELIST and ignores
> > all bbappends which match a file pattern in that list. This is an
> > easier way to have bbappends which may or may not apply to an
> > existing recipe.
> > 
> > Example usage:
> > 
> >   # We have recipes-* directories, add to BBFILES
> >   BBFILES += "${LAYERDIR}/recipes-*/*/*.bb \
> > 	${LAYERDIR}/optional-bbappends/recipes-*/*/*.bbappend \
> > 	${LAYERDIR}/recipes-*/*/*.bbappend"
> > 
> >   # Several of our *.bbappends might be for layers that are not
> >   # guaranteed to be present. Don't warn or even error out because
> >   # of those.
> >   BBAPPENDS_DANGLING_WHITELIST += "${LAYERDIR}/optional-
> > bbappends/recipes-*/*/*.bbappend"
> 
> I've been giving this some thought. The freescale layer approach does
> have ordering issues which I don't like. Equally, Chris' comment about
> this is also a valid concern. Experience suggests saying the layer
> maintainer needs to be careful doesn't work in practise.
> 
> I'm wondering if there is a hybrid solution if we extend this syntax a
> little, e.g.:
> 
> BBFILES_DYNAMIC += "\
>     XXXX:${LAYERDIR}/optional-bbappends-XXX/recipes-*/*/*.bbappend
>     YYYY:${LAYERDIR}/optional-bbappends-YYY/recipes-*/*/*.bbappend
> "
> 
> so that the code only applies these BBFILES entries if the layer named
> in the first parameter is present?
>
> This would happen at the end of parsing so ordering becomes a moot
> point. The direction you stack BBFILES_DYANMIC in would determin
> bbappend application order.

While the usecase above was for .bbappends, would the same also make
sense for .bb files, and would that change the implementation? Perhaps
not.

The use case would be a .bb which depends on something in a layer which
may or may not be present. It's a bit harder, though, because it's not
always as clear as for the .bbappend case where something comes from
that a recipe depends on.

-- 
Best Regards, Patrick Ohly

The content of this message is my personal opinion only and although
I am an employee of Intel, the statements I make here in no way
represent Intel's position on the issue, nor am I authorized to speak
on behalf of Intel on this matter.




