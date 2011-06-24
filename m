Received: from mail-vx0-f175.google.com ([209.85.220.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1QaBBJ-00084n-Kd
	for bitbake-devel@lists.openembedded.org;
	Fri, 24 Jun 2011 20:32:41 +0200
Received: by vxa37 with SMTP id 37so2446092vxa.6
	for <bitbake-devel@lists.openembedded.org>;
	Fri, 24 Jun 2011 11:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:sender:in-reply-to:references:from
	:date:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=Cu16rMljjqJlIhovgO5yh9TQxeGbCrKoQ292WUfO0l4=;
	b=EPJ/o/jjfcUbA357Jg29lC+DCddfjc4HskgaBEW/aqnk8ilupEGFpAzxNoR9//AscK
	FoyYTLb/Nifog695dDtomIMLehKSSPHTNfnN6o3U6NjNp8rsCjs1QMB4tXXuE+9HEk8C
	+q1SjVSapTJ7CJel9QZMDZQV/XIjklEg2dC58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	b=ogQq0674X8gX93c15BUkjjBVGG2WHxl7vqlBAEmTJ6/8gpY5jOlikY1isqzgb0E/8q
	Go6sZdjWfaKduWVeDTBeNoEKov+3rrfAs+d2CgnAn2i3y45sjyn/vfn4W0NRacoI8K4o
	ypHl0pruVK1AVj8+ldNyoMIwe7bwgrWsGlYKc=
Received: by 10.52.111.71 with SMTP id ig7mr5070355vdb.209.1308939341086; Fri,
	24 Jun 2011 11:15:41 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.52.181.2 with HTTP; Fri, 24 Jun 2011 11:15:21 -0700 (PDT)
In-Reply-To: <f7f26e0dff68d4c3146caeccc653fb3c020e662a.1308749155.git.paul.eggleton@linux.intel.com>
References: <cover.1308749155.git.paul.eggleton@linux.intel.com>
	<f7f26e0dff68d4c3146caeccc653fb3c020e662a.1308749155.git.paul.eggleton@linux.intel.com>
From: Chris Larson <clarson@kergoth.com>
Date: Fri, 24 Jun 2011 11:15:21 -0700
X-Google-Sender-Auth: zhQvij9EpJ9lEIb3DVfvmBtfuJ0
Message-ID: <BANLkTin1XfH_vNQwTfab4B6THm0PRSXAkg@mail.gmail.com>
To: Paul Eggleton <paul.eggleton@linux.intel.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [RFC PATCH 1/3] bitbake: track 'overlayed' recipes
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
X-List-Received-Date: Fri, 24 Jun 2011 18:32:41 -0000
Content-Type: text/plain; charset=UTF-8

On Wed, Jun 22, 2011 at 6:28 AM, Paul Eggleton
<paul.eggleton@linux.intel.com> wrote:
> Recipes that have been 'overlayed' (where there is a recipe in another
> layer where that layer has a higher priority) are now listed within
> cooker.overlayedlist for use in bitbake-layers. This is a dict with
> keys of the topmost (highest priority) recipe file.
>
> Signed-off-by: Paul Eggleton <paul.eggleton@linux.intel.com>

Seems sane conceptually, but can we name this something else?
overlayedlist is pretty weak, particularly being it's not a list at
all :) I'd say just overlayed, or overlayed_recipes, or similar.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


