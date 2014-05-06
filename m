Return-Path: <raj.khem@gmail.com>
Received: from mail-ie0-f177.google.com (mail-ie0-f177.google.com
	[209.85.223.177])
	by mail.openembedded.org (Postfix) with ESMTP id 0742D65D20;
	Tue,  6 May 2014 17:56:28 +0000 (UTC)
Received: by mail-ie0-f177.google.com with SMTP id rp18so10120666iec.22
	for <multiple recipients>; Tue, 06 May 2014 10:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type;
	bh=k6e2IwfPlj4kyweWjzD1Z0168WW3TXTtabNwZrbIyb0=;
	b=0waYXWer7E/KI+QUa3PUYU6yHLalvIXnxTSf3qYopgAibuNlbpvOct08059Cg61d7H
	lyLjliSzDZJryvRh0ZosH3buj3VAPf4CvrMe5mumVpYtW6raeuPhvlc9PQkciG/mT8O0
	vtQK9iQfxDWdC1vxzWup0+mnXm+ADSWxrwec/aSZoYVS4B0VpOTBsiNyfhKdUb2d+rlA
	W7V1QOK1x+fZp4LGoesdGZX2/MHzqBwTIZytlyHtBhpdvizKCYDo/eqnwUWUK5UBIfEK
	KDQmd0cZu8okp/ZpE74/DZNdFW8WvW8n48G+jeKA1RePnAJvitsM6rgFx0R17EszbrAE
	8dXg==
X-Received: by 10.50.30.167 with SMTP id t7mr34315132igh.17.1399398989618;
	Tue, 06 May 2014 10:56:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.50.74.228 with HTTP; Tue, 6 May 2014 10:55:59 -0700 (PDT)
In-Reply-To: <53691266.2090107@intel.com>
References: <53691266.2090107@intel.com>
From: Khem Raj <raj.khem@gmail.com>
Date: Tue, 6 May 2014 10:55:59 -0700
Message-ID: <CAMKF1so2Zrx0D39wkGj0xYSbGOKu7Kd3iMS6D=6_+yjj2vGYXA@mail.gmail.com>
To: Saul Wold <saul.wold@intel.com>
Cc: Yocto Project Discussion <yocto@yoctoproject.org>,
	"poky@yoctoproject.org" <poky@yoctoproject.org>,
	bitbake-devel <bitbake-devel@lists.openembedded.org>,
	Patches and discussions about the oe-core layer
	<openembedded-core@lists.openembedded.org>
Subject: Re: [OE-core] Daisy Stable Branch - open for patch suggestions
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
X-List-Received-Date: Tue, 06 May 2014 17:56:29 -0000
Content-Type: text/plain; charset=UTF-8

Saul

On Tue, May 6, 2014 at 9:48 AM, Saul Wold <saul.wold@intel.com> wrote:
>
> [Sorry for the overlap, want to make sure I hit a broad audience]
>
> Hi Everyone!
>
> I will be the stable maintainer for the Daisy branch, and it is now open for
> suggestions of backport patches.  I am starting to generate a list of
> patches that are already in master.

Thanks for helping with 1.6/daisy

>
> The following wiki page has the Policies and process for requesting a fix in
> a stable branch, please review that before sending a patch.
>
> https://wiki.yoctoproject.org/wiki/Stable_branch_maintenance
>
> Please remember to include [daisy] in any request (backport or commit).
>

I already have a patch posted for daisy back port.
see http://comments.gmane.org/gmane.comp.handhelds.openembedded.core/50627

> We do not have a hard date for this yet, but likely be in late May - early
> June time frame for the 1.6.1 release.
>
> Thanks to all for your efforts.
>
> Sau!
> --
> _______________________________________________
> Openembedded-core mailing list
> Openembedded-core@lists.openembedded.org
> http://lists.openembedded.org/mailman/listinfo/openembedded-core

