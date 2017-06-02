Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id 3E30277E86
	for <bitbake-devel@lists.openembedded.org>;
	Fri,  2 Jun 2017 12:58:19 +0000 (UTC)
Received: from hex ([192.168.3.34]) (authenticated bits=0)
	by dan.rpsys.net (8.15.2/8.15.2/Debian-3) with ESMTPSA id
	v52CwGTh015894
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128
	verify=NOT); Fri, 2 Jun 2017 13:58:17 +0100
Message-ID: <1496408295.6630.95.camel@linuxfoundation.org>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Patrick Ohly <patrick.ohly@intel.com>, bitbake-devel@lists.openembedded.org
Date: Fri, 02 Jun 2017 13:58:15 +0100
In-Reply-To: <cf231a157650f22c55ce6861ce824b74b245af55.1495450175.git-series.patrick.ohly@intel.com>
References: <cf231a157650f22c55ce6861ce824b74b245af55.1495450175.git-series.patrick.ohly@intel.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu3.1 
Mime-Version: 1.0
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.11
	(dan.rpsys.net [192.168.3.1]);
	Fri, 02 Jun 2017 13:58:17 +0100 (BST)
X-Virus-Scanned: clamav-milter 0.99.2 at dan
X-Virus-Status: Clean
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
X-List-Received-Date: Fri, 02 Jun 2017 12:58:21 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On Mon, 2017-05-22 at 12:50 +0200, Patrick Ohly wrote:
> Having a .bbappend without corresponding .bb file triggers an error
> or
> at least warning, depending on the global
> BB_DANGLINGAPPENDS_WARNONLY.
> 
> Some layers (for example, meta-freescale) avoid that message by only
> adding .bbappends to the BBFILES when the layers they apply to are
> present. Others (like intel-iot-refkit) avoid such .bbappends by
> falling back to global assignments with _pn-<recipe> as override.
> Both
> is complicated.
> 
> Now the warning code checks BBAPPENDS_DANGLING_WHITELIST and ignores
> all bbappends which match a file pattern in that list. This is an
> easier way to have bbappends which may or may not apply to an
> existing recipe.
> 
> Example usage:
> 
>   # We have recipes-* directories, add to BBFILES
>   BBFILES += "${LAYERDIR}/recipes-*/*/*.bb \
> 	${LAYERDIR}/optional-bbappends/recipes-*/*/*.bbappend \
> 	${LAYERDIR}/recipes-*/*/*.bbappend"
> 
>   # Several of our *.bbappends might be for layers that are not
>   # guaranteed to be present. Don't warn or even error out because
>   # of those.
>   BBAPPENDS_DANGLING_WHITELIST += "${LAYERDIR}/optional-
> bbappends/recipes-*/*/*.bbappend"

I've been giving this some thought. The freescale layer approach does
have ordering issues which I don't like. Equally, Chris' comment about
this is also a valid concern. Experience suggests saying the layer
maintainer needs to be careful doesn't work in practise.

I'm wondering if there is a hybrid solution if we extend this syntax a
little, e.g.:

BBFILES_DYNAMIC += "\
    XXXX:${LAYERDIR}/optional-bbappends-XXX/recipes-*/*/*.bbappend
    YYYY:${LAYERDIR}/optional-bbappends-YYY/recipes-*/*/*.bbappend
"

so that the code only applies these BBFILES entries if the layer named
in the first parameter is present?

This would happen at the end of parsing so ordering becomes a moot
point. The direction you stack BBFILES_DYANMIC in would determin
bbappend application order.

How does that sound to people?

Cheers,

Richard

