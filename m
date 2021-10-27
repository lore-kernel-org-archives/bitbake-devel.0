Return-Path: <alexandre.belloni@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD2BC433EF
	for <webhook@archiver.kernel.org>; Wed, 27 Oct 2021 15:13:39 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net
 [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web09.13200.1635347618003871007
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 27 Oct 2021 08:13:38 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: alexandre.belloni@bootlin.com)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
	by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id DB1952000A;
	Wed, 27 Oct 2021 15:13:35 +0000 (UTC)
Date: Wed, 27 Oct 2021 17:13:35 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Chen Qi <Qi.Chen@windriver.com>
Cc: bitbake-devel@lists.openembedded.org,
	Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Re: [bitbake-devel][PATCH V2 1/3] fetch2: fix downloadfilename issue
 with premirror
Message-ID: <YXlsn/r8vCaZvlkL@piout.net>
References: <16AF0338AE5E9F1B.30006@lists.openembedded.org>
 <2788d484-ab73-6f5e-c7b0-deaec4670a43@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2788d484-ab73-6f5e-c7b0-deaec4670a43@windriver.com>
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 27 Oct 2021 15:13:39 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/12843

Hi,

On 27/10/2021 09:59:54+0800, Chen Qi wrote:
> Gentle ping on this series.
> 

It is currently under testing and will be in the next queue for Richard
to review and apply.

> Regards,
> Qi
> 
> On 10/18/2021 11:45 AM, Chen Qi wrote:
> > The following commit to fix [Yocto #13039] causes regression of
> > the behavior of PREMIRRORS.
> > 
> >    "bitbake: fetch2: fix premirror URI when downloadfilename defined"
> > 
> > Take meta-openembedded/meta-networking/recipes-protocols/freediameter/freediameter_1.4.0.bb
> > as an example.
> > SRC_URI = "\
> >      http://www.freediameter.net/hg/${fd_pkgname}/archive/${PV}.tar.gz;downloadfilename=${fd_pkgname}-${PV}.tar.gz \
> >      ...
> > "
> > With the above commit, it now tries to fetch 1.4.0.tar.gz instead of
> > freeDiameter-1.4.0.tar.gz. This makes https://downloads.yoctoproject.org/mirror/sources
> > not work for freediameter, as it holds freeDiameter-1.4.0.tar.gz.
> > 
> > The commit above tries to avoid fetching from invalid url such as:
> > https://<some_mirror>/1.4.0.tar.gz/freeDiameter-1.4.0.tar.gz.
> > And its solution is to make basename to be 1.4.0.tar.gz, thus causing the
> > regression.
> > 
> > This patch fixes the above regression. For Yocto #13039, it now tries
> > to fetch from url: https://<some_mirror>/freeDiameter-1.4.0.tar.gz.
> > 
> > Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> > ---
> >   bitbake/lib/bb/fetch2/__init__.py | 10 +++++++---
> >   1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
> > index 666cc1306a..000b49a500 100644
> > --- a/bitbake/lib/bb/fetch2/__init__.py
> > +++ b/bitbake/lib/bb/fetch2/__init__.py
> > @@ -466,9 +466,13 @@ def uri_replace(ud, uri_find, uri_replace, replacements, d, mirrortarball=None):
> >                       # Kill parameters, they make no sense for mirror tarballs
> >                       uri_decoded[5] = {}
> >                   elif ud.localpath and ud.method.supports_checksum(ud):
> > -                    basename = os.path.basename(uri_decoded[loc])
> > -                if basename and not result_decoded[loc].endswith(basename):
> > -                    result_decoded[loc] = os.path.join(result_decoded[loc], basename)
> > +                    basename = os.path.basename(ud.localpath)
> > +                if basename:
> > +                    uri_basename = os.path.basename(uri_decoded[loc])
> > +                    if basename != uri_basename and result_decoded[loc].endswith(uri_basename):
> > +                        result_decoded[loc] = result_decoded[loc].replace(uri_basename, basename)
> > +                    elif not result_decoded[loc].endswith(basename):
> > +                        result_decoded[loc] = os.path.join(result_decoded[loc], basename)
> >           else:
> >               return None
> >       result = encodeurl(result_decoded)
> > 
> > 
> > 
> > 
> 

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#12840): https://lists.openembedded.org/g/bitbake-devel/message/12840
> Mute This Topic: https://lists.openembedded.org/mt/86406437/3617179
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alexandre.belloni@bootlin.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

