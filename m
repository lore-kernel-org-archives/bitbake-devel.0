Received: from mail-vw0-f47.google.com ([209.85.212.47])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <kergoth@gmail.com>) id 1QRnlC-0001hb-DX
	for bitbake-devel@lists.openembedded.org;
	Wed, 01 Jun 2011 17:55:06 +0200
Received: by vws2 with SMTP id 2so4719864vws.6
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 01 Jun 2011 08:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=gamma;
	h=domainkey-signature:mime-version:sender:in-reply-to:references:from
	:date:x-google-sender-auth:message-id:subject:to:cc:content-type;
	bh=F2qni5QJEFu5ENhcG6RAj3tNVU68S3+EpRjccOxAO/M=;
	b=rSNUnKgprKJ27I7SPybeiO+HRE2DXqJPW9B6zMDDa5xQyWw4a1Tj3mIfT/n3zvnR4U
	BRlXdoufSREgkVXzRB+bOuVRKE+CmR8KW+XKTZhXmwyKuxR5NeP9VsYkQqKvetvxRzwZ
	py0zG7e3Ep2ryVSWh5C02mKQrbwGDQqBq5Ei8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=gmail.com; s=gamma;
	h=mime-version:sender:in-reply-to:references:from:date
	:x-google-sender-auth:message-id:subject:to:cc:content-type;
	b=aUa4U34t0Pz+YgMx9cLqLNpPlT9sBE77JkaoL0DelJUbeBrvb2HJAxPsm127Ba3VLA
	TNghYdNgZg/ABVK8tTQ/fbZTv5ahh2NJELl45byQB2qNMdLu1oqMtwy+7iVTlNYQLoUI
	MZpGeZmSgkizs6IKxGXf5MIP86mupdo3QmR0o=
Received: by 10.52.111.131 with SMTP id ii3mr2321727vdb.235.1306943514092;
	Wed, 01 Jun 2011 08:51:54 -0700 (PDT)
MIME-Version: 1.0
Sender: kergoth@gmail.com
Received: by 10.52.101.134 with HTTP; Wed, 1 Jun 2011 08:51:34 -0700 (PDT)
In-Reply-To: <1306940377.27470.429.camel@rex>
References: <1306882804.27470.402.camel@rex> <1306940377.27470.429.camel@rex>
From: Chris Larson <clarson@kergoth.com>
Date: Wed, 1 Jun 2011 08:51:34 -0700
X-Google-Sender-Auth: uj9vj2mEu3SgPjGYTksXGjyMlW8
Message-ID: <BANLkTintk+iHqO=dGZyDnke=1P3WwZ2iYQ@mail.gmail.com>
To: Richard Purdie <richard.purdie@linuxfoundation.org>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: RFC: Override expansion - changing the behaviour
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
X-List-Received-Date: Wed, 01 Jun 2011 15:55:06 -0000
Content-Type: text/plain; charset=UTF-8

On Wed, Jun 1, 2011 at 7:59 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> To follow up on this, what kind of cleanup would this and some other
> tweaks to bitbake allow?
>
> This is my proof of concept:
>
> http://git.yoctoproject.org/cgit.cgi/poky-contrib/commit/?h=rpurdie/temp3&id=1ed909e8b9bac6ed88ffbbe6a100a42c4289f498
>
> which cleans up native.bbclass and nativesdk.bbclass to be much cleaner
> code with less strange side effects and hoops to jump through.
>
> The main changes to bitbake after the original patch I posted were:
>
> a) Add handlers before any data finalisation
> b) Add a new "pre finalise" event
>

This looks quite sane in general. The "if len(override) > 0" isn't
pythonic, however. That should be "if override:". Of course,
_seen_overrides would be better as a defaultdict(set), but that's
minor. I'd also have taken the time to fix the formatting of
"self._seen_overrides[override].add( var )". Those spaces around the
argument aren't consistent with the code style of the rest of bitbake.
Regarding the metadata comparison, there's emit_data.bbclass in OE
which does essentially the same thing, dumps and compares. I support
the overrides change going into bitbake, as long as we can ensure it
breaks neither oe-core/poky or upstream OE.
-- 
Christopher Larson
clarson at kergoth dot com
Founder - BitBake, OpenEmbedded, OpenZaurus
Maintainer - Tslib
Senior Software Engineer, Mentor Graphics


