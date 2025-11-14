Return-Path: <alex.kanavin@gmail.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8931BCE8D77
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 18:27:26 +0000 (UTC)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5081.1763144840943809401
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 14 Nov 2025 10:27:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@gmail.com header.s=20230601 header.b=Qos/VOWI;
 spf=pass (domain: gmail.com, ip: 209.85.160.172, mailfrom: alex.kanavin@gmail.com)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4eddfc251d0so21375491cf.0
        for <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 10:27:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763144840; x=1763749640; darn=lists.openembedded.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FBpzbxW3R8LwYvTmtJjLlTgMTTN0mzF/tR9X08GQm34=;
        b=Qos/VOWILUdCbnA0oKcJpSOD3frA9ojI+LmeyE03cXwdQNBbrF2VmPRrvbU2HOAmb7
         82jMykb9mYWq2po4m/WySjVvXFmLeXfHWKmzq1aPPH1VrRB0UDDuY3Cb831QwkhsKgSc
         dN/eujOYLgXqxCs0tN3mRUT7slCfaMlAVvP/LQ3u03Mv/VUNKd/5902z7yw64DQEcRrf
         YgoC4fyYPEH6bypyp0dKbsFFr5sSOYFcZZccMAWbKhyoCIIe690use84SloeCDV4w1Pl
         4vfS2FKLSZJCSKzrfyLkpSFrlHMhanpadnkYPGQg0K8ylBwXIWiLKzZFcK4xhBtMECtm
         dltA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763144840; x=1763749640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FBpzbxW3R8LwYvTmtJjLlTgMTTN0mzF/tR9X08GQm34=;
        b=uQZ1Ap/Kr19ow3+WsO32cn3F6AxBwURDV0BxDiudMi9zmsJoljmC5QHMJ821899/gO
         PSsMltUNL64jevQ/OnkIGsEQkJx/YPg0pNA1/dB3mjJYupxhT9OppKrAlodY5BXB6fxt
         bYQjueQF+hEtKK/GmUeD3OWC4aCN4UvTxmeKYdc7W5YDGrK9K1NVTlZPXSEDnAxxjbeB
         qPC5DKK5DyRob6iRUy7+gyiWW45biZxV1GwqXF09Rn+0dyuhBdkNnorNApM8NQ0WUu5Y
         aX/N1jOZUZGfvrO8+X6awJNg9kBiXzGzZ4U001abotGTGGxB6O70c8+bDxP3gfnxg3nd
         rinw==
X-Gm-Message-State: AOJu0YwJ6yEaZI+JZ1fy6G5/+DIoNbBGxE5QdhVdN40KDPmiGYHRkKxN
	DMJm3EPy1r68ys4MRN4DhxWfWFCt1VBmZdNRSX1T70LCroVC1/7VMRzXhO1M96MbXnypxienffy
	+WgA44jxRSnDEjiOVARQJXl1es52JcnEzOA==
X-Gm-Gg: ASbGnctZsqqpV5sglsjgC5WJk2pZUxu5EJw+67K6qVQ9qE4jXXT14v1i6rbA+F/PO4m
	VypP8mMWBGLCFtqAaFgjuL9U4oFhdoFNL5DzyjQILZwSd9SP5rzUaNedzygfkZMS2Jof2/0mWQu
	T0CahzoGkbi4bzEml8IMswxs3HWfkleDNfgWUe9nvMBaEPMlK1K0nLrFN7XsHkcE6lAvY9D4mAQ
	d9ZjIZEX+fqGYEur7bgAmICYr7M2W5QjaV5eHNcYUGJW7/jELRqd65kgpJMfjDPUDKkLQ==
X-Google-Smtp-Source: AGHT+IFoMzyE0fiVkYsaUQKGVlG7Bowo4QtRToUTJk5cnbHMRLXvyUmUsVQs3UHXPXBi+aE/8fjvhwS+Qz14QbMj3ko=
X-Received: by 2002:a05:622a:4105:b0:4ee:d6:7a51 with SMTP id
 d75a77b69052e-4ee00d68253mr9090531cf.12.1763144839261; Fri, 14 Nov 2025
 10:27:19 -0800 (PST)
MIME-Version: 1.0
References: <20251114-bitbake-setup-abort-v1-0-d2f9967df3b1@bootlin.com> <20251114-bitbake-setup-abort-v1-3-d2f9967df3b1@bootlin.com>
In-Reply-To: <20251114-bitbake-setup-abort-v1-3-d2f9967df3b1@bootlin.com>
From: Alexander Kanavin <alex.kanavin@gmail.com>
Date: Fri, 14 Nov 2025 19:27:07 +0100
X-Gm-Features: AWmQ_bkdKdwoBHEAYAozup8Y-PlAfmF1lwqHKXT7IOkKdKv8o_mKeDfduY_KEns
Message-ID: <CANNYZj9-eUPC0TTFus0J3AF4KXappsuxSFx0rvrwJk1Dmn=TPg@mail.gmail.com>
Subject: Re: [bitbake-devel] [PATCH 3/3] bitbake-setup: handle ctrl+c in init
To: antonin.godard@bootlin.com
Cc: bitbake-devel@lists.openembedded.org, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 14 Nov 2025 18:27:26 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/18410

Since other functions may also become interactive (e.g. update
prompting the user if files in build/conf/ should be replaced),
shouldn't this be installed as a generic handler in main()?

Alex

On Fri, 14 Nov 2025 at 12:07, Antonin Godard via
lists.openembedded.org
<antonin.godard=bootlin.com@lists.openembedded.org> wrote:
>
> Instead of printing the stack trace, print "Shutting down..." when the
> user presses Ctrl+C during the init. Mention that the top-directory's
> setups might be incomplete if the topdir was already created.
>
> Signed-off-by: Antonin Godard <antonin.godard@bootlin.com>
> ---
>  bin/bitbake-setup | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/bin/bitbake-setup b/bin/bitbake-setup
> index 3dc46cbbfa..151cb79cac 100755
> --- a/bin/bitbake-setup
> +++ b/bin/bitbake-setup
> @@ -17,6 +17,8 @@ import glob
>  import subprocess
>  import copy
>  import textwrap
> +import signal
> +import functools
>
>  default_registry = os.path.normpath(os.path.dirname(__file__) + "/../default-registry")
>
> @@ -452,7 +454,15 @@ def obtain_config(top_dir, settings, args, source_overrides, d):
>      upstream_config['skip-selection'] = args.skip_selection
>      return upstream_config
>
> +def init_sigint_handler(sig, frame, top_dir):
> +    print(f'\nShutting down...')
> +    if isinstance(top_dir, str) and os.path.exists(top_dir):
> +        print(f'{top_dir} may contain an incomplete setup!')
> +    exit()
> +
>  def init_config(top_dir, settings, args):
> +    _handler = functools.partial(init_sigint_handler, top_dir=top_dir)
> +    signal.signal(signal.SIGINT, _handler)
>      create_siteconf(top_dir, args.non_interactive, settings)
>
>      d = init_bb_cache(top_dir, settings, args)
>
> --
> 2.51.0
>
>
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18392): https://lists.openembedded.org/g/bitbake-devel/message/18392
> Mute This Topic: https://lists.openembedded.org/mt/116290015/1686489
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [alex.kanavin@gmail.com]
> -=-=-=-=-=-=-=-=-=-=-=-
>

